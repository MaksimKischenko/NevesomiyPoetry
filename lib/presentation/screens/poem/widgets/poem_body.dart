import 'dart:math';

import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
  late ConfettiController _controllerCenter;

  @override
  void initState() {
    super.initState();
    _controllerCenter = ConfettiController(duration: const Duration(seconds: 5));
  }

  @override
  void dispose() {
    _controllerCenter.dispose();
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
  Widget build(BuildContext context) => Scaffold(
      appBar: PoemAppBar(
        poem: widget.poem,
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
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    PoemParser.byBreakContent(widget.poem.content), 
                    style: Theme.of(context).textTheme.bodyMedium
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
        ElevatedButton.icon(
          label: const Text('Нравится'),
          onPressed: () {
            _controllerCenter.play();
            context.read<PoemBloc>().add(const PoemAction(isFavorite: true));
            // context.read<PoemsBloc>().add(PoemsLoadCache());
          },
          icon: SvgPicture.asset(
            SvgRepo.like.location,
            width: 24,
            height: 24,
          ),
        ),
        ElevatedButton.icon(
          label: const Text('Не нравится'),
          onPressed: () {
            context.read<PoemBloc>().add(const PoemAction(isFavorite: false));
            context.read<PoemsBloc>().add(PoemsLoadCache());
          },
          icon: SvgPicture.asset(
            SvgRepo.unLike.location,
            width: 24,
            height: 24,
          ),
        )
      ],
    );

  // Future<void> makeFavorite() {

  // }
}