import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:wirdi_app/data/demo_data.dart';
import 'package:wirdi_app/data/models.dart';
import 'package:wirdi_app/data/wird_repository.dart';

enum Session { none, supervisor, student }

/// Single source of truth of the app: holds the data, exposes queries and
/// use cases, persists every change through the [WirdRepository].
class AppState extends ChangeNotifier {
  AppState(this._repo, {DateTime Function()? clock}) : _clock = clock ?? DateTime.now;

  final WirdRepository _repo;
  final DateTime Function() _clock;
  final _random = Random();

  WirdData _data = const WirdData();
  bool _loaded = false;
  Session _session = Session.none;
  String? _currentStudentId;

  // ------------------------------------------------------------------ reads
  bool get loaded => _loaded;
  Session get session => _session;
  DateTime get now => _clock();
  Association? get association => _data.association;
  bool get isConfigured => _data.association != null;

  List<Group> get groups => _data.groups;
  List<Student> get students => [..._data.students]..sort((a, b) => a.name.compareTo(b.name));
  List<Program> get programs => _data.programs;
  List<Exam> get exams => [..._data.exams]..sort((a, b) => a.date.compareTo(b.date));

  Student? get currentStudent => _currentStudentId == null ? null : studentById(_currentStudentId!);

  Student? studentById(String id) => _data.students.where((s) => s.id == id).firstOrNull;
  Group? groupById(String? id) => id == null ? null : _data.groups.where((g) => g.id == id).firstOrNull;

  List<Program> programsOf(String studentId, [ProgramType? type]) =>
      _data.programs.where((p) => p.studentId == studentId && (type == null || p.type == type)).toList();

  List<Exam> examsOf(String studentId) => exams.where((e) => e.studentId == studentId).toList();

  List<Exam> get upcomingExams => exams.where((e) => e.isUpcoming).toList();

  List<Program> get atRiskPrograms => _data.programs.where((p) => p.isAtRisk(now)).toList();

  /// Average progress of all the student's programmes (0..1).
  double progressOf(String studentId) {
    final list = programsOf(studentId);
    if (list.isEmpty) return 0;
    return list.map((p) => p.progress).reduce((a, b) => a + b) / list.length;
  }

  double get averageProgress {
    if (_data.students.isEmpty) return 0;
    return _data.students.map((s) => progressOf(s.id)).reduce((a, b) => a + b) / _data.students.length;
  }

  /// Events for the current user, newest first.
  List<AppEvent> get notifications {
    final all = [..._data.events]..sort((a, b) => b.date.compareTo(a.date));
    if (_session == Session.student) return all.where((e) => e.studentId == _currentStudentId).toList();
    return all;
  }

  // ------------------------------------------------------------- lifecycle
  Future<void> init() async {
    _data = await _repo.load();
    _loaded = true;
    notifyListeners();
  }

  Future<void> _commit(WirdData data) async {
    _data = data;
    notifyListeners();
    await _repo.save(data);
  }

  WirdData _copy({
    Association? association,
    List<Group>? groups,
    List<Student>? students,
    List<Program>? programs,
    List<Exam>? exams,
    List<AppEvent>? events,
  }) =>
      WirdData(
        association: association ?? _data.association,
        groups: groups ?? _data.groups,
        students: students ?? _data.students,
        programs: programs ?? _data.programs,
        exams: exams ?? _data.exams,
        events: events ?? _data.events,
      );

  String _id(String prefix) => '$prefix${now.microsecondsSinceEpoch}${_random.nextInt(999)}';

  List<AppEvent> _withEvent(EventType type, String message, {String? studentId}) {
    final event = AppEvent(id: _id('n'), type: type, message: message, date: now, studentId: studentId);
    return [event, ..._data.events].take(100).toList();
  }

  // ---------------------------------------------------------------- session
  Future<void> setUpAssociation({required String name, required String supervisor, required String pin, bool withDemo = false}) async {
    final association = Association(name: name.trim(), supervisorName: supervisor.trim(), pin: pin);
    _session = Session.supervisor;
    await _commit(withDemo ? buildDemoData(association, now) : WirdData(association: association));
  }

  bool loginSupervisor(String pin) {
    if (_data.association?.pin != pin) return false;
    _session = Session.supervisor;
    notifyListeners();
    return true;
  }

  /// Returns null on success, or an error message.
  String? loginStudent(String email, String code) {
    final student = _data.students
        .where((s) => s.email.toLowerCase() == email.trim().toLowerCase() && s.accessCode == code.trim())
        .firstOrNull;
    if (student == null) return 'البريد الإلكتروني أو رمز الدخول غير صحيح';
    _session = Session.student;
    _currentStudentId = student.id;
    notifyListeners();
    return null;
  }

  void logout() {
    _session = Session.none;
    _currentStudentId = null;
    notifyListeners();
  }

  Future<void> resetAll() async {
    await _repo.clear();
    _data = const WirdData();
    logout();
  }

  Future<void> loadDemo() async {
    final association = _data.association;
    if (association == null) return;
    await _commit(buildDemoData(association, now));
  }

  // ----------------------------------------------------------------- groups
  Future<void> saveGroup({String? id, required String name, String supervisor = ''}) async {
    final groups = [..._data.groups];
    if (id == null) {
      groups.add(Group(id: _id('g'), name: name.trim(), supervisor: supervisor.trim()));
    } else {
      final i = groups.indexWhere((g) => g.id == id);
      if (i >= 0) groups[i] = groups[i].copyWith(name: name.trim(), supervisor: supervisor.trim());
    }
    await _commit(_copy(groups: groups));
  }

