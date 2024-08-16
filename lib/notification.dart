import 'package:flutter/material.dart';

class NotificationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('الاشعارات'),
      ),
      body: Center(
        child: Text(
          'Bienvenue à la page des notifications',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
