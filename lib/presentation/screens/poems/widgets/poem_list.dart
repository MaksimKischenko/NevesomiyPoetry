import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:nevesomiy/data/data.dart';
import 'package:nevesomiy/domain/entites/ettities.dart';


class PoemList extends StatelessWidget {
  final List<Poem> poems;

  const PoemList({
    super.key,
    required this.poems,
  });

  @override
  Widget build(BuildContext context) => SliverList(
    delegate: SliverChildBuilderDelegate(
      childCount: poems.length,
      (_, index) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(
                elevation: 4,
                child: Ink(
                  child: InkWell(
                    borderRadius: const BorderRadius.all(Radius.circular(16)),
                    onTap: () => navigateToPoem(context, poems[index]),
                    child: ListTile(
                    leading: SvgPicture.asset(
                      poems[index].poemTopicAssetLocation,
                      height: 80,
                      width: 80,
                    ),  
                    title: Text(
                      poems[index].title, 
                      style: Theme.of(context).textTheme.titleMedium
                    ),
                    subtitle: Text(
                      poems[index].previewContent,
                      style: Theme.of(context).textTheme.bodySmall
                    ),       
                  )),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Нравится: ${poems[index].peopleLiked?.length?? 0}', 
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: 15)
                    ),
                    favoriteWidget(poems[index])  
                  ],
              ),
            )
          ])
        )
      )
    )
 );

  Widget favoriteWidget(Poem poem) => poem.peopleLiked?.contains(DataManager.instance.userEmail) ?? false ? 
    SvgPicture.asset(
      SvgRepo.heart.location,
      // colorFilter: ColorFilter.mode(Colors.black54, BlendMode.overlay),
      width: 18,
      height: 18,
  ) : const SizedBox.shrink();

  Future<void> navigateToPoem(BuildContext context, Poem poem) async {
      await context.pushNamed<Poem>('poem', extra: poem);
  }
}


