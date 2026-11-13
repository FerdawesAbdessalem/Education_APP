import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wirdi_app/state/app_state.dart';
import 'package:wirdi_app/ui/supervisor/supervisor_shell.dart';
import 'package:wirdi_app/ui/theme.dart';

class SupervisorLoginPage extends StatefulWidget {
  const SupervisorLoginPage({super.key});

  @override
  State<SupervisorLoginPage> createState() => _SupervisorLoginPageState();
}

class _SupervisorLoginPageState extends State<SupervisorLoginPage> {
  final _pin = TextEditingController();
  String? _error;

  @override
  void dispose() {
    _pin.dispose();
    super.dispose();
  }

  void _submit() {
    final ok = context.read<AppState>().loginSupervisor(_pin.text);
    if (!ok) {
      setState(() => _error = 'الرمز السري غير صحيح');
      _pin.clear();
      return;
    }
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => const SupervisorShell()),
      (route) => route.isFirst,
    );
  }

  @override
  Widget build(BuildContext context) {
    final association = context.watch<AppState>().association;
    return Scaffold(
      appBar: AppBar(title: const Text('فضاء المشرف')),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          const CircleAvatar(
            radius: 40,
            backgroundColor: AppColors.primarySoft,
            child: Icon(Icons.lock_person_rounded, size: 40, color: AppColors.primary),
          ),
          const SizedBox(height: 16),
          Text(
            'مرحبًا ${association?.supervisorName ?? ''}',
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 4),
          Text(association?.name ?? '', textAlign: TextAlign.center, style: const TextStyle(color: AppColors.textMuted)),
          const SizedBox(height: 28),
          TextField(
            controller: _pin,
            autofocus: true,
            obscureText: true,
            keyboardType: TextInputType.number,
            maxLength: 4,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 26, letterSpacing: 16, fontWeight: FontWeight.w700),
            decoration: InputDecoration(labelText: 'الرمز السري', errorText: _error, counterText: ''),
            onChanged: (v) {
              if (_error != null) setState(() => _error = null);
              if (v.length == 4) _submit();
            },
          ),
          const SizedBox(height: 16),
          FilledButton(onPressed: _submit, child: const Text('دخول')),
        ],
      ),
    );
  }
}
