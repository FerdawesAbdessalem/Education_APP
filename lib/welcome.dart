import 'package:flutter/material.dart';

class WelcomePage extends StatelessWidget {
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
                Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: const EdgeInsets.only(
                        right: 50.0), // Adjust the padding to move the image
                    child: Image.asset(
                      'assets/association.jpg', // Add your image in the assets folder and update the path
                      width: MediaQuery.of(context).size.width *
                          0.7, // Adjust width
                      height: MediaQuery.of(context).size.height *
                          0.3, // Adjust height
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                // Subtitle text
                Text(
                  'يهدف تطبيق "وردي" إلى مساعدة مشايخنا الكرام وطلابنا الأعزاء في متابعة الحفظ والمراجعة وتنظيم الإمتحانات.',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 20, 4, 81),
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 60),
                // Button: "التسجيل"
                Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/login');
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
                // Button: "إنشاء حساب"
                Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/create');
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
