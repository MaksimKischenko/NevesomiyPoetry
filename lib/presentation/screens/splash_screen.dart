import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:nevesomiy/presentation/bloc/bloc.dart';

import 'package:nevesomiy/presentation/styles/styles.dart';
import 'package:nevesomiy/presentation/widgets/widget.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthStreamStates) {
            if (state.user == null) {
              context.go('/auth');
            } else {
              _loadPoems();
              context.go('/home');
            }
          }
        },
        builder: (context, state) {
          if (state is AuthLoading) {
            return Center(
              child: LoadingIndicator(
                indicatorsSize: 48,
                color: ColorStyles.mainColor,
              ),
            );
          }
          return const SizedBox.shrink();
        },
        //child: Container(),
      ),
    );
  }

  Future<void> _loadPoems() async {
    context.read<PoemsBloc>().add(const PoemsLoad(syncWithFireStore: true));
    // context.read<RemoteResourcesBloc>().add(const RemoteResourcesLoad(syncWithFireStore: true));
  }
}
