import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  LoginPage({super.key});
  Future<void> loginUser(BuildContext context) async {
    final String apiUrl = "http://127.0.0.1:8000/login";

    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      if (context.mounted) {
        showCustomSnackBar(context, "Veuillez remplir tous les champs.", false);
      }
      return;
    }

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {"Content-Type": "application/x-www-form-urlencoded"},
        body: {
          "email": emailController.text, // Changer "username" en "email"
          "password": passwordController.text,
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        final String token = responseData['access_token'];

        if (context.mounted) {
          showCustomSnackBar(context, "Connexion réussie !", true);
          Navigator.pushReplacementNamed(context, '/home'); // Navigue vers la page Home
        }
      } else {
        if (context.mounted) {
          showCustomSnackBar(context, "Email ou mot de passe incorrect.", false);
        }
      }
    } catch (e) {
      if (context.mounted) {
        showCustomSnackBar(context, "Erreur réseau : ${e.toString()}", false);
      }
    }
  }


  void showCustomSnackBar(BuildContext context, String message, bool isSuccess) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Row(
        children: [
          Icon(
            isSuccess ? Icons.check_circle : Icons.error,
            color: Colors.white,
          ),
          SizedBox(width: 10),
          Expanded(child: Text(message)),
        ],
      ),
      backgroundColor: isSuccess ? Colors.green : Colors.red,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFF6F4F37),
                Color(0xFF3E2723),
                Color(0xFF9E7C4F),
                Color(0xFFCBB89C),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Connexion',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 16),
                    TextField(
                      controller: emailController,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintText: 'Email',
                        hintStyle: TextStyle(color: Colors.white60),
                        filled: true,
                        fillColor: Color(0xFF212325),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide.none,
                        ),
                        prefixIcon: Icon(
                          Icons.email,
                          color: Colors.white60,
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                    TextField(
                      controller: passwordController,
                      obscureText: true,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintText: 'Mot de passe',
                        hintStyle: TextStyle(color: Colors.white60),
                        filled: true,
                        fillColor: Color(0xFF212325),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide.none,
                        ),
                        prefixIcon: Icon(
                          Icons.lock,
                          color: Colors.white60,
                        ),
                      ),
                    ),
                    SizedBox(height: 22),
                    Center(
                      child: ElevatedButton(
                        onPressed: () => loginUser(context),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFFE57734),
                          padding: EdgeInsets.symmetric(
                              horizontal: 80, vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Text(
                          'Connexion',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    SizedBox(height: 50),
                    Center(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pushReplacementNamed(context, '/register');
                        },
                        child: RichText(
                          text: TextSpan(
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                            children: [
                              TextSpan(
                                text: "Vous n'êtes pas inscrit ? ",
                                style: TextStyle(color: Colors.white),
                              ),
                              TextSpan(
                                text: "S'inscrire",
                                style: TextStyle(
                                  foreground: Paint()
                                    ..shader = LinearGradient(
                                      colors: [
                                        Color(0xFFE57734),
                                        Color(0xFF6F4F37)
                                      ],
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                    ).createShader(Rect.fromLTWH(0.0, 0.0,
                                        200.0, 70.0)),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
