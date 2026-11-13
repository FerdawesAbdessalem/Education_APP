import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wirdi_app/data/models.dart';
import 'package:wirdi_app/state/app_state.dart';
import 'package:wirdi_app/ui/supervisor/exam_form_page.dart';
import 'package:wirdi_app/ui/theme.dart';
import 'package:wirdi_app/ui/widgets.dart';

class ExamsPage extends StatelessWidget {
  const ExamsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final s = context.watch<AppState>();
    final upcoming = s.upcomingExams;
    final past = s.exams.where((e) => !e.isUpcoming).toList().reversed.toList();

    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ExamFormPage())),
        icon: const Icon(Icons.event_note_rounded),
        label: const Text('برمجة اختبار'),
      ),
      body: (upcoming.isEmpty && past.isEmpty)
          ? const EmptyState(icon: Icons.fact_check_rounded, title: 'لا توجد اختبارات', message: 'برمج اختبارًا لأحد الطلاب.')
          : ListView(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 96),
              children: [
                if (upcoming.isNotEmpty) const SectionTitle('القادمة'),
                ...upcoming.map((e) => Padding(padding: const EdgeInsets.only(bottom: 10), child: ExamTile(exam: e))),
                if (past.isNotEmpty) const SectionTitle('النتائج'),
                ...past.map((e) => Padding(padding: const EdgeInsets.only(bottom: 10), child: ExamTile(exam: e))),
              ],
            ),
    );
  }
}

/// Exam row with its status, and a button to record the result.
class ExamTile extends StatelessWidget {
  const ExamTile({super.key, required this.exam, this.showStudent = true, this.readOnly = false});

  final Exam exam;
  final bool showStudent;
  final bool readOnly;

  @override
  Widget build(BuildContext context) {
    final s = context.watch<AppState>();
    final student = s.studentById(exam.studentId);
    final (label, color) = switch (exam.status) {
      ExamStatus.scheduled => (Dates.relative(exam.date, s.now), AppColors.primary),
      ExamStatus.passed => ('ناجح · ${_grade(exam.grade)}/20', AppColors.success),
      ExamStatus.failed => ('يُعاد · ${_grade(exam.grade)}/20', AppColors.danger),
    };

    return AppCard(
      onTap: readOnly ? null : () => Navigator.push(context, MaterialPageRoute(builder: (_) => ExamFormPage(exam: exam))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.fact_check_outlined, color: AppColors.gold),
              const SizedBox(width: 8),
              Expanded(child: Text(exam.title, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 15))),
              Pill(label, color: color),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            [if (showStudent && student != null) student.name, Dates.day(exam.date)].join(' · '),
            style: const TextStyle(color: AppColors.textMuted, fontSize: 13),
          ),
          if (exam.notes.isNotEmpty) ...[
            const SizedBox(height: 6),
            Text(exam.notes, style: const TextStyle(fontSize: 13)),
          ],
          if (!readOnly && exam.isUpcoming) ...[
            const SizedBox(height: 10),
            Align(
              alignment: AlignmentDirectional.centerEnd,
              child: FilledButton.tonalIcon(
                style: FilledButton.styleFrom(minimumSize: const Size(0, 40)),
                onPressed: () => recordResultDialog(context, exam),
                icon: const Icon(Icons.grading_rounded, size: 18),
                label: const Text('تسجيل النتيجة'),
              ),
            ),
          ],
        ],
      ),
    );
  }

  static String _grade(double? g) => g == null ? '-' : g.toStringAsFixed(g % 1 == 0 ? 0 : 1);
}

Future<void> recordResultDialog(BuildContext context, Exam exam) async {
  final controller = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final grade = await showDialog<double>(
    context: context,
    builder: (c) => AlertDialog(
      title: Text('نتيجة ${exam.title}'),
      content: Form(
        key: formKey,
        child: TextFormField(
          controller: controller,
          autofocus: true,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          decoration: const InputDecoration(labelText: 'العدد على 20', helperText: '10 فما فوق = ناجح'),
          validator: (v) {
            final n = double.tryParse((v ?? '').replaceAll(',', '.'));
            return (n == null || n < 0 || n > 20) ? 'أدخل عددًا بين 0 و20' : null;
          },
        ),
      ),
      actions: [
        TextButton(onPressed: () => Navigator.pop(c), child: const Text('إلغاء')),
        FilledButton(
          style: FilledButton.styleFrom(minimumSize: const Size(88, 44)),
          onPressed: () {
            if (formKey.currentState?.validate() ?? false) {
              Navigator.pop(c, double.parse(controller.text.replaceAll(',', '.')));
            }
          },
          child: const Text('حفظ'),
        ),
      ],
    ),
  );
  if (grade != null && context.mounted) {
    await context.read<AppState>().recordResult(exam.id, grade);
  }
}
