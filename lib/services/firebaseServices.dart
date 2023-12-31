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

        // Kullanıcının UID'sini kullanarak, "users" koleksiyonundaki belgesine ulaş
        DocumentReference userDocRef = usersCollection.doc(uid);

        // Kullanıcının belgesinde "targets" adında bir koleksiyon kontrol et
        final targetsCollectionRef = userDocRef.collection('targets');

        // Kullanıcının "targets" koleksiyonuna yeni bir belge ekleyin
        await targetsCollectionRef.add({
          'targetTitle': targetTitle,
          'startDate': startDate,
          'endDate': endDate,
          'category': category,
        });
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

        // Kullanıcının UID'sini kullanarak, "users" koleksiyonundaki belgesine ulaş
        DocumentReference userDocRef = usersCollection.doc(uid);

        // Kullanıcının belgesinde "targets" adında bir koleksiyon kontrol et
        final targetsCollectionRef = userDocRef.collection('targets');

        // "targets" koleksiyonundaki verileri al
        QuerySnapshot targetsQuerySnapshot = await targetsCollectionRef.get();

        // QuerySnapshot'tan verileri çıkart ve liste olarak döndür
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
}
