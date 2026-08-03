import 'package:flutter/material.dart';
import 'package:study_planner/core/app_colors.dart';


class ThemePreviewUI extends StatefulWidget {
  const ThemePreviewUI({
    super.key,
    required this.themeMode,
    required this.onToggleTheme,
  });

  final ThemeMode themeMode;
  final VoidCallback onToggleTheme;

  @override
  State<ThemePreviewUI> createState() => _ThemePreviewUIState();
}

class _ThemePreviewUIState extends State<ThemePreviewUI> {
  bool _switchValue = true;
  int _navIndex = 0;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = context.sfColors;
    final scheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('StudyFlow Theme Preview'),
        actions: [
          IconButton(
            tooltip: 'Toggle theme',
            onPressed: widget.onToggleTheme,
            icon: Icon(switch (widget.themeMode) {
              ThemeMode.light => Icons.light_mode_outlined,
              ThemeMode.dark => Icons.dark_mode_outlined,
              ThemeMode.system => Icons.brightness_auto_outlined,
            }),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(24, 8, 24, 32),
        children: [
          _SectionTitle('Theme mode'),
          Text(
            _themeModeLabel(widget.themeMode),
            style: theme.textTheme.bodyMedium?.copyWith(
              color: colors.mutedForeground,
            ),
          ),
          const SizedBox(height: 24),
          _SectionTitle('Typography'),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Display', style: theme.textTheme.displaySmall),
                  const SizedBox(height: 8),
                  Text('Headline', style: theme.textTheme.headlineMedium),
                  const SizedBox(height: 8),
                  Text('Title', style: theme.textTheme.titleLarge),
                  const SizedBox(height: 8),
                  Text('Body large — base 16px', style: theme.textTheme.bodyLarge),
                  const SizedBox(height: 8),
                  Text(
                    'Muted foreground subtitle',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: colors.mutedForeground,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text('Label small', style: theme.textTheme.labelSmall),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          _SectionTitle('Brand colors'),
          _ColorGrid(
            items: [
              _ColorItem('Primary', scheme.primary),
              _ColorItem('Primary light', colors.primaryLight),
              _ColorItem('Primary dark', colors.primaryDark),
              _ColorItem('Success', colors.success),
              _ColorItem('Success light', colors.successLight),
              _ColorItem('Accent', colors.accent),
              _ColorItem('Accent light', colors.accentLight),
              _ColorItem('Warning', colors.warning),
              _ColorItem('Destructive', scheme.error),
              _ColorItem('Muted', colors.muted),
              _ColorItem('Border', colors.border),
              _ColorItem('Background', scheme.surface),
            ],
          ),
          const SizedBox(height: 24),
          _SectionTitle('Chart colors'),
          _ColorGrid(
            items: [
              _ColorItem('Chart 1', colors.chart1),
              _ColorItem('Chart 2', colors.chart2),
              _ColorItem('Chart 3', colors.chart3),
              _ColorItem('Chart 4', colors.chart4),
              _ColorItem('Chart 5', colors.chart5),
            ],
          ),
          const SizedBox(height: 24),
          _SectionTitle('Buttons'),
          FilledButton(
            onPressed: () {},
            child: const Text('Primary'),
          ),
          const SizedBox(height: 12),
          FilledButton.tonal(
            onPressed: () {},
            style: FilledButton.styleFrom(
              backgroundColor: colors.success,
              foregroundColor: colors.successForeground,
            ),
            child: const Text('Success'),
          ),
          const SizedBox(height: 12),
          FilledButton.tonal(
            onPressed: () {},
            style: FilledButton.styleFrom(
              backgroundColor: scheme.error,
              foregroundColor: colors.destructiveForeground,
            ),
            child: const Text('Destructive'),
          ),
          const SizedBox(height: 12),
          OutlinedButton(
            onPressed: () {},
            child: const Text('Outline'),
          ),
          const SizedBox(height: 12),
          TextButton(
            onPressed: () {},
            child: const Text('Ghost / Text'),
          ),
          const SizedBox(height: 24),
          _SectionTitle('Cards'),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Default card', style: theme.textTheme.titleMedium),
                  const SizedBox(height: 4),
                  Text(
                    'Used for stats, quotes, and list items.',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: colors.mutedForeground,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          Card(
            elevation: 4,
            shadowColor: Colors.black.withValues(alpha: 0.12),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Text('Elevated card', style: theme.textTheme.titleMedium),
            ),
          ),
          const SizedBox(height: 12),
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppColors.radiusLg),
              side: BorderSide(color: colors.border, width: 2),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Text('Outlined card', style: theme.textTheme.titleMedium),
            ),
          ),
          const SizedBox(height: 24),
          _SectionTitle('Home-style stat row'),
          Row(
            children: [
              Expanded(
                child: _StatCard(
                  icon: Icons.local_fire_department_outlined,
                  iconColor: colors.accent,
                  iconBackground: colors.accentLight,
                  value: '7',
                  label: 'Day Streak',
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _StatCard(
                  icon: Icons.emoji_events_outlined,
                  iconColor: scheme.primary,
                  iconBackground: colors.primaryLight,
                  value: '12',
                  label: 'Achievements',
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _StatCard(
                  icon: Icons.bolt_outlined,
                  iconColor: colors.success,
                  iconBackground: colors.successLight,
                  value: '85',
                  label: 'Focus Score',
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          _SectionTitle('Inputs & controls'),
          const TextField(
            decoration: InputDecoration(
              labelText: 'Subject name',
              hintText: 'e.g. Mathematics',
            ),
          ),
          const SizedBox(height: 16),
          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            title: const Text('Daily reminders'),
            subtitle: Text(
              'Get notified to study',
              style: theme.textTheme.bodySmall?.copyWith(
                color: colors.mutedForeground,
              ),
            ),
            value: _switchValue,
            onChanged: (value) => setState(() => _switchValue = value),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: const [
              Chip(label: Text('Mathematics')),
              Chip(label: Text('High priority')),
              Chip(label: Text('45 min')),
            ],
          ),
          const SizedBox(height: 16),
          LinearProgressIndicator(value: 0.65),
          const SizedBox(height: 12),
          Center(
            child: SizedBox(
              width: 72,
              height: 72,
              child: CircularProgressIndicator(
                value: 0.65,
                strokeWidth: 8,
                backgroundColor: colors.muted,
                color: scheme.primary,
              ),
            ),
          ),
          const SizedBox(height: 24),
          _SectionTitle('Bottom navigation preview'),
          Card(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _NavPreviewItem(
                    icon: Icons.home_outlined,
                    label: 'Home',
                    selected: _navIndex == 0,
                    onTap: () => setState(() => _navIndex = 0),
                  ),
                  _NavPreviewItem(
                    icon: Icons.calendar_today_outlined,
                    label: 'Planner',
                    selected: _navIndex == 1,
                    onTap: () => setState(() => _navIndex = 1),
                  ),
                  _NavPreviewItem(
                    icon: Icons.schedule_outlined,
                    label: 'Study',
                    selected: _navIndex == 2,
                    onTap: () => setState(() => _navIndex = 2),
                  ),
                  _NavPreviewItem(
                    icon: Icons.trending_up_outlined,
                    label: 'Progress',
                    selected: _navIndex == 3,
                    onTap: () => setState(() => _navIndex = 3),
                  ),
                  _NavPreviewItem(
                    icon: Icons.settings_outlined,
                    label: 'Settings',
                    selected: _navIndex == 4,
                    onTap: () => setState(() => _navIndex = 4),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _themeModeLabel(ThemeMode mode) {
    return switch (mode) {
      ThemeMode.light => 'Light mode',
      ThemeMode.dark => 'Dark mode',
      ThemeMode.system => 'System default',
    };
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle(this.label);

  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(
        label,
        style: Theme.of(context).textTheme.titleMedium,
      ),
    );
  }
}

class _ColorItem {
  const _ColorItem(this.name, this.color);

  final String name;
  final Color color;
}

class _ColorGrid extends StatelessWidget {
  const _ColorGrid({required this.items});

  final List<_ColorItem> items;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: items.map((item) => _ColorSwatch(item: item)).toList(),
    );
  }
}

class _ColorSwatch extends StatelessWidget {
  const _ColorSwatch({required this.item});

  final _ColorItem item;

  @override
  Widget build(BuildContext context) {
    final textColor = ThemeData.estimateBrightnessForColor(item.color) ==
            Brightness.dark
        ? Colors.white
        : Colors.black87;

    return SizedBox(
      width: 148,
      child: Card(
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: 56,
              color: item.color,
              alignment: Alignment.center,
              child: Text(
                '#${item.color.toARGB32().toRadixString(16).substring(2).toUpperCase()}',
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: textColor,
                      fontFeatures: const [FontFeature.tabularFigures()],
                    ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Text(
                item.name,
                style: Theme.of(context).textTheme.labelMedium,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  const _StatCard({
    required this.icon,
    required this.iconColor,
    required this.iconBackground,
    required this.value,
    required this.label,
  });

  final IconData icon;
  final Color iconColor;
  final Color iconBackground;
  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: iconBackground,
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: iconColor, size: 20),
            ),
            const SizedBox(height: 8),
            Text(
              value,
              style: theme.textTheme.headlineSmall,
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: theme.textTheme.labelSmall?.copyWith(
                color: context.sfColors.mutedForeground,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class _NavPreviewItem extends StatelessWidget {
  const _NavPreviewItem({
    required this.icon,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = context.sfColors;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppColors.radiusLg),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: selected ? colors.primaryLight : Colors.transparent,
          borderRadius: BorderRadius.circular(AppColors.radiusLg),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: selected ? theme.colorScheme.primary : colors.mutedForeground,
              size: 24,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: theme.textTheme.labelSmall?.copyWith(
                color: selected
                    ? theme.colorScheme.primary
                    : colors.mutedForeground,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
