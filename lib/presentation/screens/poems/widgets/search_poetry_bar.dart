import 'package:flutter/material.dart';
import 'package:nevesomiy/presentation/widgets/poetry_search.dart';


class SearchPoetryBar extends StatelessWidget {
  final Function() onSearch;
  final TextEditingController poetryNameController;
  final Animation<Offset> offsetAnimation;  
  final bool isVisibleSearchField;

  const SearchPoetryBar({
    super.key,
    required this.onSearch,
    required this.poetryNameController,
    required this.offsetAnimation,
    required this.isVisibleSearchField,
  });
  @override
  Widget build(BuildContext context) => SliverList(
      delegate: SliverChildBuilderDelegate(
        childCount: 1,
        (_, simpleIndex) => isVisibleSearchField? SlideTransition(
          position: offsetAnimation,
          child: PoetrySearch(
            poetryNameController: poetryNameController, 
            onSearch: onSearch
          ),
        ): const SizedBox.shrink()
    )
  );
}
