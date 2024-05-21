import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nevesomiy/data/data.dart';
import 'package:nevesomiy/domain/entites/ettities.dart';


class PoemAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Poem poem;
  final bool isFavorite;

  const PoemAppBar({
    super.key, 
    required this.poem,
    required this.isFavorite
  });

  @override
  Widget build(BuildContext context) => AppBar(
      automaticallyImplyLeading: false,
      centerTitle: true,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            poem.title, 
            style: Theme.of(context).appBarTheme.titleTextStyle,
          ),
          const SizedBox(width: 12),
          SvgPicture.asset(
            poem.poemTopicAssetLocation,
            width: 24,
            height: 24,
          ),
        ],
      ),
      actions: [
       if (isFavorite) SvgPicture.asset(
            SvgRepo.heart.location,
            width: 24,
            height: 24,
        ) else const SizedBox.shrink()
      ],
  );

  @override
  Size get preferredSize => const Size.fromHeight(60);
}
