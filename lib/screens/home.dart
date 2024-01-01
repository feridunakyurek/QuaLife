// ignore_for_file: prefer_final_fields, unused_field, sized_box_for_whitespace, prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:qualife_mobileapp/constant/header.dart';
import 'package:qualife_mobileapp/constant/pieChart.dart';
import 'package:qualife_mobileapp/screens/addTarget.dart';
import 'package:qualife_mobileapp/screens/signOutBtn.dart';
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
                        children: targets.map(
                          (target) {
                            bool isCompleted = target['status'] ?? false;

                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Card(
                                color: isCompleted
                                    ? Colors.green[200]
                                    : Colors.blue[200],
                                child: ExpansionTile(
                                  title: Text(
                                    target['targetTitle'],
                                    style: TextStyle(
                                      fontSize: 20,
                                      decoration: isCompleted
                                          ? TextDecoration.lineThrough
                                          : null,
                                    ),
                                  ),
                                  subtitle: Text(
                                    '${target['categories']}',
                                    style: TextStyle(
                                      fontSize: 16,
                                      decoration: isCompleted
                                          ? TextDecoration.lineThrough
                                          : TextDecoration.none,
                                    ),
                                  ),
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        children: [
                                          Text(
                                            'Başlangıç Tarihi: ${target['startDate']}',
                                            style:
                                                const TextStyle(fontSize: 18),
                                          ),
                                          Text(
                                            'Bitiş Tarihi: ${target['endDate']}',
                                            style:
                                                const TextStyle(fontSize: 18),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              ElevatedButton(
                                                onPressed: () {},
                                                style: ButtonStyle(
                                                  minimumSize:
                                                      MaterialStateProperty.all<
                                                          Size>(
                                                    const Size(100, 40),
                                                  ),
                                                  backgroundColor:
                                                      MaterialStateProperty.all<
                                                          Color>(
                                                    HexColor("#ffffff"),
                                                  ),
                                                  shape: MaterialStateProperty
                                                      .all<OutlinedBorder>(
                                                    const RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                        Radius.circular(8.0),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                child: const Text(
                                                  'Güncelle',
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 16,
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(width: 20),
                                              ElevatedButton(
                                                onPressed: () async {
                                                  await _firebaseService
                                                      .updateTargetStatus(
                                                          target['targetId'],
                                                          true);
                                                  setState(() {
                                                    target['status'] = true;
                                                  });
                                                },
                                                style: ButtonStyle(
                                                  minimumSize:
                                                      MaterialStateProperty.all<
                                                          Size>(
                                                    const Size(100, 40),
                                                  ),
                                                  backgroundColor:
                                                      MaterialStateProperty.all<
                                                          Color>(
                                                    HexColor("#ffffff"),
                                                  ),
                                                  shape: MaterialStateProperty
                                                      .all<OutlinedBorder>(
                                                    const RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                        Radius.circular(8.0),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                child: const Text(
                                                  'Tamamlandı',
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 16,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ).toList(),
                      );
                    }
                  },
                ),
                const SizedBox(height: 20),

                //* Hedef ekle butonu
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        bool? success = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const addTarget(),
                          ),
                        );
                        if (success == true) {
                          setState(() {});
                        } else {
                          setState(() {});
                        }
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            HexColor("#f2f2f2")),
                        shape: MaterialStateProperty.all<OutlinedBorder>(
                          const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(8.0),
                            ),
                          ),
                        ),
                      ),
                      child: const Text(
                        'Hedef Ekle',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => StatusChart(),
                          ),
                        );
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            HexColor("#f2f2f2")),
                        shape: MaterialStateProperty.all<OutlinedBorder>(
                          const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(8.0),
                            ),
                          ),
                        ),
                      ),
                      child: Text(
                        'Istatistikler',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ],
                ),
                signOut(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
