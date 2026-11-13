import 'package:wirdi_app/data/models.dart';
import 'package:wirdi_app/data/wird_repository.dart';

/// Fictional sample data so the app can be explored right away
/// (no real person's name, e-mail or phone number).
WirdData buildDemoData(Association association, DateTime now) {
  DateTime inDays(int d) => DateTime(now.year, now.month, now.day).add(Duration(days: d));

  const groups = [
    Group(id: 'g1', name: 'حلقة جزء عمّ', supervisor: 'الأستاذة مريم'),
    Group(id: 'g2', name: 'حلقة سورة البقرة', supervisor: 'الأستاذ يوسف'),
    Group(id: 'g3', name: 'حلقة يس والصافات', supervisor: 'الأستاذة سارة'),
  ];

  const students = [
    Student(id: 's1', name: 'آمنة بن علي', email: 'amna@example.com', accessCode: '204816', groupId: 'g1', phone: '20 000 001'),
    Student(id: 's2', name: 'يوسف التميمي', email: 'youssef@example.com', accessCode: '318402', groupId: 'g2', phone: '20 000 002'),
    Student(id: 's3', name: 'خديجة الحداد', email: 'khadija@example.com', accessCode: '527193', groupId: 'g2'),
    Student(id: 's4', name: 'عمر الشابي', email: 'omar@example.com', accessCode: '640358', groupId: 'g3'),
    Student(id: 's5', name: 'ليلى الجزيري', email: 'leila@example.com', accessCode: '751624', groupId: 'g1'),
  ];

  final programs = [
    Program(id: 'p1', studentId: 's1', type: ProgramType.memorization, title: 'سورة النبأ إلى سورة الناس', totalUnits: 23, doneUnits: 18, deadline: inDays(20)),
    Program(id: 'p2', studentId: 's2', type: ProgramType.memorization, title: 'سورة البقرة (1 – 141)', totalUnits: 20, doneUnits: 9, deadline: inDays(5)),
    Program(id: 'p3', studentId: 's3', type: ProgramType.revision, title: 'الثمن الأخير من سورة البقرة', totalUnits: 10, doneUnits: 10, deadline: inDays(-2)),
    Program(id: 'p4', studentId: 's4', type: ProgramType.revision, title: 'سورة يس', totalUnits: 6, doneUnits: 2, deadline: inDays(12)),
    Program(id: 'p5', studentId: 's5', type: ProgramType.memorization, title: 'جزء تبارك', totalUnits: 20, doneUnits: 4, deadline: inDays(40)),
    Program(id: 'p6', studentId: 's1', type: ProgramType.revision, title: 'جزء عمّ كاملًا', totalUnits: 23, doneUnits: 11, deadline: inDays(30)),
  ];

  final exams = [
    Exam(id: 'e1', studentId: 's1', title: 'اختبار جزء عمّ', date: inDays(6)),
    Exam(id: 'e2', studentId: 's2', title: 'اختبار الربع الأول من البقرة', date: inDays(14)),
    Exam(id: 'e3', studentId: 's3', title: 'اختبار مراجعة البقرة', date: inDays(-10), status: ExamStatus.passed, grade: 17.5),
    Exam(id: 'e4', studentId: 's4', title: 'اختبار سورة الصافات', date: inDays(-20), status: ExamStatus.failed, grade: 8),
  ];

  final events = [
    AppEvent(id: 'n1', type: EventType.exam, message: 'تمت برمجة اختبار جزء عمّ لآمنة بن علي', date: now.subtract(const Duration(hours: 3)), studentId: 's1'),
    AppEvent(id: 'n2', type: EventType.progress, message: 'خديجة الحداد أنهت مراجعة الثمن الأخير من البقرة', date: now.subtract(const Duration(days: 1)), studentId: 's3'),
    AppEvent(id: 'n3', type: EventType.program, message: 'برنامج حفظ جديد: جزء تبارك لليلى الجزيري', date: now.subtract(const Duration(days: 2)), studentId: 's5'),
  ];

  return WirdData(
    association: association,
    groups: groups,
    students: students,
    programs: programs,
    exams: exams,
    events: events,
  );
}
