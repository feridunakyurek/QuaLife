// ignore_for_file: prefer_final_fields, unused_field, sized_box_for_whitespace
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qualife_mobileapp/constant/header.dart';
import 'package:qualife_mobileapp/screens/addTarget.dart';
import 'package:qualife_mobileapp/services/firebaseServices.dart';
import 'package:sensors/sensors.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _stepCount = 0;
  FirebaseService _firebaseService = FirebaseService();

  @override
  void initState() {
    super.initState();
    accelerometerEvents.listen((AccelerometerEvent event) {
      if (event.y > 11.0) {
        setState(() {
          _stepCount++;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: GoogleFonts.roboto().fontFamily),
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [
                const Header(),
                Card(
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      color: Theme.of(context).colorScheme.outline,
                    ),
                    borderRadius: const BorderRadius.all(Radius.circular(12)),
                  ),
                  child: SizedBox(
                    width: 260,
                    height: 40,
                    child: Center(
                      child: Text(
                        'Günlük Adım: $_stepCount',
                        style: const TextStyle(
                          fontSize: 24,
                        ),
                      ),
                    ),
                  ),
                ),
                const Text(
                  "Hedeflerim",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                FutureBuilder(
                  future: _firebaseService.getTargetsOfCurrentUser(),
                  builder: (context,
                      AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text('Hata oluştu: ${snapshot.error}');
                    } else {
                      List<Map<String, dynamic>> targets = snapshot.data ?? [];

                      return Column(
                        children: targets
                            .map(
                              (target) => Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Card(
                                  color: Colors.grey[200],
                                  child: ListTile(
                                    title: Text(
                                      target['targetTitle'],
                                      style: const TextStyle(fontSize: 20),
                                    ),
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                      );
                    }
                  },
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const addTarget(),
                      ),
                    );
                  },
                  child: const Text('Hedef Ekle'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
