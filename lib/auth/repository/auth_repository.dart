import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRepository {
  //firestore instance
  final _firestore = FirebaseFirestore.instance;

  //get current user
  final _auth = FirebaseAuth.instance;

  User? get currentUser => _auth.currentUser;

  //sign up
  Future<Either<String, User?>> signUp(
      {required String email,
      required String password,
      required String? fullName}) async {
    try {
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      User? _user = credential.user;

      //add full name into the user's profile
      await _user!.updateProfile(displayName: fullName);
      await _user.reload(); // to apply changes

      _user = FirebaseAuth.instance.currentUser;

      //storing in firestore
      await _firestore.collection("users").doc(_user!.uid).set(
        {
          "userId": _user.uid,
          "fullName": _user.displayName,
          "email": _user.email,
        },
        SetOptions(merge: true),
      );

      //return user
      return Right(_user);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return (Left('The password provided is too weak.'));
      } else if (e.code == 'email-already-in-use') {
        return (Left('The account already exists for that email.'));
      } else {
        return Left(e.toString());
      }
    } catch (e) {
      return Left(e.toString());
    }
  }

  //sign in
  Future<Either<String, User?>> signIn(
      {required String email, required String password}) async {
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      final _user = credential.user;

      //storing in firestore
      await _firestore.collection("users").doc(_user!.uid).set(
        {
          "userId": _user.uid,
          "fullName": _user.displayName,
          "email": _user.email,
        },
        SetOptions(merge: true),
      );

      return (Right(_user));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return (Left('TNo user found for that email.'));
      } else if (e.code == 'wrong-password') {
        return (Left('Wrong password provided for that user.'));
      } else {
        return Left(e.toString());
      }
    } catch (e) {
      return Left(e.toString());
    }
  }

  //sign out
  Future<Either<String, void>> signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      return (Right(null));
    } on FirebaseAuthException catch (e) {
      return Left(e.toString());
    } catch (e) {
      return Left(e.toString());
    }
  }
}
