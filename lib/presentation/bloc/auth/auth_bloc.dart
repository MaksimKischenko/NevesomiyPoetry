import 'dart:async';



import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:nevesomiy/data/data.dart';
import 'package:nevesomiy/data/failure.dart';
import 'package:nevesomiy/domain/services/fire_base_auth_service.dart';
import 'package:nevesomiy/domain/services/local_cache_service.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {

  final FireBaseAuthService service;
  final CacheService cacheService;
  
  AuthBloc() 
    : service = FireBaseAuthService.instance,
    cacheService = CacheService.instance,
    super(AuthInitial()){
      on<AuthEvent>(_onEvent);
     } 

  Timer? timer;


  Future<void>? _onEvent (
    AuthEvent event,
    Emitter<AuthState> emit,
  ) async {
    if (event is AuthCheckState) return await _onCheckState(event, emit);
    if (event is AuthSignIn) return await _onSignIn(event, emit);
    if (event is AuthSignInWithGoogle) return await _onSignInWithGoogle(event, emit);
    if (event is AuthSignUp) return await _onSignUp(event, emit);
    if (event is AuthSignOut) return await _onSignOut(event, emit);
    if (event is ResetPassword) return await _onResetPassword(event, emit); 
    return;
  }

  Future<void> _onCheckState(
    AuthCheckState event,
    Emitter<AuthState> emit
  ) async {

    await emit.forEach<User?>(
      service.myStream, 
      onData: (authData) {
        if(authData != null) {
          if(!authData.emailVerified) {
            timer ??= Timer.periodic(const Duration(seconds: 3), (timer) async{
              final user = (await service.reloadUser()).currentUser;
              if(user!.emailVerified) {
                DataManager.instance.userEmail = authData.email;
                DataManager.instance.creationDate = user.metadata.creationTime;
                DataManager.instance.lastSignTime = user.metadata.lastSignInTime;
                emit(AuthSignedIn(
                  user: user
                ));
                timer.cancel();   
              }
            });            
          } else {
            DataManager.instance.userEmail = authData.email;
            DataManager.instance.creationDate = authData.metadata.creationTime;
            DataManager.instance.lastSignTime = authData.metadata.lastSignInTime;
          }
        } 
        return AuthStreamStates(
          user: authData,
        );
      }
    );
  }

  Future<void> _onSignIn(
    AuthSignIn event,
    Emitter<AuthState> emit
  ) async {
    emit(AuthLoading());
    try {
      final userCredential = await service.signIn(event.email, event.password);
      emit(AuthSignedIn(user: userCredential?.user));
    } on FirebaseAuthException catch (e) {
      emit(AuthError(error: FireBaseAuthFailure(error: e).message));
    }   
  }  

  Future<void> _onSignInWithGoogle(
    AuthSignInWithGoogle event,
    Emitter<AuthState> emit
  ) async {
    emit(AuthLoading());
    try {
      final user = await service.signInWithGoogle();
      emit(AuthSignedIn(user: user));
    } on FirebaseAuthException catch (e) {
      emit(AuthError(error: FireBaseAuthFailure(error: e).message));
    }    
  }  

  Future<void> _onSignUp(
    AuthSignUp event,
    Emitter<AuthState> emit
  ) async {
    emit(AuthLoading());
    try {
      final userCredential = await service.signUp(
        event.email, event.password
      );
      emit(AuthUnVerifiedEmail(user: userCredential.user));
    } on FirebaseAuthException catch (e) {
      emit(AuthError(error: FireBaseAuthFailure(error: e).message));
    }
  }

  Future<void> _onSignOut(
    AuthSignOut event,
    Emitter<AuthState> emit
  ) async {
    emit(AuthLoading());
    try {
      await Future.wait([
       cacheService.clearCache(),
       service.signOut()
      ]);
    } on FirebaseAuthException catch (e) {
      emit(AuthError(error: FireBaseAuthFailure(error: e).message));
    }
  }

  Future<void> _onResetPassword(
    ResetPassword event,
    Emitter<AuthState> emit
  ) async {
    emit(AuthLoading());
    try {
       await service.resetPassword(event.email);
       emit(PasswordReseted());
    } on FirebaseAuthException catch (e) {
       emit(AuthError(error: FireBaseAuthFailure(error: e).message));
    }
  }     
}
