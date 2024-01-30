import 'package:animo/widgets/custom_input_form.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sliver_tools/sliver_tools.dart';

class ChapterListView extends StatefulWidget {
  const ChapterListView({
    super.key,
    required this.chapterList,
    required this.slug,
    this.isModal = false,
  });

  final List<String> chapterList;
  final String slug;
  final bool isModal;

  @override
  State<ChapterListView> createState() => _ChapterListViewState();
}

class _ChapterListViewState extends State<ChapterListView> {
  late final TextEditingController _searchController;
  List<String> searchResultList = [];

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SliverPadding(
      padding: const EdgeInsets.all(14),
      sliver: MultiSliver(
        children: [
          SliverPinnedHeader(
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Search',
                            style: theme.textTheme.titleMedium,
                          ),
                          Text(
                            '100 Total chapters found',
                            style: theme.textTheme.bodySmall,
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: CustomInputForm(
                        hintText: 'Goto',
                        hintTextStyle: theme.textTheme.bodySmall!.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                        textStyle: theme.textTheme.bodySmall!.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                        controller: _searchController,
                        onChanged: (value) {
                          setState(
                            () {
                              if (value != null) {
                                searchResultList = widget.chapterList
                                    .where((chapter) => chapter
                                        .toLowerCase()
                                        .contains(value.toLowerCase()))
                                    .toList();
                              }
                            },
                          );
                        },
                        suffixIcon: _searchController.text.isEmpty
                            ? const Icon(Icons.search)
                            : IconButton(
                                onPressed: () {
                                  setState(() {
                                    _searchController.text = '';
                                    searchResultList.clear();
                                  });
                                },
                                icon: const Icon(Icons.close),
                              ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
                const Divider(),
              ],
            ),
          ),
          SliverClip(
            child: MultiSliver(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '32 Languages are available',
                      style: theme.textTheme.bodyMedium,
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.filter_list),
                    ),
                  ],
                ),
                ListView.builder(
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: searchResultList.isEmpty
                      ? widget.chapterList.length
                      : searchResultList.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      onTap: () {
                        if (widget.isModal) {
                          Navigator.of(context).pop();
                          Navigator.of(context).pop();
                        }
                        context.pushNamed(
                          'chapter',
                          pathParameters: {
                            'slug': widget.slug,
                            'ch': index.toString(),
                          },
                        );
                      },
                      title: Text(
                        searchResultList.isEmpty
                            ? widget.chapterList[index]
                            : searchResultList[index],
                      ),
                    );
                  },
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
