import 'package:flutter/material.dart';

class ExamDetailPage extends StatelessWidget {
  final Map<String, String> exam;

  ExamDetailPage({required this.exam});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('تفاصيل الامتحان'),
        backgroundColor: Color(0xFF50B3B3), // Couleur personnalisée de l'AppBar
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.center, // Centrer horizontalement
          children: [
            Text(
              ' ${exam['title']}',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 83, 94, 103), // Couleur du titre
              ),
              textAlign: TextAlign.center, // Centrer le titre
            ),
            SizedBox(height: 16),
            _buildInfoRow(Icons.calendar_today, 'التاريخ: ${exam['details']}'),
            SizedBox(height: 16),
            _buildInfoRow(Icons.attach_money, 'المقدار: ${exam['amount']}'),
            SizedBox(height: 16),
            _buildInfoRow(Icons.person,
                'الطلبة المعنيين: ${exam['student'] ?? 'غير محدد'}'),
            SizedBox(height: 16),
            _buildInfoRow(Icons.supervisor_account,
                ' المشرف: ${exam['responsible'] ?? 'غير محدد'}'),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String text) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center, // Centrer horizontalement
      children: [
        Expanded(
          child: Text(
            text,
            style: TextStyle(fontSize: 18),
            textAlign:
                TextAlign.right, // Aligner le texte à droite pour l'arabe
          ),
        ),
        SizedBox(width: 8), // Espacement entre le texte et l'icône
        Icon(icon, color: Color(0xFF50B3B3)), // Icône personnalisée
      ],
    );
  }
}
