// ignore_for_file: avoid_print, prefer_final_fields

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:qualife_mobileapp/constant/header.dart';
import 'package:qualife_mobileapp/screens/home.dart';
import 'package:qualife_mobileapp/screens/signUp.dart';
import 'package:qualife_mobileapp/services/provider/authServices.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isRegisterButtonClicked = false;

  final AuthService _auth = AuthService();

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
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
                                    "GİRİŞ YAP",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  isRegisterButtonClicked = true;
                                });
                                // Kayıt ol sayfasına yönlendirme yapabilirsiniz
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const RegisterPage(),
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                elevation: 0.0,
                                // Gölgeyi kaldırmak için elevation'ı 0.0 olarak ayarlayın
                                backgroundColor: HexColor("#FFFFFF"),
                                // Butonun arka plan rengi
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                              ),
                              child: Text(
                                "KAYIT OL",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: isRegisterButtonClicked
                                      ? Colors.white
                                      : Colors.black,
                                ),
                              ),
                            )
                          ],
                        ),
                        /* Input1 */
                        Padding(
                          padding: const EdgeInsets.only(top: 50),
                          child: Stack(
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
                        /* Forgot Password */
                        Align(
                          alignment: Alignment.centerLeft,
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const LoginPage(),
                                ),
                              );
                            },
                            child: const Text(
                              'Sifreni mi Unuttun?',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey,
                                  decoration: TextDecoration.underline),
                            ),
                          ),
                        ),
                        /* Navigation Button */
                        Align(
                          alignment: Alignment.centerRight,
                          child: ElevatedButton(
                            onPressed: () {
                              _signIn();
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
                              // Diğer özelleştirmeleri ekleyebilirsiniz
                            ),
                            child: const Text(
                              'GİRİŞ YAP',
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

  void _signIn() async {
    String email = _emailController.text;
    String password = _passwordController.text;

    User? user = await _auth.signInWithEmailAndPassword(email, password);

    if (user != null) {
      print("Giris başarılı");
      // ignore: use_build_context_synchronously
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const HomePage(),
        ),
      );
    } else {
      print("Giris başarısız");
    }
  }
}
