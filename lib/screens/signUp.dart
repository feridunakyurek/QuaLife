// ignore_for_file: file_names, unused_local_variable, use_build_context_synchronously, prefer_final_fields

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:qualife_mobileapp/screens/home.dart';
import 'package:qualife_mobileapp/screens/login.dart';
import 'package:qualife_mobileapp/services/provider/auth_services.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool isRegisterButtonClicked = false;

  final AuthService _auth = AuthService();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _surnameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _surnameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;
    return MaterialApp(
      theme: ThemeData(fontFamily: GoogleFonts.roboto().fontFamily),
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [
                // **Header**
                Container(
                  width: deviceWidth,
                  height: deviceHeight / 8,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(8),
                      bottomRight: Radius.circular(8),
                    ),
                  ),
                  child: const Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 25),
                        child: Text(
                          'QuaLife',
                          style: TextStyle(color: Colors.black, fontSize: 28),
                        ),
                      ),
                      Text(
                        "Kaliteli Yaşam Destekçiniz",
                        style: TextStyle(fontSize: 18),
                      )
                    ],
                  ),
                ),
                // **Body**
                Padding(
                  padding: const EdgeInsets.only(top: 100),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const LoginPage(),
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                elevation: 0.0,
                                backgroundColor: HexColor(
                                    "#FFFFFF"), // Butonun arka plan rengi
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                              ),
                              child: const Text(
                                "GİRİŞ YAP",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  isRegisterButtonClicked = false;
                                });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                      color: isRegisterButtonClicked
                                          ? Colors.transparent
                                          : Colors.black, // Çizgi rengi
                                      width: 2.0, // Çizgi kalınlığı
                                    ),
                                  ),
                                ),
                                child: ElevatedButton(
                                  onPressed: null,
                                  style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                      HexColor("#FFFFFF"),
                                    ),
                                    shape: MaterialStateProperty.all<
                                        OutlinedBorder>(
                                      const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(8.0),
                                        ),
                                      ),
                                    ),
                                    // Diğer özelleştirmeleri ekleyebilirsiniz
                                  ),
                                  child: const Text(
                                    "KAYIT OL",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        /* Input1 */
                        Padding(
                          padding: const EdgeInsets.only(top: 50),
                          child: Center(
                            child: Stack(
                              children: [
                                TextField(
                                  controller: _nameController,
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: HexColor("#FFFFFF"),
                                    labelText: 'Ad',
                                    labelStyle: const TextStyle(
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  bottom: 0,
                                  left: 0,
                                  right: 0,
                                  child: Container(
                                    height: 1.0,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Stack(
                          children: [
                            TextField(
                              controller: _surnameController,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: HexColor("#FFFFFF"),
                                labelText: 'Soyad',
                                labelStyle: const TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              left: 0,
                              right: 0,
                              child: Container(
                                height: 1.0,
                                color: Colors.black, // Çizgi rengi
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Stack(
                          children: [
                            TextField(
                              controller: _emailController,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: HexColor("#FFFFFF"),
                                labelText: 'E-Mail',
                                labelStyle: const TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              left: 0,
                              right: 0,
                              child: Container(
                                height: 1.0,
                                color: Colors.black, // Çizgi rengi
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),

                        /* Input2 */

                        Stack(
                          children: [
                            TextField(
                              controller: _passwordController,
                              obscureText: true,
                              keyboardType: TextInputType.visiblePassword,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: HexColor("#FFFFFF"),
                                labelText: 'Şifre',
                                labelStyle: const TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              left: 0,
                              right: 0,
                              child: Container(
                                height: 1.0,
                                color: Colors.black, // Çizgi rengi
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        /* Navigation Button */
                        Align(
                          alignment: Alignment.centerRight,
                          child: ElevatedButton(
                            onPressed: () {
                              _signUp();
                            },
                            /* Button style */
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
                              'KAYIT OL',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _signUp() async {
    String name = _nameController.text;
    String surname = _surnameController.text;
    String email = _emailController.text;
    String password = _passwordController.text;

    User? user =
        await _auth.signUpWithEmailAndPassword(name, surname, email, password);

    if (user != null) {
      // ignore: avoid_print
      print("Kayıt başarılı");
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const HomePage(),
        ),
      );
    } else {
      Fluttertoast.showToast(
          msg: "Kayıt başarısız", toastLength: Toast.LENGTH_LONG);
      // ignore: avoid_print
      print("Kayıt başarısız");
    }
  }
}
