import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wirdi_app/data/models.dart';
import 'package:wirdi_app/state/app_state.dart';
import 'package:wirdi_app/ui/supervisor/program_form_page.dart';
import 'package:wirdi_app/ui/widgets.dart';

/// Memorization and revision programmes of all students, in two tabs.
class ProgramsPage extends StatelessWidget {
  const ProgramsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ProgramFormPage())),
          icon: const Icon(Icons.add),
          label: const Text('برنامج جديد'),
        ),
        body: const Column(
          children: [
            TabBar(tabs: [Tab(text: 'الحفظ'), Tab(text: 'المراجعة')]),
            Expanded(
              child: TabBarView(
                children: [
                  _ProgramList(type: ProgramType.memorization),
                  _ProgramList(type: ProgramType.revision),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProgramList extends StatelessWidget {
  const _ProgramList({required this.type});

  final ProgramType type;

  @override
  Widget build(BuildContext context) {
    final s = context.watch<AppState>();
    final now = s.now;
    // Late programmes first, then by deadline.
    final list = s.programs.where((p) => p.type == type).toList()
      ..sort((a, b) {
        final risk = (b.isAtRisk(now) ? 1 : 0) - (a.isAtRisk(now) ? 1 : 0);
        if (risk != 0) return risk;
        return (a.deadline ?? DateTime(9999)).compareTo(b.deadline ?? DateTime(9999));
      });

    if (list.isEmpty) {
      return EmptyState(
        icon: type == ProgramType.memorization ? Icons.menu_book_rounded : Icons.replay_rounded,
        title: type == ProgramType.memorization ? 'لا توجد برامج حفظ' : 'لا توجد برامج مراجعة',
        message: 'أنشئ برنامجًا وحدّد عدد الصفحات والموعد النهائي.',
      );
    }
    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 96),
      itemCount: list.length,
      separatorBuilder: (_, __) => const SizedBox(height: 10),
      itemBuilder: (_, i) {
        final p = list[i];
        return ProgramTile(
          program: p,
          now: now,
          subtitle: s.studentById(p.studentId)?.name,
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ProgramFormPage(program: p))),
          onIncrement: () => context.read<AppState>().addProgress(p.id, 1),
          onDecrement: () => context.read<AppState>().addProgress(p.id, -1),
        );
      },
    );
  }
}
