import 'package:flutter/material.dart';
import 'package:nevesomiy/presentation/widgets/widget.dart';


class PoetrySearch extends StatelessWidget {
  final TextEditingController poetryNameController;
  final Function() onSearch;
    

  const PoetrySearch({
    super.key,
    required this.poetryNameController,
    required this.onSearch,
  });

  @override
  Widget build(BuildContext context) => Padding(
      padding: const EdgeInsets.symmetric(horizontal: 64),
      child: SearchField(
        controller: poetryNameController,
        onFieldSubmitted: (name) {
          onSearch.call();
        },
      )
    );
}