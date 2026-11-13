import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wirdi_app/state/app_state.dart';
import 'package:wirdi_app/ui/auth/welcome_page.dart';
import 'package:wirdi_app/ui/theme.dart';
import 'package:wirdi_app/ui/widgets.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  void _backToWelcome(BuildContext context) {
    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (_) => const WelcomePage()), (_) => false);
  }

  @override
  Widget build(BuildContext context) {
    final s = context.watch<AppState>();
    final isSupervisor = s.session == Session.supervisor;

    return Scaffold(
      appBar: AppBar(title: const Text('الإعدادات')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          AppCard(
            padding: EdgeInsets.zero,
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.mosque_outlined),
                  title: Text(s.association?.name ?? 'وِردي'),
                  subtitle: Text(isSupervisor ? 'المشرف: ${s.association?.supervisorName ?? ''}' : (s.currentStudent?.name ?? '')),
                ),
                if (isSupervisor) ...[
                  const Divider(),
                  ListTile(
                    leading: const Icon(Icons.auto_awesome_outlined),
                    title: const Text('تحميل البيانات التجريبية'),
                    subtitle: const Text('يستبدل البيانات الحالية بأمثلة وهمية'),
                    onTap: () async {
                      if (await confirmDelete(context, 'البيانات الحالية واستبدالها بالبيانات التجريبية') && context.mounted) {
                        await context.read<AppState>().loadDemo();
                        if (context.mounted) showMessage(context, 'تم تحميل البيانات التجريبية');
                      }
                    },
                  ),
                  const Divider(),
                  ListTile(
                    leading: const Icon(Icons.delete_forever_outlined, color: AppColors.danger),
                    title: const Text('حذف كل البيانات', style: TextStyle(color: AppColors.danger)),
                    subtitle: const Text('يحذف الجمعية والطلاب والبرامج من هذا الجهاز'),
                    onTap: () async {
                      if (await confirmDelete(context, 'كل بيانات التطبيق') && context.mounted) {
                        await context.read<AppState>().resetAll();
                        if (context.mounted) _backToWelcome(context);
                      }
                    },
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(height: 16),
          AppCard(
            padding: EdgeInsets.zero,
            child: Column(
              children: [
                const ListTile(
                  leading: Icon(Icons.info_outline),
                  title: Text('حول التطبيق'),
                  subtitle: Text('وِردي 2.0 — متابعة الحفظ والمراجعة والاختبارات في جمعيات القرآن الكريم. البيانات محفوظة على هذا الجهاز.'),
                ),
                const Divider(),
                ListTile(
                  leading: const Icon(Icons.logout_rounded),
                  title: const Text('تسجيل الخروج'),
                  onTap: () {
                    context.read<AppState>().logout();
                    _backToWelcome(context);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
