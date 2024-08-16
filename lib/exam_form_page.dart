import 'package:flutter/material.dart';

class ExamFormPage extends StatefulWidget {
  @override
  _ExamFormPageState createState() => _ExamFormPageState();
}

class _ExamFormPageState extends State<ExamFormPage> {
  DateTime _selectedDate = DateTime.now();
  String? _selectedStudent;
  String? _selectedResponsible;
  String? _amount;
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  List<String> students = [
    'فردوس عبد السلام',
    'أنس العويان',
    'بلسم عبد السلام',
    'احمد'
  ];
  List<String> responsibles = ['الشيخ احمد', 'الشيخ اسامة', 'المعلمة اكرام'];

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate)
      setState(() {
        _selectedDate = picked;
      });
  }

  void _submitForm() {
    if (_formKey.currentState?.validate() ?? false) {
      final newExam = {
        'title': _titleController.text,
        'details': _selectedDate.toLocal().toString().split(' ')[0],
        'amount': _amountController.text,
        'student': _selectedStudent ?? 'غير محدد',
        'responsible': _selectedResponsible ?? 'غير محدد',
      };

      Navigator.pop(context, newExam);
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
                SizedBox(height: 180),
                Container(
                  width: 250,
                  child: ElevatedButton(
                    onPressed: () {
                      print('الامتحان');
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.assignment,
                          size: 20,
                          color: Colors.black,
                        ),
                        SizedBox(width: 8),
                        Text(
                          'الامتحان',
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
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _titleController,
                        decoration: InputDecoration(
                          label: RichText(
                            text: TextSpan(
                              text: 'عنوان الامتحان',
                              style: TextStyle(color: Colors.black),
                              children: [
                                TextSpan(
                                  text: ' *',
                                  style: TextStyle(color: Colors.red),
                                ),
                              ],
                            ),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'يرجى إدخال عنوان الامتحان';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 16),
                      TextFormField(
                        readOnly: true,
                        onTap: () => _selectDate(context),
                        decoration: InputDecoration(
                          label: RichText(
                            text: TextSpan(
                              text: 'تاريخ الامتحان',
                              style: TextStyle(color: Colors.black),
                              children: [
                                TextSpan(
                                  text: ' *',
                                  style: TextStyle(color: Colors.red),
                                ),
                              ],
                            ),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                        ),
                      ),
                      SizedBox(height: 16),
                      TextFormField(
                        controller: _amountController,
                        decoration: InputDecoration(
                          label: RichText(
                            text: TextSpan(
                              text: 'المجموعة',
                              style: TextStyle(color: Colors.black),
                              children: [
                                TextSpan(
                                  text: ' *',
                                  style: TextStyle(color: Colors.red),
                                ),
                              ],
                            ),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'يرجى إدخال المجموعة';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 16),
                      DropdownButtonFormField(
                        decoration: InputDecoration(
                          label: RichText(
                            text: TextSpan(
                              text: 'اختيار الطالب',
                              style: TextStyle(color: Colors.black),
                              children: [
                                TextSpan(
                                  text: ' ',
                                  style: TextStyle(color: Colors.red),
                                ),
                              ],
                            ),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                        ),
                        value: _selectedStudent,
                        onChanged: (String? newValue) {
                          setState(() {
                            _selectedStudent = newValue;
                          });
                        },
                        items: students
                            .map<DropdownMenuItem<String>>((String student) {
                          return DropdownMenuItem<String>(
                            value: student,
                            child: Text(student),
                          );
                        }).toList(),
                        validator: (value) {
                          if (value == null) {
                            return 'يرجى اختيار الطالب';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 16),
                      DropdownButtonFormField(
                        decoration: InputDecoration(
                          label: RichText(
                            text: TextSpan(
                              text: 'اختيار المشرف',
                              style: TextStyle(color: Colors.black),
                              children: [
                                TextSpan(
                                  text: ' *',
                                  style: TextStyle(color: Colors.red),
                                ),
                              ],
                            ),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                        ),
                        value: _selectedResponsible,
                        onChanged: (String? newValue) {
                          setState(() {
                            _selectedResponsible = newValue;
                          });
                        },
                        items: responsibles.map<DropdownMenuItem<String>>(
                            (String responsible) {
                          return DropdownMenuItem<String>(
                            value: responsible,
                            child: Text(responsible),
                          );
                        }).toList(),
                        validator: (value) {
                          if (value == null) {
                            return 'يرجى اختيار المسؤول';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20),
                      Center(
                        child: ElevatedButton(
                          onPressed: _submitForm,
                          child: Text(
                            'إضافة',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(
                                vertical: 15, horizontal: 50),
                            backgroundColor: Color(0xFF50B3B3),
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                          ),
                        ),
                      ),
                    ],
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
