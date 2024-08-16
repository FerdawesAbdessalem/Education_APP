import 'package:flutter/material.dart';

class WelcomeEtudiantPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Top circular design
          Positioned(
            top: 0,
            left: -80,
            child: Container(
              width: 190,
              height: 190,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color:
                    Color(0xFF499DA2).withOpacity(0.5), // Couleur mise à jour
              ),
            ),
          ),
          Positioned(
            top: -70,
            left: 20,
            child: Container(
              width: 180,
              height: 180,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color:
                    Color(0xFF499DA2).withOpacity(0.5), // Couleur mise à jour
              ),
            ),
          ),
          // Main content
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Nouvelle image
                Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: const EdgeInsets.only(
                        right:
                            50.0), // Ajustez le padding pour déplacer l'image
                    child: Image.asset(
                      'assets/etu.png', // Remplacez par le chemin de votre nouvelle image
                      width: MediaQuery.of(context).size.width *
                          0.7, // Ajustez la largeur
                      height: MediaQuery.of(context).size.height *
                          0.3, // Ajustez la hauteur
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                // Texte de sous-titre
                Text(
                  'يهدف تطبيق "وردي" إلى مساعدة مشايخنا الكرام وطلابنا الأعزاء في متابعة الحفظ والمراجعة وتنظيم الإمتحانات.',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 20, 4, 81), // Couleur du texte
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 60),
                // Bouton : "التسجيل"
                Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context,
                          '/login_etudiant'); // Mise à jour de la route
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          Color(0xFF50B3B3), // Couleur de fond du bouton
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 15),
                    ),
                    child: Text(
                      'التسجيل',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                // Bouton : "إنشاء حساب"
                Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context,
                          '/create_etudiant'); // Mise à jour de la route
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          Color(0xFF50B3B3), // Couleur de fond du bouton
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 15),
                    ),
                    child: Text(
                      'إنشاء حساب',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
