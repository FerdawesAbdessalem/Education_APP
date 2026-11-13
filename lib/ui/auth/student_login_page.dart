import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wirdi_app/state/app_state.dart';
import 'package:wirdi_app/ui/student/student_shell.dart';
import 'package:wirdi_app/ui/theme.dart';

/// Students sign in with their e-mail and the 6-digit code given by the supervisor.
class StudentLoginPage extends StatefulWidget {
  const StudentLoginPage({super.key});

  @override
  State<StudentLoginPage> createState() => _StudentLoginPageState();
}

class _StudentLoginPageState extends State<StudentLoginPage> {
  final _form = GlobalKey<FormState>();
  final _email = TextEditingController();
  final _code = TextEditingController();
  String? _error;

  @override
  void dispose() {
    _email.dispose();
    _code.dispose();
    super.dispose();
  }

  void _submit() {
    if (!(_form.currentState?.validate() ?? false)) return;
    final error = context.read<AppState>().loginStudent(_email.text, _code.text);
    if (error != null) {
      setState(() => _error = error);
      return;
    }
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => const StudentShell()),
      (route) => route.isFirst,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('فضاء الطالب')),
      body: Form(
        key: _form,
        child: ListView(
          padding: const EdgeInsets.all(24),
          children: [
            const CircleAvatar(
              radius: 40,
              backgroundColor: AppColors.goldSoft,
              child: Icon(Icons.school_rounded, size: 40, color: AppColors.gold),
            ),
            const SizedBox(height: 16),
            const Text('تسجيل الدخول', textAlign: TextAlign.center, style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800)),
            const SizedBox(height: 4),
            const Text(
              'استعمل بريدك الإلكتروني ورمز الدخول الذي سلّمه لك المشرف.',
              textAlign: TextAlign.center,
              style: TextStyle(color: AppColors.textMuted),
            ),
            const SizedBox(height: 24),
            TextFormField(
              controller: _email,
              keyboardType: TextInputType.emailAddress,
              textDirection: TextDirection.ltr,
              decoration: const InputDecoration(labelText: 'البريد الإلكتروني', prefixIcon: Icon(Icons.mail_outline)),
              validator: (v) => (v != null && v.contains('@')) ? null : 'أدخل بريدًا إلكترونيًا صحيحًا',
            ),
            const SizedBox(height: 14),
            TextFormField(
              controller: _code,
              keyboardType: TextInputType.number,
              maxLength: 6,
              decoration: const InputDecoration(labelText: 'رمز الدخول (6 أرقام)', prefixIcon: Icon(Icons.key_outlined)),
              validator: (v) => RegExp(r'^\d{6}$').hasMatch(v ?? '') ? null : 'الرمز يتكون من 6 أرقام',
              onFieldSubmitted: (_) => _submit(),
            ),
            if (_error != null)
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Text(_error!, style: const TextStyle(color: AppColors.danger, fontWeight: FontWeight.w600)),
              ),
            const SizedBox(height: 8),
            FilledButton(onPressed: _submit, child: const Text('دخول')),
          ],
        ),
      ),
    );
  }
}
