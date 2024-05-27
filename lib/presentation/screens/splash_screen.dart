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
  void initState() {
  super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
    (_) async{
      _onListenNetworkConnection();
    });   
  }

  @override
  Widget build(BuildContext context) => Scaffold(
      backgroundColor: Theme.of(context).colorScheme.tertiary,
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) async{
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
                color: ColorStyles.pallete1,
              ),
            );
          }
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                LoadingIndicator(
                  indicatorsSize: 48,
                  color: ColorStyles.pallete1,
                ),
                const SizedBox(height: 24),
                Text(
                  'Пожалуйста подождите',
                  style: TextStyle(
                    fontSize: 14,
                    fontFamily: 'Pacifico',     
                    color: Theme.of(context).colorScheme.primary,
                  )
                )    
              ],
            ),
          );
        },
      ),
    );

  void _loadPoems() {
    context.read<PoemsBloc>().add(PoemsLoadAndListen());
  }

  void _onListenNetworkConnection() {
    context.read<NetworkConnectionBloc>().add(NetworkConnectionRun());
  }
}
