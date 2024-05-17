import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:nevesomiy/data/remote_models/poem.dart';
import 'package:nevesomiy/domain/entites/ettities.dart';


class PoemList extends StatelessWidget {
  final List<Poem> poems;

  const PoemList({
    super.key,
    required this.poems,
  });

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        childCount: poems.length,
        (_, index) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Ink(
            child: InkWell(
              onTap: () => navigateToPoem(context, poems[index]),
              child: ListTile(
                leading: SvgPicture.asset(
                  poems[index].poemTopicAssetLocation,
                  width: 120,
                  height: 120,
                ),  
                title: Text(
                  poems[index].title, 
                  style: Theme.of(context).textTheme.titleMedium
                ),
                subtitle: Text(
                  poems[index].previewContent,
                  style: Theme.of(context).textTheme.bodySmall
                ),
                trailing: (poems[index].isFavorite ?? false)? SvgPicture.asset(
                  SvgRepo.medal.location,
                  width: 18,
                  height: 18,
                ) : null,                
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> navigateToPoem(BuildContext context, Poem poem) async {
     await context.pushNamed<Poem>('poem', 
      extra: poem
    );
  }
}


