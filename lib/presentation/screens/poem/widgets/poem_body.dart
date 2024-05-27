import 'dart:math';

import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:nevesomiy/data/data.dart';
import 'package:nevesomiy/domain/entites/ettities.dart';
import 'package:nevesomiy/presentation/bloc/bloc.dart';
import 'package:nevesomiy/presentation/screens/poem/widgets/widgets.dart';
import 'package:nevesomiy/utils/utils.dart';

class PoemBody extends StatefulWidget {
  final Poem poem;

  const PoemBody({
    super.key,
    required this.poem,
  });

  @override
  State<PoemBody> createState() => _PoemBodyState();
}

class _PoemBodyState extends State<PoemBody> {
  final ValueNotifier<bool> _isFavorite = ValueNotifier(false);
  late ConfettiController _controllerCenter;

  @override
  void initState() {
    super.initState();
    _controllerCenter = ConfettiController(duration: const Duration(seconds: 5));
    _isFavorite.value = widget.poem.peopleLiked?.contains(DataManager.instance.userEmail) ?? true;
  }

  @override
  void dispose() {
    _controllerCenter.dispose();
    _isFavorite.dispose();
    super.dispose();
  }

  Path drawStar(Size size) {
    double degToRad(double deg) => deg * (pi / 180.0);
    const numberOfPoints = 5;
    final halfWidth = size.width / 2;
    final externalRadius = halfWidth;
    final internalRadius = halfWidth / 2.5;
    final degreesPerStep = degToRad(360 / numberOfPoints);
    final halfDegreesPerStep = degreesPerStep / 2;
    final path = Path();
    final fullAngle = degToRad(360);
    path.moveTo(size.width, halfWidth);

    // ignore: omit_local_variable_types
    for (double step = 0; step < fullAngle; step += degreesPerStep) {
      path
        ..lineTo(halfWidth + externalRadius * cos(step), halfWidth + externalRadius * sin(step))
        ..lineTo(halfWidth + internalRadius * cos(step + halfDegreesPerStep),
            halfWidth + internalRadius * sin(step + halfDegreesPerStep));
    }
    path.close();
    return path;
  }

  @override
  Widget build(BuildContext context) => BlocListener<PoemBloc, PoemState>(
        listener: (context, state) {
          
        },
        child: Scaffold(
          appBar: PoemAppBar(
            poem: widget.poem,
            isFavorite: _isFavorite.value,
          ),
          body: Stack(
            children: [
              Align(
                alignment: Alignment.center,
                child: ConfettiWidget(
                  confettiController: _controllerCenter,
                  blastDirectionality: BlastDirectionality.explosive, // don't specify a direction, blast randomly
                  shouldLoop: true, // start again as soon as the animation is finished
                  colors: const [
                    Colors.green,
                    Colors.blue,
                    Colors.pink,
                    Colors.orange,
                    Colors.purple
                  ], // manually specify the colors to be used
                  createParticlePath: drawStar, // define a custom shape/path.
                ),
              ),
              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      SelectableText(PoemParser.byBreakContent(widget.poem.content),
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontFamily: 'Roboto')
                      ),
                      const SizedBox(height: 12),
                    ],
                  ),
                ),
              ),
            ],
          ),
          persistentFooterAlignment: AlignmentDirectional.center,
          persistentFooterButtons: [
            ValueListenableBuilder<bool>(
              valueListenable: _isFavorite,
              builder: (context, value, child) => ElevatedButton.icon(
                label: Text('Нравится',  style: Theme.of(context).textTheme.bodySmall),
                onPressed: _isFavorite.value ? null : _makeFavorite,
                icon: SvgPicture.asset(
                  SvgRepo.heart.location,
                  width: 24,
                  height: 24,
                ),
              ),
            ),
            ElevatedButton.icon(
              label: Text('Вернуться', style: Theme.of(context).textTheme.bodySmall),
              onPressed: () {
                context.pop(widget.poem);
              },
              icon: SvgPicture.asset(
                SvgRepo.back.location,
                width: 24,
                height: 24,
              ),
            )
          ],
        ),
      );

  void _makeFavorite() {
    _controllerCenter.play();
    context.read<PoemBloc>().add(PoemAction());
    _isFavorite.value = true;
  }
}
