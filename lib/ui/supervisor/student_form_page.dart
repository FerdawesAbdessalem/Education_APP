import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wirdi_app/data/models.dart';
import 'package:wirdi_app/state/app_state.dart';
import 'package:wirdi_app/ui/supervisor/student_detail_page.dart';
import 'package:wirdi_app/ui/widgets.dart';

class StudentFormPage extends StatefulWidget {
  const StudentFormPage({super.key, this.student});

  /// Null to create a new student.
  final Student? student;

  @override
  State<StudentFormPage> createState() => _StudentFormPageState();
}

class _StudentFormPageState extends State<StudentFormPage> {
  final _form = GlobalKey<FormState>();
  late final _name = TextEditingController(text: widget.student?.name);
  late final _email = TextEditingController(text: widget.student?.email);
  late final _phone = TextEditingController(text: widget.student?.phone);
  late String? _groupId = widget.student?.groupId;
  bool _saving = false;

  bool get _isNew => widget.student == null;

  @override
  void dispose() {
    _name.dispose();
    _email.dispose();
    _phone.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (!(_form.currentState?.validate() ?? false)) return;
    setState(() => _saving = true);
    final student = await context.read<AppState>().saveStudent(
          id: widget.student?.id,
          name: _name.text,
          email: _email.text,
          phone: _phone.text,
          groupId: _groupId,
        );
    if (!mounted) return;
    if (_isNew) {
      showMessage(context, 'تمت إضافة ${student.name} — رمز الدخول: ${student.accessCode}');
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => StudentDetailPage(studentId: student.id)));
    } else {
      showMessage(context, 'تم حفظ التعديلات');
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final s = context.watch<AppState>();
    return Scaffold(
      appBar: AppBar(title: Text(_isNew ? 'طالب جديد' : 'تعديل الطالب')),
      body: Form(
        key: _form,
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            TextFormField(
              controller: _name,
              decoration: const InputDecoration(labelText: 'الاسم واللقب', prefixIcon: Icon(Icons.person_outline)),
              validator: (v) => (v == null || v.trim().length < 3) ? 'أدخل اسمًا صحيحًا' : null,
            ),
            const SizedBox(height: 14),
            TextFormField(
              controller: _email,
              keyboardType: TextInputType.emailAddress,
              textDirection: TextDirection.ltr,
              decoration: const InputDecoration(labelText: 'البريد الإلكتروني', prefixIcon: Icon(Icons.mail_outline)),
              validator: (v) {
                final value = v?.trim() ?? '';
                if (!RegExp(r'^[\w.+-]+@[\w-]+\.[\w.-]{2,}$').hasMatch(value)) return 'بريد إلكتروني غير صالح';
                if (s.emailTaken(value, exceptId: widget.student?.id)) return 'هذا البريد مستعمل من طالب آخر';
                return null;
              },
            ),
            const SizedBox(height: 14),
            TextFormField(
              controller: _phone,
              keyboardType: TextInputType.phone,
              textDirection: TextDirection.ltr,
              decoration: const InputDecoration(labelText: 'الهاتف (اختياري)', prefixIcon: Icon(Icons.phone_outlined)),
            ),
            const SizedBox(height: 14),
            DropdownButtonFormField<String?>(
              value: _groupId,
              decoration: const InputDecoration(labelText: 'الحلقة', prefixIcon: Icon(Icons.diversity_3_outlined)),
              items: [
                const DropdownMenuItem<String?>(value: null, child: Text('بدون حلقة')),
                ...s.groups.map((g) => DropdownMenuItem<String?>(value: g.id, child: Text(g.name))),
              ],
              onChanged: (v) => setState(() => _groupId = v),
            ),
            if (_isNew) ...[
              const SizedBox(height: 14),
              const Text(
                'سيُولَّد رمز دخول من 6 أرقام تسلّمه للطالب ليتابع برامجه من هاتفه.',
                style: TextStyle(color: Colors.black54),
              ),
            ],
            const SizedBox(height: 24),
            FilledButton(
              onPressed: _saving ? null : _save,
              child: Text(_isNew ? 'إضافة الطالب' : 'حفظ'),
            ),
          ],
        ),
      ),
    );
  }
}
