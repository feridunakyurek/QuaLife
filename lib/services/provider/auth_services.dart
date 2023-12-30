import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService {
  final userCollection = FirebaseFirestore.instance.collection("users");

  Future<void> register(
      {required String name,
      required String surname,
      required String email,
      required String password,
      required String confirmPassword}) async {
    await userCollection.doc().set({
      "name": name,
      "surname": surname,
      "email": email,
      "password": password
    });
  }
}
