import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wirdi_app/data/models.dart';
import 'package:wirdi_app/state/app_state.dart';
import 'package:wirdi_app/ui/common/notifications_page.dart';
import 'package:wirdi_app/ui/common/settings_page.dart';
import 'package:wirdi_app/ui/supervisor/exams_page.dart';
import 'package:wirdi_app/ui/theme.dart';
import 'package:wirdi_app/ui/widgets.dart';

/// Student space: my programmes (with progress I can update), my exams, my notifications.
class StudentShell extends StatefulWidget {
  const StudentShell({super.key});

  @override
  State<StudentShell> createState() => _StudentShellState();
}

class _StudentShellState extends State<StudentShell> {
  int _tab = 0;

  @override
  Widget build(BuildContext context) {
    final student = context.watch<AppState>().currentStudent;
    if (student == null) {
      return const Scaffold(body: EmptyState(icon: Icons.person_off_outlined, title: 'انتهت الجلسة'));
    }
    const titles = ['وردي', 'اختباراتي', 'الإشعارات'];
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(titles[_tab]),
        actions: [
          IconButton(
            tooltip: 'الإعدادات',
            icon: const Icon(Icons.settings_outlined),
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const SettingsPage())),
          ),
        ],
      ),
      body: IndexedStack(
        index: _tab,
        children: [
          _MyWird(student: student),
          _MyExams(student: student),
          const NotificationsPage(embedded: true),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _tab,
        onDestinationSelected: (i) => setState(() => _tab = i),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.menu_book_outlined), selectedIcon: Icon(Icons.menu_book_rounded), label: 'وردي'),
          NavigationDestination(icon: Icon(Icons.fact_check_outlined), selectedIcon: Icon(Icons.fact_check_rounded), label: 'اختباراتي'),
          NavigationDestination(icon: Icon(Icons.notifications_none_rounded), selectedIcon: Icon(Icons.notifications_rounded), label: 'الإشعارات'),
        ],
      ),
    );
  }
}

class _MyWird extends StatelessWidget {
  const _MyWird({required this.student});

  final Student student;

  @override
  Widget build(BuildContext context) {
    final s = context.watch<AppState>();
    final memorization = s.programsOf(student.id, ProgramType.memorization);
    final revision = s.programsOf(student.id, ProgramType.revision);
    final next = s.examsOf(student.id).where((e) => e.isUpcoming).firstOrNull;

    Widget programList(List<Program> list) => Column(
          children: list
              .map((p) => Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: ProgramTile(
                      program: p,
                      now: s.now,
                      onIncrement: () => context.read<AppState>().addProgress(p.id, 1),
                      onDecrement: () => context.read<AppState>().addProgress(p.id, -1),
                    ),
                  ))
              .toList(),
        );

    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 4, 16, 24),
      children: [
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(gradient: AppColors.headerGradient, borderRadius: BorderRadius.circular(22)),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('أهلًا ${student.name.split(' ').first} 👋',
                        style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w800)),
                    const SizedBox(height: 6),
                    Text(
                      s.groupById(student.groupId)?.name ?? '',
                      style: TextStyle(color: Colors.white.withValues(alpha: 0.85)),
                    ),
                    const SizedBox(height: 10),
                    const Text('«خيركم من تعلّم القرآن وعلّمه»', style: TextStyle(color: AppColors.goldSoft, fontSize: 13)),
                  ],
                ),
              ),
              ProgressRing(value: s.progressOf(student.id), size: 84),
            ],
          ),
        ),
        if (next != null) ...[
          const SectionTitle('اختباري القادم'),
          ExamTile(exam: next, showStudent: false, readOnly: true),
        ],
        const SectionTitle('الحفظ'),
        if (memorization.isEmpty)
          const AppCard(child: Text('لا يوجد برنامج حفظ حاليًا.', style: TextStyle(color: AppColors.textMuted)))
        else
          programList(memorization),
        const SectionTitle('المراجعة'),
        if (revision.isEmpty)
          const AppCard(child: Text('لا يوجد برنامج مراجعة حاليًا.', style: TextStyle(color: AppColors.textMuted)))
        else
          programList(revision),
        const SizedBox(height: 8),
        const Text(
          'اضغط على ⊕ بعد إتمام كل صفحة ليتابع المشرف تقدّمك.',
          textAlign: TextAlign.center,
          style: TextStyle(color: AppColors.textMuted, fontSize: 13),
        ),
      ],
    );
  }
}

class _MyExams extends StatelessWidget {
  const _MyExams({required this.student});

  final Student student;

  @override
  Widget build(BuildContext context) {
    final exams = context.watch<AppState>().examsOf(student.id);
    if (exams.isEmpty) {
      return const EmptyState(icon: Icons.fact_check_rounded, title: 'لا توجد اختبارات', message: 'سيبرمج المشرف اختباراتك هنا.');
    }
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: exams.length,
      separatorBuilder: (_, __) => const SizedBox(height: 10),
      itemBuilder: (_, i) => ExamTile(exam: exams[i], showStudent: false, readOnly: true),
    );
  }
}
