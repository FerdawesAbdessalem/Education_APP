import 'package:flutter_test/flutter_test.dart';
import 'package:wirdi_app/data/models.dart';
import 'package:wirdi_app/data/wird_repository.dart';
import 'package:wirdi_app/state/app_state.dart';

void main() {
  final now = DateTime(2025, 1, 15, 10);

  Future<AppState> freshState() async {
    final state = AppState(MemoryWirdRepository(), clock: () => now);
    await state.init();
    await state.setUpAssociation(name: 'جمعية النور', supervisor: 'مريم', pin: '1234');
    return state;
  }

  group('Program', () {
    test('progress and completion', () {
      const p = Program(id: 'p', studentId: 's', type: ProgramType.memorization, title: 'الملك', totalUnits: 10, doneUnits: 4);
      expect(p.progress, 0.4);
      expect(p.isDone, isFalse);
      expect(p.copyWith(doneUnits: 50).doneUnits, 10, reason: 'done is capped by the total');
    });

    test('a programme close to its deadline and far from done is at risk', () {
      final p = Program(id: 'p', studentId: 's', type: ProgramType.revision, title: 'يس', totalUnits: 10, doneUnits: 2, deadline: now.add(const Duration(days: 3)));
      expect(p.isAtRisk(now), isTrue);
      expect(p.copyWith(doneUnits: 10).isAtRisk(now), isFalse);
    });

    test('JSON round trip', () {
      final p = Program(id: 'p', studentId: 's', type: ProgramType.revision, title: 'يس', totalUnits: 6, doneUnits: 2, deadline: now);
      final back = Program.fromJson(p.toJson());
      expect(back.title, p.title);
      expect(back.type, ProgramType.revision);
      expect(back.deadline, now);
    });
  });

  group('AppState', () {
    test('supervisor PIN', () async {
      final state = await freshState();
      state.logout();
      expect(state.loginSupervisor('0000'), isFalse);
      expect(state.loginSupervisor('1234'), isTrue);
      expect(state.session, Session.supervisor);
    });

    test('student signs in with e-mail and access code', () async {
      final state = await freshState();
      final student = await state.saveStudent(name: 'آمنة بن علي', email: 'Amna@Example.com');
      expect(student.accessCode, hasLength(6));
      expect(state.loginStudent('amna@example.com', '000000'), isNotNull);
      expect(state.loginStudent(' amna@example.com ', student.accessCode), isNull);
      expect(state.currentStudent?.id, student.id);
    });

    test('completing a programme creates a notification', () async {
      final state = await freshState();
      final student = await state.saveStudent(name: 'يوسف', email: 'y@example.com');
      final program = state.newProgram(studentId: student.id, type: ProgramType.memorization, title: 'الناس', totalUnits: 1);
      await state.saveProgram(program, isNew: true);
      await state.addProgress(program.id, 1);
      expect(state.programsOf(student.id).single.isDone, isTrue);
      expect(state.notifications.first.type, EventType.progress);
    });

    test('exam result: 10/20 or more is a pass', () async {
      final state = await freshState();
      final student = await state.saveStudent(name: 'خديجة', email: 'k@example.com');
      final exam = state.newExam(studentId: student.id, title: 'اختبار', date: now);
      await state.saveExam(exam, isNew: true);
      await state.recordResult(exam.id, 12.5);
      expect(state.examsOf(student.id).single.status, ExamStatus.passed);
    });

    test('deleting a student removes their programmes and exams', () async {
      final state = await freshState();
      final student = await state.saveStudent(name: 'عمر', email: 'o@example.com');
      await state.saveProgram(state.newProgram(studentId: student.id, type: ProgramType.revision, title: 'يس', totalUnits: 5), isNew: true);
      await state.deleteStudent(student.id);
      expect(state.programs, isEmpty);
      expect(state.students, isEmpty);
    });
  });
}
