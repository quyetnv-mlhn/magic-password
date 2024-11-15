import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:magic_password/core/enums/section_enum.dart';
import 'package:magic_password/core/widgets/custom_search_bar.dart';
import 'package:magic_password/core/widgets/loading_overlay.dart';
import 'package:magic_password/features/search/providers/search_provider.dart';
import 'package:magic_password/features/search/states/search_state.dart';
import 'package:magic_password/features/search/widgets/filter_bottom_sheet.dart';
import 'package:magic_password/features/search/widgets/search_result_list.dart';
import 'package:magic_password/gen/locale_keys.g.dart';

class SearchScreen extends ConsumerWidget {
  final bool autoFocus;
  final SectionEnum? initSection;
  final bool? showFilterSheet;

  const SearchScreen({
    this.autoFocus = false,
    this.initSection,
    this.showFilterSheet,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchPageState = ref.watch(searchNotifierProvider);

    void initializeFilters() {
      if (initSection != null && showFilterSheet == true) {
        ref.read(searchNotifierProvider.notifier).presetFilter(
          sections: {initSection!},
        );
      }
    }

    void showFilterBottomSheet() {
      if (showFilterSheet == true) {
        showModalBottomSheet(
          context: context,
          builder: (_) => const FilterBottomSheet(),
        );
      }
    }

    ref.listen(searchNotifierProvider, (previous, next) {
      if (previous?.value?.isLoading == true &&
          next.value?.isLoading == false) {
        initializeFilters();
        showFilterBottomSheet();
      }
    });

    return searchPageState.when(
      data: (state) => SearchScreenContent(
        searchPageState: state,
        autoFocus: autoFocus,
      ),
      error: (error, stack) => const SizedBox.shrink(),
      loading: LoadingOverlay.new,
    );
  }
}

class SearchScreenContent extends ConsumerWidget {
  final SearchPageState searchPageState;
  final bool autoFocus;

  const SearchScreenContent({
    required this.searchPageState,
    required this.autoFocus,
    super.key,
  });

  void _showFilterBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) => const FilterBottomSheet(),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchNotifier = ref.read(searchNotifierProvider.notifier);

    return Stack(
      children: [
        Scaffold(
          body: SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: SearchBarWidget(
                    hintText: LocaleKeys.search_title.tr(),
                    autoFocus: autoFocus,
                    onFilterPressed: () => _showFilterBottomSheet(context),
                    onChanged: searchNotifier.search,
                  ),
                ),
                Expanded(
                  child: SearchResultList(
                    passwords: searchPageState.filteredPasswords,
                    deletePassword: searchNotifier.deletePassword,
                  ),
                ),
              ],
            ),
          ),
        ),
        if (searchPageState.isLoading) const LoadingOverlay(),
      ],
    );
  }
}