  Future<void> deleteGroup(String id) async {
    await _commit(_copy(
      groups: _data.groups.where((g) => g.id != id).toList(),
      students: _data.students.map((s) => s.groupId == id ? s.copyWith(clearGroup: true) : s).toList(),
    ));
  }

  // --------------------------------------------------------------- students
  String generateAccessCode() {
    String code;
    do {
      code = (100000 + _random.nextInt(900000)).toString();
    } while (_data.students.any((s) => s.accessCode == code));
    return code;
  }

  bool emailTaken(String email, {String? exceptId}) =>
      _data.students.any((s) => s.id != exceptId && s.email.toLowerCase() == email.trim().toLowerCase());

  Future<Student> saveStudent({String? id, required String name, required String email, String phone = '', String? groupId}) async {
    final students = [..._data.students];
    Student result;
    var events = _data.events;
    if (id == null) {
      result = Student(
        id: _id('s'),
        name: name.trim(),
        email: email.trim(),
        phone: phone.trim(),
        groupId: groupId,
        accessCode: generateAccessCode(),
      );
      students.add(result);
      events = _withEvent(EventType.student, 'تمت إضافة الطالب ${result.name}');
    } else {
      final i = students.indexWhere((s) => s.id == id);
      result = students[i].copyWith(
        name: name.trim(),
        email: email.trim(),
        phone: phone.trim(),
        groupId: groupId,
        clearGroup: groupId == null,
      );
      students[i] = result;
    }
    await _commit(_copy(students: students, events: events));
    return result;
  }

  Future<void> deleteStudent(String id) async {
    await _commit(_copy(
      students: _data.students.where((s) => s.id != id).toList(),
      programs: _data.programs.where((p) => p.studentId != id).toList(),
      exams: _data.exams.where((e) => e.studentId != id).toList(),
      events: _data.events.where((e) => e.studentId != id).toList(),
    ));
  }

  // --------------------------------------------------------------- programs
  Future<void> saveProgram(Program program, {required bool isNew}) async {
    final programs = isNew
        ? [..._data.programs, program]
        : _data.programs.map((p) => p.id == program.id ? program : p).toList();
    final student = studentById(program.studentId);
    final kind = program.type == ProgramType.memorization ? 'حفظ' : 'مراجعة';
    final events = isNew
        ? _withEvent(EventType.program, 'برنامج $kind جديد: ${program.title} لـ${student?.name ?? ''}', studentId: program.studentId)
        : _data.events;
    await _commit(_copy(programs: programs, events: events));
  }

  Program newProgram({required String studentId, required ProgramType type, required String title, required int totalUnits, int doneUnits = 0, DateTime? deadline, String notes = ''}) =>
      Program(id: _id('p'), studentId: studentId, type: type, title: title.trim(), totalUnits: totalUnits, doneUnits: doneUnits, deadline: deadline, notes: notes.trim());

  /// Adds (or removes, with a negative [delta]) completed pages.
  Future<void> addProgress(String programId, int delta) async {
    final program = _data.programs.firstWhere((p) => p.id == programId);
    final updated = program.copyWith(doneUnits: program.doneUnits + delta);
    var events = _data.events;
    if (updated.isDone && !program.isDone) {
      final student = studentById(program.studentId);
      events = _withEvent(EventType.progress, '${student?.name ?? ''} أتمّ برنامج ${program.title}', studentId: program.studentId);
    }
    await _commit(_copy(programs: _data.programs.map((p) => p.id == programId ? updated : p).toList(), events: events));
  }

  Future<void> deleteProgram(String id) async =>
      _commit(_copy(programs: _data.programs.where((p) => p.id != id).toList()));

  // ------------------------------------------------------------------ exams
  Exam newExam({required String studentId, required String title, required DateTime date, String notes = ''}) =>
      Exam(id: _id('e'), studentId: studentId, title: title.trim(), date: date, notes: notes.trim());

  Future<void> saveExam(Exam exam, {required bool isNew}) async {
    final exams = isNew ? [..._data.exams, exam] : _data.exams.map((e) => e.id == exam.id ? exam : e).toList();
    final student = studentById(exam.studentId);
    final events = isNew
        ? _withEvent(EventType.exam, 'تمت برمجة ${exam.title} لـ${student?.name ?? ''}', studentId: exam.studentId)
        : _data.events;
    await _commit(_copy(exams: exams, events: events));
  }

  /// Records the mark (out of 20); 10 or more = passed.
  Future<void> recordResult(String examId, double grade) async {
    final exam = _data.exams.firstWhere((e) => e.id == examId);
    final passed = grade >= 10;
    final updated = exam.copyWith(grade: grade, status: passed ? ExamStatus.passed : ExamStatus.failed);
    final events = _withEvent(
      EventType.exam,
      'نتيجة ${exam.title}: ${grade.toStringAsFixed(grade % 1 == 0 ? 0 : 1)}/20 — ${passed ? 'ناجح' : 'يُعاد'}',
      studentId: exam.studentId,
    );
    await _commit(_copy(exams: _data.exams.map((e) => e.id == examId ? updated : e).toList(), events: events));
  }

  Future<void> deleteExam(String id) async => _commit(_copy(exams: _data.exams.where((e) => e.id != id).toList()));
}
