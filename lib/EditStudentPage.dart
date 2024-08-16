import 'package:flutter/material.dart';

class EditStudentPage extends StatefulWidget {
  final Map<String, String> student;

  EditStudentPage({required this.student});

  @override
  _EditStudentPageState createState() => _EditStudentPageState();
}

class _EditStudentPageState extends State<EditStudentPage> {
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _progressController;
  late TextEditingController _addressController;
  late TextEditingController _phoneController;
  late TextEditingController _groupController;
  late TextEditingController _descriptionController; // New controller

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.student['name']);
    _emailController = TextEditingController(text: widget.student['email']);
    _progressController =
        TextEditingController(text: widget.student['progress']);
    _addressController = TextEditingController(text: widget.student['address']);
    _phoneController = TextEditingController(text: widget.student['phone']);
    _groupController = TextEditingController(text: widget.student['group']);
    _descriptionController = TextEditingController(
        text: widget.student['description'] ?? ''); // Initialize new controller
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _progressController.dispose();
    _addressController.dispose();
    _phoneController.dispose();
    _groupController.dispose();
    _descriptionController.dispose(); // Dispose new controller
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('تعديل الطالب')),
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
                _buildTextField('الاسم:', _nameController),
                _buildTextField('البريد الإلكتروني:', _emailController),
                _buildTextField('المقدار:', _progressController),
                _buildTextField('العنوان:', _addressController),
                _buildTextField('رقم الهاتف:', _phoneController),
                _buildTextField('المجموعة:', _groupController),
                _buildTextField('الوصف:', _descriptionController), // New field
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _saveChanges,
                  child: Text('حفظ التعديلات'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0), // Rounded corners
          ),
        ),
      ),
    );
  }

  void _saveChanges() {
    final updatedStudent = {
      'name': _nameController.text,
      'email': _emailController.text,
      'progress': _progressController.text,
      'address': _addressController.text,
      'phone': _phoneController.text,
      'group': _groupController.text,
      'description': _descriptionController.text, // Include description
      'image': widget.student['image']!,
    };
    Navigator.pop(context, updatedStudent);
  }
}
