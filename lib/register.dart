import 'dart:convert'; // Pour encoder les données JSON
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http; // Pour effectuer des requêtes HTTP

class RegisterPage extends StatelessWidget {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  RegisterPage({super.key});

  // Méthode pour envoyer les données au backend
  Future<void> registerUser(BuildContext context) async {
    // Supprimer le focus des champs actifs
    FocusScope.of(context).unfocus();

    final String apiUrl = "http://localhost:8000/resellers"; // URL de l'API pour émulateur Android

    // Validation des mots de passe
    if (passwordController.text != confirmPasswordController.text) {
      showCustomSnackBar(context, "Les mots de passe ne correspondent pas.", false);
      return;
    }

    // Vérifier que les champs ne sont pas vides
    if (firstNameController.text.isEmpty ||
        lastNameController.text.isEmpty ||
        emailController.text.isEmpty ||
        passwordController.text.isEmpty) {
      showCustomSnackBar(context, "Veuillez remplir tous les champs.", false);
      return;
    }

    // Vérification du format de l'email
    if (!isValidEmail(emailController.text)) {
      showCustomSnackBar(context, "Veuillez entrer un email valide.", false);
      return;
    }

    // Préparer les données pour l'API
    Map<String, dynamic> userData = {
      "name": firstNameController.text,
      "surname": lastNameController.text,
      "email": emailController.text,
      "password": passwordController.text,
    };

    // Afficher un indicateur de chargement
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Center(child: CircularProgressIndicator());
      },
    );

    try {
      // Envoyer une requête POST
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {"Content-Type": "application/json"},
        body: json.encode(userData),
      );

      // Fermer l'indicateur de chargement
      Navigator.pop(context);

      if (response.statusCode == 201) {
        // Succès : utilisateur enregistré
        showCustomSnackBar(context, "Inscription réussie !", true);
        Navigator.pushReplacementNamed(context, '/login'); // Redirige vers la page de connexion
      } else if (response.statusCode == 400) {
        // Email déjà utilisé
        final Map<String, dynamic> errorResponse = json.decode(response.body);
        showCustomSnackBar(context, "Erreur : ${errorResponse['detail'] ?? 'Email déjà utilisé.'}", false);
      } else {
        // Erreur générique retournée par le backend
        final Map<String, dynamic> errorResponse = json.decode(response.body);
        showCustomSnackBar(context, "Erreur : ${errorResponse['detail'] ?? 'Une erreur est survenue.'}", false);
      }
    } catch (e) {
      // Gérer les erreurs réseau
      Navigator.pop(context); // Fermer l'indicateur de chargement
      showCustomSnackBar(context, "Impossible de se connecter au serveur.", false);
      print(e);
    }
  }

  // Méthode pour valider les emails
  bool isValidEmail(String email) {
    final RegExp regex = RegExp(r"^[a-zA-Z0-9._%-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$");
    return regex.hasMatch(email);
  }

  // Méthode pour afficher des messages utilisateur personnalisés
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
        onTap: () {
          // Retire le focus lorsqu'on clique en dehors des champs
          FocusScope.of(context).unfocus();
        },
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFF6F4F37), // Café moka (brun chaud)
                Color(0xFF3E2723), // Café expresso (brun très foncé)
                Color(0xFF9E7C4F), // Latte (brun clair)
                Color(0xFFCBB89C), // Crème de café (beige clair)
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: SingleChildScrollView( // Ajoute un scroll si nécessaire
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Créer un nouveau compte',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 20),

                    // Champs de formulaire
                    buildTextField("Prénom", firstNameController, Icons.person),
                    SizedBox(height: 16),
                    buildTextField("Nom", lastNameController, Icons.person),
                    SizedBox(height: 16),
                    buildTextField("Email", emailController, Icons.email),
                    SizedBox(height: 16),
                    buildTextField("Mot de passe", passwordController, Icons.lock,
                        obscureText: true),
                    SizedBox(height: 16),
                    buildTextField("Confirmer le mot de passe",
                        confirmPasswordController, Icons.lock,
                        obscureText: true),
                    SizedBox(height: 22),

                    // Bouton pour s'inscrire
                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                          registerUser(context); // Appel de la méthode d'inscription
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFFE57734),
                          padding: EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Text(
                          'Créer',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
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

  // Widget pour créer un champ de texte réutilisable
  Widget buildTextField(String hintText, TextEditingController controller,
      IconData icon, {bool obscureText = false}) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      autofocus: false,
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.white60),
        filled: true,
        fillColor: Color(0xFF212325),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
        prefixIcon: Icon(
          icon,
          color: Colors.white60,
        ),
      ),
    );
  }
}
