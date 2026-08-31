import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:study_planner/core/app_colors.dart';
import 'package:study_planner/l10n/app_localizations.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({
    super.key,
    required this.onRecordsTap,
    required this.onHistoryTap,
    required this.onAskTeacherTap,
  });

  final VoidCallback onRecordsTap;
  final VoidCallback onHistoryTap;
  final VoidCallback onAskTeacherTap;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final colors = context.sfColors;

    return Drawer(
      width: 300,
      child: SafeArea(
        child: Column(
          children: [
            // ─────────────────────────────────────────────────────────────
            // Header
            // ─────────────────────────────────────────────────────────────
            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(24, 28, 24, 24),
              decoration: BoxDecoration(color: theme.colorScheme.primary),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 58,
                    height: 58,
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Icon(
                      Icons.school_rounded,
                      size: 30,
                      color: theme.colorScheme.onPrimary,
                    ),
                  ),

                  const SizedBox(height: 16),

                  Text(
                    l10n.appName,
                    style: theme.textTheme.titleLarge?.copyWith(
                      color: theme.colorScheme.onPrimary,
                      fontWeight: FontWeight.w700,
                    ),
                  ),

                  const SizedBox(height: 4),

                  Text(
                    l10n.appTagline,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onPrimary.withValues(
                        alpha: 0.75,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // ─────────────────────────────────────────────────────────────
            // Main menu
            // ─────────────────────────────────────────────────────────────
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 16,
                ),
                children: [
                  _DrawerItem(
                    icon: Icons.emoji_events_rounded,
                    title: l10n.records,
                    subtitle: l10n.recordsSubtitle,
                    onTap: () {
                      Navigator.pop(context);
                      onRecordsTap();
                    },
                  ),

                  _DrawerItem(
                    icon: Icons.history_rounded,
                    title: l10n.history,
                    subtitle: l10n.historySubtitle,
                    onTap: () {
                      Navigator.pop(context);
                      onHistoryTap();
                    },
                  ),

                  _DrawerItem(
                    icon: Icons.chat_rounded,
                    title: l10n.askTeacher,
                    subtitle: l10n.askTeacherSubtitle,
                    iconColor: colors.primaryLight,
                    onTap: () {
                      Navigator.pop(context);
                      onAskTeacherTap();
                    },
                  ),

                  const SizedBox(height: 12),

                  Divider(color: colors.border, indent: 12, endIndent: 12),

                  const SizedBox(height: 12),

                  _DrawerItem(
                    icon: Icons.info_outline_rounded,
                    title: l10n.about,
                    subtitle: l10n.aboutSubtitle,
                    onTap: () {
                      _showAboutDialog(context);
                    },
                  ),
                ],
              ),
            ),

            // ─────────────────────────────────────────────────────────────
            // Footer
            // ─────────────────────────────────────────────────────────────
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
              child: Text(
                '${l10n.appName} • ${l10n.versionWithNumber('1.0.0')}',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: colors.mutedForeground,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ───────────────────────────────────────────────────────────────────────
  // About dialog
  // ───────────────────────────────────────────────────────────────────────

  void _showAboutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return const _AboutDialog();
      },
    );
  }
}

// ═════════════════════════════════════════════════════════════════════════════
// Drawer Item
// ═════════════════════════════════════════════════════════════════════════════

class _DrawerItem extends StatelessWidget {
  const _DrawerItem({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
    this.iconColor,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = context.sfColors;

    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppColors.radiusLg),
      ),
      leading: Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          color: (iconColor ?? theme.colorScheme.primary).withValues(
            alpha: 0.10,
          ),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Icon(
          icon,
          color: iconColor ?? theme.colorScheme.primary,
          size: 22,
        ),
      ),
      title: Text(
        title,
        style: theme.textTheme.titleSmall?.copyWith(
          fontWeight: FontWeight.w700,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: theme.textTheme.bodySmall?.copyWith(
          color: colors.mutedForeground,
        ),
      ),
      onTap: onTap,
    );
  }
}

// ═════════════════════════════════════════════════════════════════════════════
// About Dialog
// ═════════════════════════════════════════════════════════════════════════════

class _AboutDialog extends StatelessWidget {
  const _AboutDialog();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final colors = context.sfColors;

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppColors.radiusXl),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // App icon
            Container(
              width: 72,
              height: 72,
              decoration: BoxDecoration(
                color: theme.colorScheme.primary.withValues(alpha: 0.10),
                borderRadius: BorderRadius.circular(22),
              ),
              child: Icon(
                Icons.school_rounded,
                size: 36,
                color: theme.colorScheme.primary,
              ),
            ),

            const SizedBox(height: 16),

            Text(
              l10n.appName,
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),

            const SizedBox(height: 8),

            Text(
              l10n.aboutLongDescription,
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: colors.mutedForeground,
                height: 1.5,
              ),
            ),

            const SizedBox(height: 20),

            Text(
              l10n.createdBy,
              style: theme.textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),

            const SizedBox(height: 4),

            Text(
              l10n.developerRole,
              textAlign: TextAlign.center,
              style: theme.textTheme.bodySmall?.copyWith(
                color: colors.mutedForeground,
              ),
            ),

            const SizedBox(height: 20),

            Divider(color: colors.border),

            const SizedBox(height: 12),

            Text(
              l10n.connectWithMe,
              style: theme.textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),

            const SizedBox(height: 12),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _SocialButton(
                  icon: Icons.telegram,
                  label: 'Telegram',
                  url: 'https://t.me/@aliali180',
                ),

                const SizedBox(width: 10),

                _SocialButton(
                  icon: Icons.facebook,
                  label: 'Facebook',
                  url: 'https://facebook.com/ali.ali.896594',
                ),

                const SizedBox(width: 10),

                _SocialButton(
                  icon: Icons.business_center_rounded,
                  label: 'LinkedIn',
                  url: 'https://www.linkedin.com/in/ali-al-ali-8b4643246/',
                ),

                const SizedBox(width: 10),

                _SocialButton(
                  icon: Icons.chat_rounded,
                  label: 'WhatsApp',
                  url: 'https://wa.me/963937543024',
                ),
              ],
            ),

            const SizedBox(height: 20),

            Text(
              l10n.versionWithNumber('1.0.0'),
              style: theme.textTheme.bodySmall?.copyWith(
                color: colors.mutedForeground,
              ),
            ),

            const SizedBox(height: 16),

            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: () => Navigator.pop(context),
                child: Text(l10n.close),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ═════════════════════════════════════════════════════════════════════════════
// Social Button
// ═════════════════════════════════════════════════════════════════════════════

class _SocialButton extends StatelessWidget {
  const _SocialButton({
    required this.icon,
    required this.label,
    required this.url,
  });

  final IconData icon;
  final String label;
  final String url;

  Future<void> _openUrl() async {
    final uri = Uri.parse(url);
    launchUrl(uri, mode: LaunchMode.externalApplication);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Tooltip(
      message: label,
      child: InkWell(
        onTap: _openUrl,
        borderRadius: BorderRadius.circular(14),
        child: Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: theme.colorScheme.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(14),
          ),
          child: Icon(icon, size: 22, color: theme.colorScheme.primary),
        ),
      ),
    );
  }
}
