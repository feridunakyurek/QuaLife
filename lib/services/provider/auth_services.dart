// ignore_for_file: avoid_print, use_build_context_synchronously
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final userCollection = FirebaseFirestore.instance.collection("users");
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User?> signUpWithEmailAndPassword(
      String name, String surname, String email, String password) async {
    await userCollection.doc().set({
      "name": name,
      "surname": surname,
      "email": email,
    });
    try {
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return credential.user;
    } catch (e) {
      print("Some error occured");
    }
    return null;
  }

  Future<User?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential credential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return credential.user;
    } catch (e) {
      print("Some error occured");
    }
    return null;
  }

  // Future<void> signUp(BuildContext context,
  //     {required String name,
  //     required String surname,
  //     required String email,
  //     required String password}) async {
  //   final navigator = Navigator.of(context);
  //   try {
  //     final UserCredential userCredential = await _auth
  //         .createUserWithEmailAndPassword(email: email, password: password);
  //     if (userCredential.user != null) {
  //       await register(name: name, surname: surname, email: email);
  //       navigator
  //           .push(MaterialPageRoute(builder: (context) => const HomePage()));
  //     }
  //   } on FirebaseAuthException catch (e) {
  //     Fluttertoast.showToast(msg: e.message!, toastLength: Toast.LENGTH_LONG);
  //   }
  // }

  // Future<void> signIn(BuildContext context,
  //     {required String email, required String password}) async {
  //   final navigator = Navigator.of(context);
  //   try {
  //     final UserCredential userCredential = await _auth
  //         .signInWithEmailAndPassword(email: email, password: password);
  //     if (userCredential.user != null) {
  //       navigator
  //           .push(MaterialPageRoute(builder: (context) => const HomePage()));
  //     }
  //   } on FirebaseAuthException catch (e) {
  //     Fluttertoast.showToast(msg: e.message!, toastLength: Toast.LENGTH_LONG);
  //   }
  // }
}
