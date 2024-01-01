// ignore_for_file: avoid_print, file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseService {
  final CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('users');

  Future<void> addTargetToUser(String targetTitle, String startDate,
      String endDate, String category) async {
    try {
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        String uid = user.uid;

        DocumentReference userDocRef = usersCollection.doc(uid);

        final targetsCollectionRef = userDocRef.collection('targets');

        // eklenen hedefe kendi id'sini vermek için
        DocumentReference newTargetDocRef = targetsCollectionRef.doc();

        await newTargetDocRef.set({
          'targetId': newTargetDocRef.id,
          'targetTitle': targetTitle,
          'startDate': startDate,
          'endDate': endDate,
          'categories': category,
          'status': false,
        });

        print(
            'Target koleksiyonu başarıyla eklendi. Target ID: ${newTargetDocRef.id}');
      } else {
        print('Kullanıcı giriş yapmamış.');
      }
    } catch (error) {
      print('Hata oluştu: $error');
    }
  }

  Future<List<Map<String, dynamic>>> getTargetsOfCurrentUser() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        String uid = user.uid;

        DocumentReference userDocRef = usersCollection.doc(uid);

        final targetsCollectionRef = userDocRef.collection('targets');

        QuerySnapshot targetsQuerySnapshot = await targetsCollectionRef.get();

        List<Map<String, dynamic>> targetsList = targetsQuerySnapshot.docs
            .map((DocumentSnapshot doc) => doc.data() as Map<String, dynamic>)
            .toList();

        return targetsList;
      } else {
        return [];
      }
    } catch (error) {
      print('Hata oluştu: $error');
      return [];
    }
  }

  Future<void> updateTargetStatus(String targetId, bool status) async {
    try {
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        String uid = user.uid;

        DocumentReference userDocRef = usersCollection.doc(uid);

        final targetsCollectionRef = userDocRef.collection('targets');

        await targetsCollectionRef.doc(targetId).update({'status': status});
        print(
            'Target durumu güncellendi. Target ID: $targetId, Status: $status');
      } else {
        print('Kullanıcı giriş yapmamış.');
      }
    } catch (error) {
      print('Hata oluştu: $error');
    }
  }

  Future<Map<String, dynamic>> getTargetDetails(String targetId) async {
    try {
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        String uid = user.uid;

        DocumentReference userDocRef = usersCollection.doc(uid);

        final targetsCollectionRef = userDocRef.collection('targets');

        DocumentSnapshot targetDocSnapshot =
            await targetsCollectionRef.doc(targetId).get();

        Map<String, dynamic>? targetDetails =
            targetDocSnapshot.data() as Map<String, dynamic>?;

        return targetDetails ?? {};
      } else {
        return {};
      }
    } catch (error) {
      print('Hata oluştu: $error');
      return {};
    }
  }
}
