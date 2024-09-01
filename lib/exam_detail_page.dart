import 'package:flutter/material.dart';

class ExamDetailPage extends StatelessWidget {
  final Map<String, String> exam;

  ExamDetailPage({required this.exam});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background circles
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
              crossAxisAlignment:
                  CrossAxisAlignment.stretch, // Stretch the Column
              children: [
                SizedBox(height: 180),
                // Title with icon and background color
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.grey[100], // Background color
                      borderRadius: BorderRadius.circular(8), // Rounded corners
                    ),
                    width: double.infinity, // Full width
                    child: Row(
                      mainAxisAlignment:
                          MainAxisAlignment.center, // Center the icon and text
                      children: [
                        Icon(Icons.save,
                            color: Color.fromARGB(255, 83, 94, 103)), // Icon
                        SizedBox(width: 8), // Space between the icon and text
                        Expanded(
                          child: Text(
                            exam['title'] ?? 'بدون عنوان',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(
                                  255, 83, 94, 103), // Title color
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 16),
                _buildInfoRow(
                    Icons.calendar_today, 'التاريخ: ${exam['details']}'),
                SizedBox(height: 16),
                _buildInfoRow(Icons.attach_money, 'المقدار: ${exam['amount']}'),
                SizedBox(height: 16),
                _buildInfoRow(Icons.person,
                    'الطلاب المعنيين: ${exam['student'] ?? 'غير محدد'}'),
                SizedBox(height: 16),
                _buildInfoRow(Icons.supervisor_account,
                    'المشرف: ${exam['responsible'] ?? 'غير محدد'}'),
                SizedBox(
                    height: 16), // Space between the last field and the button
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ScoreEntryPage(
                            exam: exam), // Navigate to ScoreEntryPage
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF50B3B3), // Button color
                    padding:
                        EdgeInsets.symmetric(vertical: 16), // Vertical padding
                    textStyle: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold), // Button text style
                  ),
                  child: Text(
                    'إدخال الدرجات',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ), // Button text
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String text) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start, // Align the text to the start
      children: [
        Icon(icon, color: Color(0xFF50B3B3)), // Custom icon color
        SizedBox(width: 8), // Spacing between the icon and text
        Expanded(
          child: Text(
            text,
            style: TextStyle(fontSize: 18),
            textAlign: TextAlign.right, // Right-align the text for Arabic
          ),
        ),
      ],
    );
  }
}

class ScoreEntryPage extends StatefulWidget {
  final Map<String, String> exam;

  ScoreEntryPage({required this.exam});

  @override
  _ScoreEntryPageState createState() => _ScoreEntryPageState();
}

class _ScoreEntryPageState extends State<ScoreEntryPage> {
  final List<Student> _students = [
    // Sample student data with photos
    Student(name: 'الطالب 1', photoUrl: 'https://via.placeholder.com/150'),
    Student(name: 'الطالب 2', photoUrl: 'https://via.placeholder.com/150'),
    Student(name: 'الطالب 3', photoUrl: 'https://via.placeholder.com/150'),
  ];

  List<Student> _filteredStudents = [];

  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _filteredStudents = _students;
    _searchController.addListener(() {
      _filterStudents();
    });
  }

  void _filterStudents() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredStudents = _students
          .where((student) => student.name.toLowerCase().contains(query))
          .toList();
    });
  }

  void _saveScores() {
    // Implement save functionality here
    print('الدرجات تم حفظها!');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background circles
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
              children: [
                SizedBox(height: 120),
                TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    labelText: 'بحث عن طالب',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.search),
                  ),
                ),
                SizedBox(height: 10),
                Expanded(
                  child: ListView.builder(
                    itemCount: _filteredStudents.length,
                    itemBuilder: (context, index) {
                      final student = _filteredStudents[index];
                      return _buildStudentRow(student);
                    },
                  ),
                ),
                SizedBox(height: 16),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: SizedBox(
                    width: double
                        .infinity, // Makes the button span the width of the screen
                    child: ElevatedButton(
                      onPressed: _saveScores,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF50B3B3), // Button color
                        padding: EdgeInsets.symmetric(
                            vertical: 16), // Vertical padding
                        textStyle: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold), // Button text style
                      ),
                      child: Text(
                        'حفظ',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ), // Save button text
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

  Widget _buildStudentRow(Student student) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8),
      color: Colors.grey[100], // Card color
      child: ListTile(
        contentPadding: EdgeInsets.all(16),
        leading: CircleAvatar(
          backgroundImage:
              NetworkImage(student.photoUrl), // Display student photo
        ),
        title: Text(student.name),
        subtitle: Row(
          children: [
            Checkbox(
              value: student.isAbsent,
              onChanged: (value) {
                setState(() {
                  student.isAbsent = value ?? false;
                });
              },
            ),
            Text('غائب'), // Absent text
            SizedBox(width: 16),
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  labelText: 'الدرجة',
                  border: OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(10.0), // Rounded corners
                  ),
                ),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  student.score = value;
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Student {
  final String name;
  final String photoUrl; // URL for student photo
  String? score;
  bool isAbsent;

  Student({
    required this.name,
    required this.photoUrl, // Require photo URL
    this.score,
    this.isAbsent = false,
  });
}
