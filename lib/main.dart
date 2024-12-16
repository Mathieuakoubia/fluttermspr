import 'package:flutter/material.dart';
import 'package:mspr_repo_new/login.dart';
import 'package:mspr_repo_new/register.dart';
import 'package:mspr_repo_new/screens/home_screen.dart';
import 'package:mspr_repo_new/screens/welcome_screen.dart';
import 'package:mspr_repo_new/ProductListPage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Color(0xFF212325),
      ),
      home: WelcomeScreen(),
      initialRoute: '/',
      routes: {
        '/register': (context) => RegisterPage(),
        '/login': (context) => LoginPage(),
        '/home': (context) => HomeScreen(),
        '/products': (context) => ProductListPage(), // LIGNE CORRIGÉE
      },
    );
  }
}
