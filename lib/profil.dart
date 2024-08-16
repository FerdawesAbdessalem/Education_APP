import 'package:flutter/material.dart';
import 'edit_profile_page.dart'; // Import the EditProfilePage

class ProfilPage extends StatefulWidget {
  @override
  _ProfilPageState createState() => _ProfilPageState();
}

class _ProfilPageState extends State<ProfilPage> {
  String _associationName = 'نور طيبة'; // Initial value
  String _location = 'سوسة سهلول4000'; // Initial value
  String _email = ' nourtayba@gmail.com'; // Initial value

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
              // Profile picture and association's name
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 60,
                    backgroundImage: AssetImage('assets/nour.jpg'),
                  ),
                  SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            _associationName,
                            style: TextStyle(
                                fontSize: 28, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(width: 8),
                          GestureDetector(
                            onTap: () async {
                              final updatedData = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => EditProfilePage()),
                              );
                              if (updatedData != null) {
                                setState(() {
                                  _associationName =
                                      updatedData['associationName'] ??
                                          _associationName;
                                  _location =
                                      updatedData['location'] ?? _location;
                                  _email = updatedData['email'] ?? _email;
                                });
                              }
                            },
                            child: Icon(
                              Icons.edit,
                              color: Colors.black,
                              size: 28,
                            ),
                          ),
                        ],
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
                    _buildButton(context, ' الطلاب', () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => StudentsPage()),
                      );
                    }),
                    _buildButton(context, ' المشرفين', () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ResponsiblePersonsPage()),
                      );
                    }),
                    _buildButton(context, ' المجموعات', () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => GroupsPage()),
                      );
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

class StudentsPage extends StatelessWidget {
  final List<Map<String, dynamic>> students = [
    {
      'name': 'فردوس عبد السلام',
      'image': 'assets/student1.jpg',
      'groups': ['مجموعة ربع يس'],
      'responsibles': ['المعلمة اكرام']
    },
    {
      'name': 'أنس العويان',
      'image': 'assets/student2.jpg',
      'groups': ['مجموعة البقرة'],
      'responsibles': ['الشيخ احمد']
    },
    {
      'name': 'احمد',
      'image': 'assets/student2.jpg',
      'groups': ['مجموعة جزء عم'],
      'responsibles': ['الشيخ اسامة']
    },
    {
      'name': 'بلسم عبد السلام',
      'image': 'assets/student2.jpg',
      'groups': ['مجموعة جزء عم'],
      'responsibles': ['الشيخ اسامة']
    },
    // Add more student details here
  ];

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
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 150.0, bottom: 10.0),
                child: Text(
                  'عدد الطلاب: ${students.length}',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: students.length,
                  itemBuilder: (context, index) {
                    return Card(
                      margin: EdgeInsets.symmetric(vertical: 4, horizontal: 16),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                CircleAvatar(
                                  backgroundImage:
                                      AssetImage(students[index]['image']),
                                ),
                                SizedBox(width: 16),
                                Text(
                                  students[index]['name'],
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            SizedBox(height: 2),
                            Text(
                                'المجموعات: ${students[index]['groups'].join(', ')}'),
                            Text(
                                'المشرفين: ${students[index]['responsibles'].join(', ')}'),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ResponsiblePersonsPage extends StatelessWidget {
  final List<Map<String, dynamic>> responsibles = [
    {
      'name': 'الشيخ احمد',
      'image': 'assets/responsible1.jpg',
      'groups': ['مجموعة جزء عم'],
    },
    {
      'name': 'المعلمة اكرام',
      'image': 'assets/responsible2.jpg',
      'groups': ['مجموعة ربع يس'],
    },
    {
      'name': 'الشيخ احمد',
      'image': 'assets/responsible2.jpg',
      'groups': ['مجموعة البقرة'],
    },

    // Add more responsible person details here
  ];

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
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 150.0, bottom: 10.0),
                child: Text(
                  'عدد المشرفين: ${responsibles.length}',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: responsibles.length,
                  itemBuilder: (context, index) {
                    return Card(
                      margin: EdgeInsets.symmetric(vertical: 4, horizontal: 16),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                CircleAvatar(
                                  backgroundImage:
                                      AssetImage(responsibles[index]['image']),
                                ),
                                SizedBox(width: 16),
                                Text(
                                  responsibles[index]['name'],
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            SizedBox(height: 8),
                            Text(
                                'المجموعات: ${responsibles[index]['groups'].join(', ')}'),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class GroupsPage extends StatelessWidget {
  final List<Map<String, dynamic>> groups = [
    {
      'name': 'ربع يس',
      'image': 'assets/group1.jpg',
      'students': ['فردوس عبد السلام'],
      'responsibles': ['المعلمة اكرام'],
    },
    {
      'name': ' البقرة',
      'image': 'assets/group2.jpg',
      'students': ['أنس العويان'],
      'responsibles': ['الشيخ احمد'],
    },
    {
      'name': ' جزء عم',
      'image': 'assets/group3.jpg',
      'students': ['بلسم عبد السلام', 'احمد'],
      'responsibles': ['الشيخ احمد'],
    },
    // Add more group details here
  ];

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
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 150.0, bottom: 10.0),
                child: Text(
                  'عدد المجموعات: ${groups.length}',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: groups.length,
                  itemBuilder: (context, index) {
                    return Card(
                      margin: EdgeInsets.symmetric(vertical: 4, horizontal: 16),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                CircleAvatar(
                                  backgroundImage:
                                      AssetImage(groups[index]['image']),
                                ),
                                SizedBox(width: 16),
                                Text(
                                  groups[index]['name'],
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            SizedBox(height: 8),
                            Text(
                                'الطلاب: ${groups[index]['students'].join(', ')}'),
                            Text(
                                'المسؤولون: ${groups[index]['responsibles'].join(', ')}'),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
