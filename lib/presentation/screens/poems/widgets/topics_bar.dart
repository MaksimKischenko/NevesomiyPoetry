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
                padding: const EdgeInsets.all(2),
                child: ElevatedButton.icon(
                  label: Text(Topics.values[index].nameAndLocation.$1,
                      style: TextStyle(
                          color: currentTopic == Topics.values[index]
                              ? null
                              : ColorStyles.assetDissableColor)
                  ),
                  onPressed: () => sortByType(Topics.values[index]),
                  icon: SvgPicture.asset(
                    Topics.values[index].nameAndLocation.$2,
                    colorFilter: currentTopic == Topics.values[index]
                        ? null
                        : ColorFilter.mode(ColorStyles.assetDissableColor, BlendMode.srcIn),
                    width: 24,
                    height: 24,
                  ),
                ),
            )).toList(),
          ),
        )
    )
  );
}
