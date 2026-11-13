import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wirdi_app/data/models.dart';
import 'package:wirdi_app/state/app_state.dart';
import 'package:wirdi_app/ui/theme.dart';
import 'package:wirdi_app/ui/widgets.dart';

/// Bottom sheet to add, rename and delete study circles (حلقات).
Future<void> showGroupsSheet(BuildContext context) {
  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    showDragHandle: true,
    builder: (_) => const _GroupsSheet(),
  );
}

class _GroupsSheet extends StatelessWidget {
  const _GroupsSheet();

  @override
  Widget build(BuildContext context) {
    final s = context.watch<AppState>();
    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: ConstrainedBox(
        constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.7),
        child: ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
          children: [
            Row(
              children: [
                const Expanded(child: Text('الحلقات', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800))),
                FilledButton.tonalIcon(
                  style: FilledButton.styleFrom(minimumSize: const Size(0, 44)),
                  onPressed: () => _edit(context),
                  icon: const Icon(Icons.add),
                  label: const Text('حلقة جديدة'),
                ),
              ],
            ),
            const SizedBox(height: 12),
            if (s.groups.isEmpty)
              const EmptyState(icon: Icons.diversity_3_rounded, title: 'لا توجد حلقات بعد'),
            ...s.groups.map((g) {
              final count = s.students.where((st) => st.groupId == g.id).length;
              return ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const CircleAvatar(backgroundColor: AppColors.goldSoft, child: Icon(Icons.diversity_3_rounded, color: AppColors.gold)),
                title: Text(g.name, style: const TextStyle(fontWeight: FontWeight.w700)),
                subtitle: Text('${g.supervisor.isEmpty ? 'بدون مشرف' : g.supervisor} · $count طالب'),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(tooltip: 'تعديل', onPressed: () => _edit(context, g), icon: const Icon(Icons.edit_outlined)),
                    IconButton(
                      tooltip: 'حذف',
                      icon: const Icon(Icons.delete_outline, color: AppColors.danger),
                      onPressed: () async {
                        if (await confirmDelete(context, 'الحلقة «${g.name}»') && context.mounted) {
                          await context.read<AppState>().deleteGroup(g.id);
                        }
                      },
                    ),
                  ],
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  Future<void> _edit(BuildContext context, [Group? group]) async {
    final name = TextEditingController(text: group?.name);
    final supervisor = TextEditingController(text: group?.supervisor);
    final formKey = GlobalKey<FormState>();
    final saved = await showDialog<bool>(
      context: context,
      builder: (c) => AlertDialog(
        title: Text(group == null ? 'حلقة جديدة' : 'تعديل الحلقة'),
        content: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: name,
                autofocus: true,
                decoration: const InputDecoration(labelText: 'اسم الحلقة'),
                validator: (v) => (v == null || v.trim().isEmpty) ? 'الاسم إجباري' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(controller: supervisor, decoration: const InputDecoration(labelText: 'المشرف (اختياري)')),
            ],
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(c, false), child: const Text('إلغاء')),
          FilledButton(
            style: FilledButton.styleFrom(minimumSize: const Size(88, 44)),
            onPressed: () {
              if (formKey.currentState?.validate() ?? false) Navigator.pop(c, true);
            },
            child: const Text('حفظ'),
          ),
        ],
      ),
    );
    if (saved == true && context.mounted) {
      await context.read<AppState>().saveGroup(id: group?.id, name: name.text, supervisor: supervisor.text);
    }
  }
}
