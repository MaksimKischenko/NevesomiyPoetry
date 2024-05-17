

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nevesomiy/data/data.dart';
import 'package:nevesomiy/presentation/bloc/bloc.dart';
import 'widgets/poem_body.dart';

class PoemScreen extends StatelessWidget {
  final Poem poem;

  const PoemScreen({
    super.key,
    required this.poem,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PoemBloc(
        poem: poem
      ),
      child: PoemBody(
        poem: poem,
      ),
    );
  }
}


