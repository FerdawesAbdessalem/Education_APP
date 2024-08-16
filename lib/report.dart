import 'package:flutter/material.dart';

class ReportPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('الإبلاغ عن مشكلة'),
      ),
      body: Center(
        child: Text(
          'Report Page Content Here',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
