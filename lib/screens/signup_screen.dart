import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:formfillpro/home_page/screens/nav_screen.dart';
import 'package:formfillpro/reusable_widgets/reusable_widget.dart';
import 'package:formfillpro/utils/color_utils.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _emailTextController = TextEditingController();
  TextEditingController _userNameTextController = TextEditingController();

  Future<void> _createUserDocument(String userId, String email, String username) async {
    try {
      await FirebaseFirestore.instance.collection('users').doc(userId).set({
        'email': email,
        'username': username,
        'role': 'user', // Set default role to "user"
        // You can add more fields as needed
      });
    } catch (e) {
      print('Error creating user document: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "Sign Up",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              hexStringToColor("CB2B93"),
              hexStringToColor("9546C4"),
              hexStringToColor("5E61F4"),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 120, 20, 0),
            child: Column(
              children: <Widget>[
                const SizedBox(
                  height: 20,
                ),
                reusableTextField(
                  "Enter UserName",
                  Icons.person_outline,
                  false,
                  _userNameTextController,
                ),
                const SizedBox(
                  height: 20,
                ),
                reusableTextField(
                  "Enter Email Id",
                  Icons.person_outline,
                  false,
                  _emailTextController,
                ),
                const SizedBox(
                  height: 20,
                ),
                reusableTextField(
                  "Enter Password",
                  Icons.lock_outlined,
                  true,
                  _passwordTextController,
                ),
                const SizedBox(
                  height: 20,
                ),
                firebaseUIButton(context, "Sign Up", () async {
                  try {
                    UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
                      email: _emailTextController.text,
                      password: _passwordTextController.text,
                    );
                    // Create user document after successful registration
                    await _createUserDocument(
                      userCredential.user!.uid,
                      _emailTextController.text,
                      _userNameTextController.text,
                    );
                    print("User registered successfully");
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const NavScreen()),
                    );
                  } on FirebaseAuthException catch (e) {
                    if (e.code == 'weak-password') {
                      print('The password provided is too weak.');
                    } else if (e.code == 'email-already-in-use') {
                      print('The account already exists for that email.');
                    }
                  } catch (e) {
                    print('Error: $e');
                  }
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
