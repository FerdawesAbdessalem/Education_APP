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

class StudentsPage extends StatefulWidget {
  @override
  _StudentsPageState createState() => _StudentsPageState();
}

class _StudentsPageState extends State<StudentsPage> {
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

  List<Map<String, dynamic>> filteredStudents = [];
  final TextEditingController _searchController = TextEditingController();
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    filteredStudents = students;
    _focusNode = FocusNode();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _filterStudents(String query) {
    setState(() {
      filteredStudents = students.where((student) {
        final nameLower = student['name'].toLowerCase();
        final queryLower = query.toLowerCase();
        return nameLower.contains(queryLower);
      }).toList();
    });
  }

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
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        spreadRadius: 2,
                        blurRadius: 8,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: TextField(
                    controller: _searchController,
                    focusNode: _focusNode,
                    onChanged: _filterStudents,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.search, color: Colors.grey),
                      suffixIcon: _searchController.text.isNotEmpty
                          ? IconButton(
                              icon: Icon(Icons.clear),
                              onPressed: () {
                                _searchController.clear();
                                _filterStudents('');
                              },
                            )
                          : null,
                      hintText: 'ابحث عن طالب...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    textInputAction: TextInputAction.search,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Text(
                  'عدد الطلاب: ${filteredStudents.length}',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: filteredStudents.length,
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
                                  backgroundImage: AssetImage(
                                      filteredStudents[index]['image']),
                                ),
                                SizedBox(width: 16),
                                Expanded(
                                  child: Text(
                                    filteredStudents[index]['name'],
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 8),
                            Text(
                                'المجموعات: ${filteredStudents[index]['groups'].join(', ')}'),
                            Text(
                                'المشرفين: ${filteredStudents[index]['responsibles'].join(', ')}'),
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

class ResponsiblePersonsPage extends StatefulWidget {
  @override
  _ResponsiblePersonsPageState createState() => _ResponsiblePersonsPageState();
}

class _ResponsiblePersonsPageState extends State<ResponsiblePersonsPage> {
  List<Map<String, dynamic>> responsibles = [
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

  List<Map<String, dynamic>> filteredResponsibles = [];

  @override
  void initState() {
    super.initState();
    filteredResponsibles = responsibles;
  }

  void _showSearchDialog() {
    showDialog(
      context: context,
      builder: (context) {
        final TextEditingController searchController = TextEditingController();
        return AlertDialog(
          title: Text('بحث'),
          content: TextField(
            controller: searchController,
            decoration: InputDecoration(hintText: 'أدخل اسم المشرف'),
            onChanged: (value) {
              setState(() {
                filteredResponsibles = responsibles
                    .where((responsible) => responsible['name'].contains(value))
                    .toList();
              });
            },
          ),
          actions: [
            TextButton(
              child: Text('إغلاق'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _navigateToAddResponsibleForm() async {
    final newResponsible = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddResponsibleFormPage(),
      ),
    );
    if (newResponsible != null) {
      setState(() {
        responsibles.add(newResponsible);
        filteredResponsibles = responsibles; // Reset filtered responsibles
      });
    }
  }

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
                padding: const EdgeInsets.only(top: 40.0, bottom: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: Icon(Icons.add),
                      onPressed: _navigateToAddResponsibleForm,
                    ),
                    IconButton(
                      icon: Icon(Icons.search),
                      onPressed: _showSearchDialog,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0, bottom: 10.0),
                child: Text(
                  'عدد المشرفين: ${filteredResponsibles.length}',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: filteredResponsibles.length,
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
                                  backgroundImage: AssetImage(
                                      filteredResponsibles[index]['image']),
                                ),
                                SizedBox(width: 16),
                                Text(
                                  filteredResponsibles[index]['name'],
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            SizedBox(height: 8),
                            Text(
                                'المجموعات: ${filteredResponsibles[index]['groups'].join(', ')}'),
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

class AddResponsibleFormPage extends StatefulWidget {
  @override
  _AddResponsibleFormPageState createState() => _AddResponsibleFormPageState();
}

class _AddResponsibleFormPageState extends State<AddResponsibleFormPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController groupsController = TextEditingController();

  List<String> availableGroups = [
    'مجموعة جزء عم',
    'مجموعة ربع يس',
    'مجموعة البقرة',
    // Add more groups here
  ];
  List<String> selectedGroups = [];

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
          // Form content
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(height: 190),
                  ],
                ),
                SizedBox(height: 20),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        TextField(
                          controller: nameController,
                          decoration: InputDecoration(labelText: 'اسم المشرف'),
                        ),
                        SizedBox(height: 20),
                        DropdownButtonFormField<String>(
                          value: selectedGroups.isNotEmpty
                              ? selectedGroups.first
                              : null,
                          items: availableGroups.map((group) {
                            return DropdownMenuItem<String>(
                              value: group,
                              child: Text(group),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              if (value != null &&
                                  !selectedGroups.contains(value)) {
                                selectedGroups.add(value);
                              }
                            });
                          },
                          decoration: InputDecoration(
                              labelText: 'المجموعات التي يشرف عليها'),
                        ),
                        SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () {
                            if (nameController.text.isNotEmpty &&
                                selectedGroups.isNotEmpty) {
                              final newResponsible = {
                                'name': nameController.text,
                                'image':
                                    'assets/default_responsible.jpg', // Use a default image
                                'groups': selectedGroups,
                              };
                              Navigator.pop(context, newResponsible);
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('يرجى ملء جميع الحقول')),
                              );
                            }
                          },
                          child: Text('حفظ'),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class GroupsPage extends StatefulWidget {
  @override
  _GroupsPageState createState() => _GroupsPageState();
}

class _GroupsPageState extends State<GroupsPage> {
  List<Map<String, dynamic>> groups = [
    {
      'name': 'ربع يس',
      'image': 'assets/group1.jpg',
      'students': ['فردوس عبد السلام'],
      'responsibles': ['المعلمة اكرام'],
    },
    {
      'name': 'البقرة',
      'image': 'assets/group2.jpg',
      'students': ['أنس العويان'],
      'responsibles': ['الشيخ احمد'],
    },
    {
      'name': 'جزء عم',
      'image': 'assets/group3.jpg',
      'students': ['بلسم عبد السلام', 'احمد'],
      'responsibles': ['الشيخ احمد'],
    },
    // Add more group details here
  ];

  List<Map<String, dynamic>> filteredGroups = [];

  @override
  void initState() {
    super.initState();
    filteredGroups = groups;
  }

  void _showSearchDialog() {
    showDialog(
      context: context,
      builder: (context) {
        final TextEditingController searchController = TextEditingController();
        return AlertDialog(
          title: Text('بحث'),
          content: TextField(
            controller: searchController,
            decoration: InputDecoration(hintText: 'أدخل اسم المجموعة'),
            onChanged: (value) {
              setState(() {
                filteredGroups = groups
                    .where((group) => group['name'].contains(value))
                    .toList();
              });
            },
          ),
          actions: [
            TextButton(
              child: Text('إغلاق'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _navigateToAddGroupForm() async {
    final newGroup = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddGroupPage()),
    );
    if (newGroup != null) {
      setState(() {
        groups.add(newGroup);
        filteredGroups = groups; // Reset filtered groups
      });
    }
  }

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
              // Top row with icons
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: Icon(Icons.add),
                      onPressed: _navigateToAddGroupForm,
                    ),
                    IconButton(
                      icon: Icon(Icons.search),
                      onPressed: _showSearchDialog,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                child: Text(
                  'عدد المجموعات: ${filteredGroups.length}',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: filteredGroups.length,
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
                                  backgroundImage: AssetImage(
                                      filteredGroups[index]['image']),
                                ),
                                SizedBox(width: 16),
                                Text(
                                  filteredGroups[index]['name'],
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            SizedBox(height: 8),
                            Text(
                                'الطلاب: ${filteredGroups[index]['students'].join(', ')}'),
                            Text(
                                'المسؤولون: ${filteredGroups[index]['responsibles'].join(', ')}'),
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

class AddGroupPage extends StatefulWidget {
  @override
  _AddGroupPageState createState() => _AddGroupPageState();
}

class _AddGroupPageState extends State<AddGroupPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController studentController = TextEditingController();

  String? selectedResponsible;
  List<String> availableResponsibles = [
    'المعلمة اكرام',
    'الشيخ احمد'
  ]; // Example responsible names
  List<String> availableStudents = [
    'فردوس عبد السلام',
    'أنس العويان',
    'بلسم عبد السلام',
    'احمد'
  ]; // Example students
  List<String> selectedStudents = [];

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
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 190), // Adds space at the top
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(labelText: 'اسم المجموعة'),
                ),
                SizedBox(height: 20),
                DropdownButtonFormField<String>(
                  value: selectedResponsible,
                  items: availableResponsibles.map((responsible) {
                    return DropdownMenuItem<String>(
                      value: responsible,
                      child: Text(responsible),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedResponsible = value;
                    });
                  },
                  decoration: InputDecoration(labelText: 'اسم المسؤول'),
                ),
                SizedBox(height: 20),
                DropdownButtonFormField<String>(
                  value: selectedStudents.isNotEmpty
                      ? selectedStudents.first
                      : null,
                  items: availableStudents.map((student) {
                    return DropdownMenuItem<String>(
                      value: student,
                      child: Text(student),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      if (value != null && !selectedStudents.contains(value)) {
                        selectedStudents.add(value);
                      }
                    });
                  },
                  decoration: InputDecoration(labelText: 'أسماء الطلاب'),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (nameController.text.isNotEmpty &&
                        selectedResponsible != null &&
                        selectedStudents.isNotEmpty) {
                      final newGroup = {
                        'name': nameController.text,
                        'image':
                            'assets/default_group.jpg', // Use a default image
                        'students': selectedStudents,
                        'responsibles': [selectedResponsible!],
                      };
                      Navigator.pop(context, newGroup);
                    } else {
                      // Handle empty field cases if needed
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('يرجى ملء جميع الحقول')),
                      );
                    }
                  },
                  child: Text('حفظ'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
