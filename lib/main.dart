import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:formfillpro/firebase_options.dart';
import 'package:formfillpro/home_page/screens/nav_screen.dart';
import 'package:formfillpro/screens/signin_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Your App Title',
      theme: ThemeData(),
      home: const SignInScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Your App Title',
//       theme: ThemeData(
        
//       ),
//       home: AuthenticationWrapper(),
//       debugShowCheckedModeBanner: false, 
//     );
//   }
// }

// class AuthenticationWrapper extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder(
//       stream: FirebaseAuth.instance.authStateChanges(),
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return const CircularProgressIndicator();
//         } else if (snapshot.hasData) {
//           return const NavScreen();
//         } else {
//           return const SignInScreen();
//         }
//       },
//     );
//   }
// }
