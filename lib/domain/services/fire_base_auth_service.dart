import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';


class FireBaseAuthService {
  FireBaseAuthService._();
  static final _instance = FireBaseAuthService._();
  static FireBaseAuthService get instance => _instance;
  
  final _fireBase = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Stream<User?> get myStream => _fireBase.authStateChanges().asBroadcastStream();

  Future<UserCredential>? signIn(String email, String password) async {
    final userCredential =  await _fireBase.signInWithEmailAndPassword(
      email: email.trim(), 
      password: password.trim(), 
    );
    return userCredential;  
  }

  Future<User?> signInWithGoogle() async {
    final googleUser = await _googleSignIn.signIn();
    if (googleUser == null) {
      return null;
    }
    final googleAuth = await googleUser.authentication;
    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    // Once signed in, return the UserCredential
    final userCredential = await _fireBase.signInWithCredential(credential);
    return userCredential.user;
  } 
  
  Future<UserCredential> signUp(String email, String password) async {
    final userCredential =  await _fireBase.createUserWithEmailAndPassword(
      email: email.trim(), 
      password: password.trim(), 
    );
    await userCredential.user?.sendEmailVerification();
    return userCredential;
  }

  Future<void> signOut() async {
    await Future.wait([
        _fireBase.signOut(),
        if(_googleSignIn.currentUser != null) 
        _googleSignIn.signOut()
      ]
    );
  }

  Future<void> resetPassword(String email) async {
    await _fireBase.sendPasswordResetEmail(
      email: email.trim(), 
    );
  }

  Future<FirebaseAuth> reloadUser() async {
    await _fireBase.currentUser?.reload();
    return _fireBase;
  } 
}