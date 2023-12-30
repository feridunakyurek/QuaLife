import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Google extends StatefulWidget {
  const Google({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _GoogleState createState() => _GoogleState();
}

class _GoogleState extends State<Google> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<User?> _signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleSignInAccount = await _googleSignIn.signIn();
      if (googleSignInAccount == null) return null;

      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      final UserCredential authResult = await _auth.signInWithCredential(credential);
      final User? user = authResult.user;

      return user;
    } catch (error) {
      // ignore: avoid_print
      print("Google Sign In Error: $error");
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login Page"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () async {
                User? user = await _signInWithGoogle();
                if (user != null) {
                  // Google ile giriş başarılı, kullanıcı bilgilerini kullanabilirsiniz
                  // ignore: avoid_print
                  print("Google Sign In Success: ${user.displayName}");
                } else {
                  // Google ile giriş başarısız
                  // ignore: avoid_print
                  print("Google Sign In Failed");
                }
              },
              child: const Text("Continue with Google"),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(
    home: Google(),
  ));
}
