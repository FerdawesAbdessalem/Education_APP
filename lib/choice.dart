import 'package:flutter/material.dart';
import 'welcome.dart'; // Importer la page WelcomePage
import 'welcome_etudiant.dart'; // Importer la page WelcomeEtudiantPage

class ChoicePage extends StatelessWidget {
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
          // Main content with horizontal buttons and images
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // First column (image + button)
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // First image (enlarged)
                      Image.asset(
                        'assets/association.jpg', // Replace with your image path
                        height: 180, // Increased height of the image
                      ),
                      SizedBox(height: 10), // Space between image and button
                      // First rectangle (wider button)
                      Container(
                        width: 160, // Increased width of the button
                        height: 60, // Increased height of the rectangle
                        margin: EdgeInsets.all(10), // Margin around the button
                        child: ElevatedButton(
                          onPressed: () {
                            // Navigate to WelcomePage
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => WelcomePage()),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                Color(0xFF50B3B3), // Button background color
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  15.0), // Rounded corners
                            ),
                          ),
                          child: Text(
                            'جمعية',
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
                // Second column (image + button)
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Second image (enlarged)
                      Image.asset(
                        'assets/etu.png', // Replace with your image path
                        height: 180, // Increased height of the image
                      ),
                      SizedBox(height: 10), // Space between image and button
                      // Second rectangle (wider button)
                      Container(
                        width: 160, // Increased width of the button
                        height: 60, // Increased height of the rectangle
                        margin: EdgeInsets.all(10), // Margin around the button
                        child: ElevatedButton(
                          onPressed: () {
                            // Navigate to WelcomeEtudiantPage
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => WelcomeEtudiantPage()),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                Color(0xFF50B3B3), // Button background color
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  15.0), // Rounded corners
                            ),
                          ),
                          child: Text(
                            'طالب',
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
          ),
          // Additional content at the bottom
          Positioned(
            bottom: 20, // Positioning at the bottom
            left: 0,
            right: 0,
            child: Column(
              children: [
                Divider(
                  color: Colors.grey, // Color of the line
                  thickness: 2, // Thickness of the line
                  indent: 40, // Space before the line starts
                  endIndent: 40, // Space before the line ends
                ),
                SizedBox(height: 10), // Space between line and text
                Text(
                  "يرجى اختيار خيار للمتابعة",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[700],
                  ),
                  textAlign: TextAlign.center, // Center the text
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
