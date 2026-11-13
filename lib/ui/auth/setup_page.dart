import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wirdi_app/state/app_state.dart';
import 'package:wirdi_app/ui/supervisor/supervisor_shell.dart';
import 'package:wirdi_app/ui/theme.dart';

/// First launch: the supervisor registers the association and chooses a PIN.
class SetupPage extends StatefulWidget {
  const SetupPage({super.key});

  @override
  State<SetupPage> createState() => _SetupPageState();
}

class _SetupPageState extends State<SetupPage> {
  final _form = GlobalKey<FormState>();
  final _association = TextEditingController();
  final _supervisor = TextEditingController();
  final _pin = TextEditingController();
  final _pinConfirm = TextEditingController();
  bool _withDemo = true;
  bool _saving = false;

  @override
  void dispose() {
    for (final c in [_association, _supervisor, _pin, _pinConfirm]) {
      c.dispose();
    }
    super.dispose();
  }

  Future<void> _submit() async {
    if (!(_form.currentState?.validate() ?? false)) return;
    setState(() => _saving = true);
    await context.read<AppState>().setUpAssociation(
          name: _association.text,
          supervisor: _supervisor.text,
          pin: _pin.text,
          withDemo: _withDemo,
        );
    if (!mounted) return;
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => const SupervisorShell()),
      (route) => route.isFirst,
    );
  }

  String? _required(String? v) => (v == null || v.trim().isEmpty) ? 'هذا الحقل إجباري' : null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('إعداد الجمعية')),
      body: Form(
        key: _form,
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            const Text(
              'مرحبًا بك! أدخل معلومات جمعيتك واختر رمزًا سريًا من 4 أرقام لحماية فضاء المشرف على هذا الجهاز.',
              style: TextStyle(color: AppColors.textMuted, height: 1.5),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _association,
              decoration: const InputDecoration(labelText: 'اسم الجمعية', prefixIcon: Icon(Icons.mosque_outlined)),
              validator: _required,
            ),
            const SizedBox(height: 14),
            TextFormField(
              controller: _supervisor,
              decoration: const InputDecoration(labelText: 'اسم المشرف', prefixIcon: Icon(Icons.person_outline)),
              validator: _required,
            ),
            const SizedBox(height: 14),
            TextFormField(
              controller: _pin,
              obscureText: true,
              keyboardType: TextInputType.number,
              maxLength: 4,
              decoration: const InputDecoration(labelText: 'الرمز السري (4 أرقام)', prefixIcon: Icon(Icons.lock_outline)),
              validator: (v) => RegExp(r'^\d{4}$').hasMatch(v ?? '') ? null : 'أدخل 4 أرقام',
            ),
            TextFormField(
              controller: _pinConfirm,
              obscureText: true,
              keyboardType: TextInputType.number,
              maxLength: 4,
              decoration: const InputDecoration(labelText: 'تأكيد الرمز السري', prefixIcon: Icon(Icons.lock_outline)),
              validator: (v) => v == _pin.text ? null : 'الرمزان غير متطابقين',
            ),
            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              value: _withDemo,
              onChanged: (v) => setState(() => _withDemo = v),
              title: const Text('إضافة بيانات تجريبية'),
              subtitle: const Text('حلقات وطلاب وبرامج وهمية لاكتشاف التطبيق'),
            ),
            const SizedBox(height: 16),
            FilledButton(
              onPressed: _saving ? null : _submit,
              child: _saving
                  ? const SizedBox(width: 22, height: 22, child: CircularProgressIndicator(strokeWidth: 2.4, color: Colors.white))
                  : const Text('إنشاء الفضاء'),
            ),
          ],
        ),
      ),
    );
  }
}
