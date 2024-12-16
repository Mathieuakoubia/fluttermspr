import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mspr_repo_new/register.dart'; // Page d'inscription
import 'package:mspr_repo_new/login.dart'; // Page de connexion
import 'package:mspr_repo_new/ProductListPage.dart'; // Page de produits

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        padding: EdgeInsets.only(top: 30, bottom: 40),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF8B4513), // Marron clair
              Color(0xFF6F4E37), // Marron café
              Color(0xFF4B2E2A), // Marron foncé
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Boutons en haut à droite
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.only(right: 20),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterPage()));
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFFE57734),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                      child: Text(
                        "S'inscrire",
                        style: TextStyle(color: Colors.white, fontSize: 14),
                      ),
                    ),
                    SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey[700],
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                      child: Text(
                        "Se connecter",
                        style: TextStyle(color: Colors.white, fontSize: 14),
                      ),
                    ),
                    SizedBox(width: 10),
                    // Bouton Produits
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => ProductListPage()));
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green[700],
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                      child: Text(
                        "Produits",
                        style: TextStyle(color: Colors.white, fontSize: 14),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Titre principal
            Padding(
              padding: const EdgeInsets.only(top: 20), // Ajuste la position verticale du titre
              child: Text(
                "Paye ton kawa",
                style: GoogleFonts.pacifico(fontSize: 60, color: Colors.white),
                textAlign: TextAlign.center,
              ),
            ),

            // Image centrale
            Expanded(
              child: Center(
                child: Image.asset(
                  'images/bg.jpg', // Assurez-vous que cette image est bien ajoutée au dossier `images` et déclarée dans pubspec.yaml
                  fit: BoxFit.contain,
                  width: 300,
                  height: 300,
                  opacity: AlwaysStoppedAnimation(0.9), // Ajuste la transparence
                ),
              ),
            ),

            // Slogan
            Text(
              "Le café c'est la vie",
              style: TextStyle(
                color: Colors.white.withOpacity(0.8),
                fontSize: 18,
                fontWeight: FontWeight.w500,
                letterSpacing: 1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
