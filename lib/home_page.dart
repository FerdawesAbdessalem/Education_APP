import 'package:flutter/material.dart';
import 'welcome.dart'; // Importez WelcomePage ici
import 'choice.dart';

class HomePage extends StatelessWidget {
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
                color: Color(0xFF499DA2).withOpacity(0.5), // Updated color
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
                color: Color(0xFF499DA2).withOpacity(0.5), // Updated color
              ),
            ),
          ),
          // Main content
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Logo
                Image.asset(
                  'assets/logo.jpg', // Add your logo image in the assets folder and update the path
                  width: MediaQuery.of(context).size.width *
                      0.8, // Set the logo to take 80% of the screen width
                ),
                SizedBox(height: 0),
                // Subtitle text
                Text(
                  'تَعلِيم و تَعزِيز فَهم أَعمَق لِلقُرآن الكَرِيم',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 20, 4, 81),
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                    height: 70), // Increased height to move the button lower
                // Button
                Container(
                  width: MediaQuery.of(context).size.width *
                      0.8, // Set the button to take 80% of the screen width
                  child: ElevatedButton(
                    onPressed: () {
                      // Navigate to WelcomePage when button is pressed
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ChoicePage()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          Color(0xFF50B3B3), // Button background color
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 15),
                    ),
                    child: Text(
                      'ابدأ الآن',
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
