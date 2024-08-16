import 'package:flutter/material.dart';

class ReviewDetailPage extends StatelessWidget {
  final Map<String, String> review;

  ReviewDetailPage({required this.review});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('تفاصيل المراجعة'),
        backgroundColor: Color(0xFF50B3B3), // Couleur personnalisée de l'AppBar
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start, // Aligner en haut
          crossAxisAlignment:
              CrossAxisAlignment.center, // Centrer horizontalement
          children: [
            Text(
              ' ${review['title']}',
              style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: const Color.fromARGB(255, 83, 94, 103)),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 30),
            _buildInfoRow(Icons.calendar_today, ' ${review['details']}'),
            SizedBox(height: 16),
            _buildInfoRow(Icons.book, 'مقدار المراجعة: ${review['progress']}'),
            SizedBox(height: 16),
            _buildInfoRow(
                Icons.date_range, 'آخر أجل للمراجعة: ${review['deadline']}'),
            SizedBox(height: 16),
            _buildInfoRow(
                Icons.person, 'الطلبة المعنيين: ${review['student']}'),
            SizedBox(height: 16),
            _buildInfoRow(
                Icons.supervisor_account, 'المشرف: ${review['responsible']}'),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String text) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Text(
            text,
            style: TextStyle(fontSize: 18),
            textAlign: TextAlign.right, // Align text to the right for Arabic
          ),
        ),
        SizedBox(width: 8), // Espacement entre le texte et l'icône
        Icon(icon, color: Color(0xFF50B3B3)), // Icône personnalisée
      ],
    );
  }
}
