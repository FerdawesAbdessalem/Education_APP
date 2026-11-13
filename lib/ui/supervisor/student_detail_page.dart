import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:wirdi_app/state/app_state.dart';
import 'package:wirdi_app/ui/supervisor/exam_form_page.dart';
import 'package:wirdi_app/ui/supervisor/exams_page.dart';
import 'package:wirdi_app/ui/supervisor/program_form_page.dart';
import 'package:wirdi_app/ui/supervisor/student_form_page.dart';
import 'package:wirdi_app/ui/theme.dart';
import 'package:wirdi_app/ui/widgets.dart';

class StudentDetailPage extends StatelessWidget {
  const StudentDetailPage({super.key, required this.studentId});

  final String studentId;

  @override
  Widget build(BuildContext context) {
    final s = context.watch<AppState>();
    final student = s.studentById(studentId);
    if (student == null) {
      return Scaffold(appBar: AppBar(), body: const EmptyState(icon: Icons.person_off_outlined, title: 'الطالب غير موجود'));
    }
    final programs = s.programsOf(student.id);
    final exams = s.examsOf(student.id);

    return Scaffold(
      appBar: AppBar(
        title: Text(student.name),
        actions: [
          IconButton(
            tooltip: 'تعديل',
            icon: const Icon(Icons.edit_outlined),
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => StudentFormPage(student: student))),
          ),
          IconButton(
            tooltip: 'حذف',
            icon: const Icon(Icons.delete_outline, color: AppColors.danger),
            onPressed: () async {
              if (await confirmDelete(context, 'الطالب ${student.name} وكل برامجه') && context.mounted) {
                Navigator.pop(context);
                await context.read<AppState>().deleteStudent(student.id);
              }
            },
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 4, 16, 32),
        children: [
          AppCard(
            child: Column(
              children: [
                Row(
                  children: [
                    StudentAvatar(student: student, radius: 30),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(student.name, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
                          Text(s.groupById(student.groupId)?.name ?? 'بدون حلقة', style: const TextStyle(color: AppColors.textMuted)),
                        ],
                      ),
                    ),
                    ProgressRing(value: s.progressOf(student.id), size: 62, color: AppColors.primary),
                  ],
                ),
                const Divider(height: 28),
                _InfoRow(icon: Icons.mail_outline, text: student.email),
                if (student.phone.isNotEmpty) _InfoRow(icon: Icons.phone_outlined, text: student.phone),
                _InfoRow(
                  icon: Icons.key_outlined,
                  text: 'رمز الدخول: ${student.accessCode}',
                  trailing: IconButton(
                    tooltip: 'نسخ الرمز',
                    icon: const Icon(Icons.copy_rounded, size: 18),
                    onPressed: () {
                      Clipboard.setData(ClipboardData(text: student.accessCode));
                      showMessage(context, 'تم نسخ رمز الدخول');
                    },
                  ),
                ),
              ],
            ),
          ),
          SectionTitle(
            'البرامج',
            action: TextButton.icon(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => ProgramFormPage(initialStudentId: student.id)),
              ),
              icon: const Icon(Icons.add),
              label: const Text('برنامج'),
            ),
          ),
          if (programs.isEmpty)
            const AppCard(child: Text('لا توجد برامج بعد.', style: TextStyle(color: AppColors.textMuted)))
          else
            ...programs.map((p) => Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: ProgramTile(
                    program: p,
                    now: s.now,
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ProgramFormPage(program: p))),
                    onIncrement: () => context.read<AppState>().addProgress(p.id, 1),
                    onDecrement: () => context.read<AppState>().addProgress(p.id, -1),
                  ),
                )),
          SectionTitle(
            'الاختبارات',
            action: TextButton.icon(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => ExamFormPage(initialStudentId: student.id)),
              ),
              icon: const Icon(Icons.add),
              label: const Text('اختبار'),
            ),
          ),
          if (exams.isEmpty)
            const AppCard(child: Text('لا توجد اختبارات بعد.', style: TextStyle(color: AppColors.textMuted)))
          else
            ...exams.map((e) => Padding(padding: const EdgeInsets.only(bottom: 10), child: ExamTile(exam: e, showStudent: false))),
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({required this.icon, required this.text, this.trailing});

  final IconData icon;
  final String text;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(icon, size: 20, color: AppColors.textMuted),
          const SizedBox(width: 10),
          Expanded(child: Text(text)),
          if (trailing != null) trailing!,
        ],
      ),
    );
  }
}
