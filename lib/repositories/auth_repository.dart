import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthRepository {
  final _authFirebase = FirebaseAuth.instance;

  Future<void> userSetup({required String displayName}) async {
    CollectionReference users = FirebaseFirestore.instance.collection('Users');

    String uid = _authFirebase.currentUser!.uid;

    users.add({'displayName': displayName, 'uid': uid});
    return;
  }

  Future<void> signUp({
    required String email,
    required String password,
  }) async {
    try {
      await _authFirebase.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw Exception('A senha é muito fraca');
      } else if (e.code == 'email-already-in-use') {
        throw Exception('A conta já existe com esse email.');
      }
    } catch (e) {
      throw Exception('Operação inválida, usuário já existe');
    }
  }

  Future<void> signIn({required String email, required String password}) async {
    try {
      await _authFirebase.signInWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw Exception('Nenhum usuario encontrado com esse email.');
      } else if (e.code == 'wrong-password') {
        throw Exception('A senha está incorreta!');
      }
    }
  }

  Future<void> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      await _authFirebase.signInWithCredential(credential);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> signOut() async {
    try {
      await _authFirebase.signOut();
    } catch (e) {
      throw Exception(e);
    }
  }
}
