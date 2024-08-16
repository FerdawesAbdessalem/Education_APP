import 'package:flutter/material.dart';
import 'review_form_page.dart'; // Ensure correct import path
import 'exam_form_page.dart'; // Ensure correct import path
import 'enregistrer.dart'; // Ensure correct import path
import 'package:flutter_application_4/menu.dart'; // Adjust the import path if needed
import 'package:flutter_application_4/EditStudentPage.dart';
import 'student_detail_page.dart'; // Import de la page de détails
import 'review_detail_page.dart';
import 'exam_detail_page.dart';
import 'menu.dart'; // Import the MenuPage
import 'save_form_page.dart';
import 'save_detail_page.dart';

class HomeJPage extends StatefulWidget {
  @override
  _HomeJPageState createState() => _HomeJPageState();
}

class _HomeJPageState extends State<HomeJPage> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    StudentsPage(),
    ReviewPage(),
    ExamsPage(),
    SPage(),
  ];

  Future<bool> _onWillPop() async {
    // Navigate to the homepage (or any specific page) when back button is pressed
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => HomeJPage()),
      (Route<dynamic> route) => false,
    );
    return Future.value(false); // Prevent the default back navigation
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        body: Stack(
          children: [
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
            _pages[_currentIndex],
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'الطلبة',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.book),
              label: 'المراجعة',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.bookmark),
              label: 'الامتحانات',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.save_as),
              label: 'الحفظ',
            ),
          ],
          backgroundColor:
              Colors.transparent, // Make the background transparent
          selectedItemColor:
              Color.fromARGB(255, 163, 157, 157), // Color of the selected item
          unselectedItemColor: const Color.fromARGB(
              255, 163, 157, 157), // Color of the unselected items
          type: BottomNavigationBarType
              .fixed, // Ensures that the items are displayed in a fixed layout
          elevation: 0, // Removes the shadow effect
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
  List<Map<String, String>> students = [
    {
      'name': 'فردوس عبد السلام',
      'email': 'ferdwesabd@gmail.com',
      'progress': '90%',
      'address': 'mahdia',
      'phone': '25289081',
      'group': 'مجموعة ربع يس',
      'image': 'assets/student1.jpg'
    },
    {
      'name': 'أنس العويان',
      'email': 'Ons.ayouan@gmail.com',
      'progress': '85%',
      'address': 'monastir',
      'phone': '99687687',
      'group': 'مجموعة البقرة',
      'image': 'assets/student2.jpg'
    },
    {
      'name': 'احمد',
      'email': 'ahmed@gmail.com',
      'progress': '85%',
      'address': 'monastir',
      'phone': '99687687',
      'group': 'مجموعة جزء عم',
      'image': 'assets/student3.jpg'
    },
    {
      'name': 'بلسم عبد السلام',
      'email': 'balcem.abd@gmail.com',
      'progress': '85%',
      'address': 'mahdia',
      'phone': '99687687',
      'group': 'مجموعة جزء عم',
      'image': 'assets/student4.jpg'
    },
    // Add more students here
  ];

  void _showOptions(BuildContext context, int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('اختيارات'),
          actions: <Widget>[
            TextButton(
              child: Text('تعديل'),
              onPressed: () {
                Navigator.of(context).pop();
                _navigateToFormPage(index);
              },
            ),
            TextButton(
              child: Text('حذف'),
              onPressed: () {
                Navigator.of(context).pop();
                setState(() {
                  students.removeAt(index);
                });
              },
            ),
          ],
        );
      },
    );
  }

  void _navigateToFormPage(int index) async {
    final updatedStudent = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EnregistrerPage(
          student: students[index], // Pass the existing student data
          onStudentAdded: (student) {
            setState(() {
              students[index] = student;
            });
          },
        ),
      ),
    );

    if (updatedStudent != null) {
      setState(() {
        students[index] = updatedStudent;
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
          // Main content
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: Icon(Icons.add, size: 30), // Plus icon
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EnregistrerPage(
                              onStudentAdded: (newStudent) {
                                if (newStudent != null) {
                                  setState(() {
                                    students.add(newStudent);
                                  });
                                }
                              },
                            ),
                          ),
                        );
                      },
                    ),
                    VerticalDivider(color: Colors.black, width: 1),
                    Row(
                      children: [
                        IconButton(
                          icon: Icon(Icons.search, size: 30),
                          onPressed: () {
                            // Implement search functionality here
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.menu, size: 30),
                          onPressed: () {
                            Navigator.pushNamed(
                                context, '/menu'); // Navigate to MenuPage
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              // Avatar Row
              Container(
                padding: const EdgeInsets.symmetric(
                    vertical: 8.0), // Add vertical padding
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: students.map((student) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 4.0), // Space between avatars
                      child: CircleAvatar(
                        backgroundImage: AssetImage(student['image']!),
                        radius: 30, // Adjust the radius as needed
                      ),
                    );
                  }).toList(),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: students.length,
                  itemBuilder: (context, index) {
                    final student = students[index];
                    return Card(
                      color: Colors.grey[100],
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundImage: AssetImage(student['image']!),
                        ),
                        title: Text(student['name']!),
                        subtitle: Text(' ${student['group']}'),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => StudentDetailPage(
                                student: student,
                              ),
                            ),
                          );
                        },
                        onLongPress: () {
                          _showOptions(context, index);
                        },
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

