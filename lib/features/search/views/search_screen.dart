import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:magic_password/core/widgets/custom_search_bar.dart';
import 'package:magic_password/features/password/widgets/loading_overlay.dart';
import 'package:magic_password/features/search/providers/search_provider.dart';
import 'package:magic_password/features/search/states/search_state.dart';
import 'package:magic_password/features/search/widgets/filter_bottom_sheet.dart';
import 'package:magic_password/features/search/widgets/search_result_list.dart';

class SearchScreen extends ConsumerWidget {
  final bool autoFocus;

  const SearchScreen({
    this.autoFocus = false,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchPageState = ref.watch(searchNotifierProvider);

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
  const SearchScreenContent({
    required this.searchPageState,
    required this.autoFocus,
    super.key,
  });

  final SearchPageState searchPageState;
  final bool autoFocus;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Stack(
      children: [
        Scaffold(
          body: SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: SearchBarWidget(
                    hintText: 'Search passwords...',
                    autoFocus: autoFocus,
                    onFilterPressed: () => _showFilterBottomSheet(context),
                    onChanged: ref.read(searchNotifierProvider.notifier).search,
                  ),
                ),
                Expanded(
                  child: SearchResultList(
                    passwords: searchPageState.filteredPasswords,
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

  void _showFilterBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) => const FilterBottomSheet(),
    );
  }
}
