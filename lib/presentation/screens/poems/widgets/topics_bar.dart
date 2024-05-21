import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nevesomiy/domain/entites/ettities.dart';
import 'package:nevesomiy/presentation/styles/styles.dart';
import 'package:nevesomiy/utils/utils.dart';

class TopicsBar extends StatelessWidget {
  final Function(Topics value) sortByType;
  final Topics currentTopic;

  const TopicsBar({
    super.key,
    required this.sortByType,
    required this.currentTopic
  });

  @override
  Widget build(BuildContext context) => SliverList(
      delegate: SliverChildBuilderDelegate(
        childCount: 1,
        (_, simpleIndex) => Padding(
          padding: const EdgeInsets.all(8),
          child: Wrap(
            children: Topics.values
              .mapIndexed((e, index) => Padding(
                padding: const EdgeInsets.all(3),
                child: ElevatedButton.icon(
                  label: Text(Topics.values[index].nameAndLocation.$1,
                      style: TextStyle(
                          color: selected(index)
                              ? null
                              : ColorStyles.assetDissableColor)
                  ),
                  onPressed: () => sortByType(Topics.values[index]),
                  style: ButtonStyle(
                    overlayColor: MaterialStateProperty.all(ColorStyles.mainColorSplash),
                    shadowColor:  MaterialStateProperty.all(ColorStyles.mainColor),
                    surfaceTintColor: MaterialStateProperty.all(ColorStyles.mainColor),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    side: selected(index)? MaterialStateProperty.all(
                      BorderSide(
                      color: ColorStyles.mainColor, // Цвет границы
                      width: 1, // Ширина границы
                      ),
                    ): null,
                    elevation: MaterialStateProperty.all(2)
                  ),
                  icon: SvgPicture.asset(
                    Topics.values[index].nameAndLocation.$2,
                    colorFilter: selected(index)
                        ? null
                        : ColorFilter.mode(ColorStyles.assetDissableColor, BlendMode.srcIn),
                    width: 16,
                    height: 16,
                  ),
                ),
            )).toList(),
          ),
        )
    )
  );

  bool selected(int index) => currentTopic == Topics.values[index];
}
