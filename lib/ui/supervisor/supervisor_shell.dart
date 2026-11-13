import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wirdi_app/data/models.dart';
import 'package:wirdi_app/state/app_state.dart';
import 'package:wirdi_app/ui/common/notifications_page.dart';
import 'package:wirdi_app/ui/common/settings_page.dart';
import 'package:wirdi_app/ui/supervisor/exams_page.dart';
import 'package:wirdi_app/ui/supervisor/programs_page.dart';
import 'package:wirdi_app/ui/supervisor/student_detail_page.dart';
import 'package:wirdi_app/ui/supervisor/students_page.dart';
import 'package:wirdi_app/ui/theme.dart';
import 'package:wirdi_app/ui/widgets.dart';

class SupervisorShell extends StatefulWidget {
  const SupervisorShell({super.key});

  @override
  State<SupervisorShell> createState() => _SupervisorShellState();
}

class _SupervisorShellState extends State<SupervisorShell> {
  int _tab = 0;

  static const _titles = ['لوحة القيادة', 'الطلاب', 'البرامج', 'الاختبارات'];

  @override
  Widget build(BuildContext context) {
    final pages = [
      _Dashboard(onOpenTab: (i) => setState(() => _tab = i)),
      const StudentsPage(),
      const ProgramsPage(),
      const ExamsPage(),
    ];
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(_titles[_tab]),
        actions: [
          IconButton(
            tooltip: 'الإشعارات',
            icon: const Icon(Icons.notifications_none_rounded),
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const NotificationsPage())),
          ),
          IconButton(
            tooltip: 'الإعدادات',
            icon: const Icon(Icons.settings_outlined),
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const SettingsPage())),
          ),
        ],
      ),
      body: IndexedStack(index: _tab, children: pages),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _tab,
        onDestinationSelected: (i) => setState(() => _tab = i),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.dashboard_outlined), selectedIcon: Icon(Icons.dashboard_rounded), label: 'الرئيسية'),
          NavigationDestination(icon: Icon(Icons.groups_outlined), selectedIcon: Icon(Icons.groups_rounded), label: 'الطلاب'),
          NavigationDestination(icon: Icon(Icons.menu_book_outlined), selectedIcon: Icon(Icons.menu_book_rounded), label: 'البرامج'),
          NavigationDestination(icon: Icon(Icons.fact_check_outlined), selectedIcon: Icon(Icons.fact_check_rounded), label: 'الاختبارات'),
        ],
      ),
    );
  }
}

class _Dashboard extends StatelessWidget {
  const _Dashboard({required this.onOpenTab});

  final ValueChanged<int> onOpenTab;

  @override
  Widget build(BuildContext context) {
    final s = context.watch<AppState>();
    final association = s.association;
    final upcoming = s.upcomingExams.take(3).toList();
    final atRisk = s.atRiskPrograms;

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
                    Text('السلام عليكم ${association?.supervisorName ?? ''}',
                        style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w800)),
                    const SizedBox(height: 4),
                    Text(association?.name ?? '', style: TextStyle(color: Colors.white.withValues(alpha: 0.85))),
                    const SizedBox(height: 12),
                    const Text('متوسط تقدّم الطلاب', style: TextStyle(color: Colors.white70, fontSize: 13)),
                  ],
                ),
              ),
              ProgressRing(value: s.averageProgress, size: 84),
            ],
          ),
        ),
        const SizedBox(height: 14),
        GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          childAspectRatio: 1.45,
          children: [
            StatCard(icon: Icons.groups_rounded, value: '${s.students.length}', label: 'طالب'),
            StatCard(icon: Icons.diversity_3_rounded, value: '${s.groups.length}', label: 'حلقة', color: AppColors.gold),
            StatCard(icon: Icons.event_available_rounded, value: '${s.upcomingExams.length}', label: 'اختبار قادم', color: AppColors.success),
            StatCard(icon: Icons.warning_amber_rounded, value: '${atRisk.length}', label: 'برنامج متأخر', color: AppColors.danger),
          ],
        ),
        SectionTitle('الاختبارات القادمة', action: TextButton(onPressed: () => onOpenTab(3), child: const Text('الكل'))),
        if (upcoming.isEmpty)
          const AppCard(child: Text('لا توجد اختبارات مبرمجة.', style: TextStyle(color: AppColors.textMuted)))
        else
          ...upcoming.map((e) => _ExamRow(exam: e)),
        SectionTitle('برامج تحتاج متابعة', action: TextButton(onPressed: () => onOpenTab(2), child: const Text('الكل'))),
        if (atRisk.isEmpty)
          const AppCard(child: Text('كل البرامج تسير وفق الجدول 👏', style: TextStyle(color: AppColors.textMuted)))
        else
          ...atRisk.take(3).map((p) => Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: ProgramTile(program: p, now: s.now, subtitle: s.studentById(p.studentId)?.name),
              )),
      ],
    );
  }
}

class _ExamRow extends StatelessWidget {
  const _ExamRow({required this.exam});

  final Exam exam;

  @override
  Widget build(BuildContext context) {
    final s = context.watch<AppState>();
    final student = s.studentById(exam.studentId);
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: AppCard(
        onTap: student == null
            ? null
            : () => Navigator.push(context, MaterialPageRoute(builder: (_) => StudentDetailPage(studentId: student.id))),
        child: Row(
          children: [
            Container(
              width: 54,
              padding: const EdgeInsets.symmetric(vertical: 8),
              decoration: BoxDecoration(color: AppColors.goldSoft, borderRadius: BorderRadius.circular(12)),
              child: Column(
                children: [
                  Text('${exam.date.day}', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w800, color: AppColors.gold)),
                  Text(Dates.day(exam.date).split(' ')[1], style: const TextStyle(fontSize: 11, color: AppColors.gold)),
                ],
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(exam.title, style: const TextStyle(fontWeight: FontWeight.w700)),
                  Text(student?.name ?? '', style: const TextStyle(color: AppColors.textMuted, fontSize: 13)),
                ],
              ),
            ),
            Pill(Dates.relative(exam.date, s.now)),
          ],
        ),
      ),
    );
  }
}
