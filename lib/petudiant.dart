import 'package:flutter/material.dart';

class PEtudiant extends StatefulWidget {
  @override
  _PEtudiantState createState() => _PEtudiantState();
}

class _PEtudiantState extends State<PEtudiant> {
  String _studentName = 'اسم الطالب'; // Replace with actual student name
  String _location = 'سوسة سهلول4000'; // Replace with actual location
  String _email = 'student@example.com'; // Replace with actual email

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
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Cover photo
              Container(
                height: 200,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/cover_photo.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(height: 10),
              // Profile picture and student's name
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 60,
                    backgroundImage: AssetImage('assets/student1.jpg'),
                  ),
                  SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _studentName,
                        style: TextStyle(
                            fontSize: 28, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 5),
                      Text(
                        _location,
                        style: TextStyle(fontSize: 16),
                      ),
                      Text(
                        _email,
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 20),
              // Personal information buttons
              Expanded(
                child: ListView(
                  children: [
                    _buildButton(context, ' تفاصيل أخرى', () {
                      // Navigate to other details page
                    }),
                    _buildButton(context, ' تعديل البيانات', () {
                      // Navigate to edit student details page
                    }),
                    _buildButton(context, ' حذف الحساب', () {
                      // Functionality to delete the account
                    }),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildButton(
      BuildContext context, String title, VoidCallback onPressed) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text(title, style: TextStyle(fontSize: 18)),
        style: ElevatedButton.styleFrom(
          minimumSize: Size(double.infinity, 50),
          backgroundColor: Colors.grey[100], // Set button color here
        ),
      ),
    );
  }
}
