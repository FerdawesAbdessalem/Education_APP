import 'package:flutter/material.dart';

class ReviewFormPage extends StatefulWidget {
  final Map<String, String>? review;

  ReviewFormPage({this.review});

  @override
  _ReviewFormPageState createState() => _ReviewFormPageState();
}

class _ReviewFormPageState extends State<ReviewFormPage> {
  DateTime _selectedDate = DateTime.now();
  DateTime _selectedDeadline = DateTime.now();
  String? _selectedStudent;
  String? _selectedResponsible;
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _progressController = TextEditingController();
  List<String> students = [
    'فردوس عبد السلام',
    'أنس العويان',
    'بلسم عبد السلام',
    'احمد'
  ];
  List<String> responsibles = ['الشيخ احمد', 'الشيخ اسامة', 'المعلمة اكرام'];

  @override
  void initState() {
    super.initState();
    if (widget.review != null) {
      _titleController.text = widget.review!['title']!;
      _progressController.text = widget.review!['progress']!;
      _selectedDate = DateTime.parse(widget.review!['details']!);
      _selectedDeadline = DateTime.parse(widget.review!['deadline']!);
      _selectedStudent = widget.review!['student'];
      _selectedResponsible = widget.review!['responsible'];
    }
  }

  Future<void> _selectDate(BuildContext context, bool isDeadline) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null &&
        picked != (isDeadline ? _selectedDeadline : _selectedDate))
      setState(() {
        if (isDeadline) {
          _selectedDeadline = picked;
        } else {
          _selectedDate = picked;
        }
      });
  }

  void _addReview() {
    if (_titleController.text.isNotEmpty &&
        _progressController.text.isNotEmpty &&
        _selectedStudent != null &&
        _selectedResponsible != null) {
      final newReview = {
        'title': _titleController.text,
        'details': _selectedDate.toLocal().toString().split(' ')[0],
        'progress': _progressController.text,
        'deadline': _selectedDeadline.toLocal().toString().split(' ')[0],
        'student': _selectedStudent!,
        'responsible': _selectedResponsible!,
      };

      Navigator.pop(context, newReview);
    }
  }

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
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                SizedBox(height: 160), // Spacer for the circular design
                Container(
                  width: 250, // Fixed width for the button
                  child: ElevatedButton(
                    onPressed: () {
                      print('برنامج مراجعة');
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.calendar_today,
                          size: 20,
                          color: Colors.black,
                        ),
                        SizedBox(width: 8),
                        Text(
                          'برنامج مراجعة',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey[100],
                      padding: EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ),
                SizedBox(height: 16),
                TextField(
                  controller: _titleController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    label: RichText(
                      text: TextSpan(
                        text: 'عنوان البرنامج',
                        style: TextStyle(color: Colors.black),
                        children: [
                          TextSpan(
                            text: ' *',
                            style: TextStyle(color: Colors.red),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 16),
                TextField(
                  readOnly: true,
                  onTap: () => _selectDate(context, false),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    label: RichText(
                      text: TextSpan(
                        text: _selectedDate.toLocal().toString().split(' ')[0],
                        style: TextStyle(color: Colors.black),
                        children: [
                          TextSpan(
                            text: ' *',
                            style: TextStyle(color: Colors.red),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 16),
                TextField(
                  controller: _progressController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    label: RichText(
                      text: TextSpan(
                        text: 'مقدار المراجعة',
                        style: TextStyle(color: Colors.black),
                        children: [
                          TextSpan(
                            text: ' *',
                            style: TextStyle(color: Colors.red),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 16),
                TextField(
                  readOnly: true,
                  onTap: () => _selectDate(context, true),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    label: RichText(
                      text: TextSpan(
                        text: _selectedDeadline
                            .toLocal()
                            .toString()
                            .split(' ')[0],
                        style: TextStyle(color: Colors.black),
                        children: [
                          TextSpan(
                            text: ' *',
                            style: TextStyle(color: Colors.red),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  value: _selectedStudent,
                  items: students.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (newValue) {
                    setState(() {
                      _selectedStudent = newValue;
                    });
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    label: RichText(
                      text: TextSpan(
                        text: 'الطلبة المعنيين',
                        style: TextStyle(color: Colors.black),
                        children: [
                          TextSpan(
                            text: ' *',
                            style: TextStyle(color: Colors.red),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  value: _selectedResponsible,
                  items: responsibles.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (newValue) {
                    setState(() {
                      _selectedResponsible = newValue;
                    });
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    label: RichText(
                      text: TextSpan(
                        text: 'المشرف',
                        style: TextStyle(color: Colors.black),
                        children: [
                          TextSpan(
                            text: ' *',
                            style: TextStyle(color: Colors.red),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 16),
                Container(
                  width: 150,
                  child: ElevatedButton(
                    onPressed: _addReview,
                    child: Text(
                      'إضافة',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      padding:
                          EdgeInsets.symmetric(vertical: 15, horizontal: 50),
                      backgroundColor: Color(0xFF50B3B3),
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(30.0), // Coins arrondis
                      ),
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
