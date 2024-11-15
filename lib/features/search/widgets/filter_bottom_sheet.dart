import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:magic_password/app/providers/account_type_provider.dart';
import 'package:magic_password/core/configs/app_sizes.dart';
import 'package:magic_password/core/enums/section_enum.dart';
import 'package:magic_password/core/extensions/theme_ext.dart';
import 'package:magic_password/domain/entities/social_media/account_type.dart';
import 'package:magic_password/features/search/providers/search_provider.dart';
import 'package:magic_password/gen/locale_keys.g.dart';

class FilterBottomSheet extends ConsumerWidget {
  const FilterBottomSheet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchState = ref.watch(searchNotifierProvider);
    final colors = context.colorScheme;
    final textTheme = context.textTheme;

    return Container(
      constraints:
          BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildHeader(context, ref, colors, textTheme),
          Expanded(
            child: searchState.when(
              data: (state) => SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildFilterSection(
                      title: LocaleKeys.search_filter_sections.tr(),
                      icon: Icons.folder_outlined,
                      child: _buildSectionFilters(
                        context,
                        ref,
                        state.selectedSections,
                      ),
                      textTheme: textTheme,
                      colors: colors,
                    ),
                    verticalSpaceL,
                    _buildFilterSection(
                      title: 'Account Types',
                      icon: Icons.category_outlined,
                      child: _buildCategoryFilters(
                        context,
                        ref,
                        state.selectedType,
                      ),
                      textTheme: textTheme,
                      colors: colors,
                    ),
                  ],
                ),
              ),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (_, __) => const SizedBox.shrink(),
            ),
          ),
          _buildFooter(context, colors),
        ],
      ),
    );
  }

  Widget _buildHeader(
    BuildContext context,
    WidgetRef ref,
    ColorScheme colors,
    TextTheme textTheme,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colors.surface,
        border: Border(bottom: BorderSide(color: colors.outlineVariant)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Filter', style: textTheme.titleLarge),
          TextButton(
            onPressed: () {
              ref.read(searchNotifierProvider.notifier).clearFilters();
              Navigator.pop(context);
            },
            child: Text('Clear All', style: textTheme.titleMedium),
          ),
        ],
      ),
    );
  }

  Widget _buildFooter(BuildContext context, ColorScheme colors) {
    return Container(
      padding: paddingAllM,
      decoration: BoxDecoration(
        color: colors.surface,
        border: Border(top: BorderSide(color: colors.outlineVariant)),
      ),
      child: Row(
        children: [
          Expanded(
            child: FilledButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                'Apply Filters',
                style: context.textTheme.titleMedium
                    ?.copyWith(color: colors.onPrimary),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterSection({
    required String title,
    required IconData icon,
    required Widget child,
    required TextTheme textTheme,
    required ColorScheme colors,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, color: colors.primary),
            horizontalSpaceS,
            Text(
              title,
              style:
                  textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        verticalSpaceM,
        child,
      ],
    );
  }

  Widget _buildSectionFilters(
    BuildContext context,
    WidgetRef ref,
    Set<SectionEnum> selectedSections,
  ) {
    return Wrap(
      spacing: spaceS,
      runSpacing: spaceS,
      children: SectionEnum.values.map((section) {
        return _buildFilterChip(
          label: section.name,
          selected: selectedSections.contains(section),
          onSelected: (selected) {
            final updatedSections = {...selectedSections};
            selected
                ? updatedSections.add(section)
                : updatedSections.remove(section);
            ref
                .read(searchNotifierProvider.notifier)
                .updateFilters(sections: updatedSections);
          },
          textTheme: context.textTheme,
        );
      }).toList(),
    );
  }

  Widget _buildCategoryFilters(
    BuildContext context,
    WidgetRef ref,
    Set<AccountTypeEntity> selectedCategories,
  ) {
    final accountTypes = ref.watch(accountTypeListProvider);
    return Wrap(
      spacing: spaceS,
      runSpacing: spaceS,
      children: accountTypes.map((type) {
        return _buildFilterChip(
          label: type.name,
          selected: selectedCategories.contains(type),
          onSelected: (selected) {
            final updatedCategories = {...selectedCategories};
            selected
                ? updatedCategories.add(type)
                : updatedCategories.remove(type);
            ref
                .read(searchNotifierProvider.notifier)
                .updateFilters(accountTypes: updatedCategories);
          },
          textTheme: context.textTheme,
        );
      }).toList(),
    );
  }

  Widget _buildFilterChip({
    required String label,
    required bool selected,
    required ValueChanged<bool> onSelected,
    required TextTheme textTheme,
  }) {
    return FilterChip(
      label: Text(
        label,
        style: textTheme.bodyMedium
            ?.copyWith(letterSpacing: 0.5, fontWeight: FontWeight.w500),
      ),
      selected: selected,
      onSelected: onSelected,
    );
  }
}
