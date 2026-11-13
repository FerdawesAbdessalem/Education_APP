import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wirdi_app/data/models.dart';
import 'package:wirdi_app/state/app_state.dart';
import 'package:wirdi_app/ui/supervisor/student_picker.dart';
import 'package:wirdi_app/ui/theme.dart';
import 'package:wirdi_app/ui/widgets.dart';

class ProgramFormPage extends StatefulWidget {
  const ProgramFormPage({super.key, this.program, this.initialStudentId});

  /// Null to create a new programme.
  final Program? program;
  final String? initialStudentId;

  @override
  State<ProgramFormPage> createState() => _ProgramFormPageState();
}

class _ProgramFormPageState extends State<ProgramFormPage> {
  final _form = GlobalKey<FormState>();
  late final _title = TextEditingController(text: widget.program?.title);
  late final _total = TextEditingController(text: widget.program?.totalUnits.toString());
  late final _done = TextEditingController(text: (widget.program?.doneUnits ?? 0).toString());
  late final _notes = TextEditingController(text: widget.program?.notes);
  late String? _studentId = widget.program?.studentId ?? widget.initialStudentId;
  late ProgramType _type = widget.program?.type ?? ProgramType.memorization;
  late DateTime? _deadline = widget.program?.deadline;

  bool get _isNew => widget.program == null;

  @override
  void dispose() {
    for (final c in [_title, _total, _done, _notes]) {
      c.dispose();
    }
    super.dispose();
  }

  Future<void> _pickDeadline() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: _deadline ?? now.add(const Duration(days: 30)),
      firstDate: now.subtract(const Duration(days: 365)),
      lastDate: now.add(const Duration(days: 365 * 3)),
    );
    if (picked != null) setState(() => _deadline = picked);
  }

  Future<void> _save() async {
    if (!(_form.currentState?.validate() ?? false)) return;
    final state = context.read<AppState>();
    final total = int.parse(_total.text);
    final done = int.parse(_done.text).clamp(0, total);
    final program = _isNew
        ? state.newProgram(
            studentId: _studentId!,
            type: _type,
            title: _title.text,
            totalUnits: total,
            doneUnits: done,
            deadline: _deadline,
            notes: _notes.text,
          )
        : widget.program!.copyWith(
            studentId: _studentId,
            type: _type,
            title: _title.text.trim(),
            totalUnits: total,
            doneUnits: done,
            deadline: _deadline,
            notes: _notes.text.trim(),
          );
    await state.saveProgram(program, isNew: _isNew);
    if (!mounted) return;
    showMessage(context, _isNew ? 'تم إنشاء البرنامج' : 'تم حفظ البرنامج');
    Navigator.pop(context);
  }

  String? _positiveInt(String? v) {
    final n = int.tryParse(v ?? '');
    return (n == null || n <= 0) ? 'أدخل عددًا أكبر من 0' : null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_isNew ? 'برنامج جديد' : 'تعديل البرنامج'),
        actions: [
          if (!_isNew)
            IconButton(
              tooltip: 'حذف',
              icon: const Icon(Icons.delete_outline, color: AppColors.danger),
              onPressed: () async {
                if (await confirmDelete(context, 'هذا البرنامج') && context.mounted) {
                  await context.read<AppState>().deleteProgram(widget.program!.id);
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
            SegmentedButton<ProgramType>(
              segments: const [
                ButtonSegment(value: ProgramType.memorization, label: Text('حفظ'), icon: Icon(Icons.menu_book_rounded)),
                ButtonSegment(value: ProgramType.revision, label: Text('مراجعة'), icon: Icon(Icons.replay_rounded)),
              ],
              selected: {_type},
              onSelectionChanged: (s) => setState(() => _type = s.first),
            ),
            const SizedBox(height: 16),
            StudentPicker(value: _studentId, onChanged: (v) => setState(() => _studentId = v)),
            const SizedBox(height: 14),
            TextFormField(
              controller: _title,
              decoration: const InputDecoration(labelText: 'المقرر', hintText: 'مثال: سورة الملك'),
              validator: (v) => (v == null || v.trim().isEmpty) ? 'حدّد المقرر' : null,
            ),
            const SizedBox(height: 14),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _total,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(labelText: 'عدد الصفحات'),
                    validator: _positiveInt,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: TextFormField(
                    controller: _done,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(labelText: 'المنجز'),
                    validator: (v) {
                      final n = int.tryParse(v ?? '');
                      final total = int.tryParse(_total.text) ?? 0;
                      if (n == null || n < 0) return 'عدد غير صالح';
                      if (n > total) return 'أكبر من المجموع';
                      return null;
                    },
                  ),
                ),
              ],
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
              title: const Text('الموعد النهائي'),
              subtitle: Text(_deadline == null ? 'غير محدد' : Dates.day(_deadline!)),
              trailing: _deadline == null
                  ? null
                  : IconButton(tooltip: 'إزالة', icon: const Icon(Icons.close), onPressed: () => setState(() => _deadline = null)),
              onTap: _pickDeadline,
            ),
            const SizedBox(height: 14),
            TextFormField(controller: _notes, maxLines: 3, decoration: const InputDecoration(labelText: 'ملاحظات (اختياري)')),
            const SizedBox(height: 24),
            FilledButton(onPressed: _save, child: Text(_isNew ? 'إنشاء البرنامج' : 'حفظ')),
          ],
        ),
      ),
    );
  }
}
