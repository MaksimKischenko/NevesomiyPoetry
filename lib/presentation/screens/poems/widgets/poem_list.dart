import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:nevesomiy/data/data.dart';
import 'package:nevesomiy/domain/entites/ettities.dart';
import 'package:nevesomiy/presentation/bloc/bloc.dart';
import 'package:nevesomiy/presentation/widgets/widget.dart';


class PoemList extends StatelessWidget {
  final List<Poem> poems;
  final Animation<Offset> offsetAnimation;  
  const PoemList({
    super.key,
    required this.offsetAnimation,
    required this.poems,
  });

  @override
  Widget build(BuildContext context) => SliverList.builder(
    itemCount: poems.length,
    itemBuilder: (_, index) => SlideTransition(
      position: offsetAnimation,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(
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
                  children: [
                    Text(
                      'Нравится: ', 
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: 15)
                    ),
                    AnimatedFlipCounter(
                      duration: const Duration(milliseconds: 500),
                      textStyle: Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: 15),
                      value: poems[index].peopleLiked?.length?? 0, // pass in a value like 2014
                    ),
                    const Spacer(),
                    favoriteWidget(poems[index])  
                  ],
              ),
            )
          ])
        )
      ),
    )
 );

  Widget favoriteWidget(Poem poem) => poem.peopleLiked?.contains(DataManager.instance.userEmail) ?? false ? 
    SvgPicture.asset(
      SvgRepo.heart.location,
      width: 18,
      height: 18,
    ) : const SizedBox.shrink();

  Future<void> navigateToPoem(BuildContext context, Poem poem) async {
    final updatedPoem = await context.pushNamed<Poem>('poem', extra: poem);
    if(updatedPoem != null) {
      context.read<PoemsBloc>().add(PoemsUpdateByPoem(poem: updatedPoem));
    }
  }
}


