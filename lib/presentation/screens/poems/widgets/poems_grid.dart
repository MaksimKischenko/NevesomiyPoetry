import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:nevesomiy/data/data.dart';
import 'package:nevesomiy/domain/entites/ettities.dart';
import 'package:nevesomiy/presentation/bloc/bloc.dart';
import 'package:nevesomiy/presentation/styles/styles.dart';
import 'package:nevesomiy/presentation/widgets/widget.dart';


class PoemGrid extends StatelessWidget {
  final List<Poem> poems;
  final Animation<Offset> offsetAnimation;  

  const PoemGrid({
    super.key,
    required this.offsetAnimation,
    required this.poems,
  });

  @override
  Widget build(BuildContext context) => SliverGrid.builder(
    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 3,
    ),
    itemCount: poems.length,
    itemBuilder: (_, index) => SlideTransition(
      position: offsetAnimation,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Card(
          child: Ink(
            child: InkWell(
              borderRadius: const BorderRadius.all(Radius.circular(16)),
              onTap: () => navigateToPoem(context, poems[index]),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    poems[index].poemTopicAssetLocation,
                    height: 24,
                    width: 24,
                  ), 
                  Expanded(
                    child: Center(
                      child: Text(
                        maxLines: 3,
                        poems[index].title, 
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: ColorStyles.pallete4,
                          fontSize: 10
                        ),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      AnimatedFlipCounter(
                        duration: const Duration(milliseconds: 500),
                        textStyle: Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: 12),
                        value: poems[index].peopleLiked?.length?? 0, // pass in a value like 2014
                      ),
                      const SizedBox(width: 8),
                      favoriteWidget(poems[index])  
                    ],
                  )
                ],
              ) 
            ),
          ),
        ),
      ),
    )
 );

  Widget favoriteWidget(Poem poem) => poem.peopleLiked?.contains(DataManager.instance.userEmail) ?? false ? 
    SvgPicture.asset(
      SvgRepo.heart.location,
      width: 10,
      height: 10,
    ) : SvgPicture.asset(
      SvgRepo.heart.location,
      colorFilter: ColorFilter.mode(ColorStyles.assetDissableColor, BlendMode.srcIn),
      width: 10,
      height: 10,
    );

  Future<void> navigateToPoem(BuildContext context, Poem poem) async {
    final updatedPoem = await context.pushNamed<Poem>('poem', extra: poem);
    if(updatedPoem != null) {
      context.read<PoemsBloc>().add(PoemsUpdateByPoem(poem: updatedPoem));
    }
  }
}


