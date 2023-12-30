import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService{
  final userCollection = FirebaseFirestore.instance.collection("users");

  Future<void> register({required String name, required String surname, required String email, required String password}) async {
    await userCollection.doc().set(data);
  }
}