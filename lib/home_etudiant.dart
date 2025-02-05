import 'package:flutter/material.dart';
import 'p_etudiant.dart'; // Make sure to import the p_etudiant.dart file
import 'review_form_page.dart';

class HomeEtudiantPage extends StatefulWidget {
  @override
  _HomeEtudiantPageState createState() => _HomeEtudiantPageState();
}

class _HomeEtudiantPageState extends State<HomeEtudiantPage> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    SavePage(),
    ReviewPage(),
    ExamsPage(),
  ];

  Future<bool> _onWillPop() async {
    return Future.value(true);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        body: IndexedStack(
          index: _currentIndex,
          children: _pages,
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.save),
              label: 'الحفظ',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.rate_review),
              label: 'المراجعة',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.assignment),
              label: 'الامتحانات',
            ),
          ],
        ),
      ),
    );
  }
}

class SavePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(
        children: [
          // Background circles
          Positioned(
            top: 0,
            left: -80,
            child: Container(
              width: 190,
              height: 190,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFF499DA2).withOpacity(0.5),
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
                color: Color(0xFF499DA2).withOpacity(0.5),
              ),
            ),
          ),
          // Icon buttons
          Positioned(
            top: 16,
            left: 16,
            child: IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                // Add your search action here
              },
            ),
          ),
          Positioned(
            top: 16,
            right: 16,
            child: IconButton(
              icon: Icon(Icons.menu),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          PEtudiantPage()), // Navigate to PEtudiantPage
                );
              },
            ),
          ),
          // Main content
          Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 180),
                  // Adding multiple cards with styled buttons
                  for (var i = 0; i < 5; i++)
                    Card(
                      elevation: 8,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      color: Colors.grey[100],
                      child: Container(
                        width: screenWidth - 32, // Full width minus padding
                        height: 80, // Adjust height as needed
                        padding: EdgeInsets.all(12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                // Add your button action here
                              },
                              child: Text(
                                'ابدأ',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              style: ElevatedButton.styleFrom(
                                // Button color
                                backgroundColor: Color.fromARGB(
                                    255, 161, 172, 172), // Button color
                                elevation: 5,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 12),
                                side: BorderSide(
                                  color: Color.fromARGB(255, 161, 172, 172),
                                  width: 2,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ReviewPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(
        children: [
          // Background circles
          Positioned(
            top: 0,
            left: -80,
            child: Container(
              width: 190,
              height: 190,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFF499DA2).withOpacity(0.5),
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
                color: Color(0xFF499DA2).withOpacity(0.5),
              ),
            ),
          ),
          // Icon buttons
          Positioned(
            top: 16,
            left: 16,
            child: IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                // Add your search action here
              },
            ),
          ),
          Positioned(
            top: 16,
            right: 16,
            child: IconButton(
              icon: Icon(Icons.menu),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          PEtudiantPage()), // Navigate to PEtudiantPage
                );
              },
            ),
          ),
          // Main content
          Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 180),
                  // Adding multiple cards with styled buttons
                  for (var i = 0; i < 5; i++)
                    Card(
                      elevation: 8,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      color: Colors.grey[100],
                      child: Container(
                        width: screenWidth - 32, // Full width minus padding
                        height: 80, // Adjust height as needed
                        padding: EdgeInsets.all(12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                // Add your button action here
                              },
                              child: Text(
                                'ابدأ',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color.fromARGB(
                                    255, 161, 172, 172), // Button color

                                elevation: 5,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 12),
                                side: BorderSide(
                                  color: Color.fromARGB(255, 161, 172, 172),
                                  width: 2,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ExamsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(
        children: [
          // Background circles
          Positioned(
            top: 0,
            left: -80,
            child: Container(
              width: 190,
              height: 190,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFF499DA2).withOpacity(0.5),
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
                color: Color(0xFF499DA2).withOpacity(0.5),
              ),
            ),
          ),
          // Icon buttons
          Positioned(
            top: 16,
            left: 16,
            child: IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                // Add your search action here
              },
            ),
          ),
          Positioned(
            top: 16,
            right: 16,
            child: IconButton(
              icon: Icon(Icons.menu),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          PEtudiantPage()), // Navigate to p_etudiant.dart
                );
              },
            ),
          ),
          // Main content
          Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 180),
                  // Adding multiple empty cards with smaller height and full width
                  for (var i = 0; i < 5; i++)
                    Card(
                      elevation: 5,
                      color: Colors.grey[100],
                      child: Container(
                        width: screenWidth - 32, // Full width minus padding
                        height: 80, // Adjust height as needed
                        // Leave the container empty for now
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
