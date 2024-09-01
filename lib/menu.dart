import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Import this for SystemNavigator

class MenuPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Decorative circles
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
          // Main content
          Positioned(
            top:
                160, // Adjust this value to position the content below the circles
            left: 0,
            right: 0,
            bottom: 0,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: GridView.count(
                crossAxisCount: 2, // Number of items per row
                crossAxisSpacing: 10, // Spacing between columns
                mainAxisSpacing: 10, // Spacing between rows
                children: [
                  _buildMenuTile(
                    context,
                    Icons.home,
                    'الرئيسية',
                    '/home_j', // Navigate to home_j.dart
                  ),
                  _buildMenuTile(
                    context,
                    Icons.person,
                    'الملف الشخصي',
                    '/profile', // Navigate to profil.dart
                  ),
                  _buildMenuTile(
                    context,
                    Icons.settings,
                    'الإعدادات',
                    '/settings', // Navigate to settings page // Navigate to settings page
                  ),
                  _buildMenuTile(
                    context,
                    Icons.notifications,
                    'الاشعارات',
                    '/notification',
                  ),
                  _buildMenuTile(
                    context,
                    Icons.report,
                    'الإبلاغ عن مشكلة',
                    '/report', // Navigate to report page
                  ),
                  _buildMenuTile(
                    context,
                    Icons.logout,
                    'تسجيل خروج',
                    '/logout', // Handle logout action
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuTile(
      BuildContext context, IconData icon, String title, String route) {
    return GestureDetector(
      onTap: () {
        if (route == '/logout') {
          // Navigate to home_j.dart and exit the app
          Navigator.pushNamedAndRemoveUntil(
              context, '/home_j', (route) => false);
          SystemNavigator.pop(); // Exit the app
        } else {
          Navigator.pushNamed(context, route);
        }
      },
      child: Card(
        color: Colors.grey[100], // Set background color here
        elevation: 5,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40, color: Colors.black),
            SizedBox(height: 10),
            Text(title,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, color: Colors.black)),
          ],
        ),
      ),
    );
  }
}
