import 'package:flutter/material.dart';
import 'package:study_planner/core/app_colors.dart';
import 'package:study_planner/features/planner/presentation/widgets/subject_card.dart';
import 'package:study_planner/shared/domain/entities/subject.dart';

final List<String> subjectIconOptions = const [
  'calculate',
  'science',
  'language',
  'history',
  'book',
  'palette',
  'music',
  'computer',
  'biotech',
  'code',
];

final List<int> subjectColorOptions = const [
  0xFF4C6FFF,
  0xFF34C759,
  0xFFFF9F43,
  0xFFAF52DE,
  0xFF00A8E8,
  0xFFFF5A5F,
  0xFF10B981,
  0xFFFB7185,
  0xFF6D4AFF,
];

class SubjectFormSheet extends StatefulWidget {
  const SubjectFormSheet({super.key, this.subject, required this.onSaved});

  final Subject? subject;
  final ValueChanged<Subject> onSaved;

  @override
  State<SubjectFormSheet> createState() => _SubjectFormSheetState();
}

class _SubjectFormSheetState extends State<SubjectFormSheet> {
  late final TextEditingController _nameController;
  late String _pickedIcon;
  late int _pickedColor;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.subject?.name ?? '');
    _pickedIcon = widget.subject?.icon ?? subjectIconOptions.first;
    _pickedColor = widget.subject?.color ?? subjectColorOptions.first;
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.sfColors;

    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Container(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 28),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 52,
                    height: 5,
                    decoration: BoxDecoration(
                      color: colors.muted,
                      borderRadius: BorderRadius.circular(99),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  widget.subject == null ? 'Add new subject' : 'Edit subject',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _nameController,
                  textInputAction: TextInputAction.done,
                  decoration: const InputDecoration(
                    hintText: 'Subject name',
                    prefixIcon: Icon(Icons.school_outlined),
                  ),
                  validator: (value) {
                    if ((value ?? '').trim().isEmpty) {
                      return 'Please enter a subject name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 22),
                Text(
                  'Icon',
                  style: Theme.of(
                    context,
                  ).textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: subjectIconOptions.map((iconKey) {
                    final isSelected = _pickedIcon == iconKey;
                    final iconColor = Color(_pickedColor);

                    return GestureDetector(
                      onTap: () => setState(() => _pickedIcon = iconKey),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 180),
                        width: 52,
                        height: 52,
                        decoration: BoxDecoration(
                          color: isSelected
                              ? iconColor.withValues(alpha: 0.14)
                              : colors.muted,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: isSelected ? iconColor : Colors.transparent,
                            width: 2,
                          ),
                        ),
                        child: Icon(
                          subjectIcons[iconKey] ?? Icons.book_rounded,
                          color: isSelected
                              ? iconColor
                              : colors.mutedForeground,
                        ),
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 22),
                Text(
                  'Color',
                  style: Theme.of(
                    context,
                  ).textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  children: subjectColorOptions.map((colorValue) {
                    final color = Color(colorValue);
                    final isSelected = _pickedColor == colorValue;

                    return GestureDetector(
                      onTap: () => setState(() => _pickedColor = colorValue),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 180),
                        width: 36,
                        height: 36,
                        decoration: BoxDecoration(
                          color: color,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: isSelected
                                ? Theme.of(context).colorScheme.onSurface
                                : Colors.transparent,
                            width: 3,
                          ),
                        ),
                        child: isSelected
                            ? const Icon(
                                Icons.check,
                                color: Colors.white,
                                size: 18,
                              )
                            : null,
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 28),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: const Text('Cancel'),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: FilledButton(
                        onPressed: () {
                          if (!_formKey.currentState!.validate()) return;

                          final value = _nameController.text.trim();
                          final saved = Subject(
                            id: widget.subject?.id ?? 0,
                            name: value,
                            color: _pickedColor,
                            icon: _pickedIcon,
                          );

                          widget.onSaved(saved);
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          widget.subject == null
                              ? 'Add subject'
                              : 'Save changes',
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
