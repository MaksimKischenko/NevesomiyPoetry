import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nevesomiy/data/data.dart';

import 'screens/screens.dart';

final router = GoRouter(
  initialLocation: '/',
  debugLogDiagnostics: true, 

  observers: [
    GoRouterObserver()
  ],
  routes: [
    GoRoute(
      path: '/',
      pageBuilder: (context, state) => CustomTransitionPage<void>(
        key: state.pageKey,
        transitionsBuilder: (context, animation, secondaryAnimation, child) =>
            FadeTransition(opacity: animation, child: child),
        child: const SplashScreen(),   
      ),
    ),
    GoRoute(
      path: '/auth',
      pageBuilder: (context, state) => CustomTransitionPage<void>(
        key: state.pageKey,
        transitionsBuilder: (context, animation, secondaryAnimation, child) =>
            FadeTransition(opacity: animation, child: child),
        child: const SignInScreen(),   
      ),
    ),    
    GoRoute(
      path: '/signUp',
      pageBuilder: (context, state) => CustomTransitionPage<void>(
        key: state.pageKey,
        transitionsBuilder: (context, animation, secondaryAnimation, child) => 
            FadeTransition(opacity: animation, child: child),
        child: const SignUpScreen(),   
      ),
    ), 
    GoRoute(
      path: '/reset',
      pageBuilder: (context, state) => CustomTransitionPage<void>(
        key: state.pageKey,
        transitionsBuilder: (context, animation, secondaryAnimation, child) =>
            FadeTransition(opacity: animation, child: child),
        child: const ResetPasswordScreen(),   
      ),
    ),           
    GoRoute(
      path: '/home',
      pageBuilder: (context, state) => CustomTransitionPage<void>(
        key: state.pageKey,
        transitionsBuilder: (context, animation, secondaryAnimation, child) =>
            FadeTransition(opacity: animation, child: child),
        child: const HomeScreen(),   
      ),
    ),    
    GoRoute(
      name: 'poem',
      path: '/poem',
      pageBuilder: (context, state) {
        final poem = state.extra as Poem; 
        return CustomTransitionPage<Poem>(
          key: state.pageKey,
            transitionsBuilder: (context, animation, secondaryAnimation, child) =>
                FadeTransition(opacity: animation, child: child),
            child: PoemScreen(poem: poem)     
          );
      },      
      // builder: (context, state) {
      //   final user = state.extra as Poem;
      //   return ParamsScreen(user: user);
      // }
    ),         
  ],
);

class GoRouterObserver extends NavigatorObserver {
  // @override
  // void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
  //   print('MyTest didPush: $route');
  // }

  // @override
  // void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
  //   print('MyTest didPop: $route');
  // }

  // @override
  // void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) {
  //   print('MyTest didRemove: $route');
  // }

  // @override
  // void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
  //   print('MyTest didReplace: $newRoute');
  // }
}