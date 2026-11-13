import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wirdi_app/state/app_state.dart';
import 'package:wirdi_app/ui/auth/setup_page.dart';
import 'package:wirdi_app/ui/auth/student_login_page.dart';
import 'package:wirdi_app/ui/auth/supervisor_login_page.dart';
import 'package:wirdi_app/ui/theme.dart';

/// First screen: choose between the supervisor space and the student space.
class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AppState>();

    void openSupervisor() {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => state.isConfigured ? const SupervisorLoginPage() : const SetupPage()),
      );
    }

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: AppColors.headerGradient),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Spacer(),
                Center(
                  child: Container(
                    width: 104,
                    height: 104,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: const [BoxShadow(color: Color(0x33000000), blurRadius: 24, offset: Offset(0, 12))],
                    ),
                    child: const Icon(Icons.menu_book_rounded, size: 56, color: AppColors.primary),
                  ),
                ),
                const SizedBox(height: 24),
                const Text(
                  'وِردي',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white, fontSize: 40, fontWeight: FontWeight.w900),
                ),
                const SizedBox(height: 8),
                Text(
                  state.association?.name ?? 'رفيقك في حفظ القرآن الكريم ومراجعته',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white.withValues(alpha: 0.9), fontSize: 16),
                ),
                const Spacer(flex: 2),
                _RoleButton(
                  icon: Icons.supervisor_account_rounded,
                  title: 'فضاء المشرف',
                  subtitle: 'إدارة الحلقات والطلاب والبرامج والاختبارات',
                  onTap: openSupervisor,
                ),
                const SizedBox(height: 14),
                _RoleButton(
                  icon: Icons.school_rounded,
                  title: 'فضاء الطالب',
                  subtitle: 'متابعة وردي واختباراتي',
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const StudentLoginPage())),
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _RoleButton extends StatelessWidget {
  const _RoleButton({required this.icon, required this.title, required this.subtitle, required this.onTap});

  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Row(
            children: [
              CircleAvatar(radius: 26, backgroundColor: AppColors.primarySoft, child: Icon(icon, color: AppColors.primary, size: 28)),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: AppColors.text)),
                    const SizedBox(height: 2),
                    Text(subtitle, style: const TextStyle(color: AppColors.textMuted, fontSize: 13)),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right_rounded, color: AppColors.textMuted),
            ],
          ),
        ),
      ),
    );
  }
}
