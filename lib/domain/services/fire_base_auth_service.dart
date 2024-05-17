import 'dart:async';
import 'package:either_dart/either.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:nevesomiy/data/failure.dart';

class FireBaseAuthService {
  FireBaseAuthService._();
  static final _instance = FireBaseAuthService._();
  static FireBaseAuthService get instance => _instance;
  
  final _fireBase = FirebaseAuth.instance;
  Stream<User?> get myStream => _fireBase.authStateChanges().asBroadcastStream();


   Future<Either<Failure, UserCredential>?> login(String email, String password) async {
    try {
     final userCredential =  await _fireBase.signInWithEmailAndPassword(
        email: email.trim(), 
        password: password.trim(), 
      );
      return Right(userCredential);  
    } on FirebaseAuthException catch (e) {
      return Left(FireBaseAuthFailure(error: e));
    }
  }

   Future<Either<Failure, UserCredential>?> signUp(String email, String password) async {
    try {
     final userCredential =  await _fireBase.createUserWithEmailAndPassword(
        email: email.trim(), 
        password: password.trim(), 
      );
      await userCredential.user?.sendEmailVerification();
      return Right(userCredential);  
    } on FirebaseAuthException catch (e) {
      return Left(FireBaseAuthFailure(error: e));
    }
  }

  Future<Either<Failure, String>> signOut() async {
    try {
      await _fireBase.signOut();
      return const Right('');  
    } on FirebaseAuthException catch (e) {
      return Left(FireBaseAuthFailure(error: e));
    }
  }

   Future<Either<Failure, String>?> resetPassword(String email) async {
    try {
      await _fireBase.sendPasswordResetEmail(
        email: email.trim(), 
      );
      return const Right('Пароль успешно сброшен');  
    } on FirebaseAuthException catch (e) {
      return Left(FireBaseAuthFailure(error: e));
    }
  }

  Future<FirebaseAuth> reloadUser() async {
    await _fireBase.currentUser?.reload();
    return _fireBase;
  } 
}