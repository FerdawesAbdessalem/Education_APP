import 'package:flutter/material.dart';

class HelpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('مساعدة'),
      ),
      body: Center(
        child: Text(
          'Help Page Content Here',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
