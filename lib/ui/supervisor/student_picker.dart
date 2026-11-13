import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wirdi_app/state/app_state.dart';

/// Drop-down to choose the student a programme or an exam belongs to.
class StudentPicker extends StatelessWidget {
  const StudentPicker({super.key, required this.value, required this.onChanged});

  final String? value;
  final ValueChanged<String?> onChanged;

  @override
  Widget build(BuildContext context) {
    final students = context.watch<AppState>().students;
    return DropdownButtonFormField<String>(
      value: students.any((s) => s.id == value) ? value : null,
      isExpanded: true,
      decoration: const InputDecoration(labelText: 'الطالب', prefixIcon: Icon(Icons.person_outline)),
      items: students.map((s) => DropdownMenuItem(value: s.id, child: Text(s.name))).toList(),
      onChanged: onChanged,
      validator: (v) => v == null ? 'اختر طالبًا' : null,
    );
  }
}
