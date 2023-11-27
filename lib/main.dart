import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:naari/widgets/login_screen.dart';
import 'package:naari/widgets/registration_screen.dart';
import 'home_screen.dart';
import 'package:naari/widgets/profile_screen.dart'; // Import the profile screen

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blue),
      ),
      home: FirebaseAuth.instance.currentUser != null
          ? HomeScreen(user: FirebaseAuth.instance.currentUser!)
          : LoginScreen(),
      // Add the route for the profile screen
      initialRoute: FirebaseAuth.instance.currentUser == null ? '/register' : '/home',
      routes: {
        '/login': (context) => LoginScreen(),
        '/register': (context) => RegistrationScreen(),
        '/home': (context) {
          final user = FirebaseAuth.instance.currentUser;
          if (user != null) {
            // User is logged in, navigate to HomeScreen
            return HomeScreen(user: user);
          } else {
            // User is not logged in, navigate to LoginScreen
            return LoginScreen();
          }
        },
      },
    );
  }
}
