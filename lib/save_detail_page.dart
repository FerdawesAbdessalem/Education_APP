import 'package:flutter/material.dart';

class SaveDetailPage extends StatelessWidget {
  final String title;
  final String details;
  final String student;
  final String supervisor;
  final String group;
  final String date;
  final String deadline;

  SaveDetailPage({
    required this.title,
    required this.details,
    required this.student,
    required this.supervisor,
    required this.group,
    required this.date,
    required this.deadline,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('تفاصيل البرنامج'),
        backgroundColor: Color(0xFF50B3B3),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('عنوان: $title', style: TextStyle(fontSize: 18)),
            SizedBox(height: 8),
            Text('تفاصيل: $details', style: TextStyle(fontSize: 16)),
            SizedBox(height: 8),
            Text('الطلبة: $student', style: TextStyle(fontSize: 16)),
            SizedBox(height: 8),
            Text('المشرف: $supervisor', style: TextStyle(fontSize: 16)),
            SizedBox(height: 8),
            Text('المجموعة: $group', style: TextStyle(fontSize: 16)),
            SizedBox(height: 8),
            Text('تاريخ: $date', style: TextStyle(fontSize: 16)),
            SizedBox(height: 8),
            Text('ال deadline: $deadline', style: TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
