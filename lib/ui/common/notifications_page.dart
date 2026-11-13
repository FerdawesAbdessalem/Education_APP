import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wirdi_app/data/models.dart';
import 'package:wirdi_app/state/app_state.dart';
import 'package:wirdi_app/ui/theme.dart';
import 'package:wirdi_app/ui/widgets.dart';

/// Activity feed (new programmes, results, completed programmes…).
class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key, this.embedded = false});

  /// True when shown inside a tab (no own app bar).
  final bool embedded;

  @override
  Widget build(BuildContext context) {
    final s = context.watch<AppState>();
    final events = s.notifications;

    final body = events.isEmpty
        ? const EmptyState(icon: Icons.notifications_off_outlined, title: 'لا توجد إشعارات')
        : ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: events.length,
            separatorBuilder: (_, __) => const SizedBox(height: 10),
            itemBuilder: (_, i) {
              final e = events[i];
              final (icon, color) = switch (e.type) {
                EventType.program => (Icons.menu_book_rounded, AppColors.primary),
                EventType.progress => (Icons.trending_up_rounded, AppColors.success),
                EventType.exam => (Icons.fact_check_rounded, AppColors.gold),
                EventType.student => (Icons.person_add_alt_1_rounded, AppColors.primary),
              };
              return AppCard(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(radius: 20, backgroundColor: color.withValues(alpha: 0.12), child: Icon(icon, color: color, size: 20)),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(e.message, style: const TextStyle(fontWeight: FontWeight.w600, height: 1.4)),
                          const SizedBox(height: 4),
                          Text(Dates.ago(e.date, s.now), style: const TextStyle(color: AppColors.textMuted, fontSize: 12)),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          );

    if (embedded) return body;
    return Scaffold(appBar: AppBar(title: const Text('الإشعارات')), body: body);
  }
}
