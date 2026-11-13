import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wirdi_app/data/models.dart';
import 'package:wirdi_app/state/app_state.dart';
import 'package:wirdi_app/ui/supervisor/student_picker.dart';
import 'package:wirdi_app/ui/theme.dart';
import 'package:wirdi_app/ui/widgets.dart';

class ExamFormPage extends StatefulWidget {
  const ExamFormPage({super.key, this.exam, this.initialStudentId});

  /// Null to schedule a new exam.
  final Exam? exam;
  final String? initialStudentId;

  @override
  State<ExamFormPage> createState() => _ExamFormPageState();
}

class _ExamFormPageState extends State<ExamFormPage> {
  final _form = GlobalKey<FormState>();
  late final _title = TextEditingController(text: widget.exam?.title);
  late final _notes = TextEditingController(text: widget.exam?.notes);
  late String? _studentId = widget.exam?.studentId ?? widget.initialStudentId;
  late DateTime _date = widget.exam?.date ?? DateTime.now().add(const Duration(days: 7));

  bool get _isNew => widget.exam == null;

  @override
  void dispose() {
    _title.dispose();
    _notes.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: now.subtract(const Duration(days: 365)),
      lastDate: now.add(const Duration(days: 365 * 2)),
    );
    if (picked != null) setState(() => _date = picked);
  }

  Future<void> _save() async {
    if (!(_form.currentState?.validate() ?? false)) return;
    final state = context.read<AppState>();
    final exam = _isNew
        ? state.newExam(studentId: _studentId!, title: _title.text, date: _date, notes: _notes.text)
        : widget.exam!.copyWith(studentId: _studentId, title: _title.text.trim(), date: _date, notes: _notes.text.trim());
    await state.saveExam(exam, isNew: _isNew);
    if (!mounted) return;
    showMessage(context, _isNew ? 'تمت برمجة الاختبار' : 'تم حفظ الاختبار');
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_isNew ? 'برمجة اختبار' : 'تعديل الاختبار'),
        actions: [
          if (!_isNew)
            IconButton(
              tooltip: 'حذف',
              icon: const Icon(Icons.delete_outline, color: AppColors.danger),
              onPressed: () async {
                if (await confirmDelete(context, 'هذا الاختبار') && context.mounted) {
                  await context.read<AppState>().deleteExam(widget.exam!.id);
                  if (context.mounted) Navigator.pop(context);
                }
              },
            ),
        ],
      ),
      body: Form(
        key: _form,
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            StudentPicker(value: _studentId, onChanged: (v) => setState(() => _studentId = v)),
            const SizedBox(height: 14),
            TextFormField(
              controller: _title,
              decoration: const InputDecoration(labelText: 'عنوان الاختبار', hintText: 'مثال: اختبار جزء عمّ'),
              validator: (v) => (v == null || v.trim().isEmpty) ? 'العنوان إجباري' : null,
            ),
            const SizedBox(height: 14),
            ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
                side: const BorderSide(color: AppColors.border),
              ),
              tileColor: AppColors.surface,
              leading: const Icon(Icons.event_outlined),
              title: const Text('التاريخ'),
              subtitle: Text(Dates.day(_date)),
              onTap: _pickDate,
            ),
            const SizedBox(height: 14),
            TextFormField(controller: _notes, maxLines: 3, decoration: const InputDecoration(labelText: 'ملاحظات (اختياري)')),
            const SizedBox(height: 24),
            FilledButton(onPressed: _save, child: Text(_isNew ? 'برمجة الاختبار' : 'حفظ')),
          ],
        ),
      ),
    );
  }
}
