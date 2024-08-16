import 'package:flutter/material.dart';
import 'save_detail_page.dart'; // Import the SaveDetailPage

class SaveFormPage extends StatefulWidget {
  @override
  _SaveFormPageState createState() => _SaveFormPageState();
}

class _SaveFormPageState extends State<SaveFormPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _detailsController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  DateTime _selectedDeadline = DateTime.now();
  List<String> students = [
    'فردوس عبد السلام',
    'أنس العويان',
    'بلسم عبد السلام',
    'احمد'
  ];
  List<String> supervisors = ['الشيخ احمد', 'الشيخ اسامة', 'المعلمة اكرام'];
  List<String> groups = [
    'ربع ياسين',
    'البقرة',
    'جزء عم',
  ];
  String? _selectedStudent;
  String? _selectedSupervisor;
  String? _selectedGroup;

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

  void _saveItem() {
    if (_formKey.currentState!.validate()) {
      // Retrieve form values
      final String title = _titleController.text;
      final String details = _detailsController.text;
      final String student = _selectedStudent ?? '';
      final String supervisor = _selectedSupervisor ?? '';
      final String group = _selectedGroup ?? '';
      final String date = _selectedDate.toLocal().toString().split(' ')[0];
      final String deadline =
          _selectedDeadline.toLocal().toString().split(' ')[0];

      // Navigate to the SaveDetailPage and pass the data
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SaveDetailPage(
            title: title,
            details: details,
            student: student,
            supervisor: supervisor,
            group: group,
            date: date,
            deadline: deadline,
          ),
        ),
      );
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
                color: Color(0xFF499DA2)
                    .withOpacity(0.5), // Match color with ReviewFormPage
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
                color: Color(0xFF499DA2)
                    .withOpacity(0.5), // Match color with ReviewFormPage
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
                      print('برنامج حفظ');
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.save,
                          size: 20,
                          color: Colors.black,
                        ),
                        SizedBox(width: 8),
                        Text(
                          'برنامج حفظ',
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
                            text: '',
                            style: TextStyle(color: Colors.red),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  value: _selectedSupervisor,
                  items: supervisors.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (newValue) {
                    setState(() {
                      _selectedSupervisor = newValue;
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
                DropdownButtonFormField<String>(
                  value: _selectedGroup,
                  items: groups.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (newValue) {
                    setState(() {
                      _selectedGroup = newValue;
                    });
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    label: RichText(
                      text: TextSpan(
                        text: 'المجموعة',
                        style: TextStyle(color: Colors.black),
                        children: [
                          TextSpan(
                            text: '*',
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
                Container(
                  width: 150,
                  child: ElevatedButton(
                    onPressed: _saveItem,
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
