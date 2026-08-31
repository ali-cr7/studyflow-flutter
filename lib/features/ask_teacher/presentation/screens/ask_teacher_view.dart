import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:study_planner/core/app_colors.dart';
import 'package:study_planner/features/ask_teacher/presentation/cubit/ask_teacher_cubit.dart';
import 'package:study_planner/l10n/app_localizations.dart';
import 'package:study_planner/shared/domain/entities/subject.dart';
class AskTeacherView extends StatelessWidget {
  const AskTeacherView({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return BlocConsumer<AskTeacherCubit, AskTeacherState>(
      listener: (context, state) {
        if (state is AskTeacherError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
            ),
          );
        }

        if (state is AskTeacherSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(l10n.whatsAppOpened),
            ),
          );
        }
      },
      builder: (context, state) {
        if (state is AskTeacherInitial) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        final cubit = context.read<AskTeacherCubit>();

        final selectedSubject = state is AskTeacherReady
            ? state.selectedSubject
            : state is AskTeacherSending
                ? state.selectedSubject
                : null;

        final question = state is AskTeacherReady
            ? state.question
            : state is AskTeacherSending
                ? state.question
                : '';

        final isSending = state is AskTeacherSending;

        return Scaffold(
          appBar: AppBar(
            title: Text(l10n.askTheTeacher),
          ),
          body: SafeArea(
            child: ListView(
              padding: const EdgeInsets.all(20),
              children: [
                _buildHeader(context),

                const SizedBox(height: 28),

                _buildStudent(context),

                const SizedBox(height: 24),

                _buildSubjectDropdown(
                  context,
                  cubit,
                  selectedSubject,
                ),

                const SizedBox(height: 24),

                _buildQuestionField(
                  context,
                  cubit,
                  question,
                ),

                const SizedBox(height: 12),

                Text(
                  l10n.messageSentViaWhatsApp,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: context.sfColors.mutedForeground,
                      ),
                ),

                const SizedBox(height: 28),

                SizedBox(
                  height: 54,
                  width: double.infinity,
                  child: FilledButton.icon(
                    onPressed: isSending
                        ? null
                        : cubit.sendQuestion,
                    icon: isSending
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                            ),
                          )
                        : const Icon(
                            Icons.send_rounded,
                          ),
                    label: Text(
                      isSending
                          ? l10n.openingWhatsApp
                          : l10n.sendViaWhatsApp,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildHeader(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final colors = context.sfColors;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: theme.colorScheme.primary.withValues(
          alpha: 0.08,
        ),
        borderRadius: BorderRadius.circular(
          AppColors.radiusXl,
        ),
        border: Border.all(
          color: theme.colorScheme.primary.withValues(
            alpha: 0.15,
          ),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: theme.colorScheme.primary.withValues(
                alpha: 0.12,
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(
              Icons.chat_rounded,
              color: theme.colorScheme.primary,
              size: 26,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.needHelp,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  l10n.askTeacherHeaderSubtitle,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: colors.mutedForeground,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStudent(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final cubit = context.read<AskTeacherCubit>();
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.student,
          style: theme.textTheme.labelLarge?.copyWith(
            color: context.sfColors.mutedForeground,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 15,
          ),
          decoration: BoxDecoration(
            color: theme.cardColor,
            borderRadius: BorderRadius.circular(
              AppColors.radiusLg,
            ),
            border: Border.all(
              color: context.sfColors.border,
            ),
          ),
          child: Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundColor:
                    theme.colorScheme.primary.withValues(
                  alpha: 0.10,
                ),
                child: Icon(
                  Icons.person_rounded,
                  color: theme.colorScheme.primary,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  cubit.studentName,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSubjectDropdown(
    BuildContext context,
    AskTeacherCubit cubit,
    Subject? selectedSubject,
  ) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.subject,
          style: theme.textTheme.labelLarge?.copyWith(
            color: context.sfColors.mutedForeground,
          ),
        ),
        const SizedBox(height: 8),
        DropdownButtonFormField<Subject>(
          initialValue: selectedSubject,
          decoration: InputDecoration(
            hintText: l10n.selectSubject,
            prefixIcon: const Icon(
              Icons.menu_book_rounded,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(
                AppColors.radiusLg,
              ),
            ),
          ),
          items: cubit.subjects.map((subject) {
            return DropdownMenuItem<Subject>(
              value: subject,
              child: Text(subject.name),
            );
          }).toList(),
          onChanged: cubit.selectSubject,
        ),
      ],
    );
  }

  Widget _buildQuestionField(
    BuildContext context,
    AskTeacherCubit cubit,
    String question,
  ) {
    final l10n = AppLocalizations.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.yourQuestion,
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
                color: context.sfColors.mutedForeground,
              ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          initialValue: question,
          minLines: 6,
          maxLines: 10,
          textInputAction: TextInputAction.newline,
          onChanged: cubit.updateQuestion,
          decoration: InputDecoration(
            hintText: l10n.describeStruggle,
            alignLabelWithHint: true,
            prefixIcon: const Padding(
              padding: EdgeInsets.only(
                left: 12,
                right: 8,
                top: 14,
              ),
              child: Icon(
                Icons.edit_note_rounded,
              ),
            ),
            prefixIconConstraints: const BoxConstraints(
              minWidth: 48,
              minHeight: 48,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(
                AppColors.radiusLg,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
