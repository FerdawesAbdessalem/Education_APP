import 'package:flutter/material.dart';
import 'package:wirdi_app/data/models.dart';
import 'package:wirdi_app/ui/theme.dart';

/// White rounded card with a thin border.
class AppCard extends StatelessWidget {
  const AppCard({super.key, required this.child, this.onTap, this.padding = const EdgeInsets.all(16)});

  final Widget child;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.surface,
      borderRadius: BorderRadius.circular(18),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(18),
        child: Container(
          padding: padding,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: AppColors.border),
          ),
          child: child,
        ),
      ),
    );
  }
}

class StatCard extends StatelessWidget {
  const StatCard({super.key, required this.icon, required this.value, required this.label, this.color = AppColors.primary});

  final IconData icon;
  final String value;
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(radius: 18, backgroundColor: color.withValues(alpha: 0.12), child: Icon(icon, color: color, size: 20)),
          const SizedBox(height: 12),
          Text(value, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w800, color: AppColors.text)),
          Text(label, style: const TextStyle(color: AppColors.textMuted, fontSize: 13)),
        ],
      ),
    );
  }
}

class StudentAvatar extends StatelessWidget {
  const StudentAvatar({super.key, required this.student, this.radius = 22});

  final Student student;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      backgroundColor: AppColors.primarySoft,
      child: Text(
        student.initials,
        style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.w800, fontSize: radius * 0.6),
      ),
    );
  }
}

class ProgressBar extends StatelessWidget {
  const ProgressBar({super.key, required this.value, this.height = 8});

  final double value;
  final double height;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(height),
      child: LinearProgressIndicator(
        value: value,
        minHeight: height,
        backgroundColor: AppColors.border,
        color: AppColors.forProgress(value),
      ),
    );
  }
}

/// Circular progress with the percentage in the middle.
class ProgressRing extends StatelessWidget {
  const ProgressRing({super.key, required this.value, this.size = 96, this.color = Colors.white});

  final double value;
  final double size;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        fit: StackFit.expand,
        children: [
          CircularProgressIndicator(
            value: value,
            strokeWidth: size / 10,
            backgroundColor: color.withValues(alpha: 0.2),
            color: color,
            strokeCap: StrokeCap.round,
          ),
          Center(
            child: Text(
              '${(value * 100).round()}%',
              style: TextStyle(color: color, fontSize: size / 4.2, fontWeight: FontWeight.w800),
            ),
          ),
        ],
      ),
    );
  }
}

class SectionTitle extends StatelessWidget {
  const SectionTitle(this.text, {super.key, this.action});

  final String text;
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, bottom: 10),
      child: Row(
        children: [
          Expanded(child: Text(text, style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w800, color: AppColors.text))),
          if (action != null) action!,
        ],
      ),
    );
  }
}

class EmptyState extends StatelessWidget {
  const EmptyState({super.key, required this.icon, required this.title, this.message});

  final IconData icon;
  final String title;
  final String? message;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 48, horizontal: 32),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircleAvatar(radius: 36, backgroundColor: AppColors.primarySoft, child: Icon(icon, size: 34, color: AppColors.primary)),
          const SizedBox(height: 16),
          Text(title, textAlign: TextAlign.center, style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w700)),
          if (message != null) ...[
            const SizedBox(height: 6),
            Text(message!, textAlign: TextAlign.center, style: const TextStyle(color: AppColors.textMuted)),
          ],
        ],
      ),
    );
  }
}

class Pill extends StatelessWidget {
  const Pill(this.text, {super.key, this.color = AppColors.primary});

  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(color: color.withValues(alpha: 0.12), borderRadius: BorderRadius.circular(20)),
      child: Text(text, style: TextStyle(color: color, fontSize: 12, fontWeight: FontWeight.w700)),
    );
  }
}

/// Programme row: title, student, progress bar and quick +1 / -1 buttons.
class ProgramTile extends StatelessWidget {
  const ProgramTile({
    super.key,
    required this.program,
    required this.now,
    this.subtitle,
    this.onTap,
    this.onIncrement,
    this.onDecrement,
  });

  final Program program;
  final DateTime now;
  final String? subtitle;
  final VoidCallback? onTap;
  final VoidCallback? onIncrement;
  final VoidCallback? onDecrement;

  @override
  Widget build(BuildContext context) {
    final p = program;
    final risk = p.isAtRisk(now);
    return AppCard(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                p.type == ProgramType.memorization ? Icons.menu_book_rounded : Icons.replay_rounded,
                color: p.type == ProgramType.memorization ? AppColors.primary : AppColors.gold,
              ),
              const SizedBox(width: 8),
              Expanded(child: Text(p.title, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 15))),
              if (p.isDone)
                const Pill('مكتمل', color: AppColors.success)
              else if (risk)
                const Pill('متأخر', color: AppColors.danger),
            ],
          ),
          if (subtitle != null) ...[
            const SizedBox(height: 4),
            Text(subtitle!, style: const TextStyle(color: AppColors.textMuted, fontSize: 13)),
          ],
          const SizedBox(height: 12),
          ProgressBar(value: p.progress),
          const SizedBox(height: 8),
          Row(
            children: [
              Text('${p.doneUnits} / ${p.totalUnits} صفحة', style: const TextStyle(fontWeight: FontWeight.w600)),
              const Spacer(),
              if (p.deadline != null)
                Text('الموعد: ${Dates.relative(p.deadline!, now)}', style: const TextStyle(color: AppColors.textMuted, fontSize: 12)),
              if (onDecrement != null)
                IconButton(
                  tooltip: 'إنقاص صفحة',
                  visualDensity: VisualDensity.compact,
                  onPressed: p.doneUnits > 0 ? onDecrement : null,
                  icon: const Icon(Icons.remove_circle_outline),
                ),
              if (onIncrement != null)
                IconButton(
                  tooltip: 'إضافة صفحة منجزة',
                  visualDensity: VisualDensity.compact,
                  color: AppColors.primary,
                  onPressed: p.isDone ? null : onIncrement,
                  icon: const Icon(Icons.add_circle),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

/// Confirmation dialog for destructive actions.
Future<bool> confirmDelete(BuildContext context, String what) async {
  final ok = await showDialog<bool>(
    context: context,
    builder: (c) => AlertDialog(
      title: const Text('تأكيد الحذف'),
      content: Text('هل تريد حذف $what؟ لا يمكن التراجع عن هذا الإجراء.'),
      actions: [
        TextButton(onPressed: () => Navigator.pop(c, false), child: const Text('إلغاء')),
        FilledButton(
          style: FilledButton.styleFrom(backgroundColor: AppColors.danger, minimumSize: const Size(88, 44)),
          onPressed: () => Navigator.pop(c, true),
          child: const Text('حذف'),
        ),
      ],
    ),
  );
  return ok ?? false;
}

void showMessage(BuildContext context, String message) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(SnackBar(content: Text(message)));
}
