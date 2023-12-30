import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:qualife_mobileapp/screens/login.dart';

void main() async{
  //Uygulamanin baslamisini bekle. Sonra firebase'i baslat.
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    );
  }
}
