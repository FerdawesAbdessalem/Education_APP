import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _notificationsEnabled = true;
  String _selectedLanguage = 'Français';
  bool _darkModeEnabled = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Top circular design
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
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title and AppBar adjustment

                  SizedBox(height: 170),

                  Expanded(
                    child: ListView(
                      padding: const EdgeInsets.all(0),
                      children: [
                        // Language Setting
                        ListTile(
                          title: Text('لغة التطبيق'),
                          subtitle: Text(_selectedLanguage),
                          trailing: Icon(Icons.language),
                          onTap: () {
                            _selectLanguage();
                          },
                        ),
                        Divider(),

                        // Notifications Setting
                        SwitchListTile(
                          title: Text('الإشعارات'),
                          value: _notificationsEnabled,
                          onChanged: (bool value) {
                            setState(() {
                              _notificationsEnabled = value;
                            });
                          },
                        ),
                        Divider(),

                        // Theme Setting
                        ListTile(
                          title: Text('ثيم التطبيق'),
                          subtitle: Text(_darkModeEnabled ? 'داكن' : 'فاتح'),
                          trailing: Switch(
                            value: _darkModeEnabled,
                            onChanged: (bool value) {
                              setState(() {
                                _darkModeEnabled = value;
                              });
                            },
                          ),
                          onTap: () {
                            setState(() {
                              _darkModeEnabled = !_darkModeEnabled;
                            });
                          },
                        ),
                        Divider(),

                        // Account Management
                        ListTile(
                          title: Text('إدارة الحساب'),
                          trailing: Icon(Icons.account_circle),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      AccountManagementPage()),
                            );
                          },
                        ),
                        Divider(),

                        // About
                        ListTile(
                          title: Text('حول'),
                          trailing: Icon(Icons.info),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AboutPage()),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _selectLanguage() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('اختر اللغة'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: Text('فرنسي'),
                onTap: () {
                  setState(() {
                    _selectedLanguage = 'فرنسي';
                  });
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                title: Text('عربي'),
                onTap: () {
                  setState(() {
                    _selectedLanguage = 'عربي';
                  });
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }
}

class AccountManagementPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('إدارة الحساب'),
      ),
      body: Center(
        child: Text(
          'صفحة إدارة الحساب',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('حول'),
      ),
      body: Center(
        child: Text(
          'معلومات عن التطبيق',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
