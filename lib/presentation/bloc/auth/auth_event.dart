part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

final class AuthCheckState extends AuthEvent {}

final class AuthSignIn extends AuthEvent {
  final String email;
  final String password;

  const AuthSignIn({
    required this.email,
    required this.password
  });

  @override
  List<Object?> get props => [email, password];  
}

final class AuthSignInWithGoogle extends AuthEvent {}

final class AuthSignUp extends AuthEvent {
  final String email;
  final String password;

  const AuthSignUp({
    required this.email,
    required this.password
  });

  @override
  List<Object?> get props => [email, password];  
}

final class AuthSignOut extends AuthEvent {}


final class ResetPassword extends AuthEvent {
  final String email;

  const ResetPassword({
    required this.email,
  });

  @override
  List<Object?> get props => [email];  
}