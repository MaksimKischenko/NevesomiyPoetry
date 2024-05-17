part of 'auth_bloc.dart';

sealed class AuthState extends Equatable {
  const AuthState();
  
  @override
  List<Object?> get props => [];
}

final class AuthStreamStates extends AuthState {
  final User? user;

  const AuthStreamStates({
    required this.user,
  });

  @override
  List<Object?> get props => [user];    
}

final class AuthLoading extends AuthState {}

final class AuthError extends AuthState {
  final Object? error;

  const AuthError({
    required this.error
  });

  @override
  List<Object?> get props => [error];  
}


final class AuthUnVerifiedEmail extends AuthState {
  final User? user;

  const AuthUnVerifiedEmail({
    required this.user,
  });

  @override
  List<Object?> get props => [user];  
}

final class AuthSignedIn extends AuthState {
  final User? user;

  const AuthSignedIn({
    required this.user,
  });

  @override
  List<Object?> get props => [user];  
}


final class PasswordReseted extends AuthState {}