class ReviewPage extends StatefulWidget {
  @override
  _ReviewPageState createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {
  List<Map<String, String>> reviews = [
    {
      'title': 'الثمن الأخير من سورة البقرة',
      'details': '2023-07-01',
      'progress': '50%',
      'deadline': '2023-12-31',
      'student': 'فردوس عبد السلام ',
      'responsible': 'المعلمة اكرام'
    },
    {
      'title': 'يس و الصافات',
      'details': '2023-08-01',
      'progress': '30%',
      'deadline': '2024-01-31',
      'student': 'أنس العويان',
      'responsible': 'الشيخ احمد'
    },
    {
      'title': 'الزمر',
      'details': '2023-09-01',
      'progress': '75%',
      'deadline': '2024-06-30',
      'student': 'بلسم عبد السلام',
      'responsible': 'الشيخ احمد'
    },
  ];

  void _showOptions(BuildContext context, int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('اختيارات'),
          actions: <Widget>[
            TextButton(
              child: Text('تعديل'),
              onPressed: () {
                Navigator.of(context).pop();
                _navigateToFormPage(reviews[index]);
              },
            ),
            TextButton(
              child: Text('حذف'),
              onPressed: () {
                Navigator.of(context).pop();
                setState(() {
                  reviews.removeAt(index);
                });
              },
            ),
          ],
        );
      },
    );
  }

  void _navigateToFormPage(Map<String, String>? review) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ReviewFormPage(review: review),
      ),
    );

    if (result != null && result is Map<String, String>) {
      setState(() {
        if (review == null) {
          reviews.add(result);
        } else {
          final index = reviews.indexOf(review);
          if (index != -1) {
            reviews[index] = result;
          }
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: Icon(Icons.add, size: 30),
                      onPressed: () {
                        _navigateToFormPage(null);
                      },
                    ),
                    VerticalDivider(color: Colors.black, width: 1),
                    Row(
                      children: [
                        IconButton(
                          icon: Icon(Icons.search, size: 30),
                          onPressed: () {
                            // Implement search functionality here
                          },
                        ),
                        SizedBox(width: 2),
                        IconButton(
                          icon: Icon(Icons.menu, size: 30),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MenuPage(),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 80),
              Expanded(
                child: ListView.builder(
                  itemCount: reviews.length,
                  itemBuilder: (context, index) {
                    final review = reviews[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                ReviewDetailPage(review: review),
                          ),
                        );
                      },
                      onLongPress: () {
                        _showOptions(context, index);
                      },
                      child: Card(
                        color: Colors.grey[100],
                        margin:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                        child: ListTile(
                          title: Text(review['title']!,
                              textDirection: TextDirection.rtl),
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

class SPage extends StatefulWidget {
  @override
  _SPageState createState() => _SPageState();
}

class _SPageState extends State<SPage> {
  List<Map<String, String>> saveItems = [
    {
      'title': 'الثمن الأخير من سورة الزمر',
      'details': '2023-07-01',
      'status': 'قيد التنفيذ',
    },
    {
      'title': 'سورة النبأ',
      'details': '2023-08-01',
      'status': 'مكتمل',
    },
    {
      'title': 'من الاية 16 الى الاية 40 من سورة غافر',
      'details': '2023-09-01',
      'status': 'لم يبدأ',
    },
  ];

  void _showOptions(BuildContext context, int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('الخيارات'),
          actions: <Widget>[
            TextButton(
              child: Text('تفاصيل'),
              onPressed: () {
                Navigator.of(context).pop();
                final item = saveItems[index];
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SaveDetailPage(
                      title: item['title']!,
                      details: item['details']!,
                      student:
                          'Student Name', // Update these values as necessary
                      supervisor: 'Supervisor Name',
                      group: 'Group Name',
                      date: 'Date',
                      deadline: 'Deadline',
                    ),
                  ),
                );
              },
            ),
            TextButton(
              child: Text('تعديل'),
              onPressed: () {
                Navigator.of(context).pop();
                _editItem(index);
              },
            ),
            TextButton(
              child: Text('حذف'),
              onPressed: () {
                Navigator.of(context).pop();
                setState(() {
                  saveItems.removeAt(index);
                });
              },
            ),
          ],
        );
      },
    );
  }

  void _editItem(int index) {
    final item = saveItems[index];
    final TextEditingController titleController =
        TextEditingController(text: item['title']);
    final TextEditingController detailsController =
        TextEditingController(text: item['details']);
    final TextEditingController statusController =
        TextEditingController(text: item['status']);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('تعديل العنصر'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: InputDecoration(labelText: 'العنوان'),
              ),
              TextField(
                controller: detailsController,
                decoration: InputDecoration(labelText: 'التفاصيل'),
              ),
              TextField(
                controller: statusController,
                decoration: InputDecoration(labelText: 'الحالة'),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: Text('حفظ'),
              onPressed: () {
                Navigator.of(context).pop();
                setState(() {
                  saveItems[index] = {
                    'title': titleController.text,
                    'details': detailsController.text,
                    'status': statusController.text,
                  };
                });
              },
            ),
            TextButton(
              child: Text('إلغاء'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: Icon(Icons.add, size: 30),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SaveFormPage(),
                          ),
                        );
                      },
                    ),
                    VerticalDivider(color: Colors.black, width: 1),
                    Row(
                      children: [
                        IconButton(
                          icon: Icon(Icons.search, size: 30),
                          onPressed: () {
                            // Implement search functionality here
                          },
                        ),
                        SizedBox(width: 2),
                        IconButton(
                          icon: Icon(Icons.menu, size: 30),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MenuPage(),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 80),
              Expanded(
                child: ListView.builder(
                  itemCount: saveItems.length,
                  itemBuilder: (context, index) {
                    final item = saveItems[index];
                    return GestureDetector(
                      onLongPress: () {
                        _showOptions(context, index);
                      },
                      child: Card(
                        color: Colors.grey[100],
                        margin:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                        child: ListTile(
                          title: Text(item['title']!,
                              textDirection: TextDirection.rtl),
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

  void _addNewItem() {
    final TextEditingController titleController = TextEditingController();
    final TextEditingController detailsController = TextEditingController();
    final TextEditingController statusController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('إضافة عنصر جديد'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: InputDecoration(labelText: 'العنوان'),
              ),
              TextField(
                controller: detailsController,
                decoration: InputDecoration(labelText: 'التفاصيل'),
              ),
              TextField(
                controller: statusController,
                decoration: InputDecoration(labelText: 'الحالة'),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: Text('إضافة'),
              onPressed: () {
                Navigator.of(context).pop();
                setState(() {
                  saveItems.add({
                    'title': titleController.text,
                    'details': detailsController.text,
                    'status': statusController.text,
                  });
                });
              },
            ),
            TextButton(
              child: Text('إلغاء'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}

class ExamsPage extends StatefulWidget {
  @override
  _ExamsPageState createState() => _ExamsPageState();
}

class _ExamsPageState extends State<ExamsPage> {
  List<Map<String, String>> exams = [
    {
      'title': 'امتحان رقم 1',
    },
    {
      'title': 'امتحان رقم 2',
    },
    {
      'title': 'امتحان رقم 3',
    },
  ];

  void _showOptions(BuildContext context, int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('اختيارات'),
          actions: <Widget>[
            TextButton(
              child: Text('تعديل'),
              onPressed: () {
                Navigator.of(context).pop();
                _navigateToFormPage(exams[index]);
              },
            ),
            TextButton(
              child: Text('حذف'),
              onPressed: () {
                Navigator.of(context).pop();
                setState(() {
                  exams.removeAt(index);
                });
              },
            ),
          ],
        );
      },
    );
  }

  void _navigateToFormPage(Map<String, String>? exam) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ExamFormPage(),
      ),
    );

    if (result != null && result is Map<String, String>) {
      if (exam == null) {
        setState(() {
          exams.add(result);
        });
      } else {
        setState(() {
          final index = exams.indexOf(exam);
          if (index != -1) {
            exams[index] = result;
          }
        });
      }
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
          // Main content
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: Icon(Icons.add, size: 30), // Plus icon
                      onPressed: () {
                        _navigateToFormPage(null);
                      },
                    ),
                    VerticalDivider(color: Colors.black, width: 1),
                    Row(
                      children: [
                        IconButton(
                          icon: Icon(Icons.search, size: 30), // Search icon
                          onPressed: () {
                            // Implement search functionality
                          },
                        ),
                        SizedBox(width: 2),
                        IconButton(
                          icon: Icon(Icons.menu, size: 30), // Menu icon
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MenuPage(),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 80),
              Expanded(
                child: ListView.builder(
                  itemCount: exams.length,
                  itemBuilder: (context, index) {
                    final exam = exams[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ExamDetailPage(exam: exam),
                          ),
                        );
                      },
                      onLongPress: () {
                        _showOptions(context, index);
                      },
                      child: Card(
                        color: Colors.grey[100], // Set card background color
                        margin: EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 4), // Reduced vertical margin
                        child: ListTile(
                          title: Text(exam['title']!,
                              textDirection: TextDirection.rtl),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [],
                          ),
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
