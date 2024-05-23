import 'dart:async';
import 'package:either_dart/either.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:nevesomiy/data/failure.dart';

class FireBaseAuthService {
  FireBaseAuthService._();
  static final _instance = FireBaseAuthService._();
  static FireBaseAuthService get instance => _instance;
  
  final _fireBase = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Stream<User?> get myStream => _fireBase.authStateChanges().asBroadcastStream();


   Future<Either<Failure, UserCredential>?> signIn(String email, String password) async {
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

  Future<Either<Failure, User?>> signInWithGoogle() async {
      final googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        return Left(GoogleAuthFailure(googleAccount: googleUser));
      }
      final googleAuth = await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Once signed in, return the UserCredential
      final userCredential = await _fireBase.signInWithCredential(credential);
      return Right(userCredential.user);
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
      await Future.wait([
         _fireBase.signOut(),
         if(_googleSignIn.currentUser != null) 
         _googleSignIn.signOut()
        ]
      );
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