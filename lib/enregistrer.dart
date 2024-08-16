import 'package:flutter/material.dart';

class EnregistrerPage extends StatefulWidget {
  final Function(Map<String, String>) onStudentAdded;
  final Map<String, String>? student;

  EnregistrerPage({required this.onStudentAdded, this.student});

  @override
  _EnregistrerPageState createState() => _EnregistrerPageState();
}

class _EnregistrerPageState extends State<EnregistrerPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _addressController = TextEditingController();
  final _phoneController = TextEditingController();
  final _progressController = TextEditingController();
  final _groupController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.student != null) {
      _nameController.text = widget.student!['name']!;
      _emailController.text = widget.student!['email']!;
      _addressController.text = widget.student!['address']!;
      _phoneController.text = widget.student!['phone']!;
      _progressController.text = widget.student!['progress']!;
      _groupController.text = widget.student!['group']!;
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
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 170),
                Container(
                  width: 250,
                  child: ElevatedButton(
                    onPressed: _registerStudent,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.person_add, size: 20, color: Colors.black),
                        SizedBox(width: 8),
                        Text(
                          widget.student == null ? 'تسجيل طالب' : 'تعديل طالب',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ],
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey[100],
                      padding: EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ),
                SizedBox(height: 8),
                Expanded(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildTextField('الإسم', _nameController, 'name'),
                        _buildTextField(
                            'البريد الإلكتروني', _emailController, 'email'),
                        _buildTextField(
                            'العنوان', _addressController, 'address'),
                        _buildTextField(
                            'رقم الهاتف', _phoneController, 'phone'),
                        _buildTextField(
                            'مقدار الحفظ', _progressController, 'progress'),
                        _buildTextField('المجموعة', _groupController, 'group'),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _registerStudent,
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 50),
                    backgroundColor: Color(0xFF50B3B3),
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                  child: Text(
                    widget.student == null ? 'تسجيل' : 'تعديل',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                ),
                SizedBox(height: 50),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _registerStudent() {
    if (_formKey.currentState?.validate() ?? false) {
      final student = {
        'name': _nameController.text,
        'email': _emailController.text,
        'address': _addressController.text,
        'phone': _phoneController.text,
        'progress': _progressController.text,
        'group': _groupController.text,
        'image': 'assets/default_student.jpg',
      };

      widget.onStudentAdded(student);
      Navigator.pop(context);
    }
  }

  Widget _buildTextField(
      String label, TextEditingController controller, String field) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        textAlign: TextAlign.right,
        decoration: InputDecoration(
          label: RichText(
            text: TextSpan(
              text: label,
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
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
            borderSide: BorderSide(color: Colors.red),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
            borderSide: BorderSide(color: Colors.red),
          ),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'هذا الحقل مطلوب';
          }
          if (field == 'email' &&
              (!value.contains('@') || !value.endsWith('.com'))) {
            return 'البريد الإلكتروني غير صالح';
          }
          if (field == 'phone' &&
              (value.length != 8 || !RegExp(r'^[0-9]+$').hasMatch(value))) {
            return 'رقم الهاتف غير صالح';
          }
          return null;
        },
      ),
    );
  }
}
