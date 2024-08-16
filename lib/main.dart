import 'package:flutter/material.dart';
import 'login.dart';
import 'create.dart';
import 'home_j.dart';
import 'home_page.dart';
import 'profil.dart';
import 'settings.dart';
import 'help.dart';
import 'report.dart';
import 'home_j.dart'; // Import StudentsPage
import 'menu.dart'; // Import MenuPage
import 'create_etudiant.dart';
import 'login_etudiant.dart';
import 'home_etudiant.dart';
import 'PEtudiant.dart';
import 'Notification.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(), // Use HomePage as the home page
      routes: {
        '/login': (context) => LoginPage(),
        '/create': (context) => CreatePage(),
        '/home_j': (context) => HomeJPage(),
        '/profile': (context) => ProfilPage(),
        '/settings': (context) => SettingsPage(),
        '/help': (context) => HelpPage(),
        '/report': (context) => ReportPage(),
        '/students': (context) => HomeJPage(), // Add route for StudentsPage
        '/menu': (context) => MenuPage(), // Add route for MenuPage
        '/login_etudiant': (context) => LoginEtudiantPage(),
        '/create_etudiant': (context) => CreateEtudiantPage(),
        '/home_etudiant': (context) => HomeEtudiantPage(),
        '/petudiant': (context) => PEtudiant(),
        '/notification': (context) => NotificationPage(),
      },
    );
  }
}
