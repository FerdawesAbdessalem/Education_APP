import 'package:flutter/material.dart';

class StudentDetailPage extends StatelessWidget {
  final Map<String, String> student;

  StudentDetailPage({required this.student});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(student['name']!),
        backgroundColor: Color(0xFF50B3B3), // Couleur personnalisée de l'AppBar
      ),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start, // Aligner en haut
          crossAxisAlignment:
              CrossAxisAlignment.center, // Centrer horizontalement
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage(student['image']!),
            ),
            SizedBox(height: 32), // Augmenter l'espacement après l'avatar
            _buildInfoRow(Icons.person, ' ${student['name']}'),
            SizedBox(height: 16),
            _buildInfoRow(Icons.email, ' ${student['email']}'),
            SizedBox(height: 16),
            _buildInfoRow(Icons.home, ' ${student['address']}'),
            SizedBox(height: 16),
            _buildInfoRow(Icons.phone, ' ${student['phone']}'),
            SizedBox(height: 16),
            _buildInfoRow(Icons.book, 'مقدار الحفظ: ${student['progress']}'),
            SizedBox(height: 16),
            _buildInfoRow(Icons.group, ' ${student['group']}'),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String text) {
    return Row(
      children: [
        Expanded(
          child: Text(
            text,
            textAlign: TextAlign.end, // Alignement du texte à droite
            style: TextStyle(fontSize: 18),
          ),
        ),
        SizedBox(width: 18), // Espacement entre le texte et l'icône
        Icon(icon, color: Color(0xFF50B3B3)), // Icône personnalisée
      ],
    );
  }
}
