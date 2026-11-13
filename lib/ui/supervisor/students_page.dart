import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wirdi_app/data/models.dart';
import 'package:wirdi_app/state/app_state.dart';
import 'package:wirdi_app/ui/supervisor/groups_sheet.dart';
import 'package:wirdi_app/ui/supervisor/student_detail_page.dart';
import 'package:wirdi_app/ui/supervisor/student_form_page.dart';
import 'package:wirdi_app/ui/theme.dart';
import 'package:wirdi_app/ui/widgets.dart';

class StudentsPage extends StatefulWidget {
  const StudentsPage({super.key});

  @override
  State<StudentsPage> createState() => _StudentsPageState();
}

class _StudentsPageState extends State<StudentsPage> {
  String _query = '';
  String? _groupId;

  @override
  Widget build(BuildContext context) {
    final s = context.watch<AppState>();
    final q = _query.trim().toLowerCase();
    final students = s.students
        .where((st) => _groupId == null || st.groupId == _groupId)
        .where((st) => q.isEmpty || st.name.toLowerCase().contains(q) || st.email.toLowerCase().contains(q))
        .toList();

    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const StudentFormPage())),
        icon: const Icon(Icons.person_add_alt_1_rounded),
        label: const Text('طالب جديد'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 4, 16, 8),
            child: TextField(
              decoration: const InputDecoration(hintText: 'ابحث بالاسم أو البريد…', prefixIcon: Icon(Icons.search)),
              onChanged: (v) => setState(() => _query = v),
            ),
          ),
          SizedBox(
            height: 44,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: [
                Padding(
                  padding: const EdgeInsetsDirectional.only(end: 8),
                  child: ChoiceChip(label: const Text('الكل'), selected: _groupId == null, onSelected: (_) => setState(() => _groupId = null)),
                ),
                ...s.groups.map((g) => Padding(
                      padding: const EdgeInsetsDirectional.only(end: 8),
                      child: ChoiceChip(
                        label: Text(g.name),
                        selected: _groupId == g.id,
                        onSelected: (_) => setState(() => _groupId = g.id),
                      ),
                    )),
                ActionChip(
                  avatar: const Icon(Icons.tune_rounded, size: 18),
                  label: const Text('إدارة الحلقات'),
                  onPressed: () => showGroupsSheet(context),
                ),
              ],
            ),
          ),
          Expanded(
            child: students.isEmpty
                ? const EmptyState(
                    icon: Icons.person_search_rounded,
                    title: 'لا يوجد طلاب',
                    message: 'أضف طالبًا جديدًا بالزر في الأسفل.',
                  )
                : ListView.separated(
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 96),
                    itemCount: students.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 10),
                    itemBuilder: (_, i) => _StudentTile(student: students[i]),
                  ),
          ),
        ],
      ),
    );
  }
}

class _StudentTile extends StatelessWidget {
  const _StudentTile({required this.student});

  final Student student;

  @override
  Widget build(BuildContext context) {
    final s = context.watch<AppState>();
    final progress = s.progressOf(student.id);
    return AppCard(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => StudentDetailPage(studentId: student.id))),
      child: Row(
        children: [
          StudentAvatar(student: student),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(student.name, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 15)),
                Text(s.groupById(student.groupId)?.name ?? 'بدون حلقة', style: const TextStyle(color: AppColors.textMuted, fontSize: 13)),
                const SizedBox(height: 8),
                ProgressBar(value: progress, height: 6),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Text('${(progress * 100).round()}%',
              style: TextStyle(fontWeight: FontWeight.w800, color: AppColors.forProgress(progress))),
        ],
      ),
    );
  }
}
