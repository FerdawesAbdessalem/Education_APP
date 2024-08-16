import 'package:flutter/material.dart';
import 'login_etudiant.dart';

class CreateEtudiantPage extends StatefulWidget {
  @override
  _CreateEtudiantPageState createState() => _CreateEtudiantPageState();
}

class _CreateEtudiantPageState extends State<CreateEtudiantPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _addressController = TextEditingController();
  final _phoneController = TextEditingController();
  final _associationNameController = TextEditingController();
  final _groupController = TextEditingController();

  bool _isButtonEnabled = false;

  void _validateForm() {
    final isValid = _formKey.currentState?.validate() ?? false;
    setState(() {
      _isButtonEnabled = isValid;
    });
  }

  @override
  void initState() {
    super.initState();
    _nameController.addListener(_validateForm);
    _emailController.addListener(_validateForm);
    _passwordController.addListener(_validateForm);
    _addressController.addListener(_validateForm);
    _phoneController.addListener(_validateForm);
    _associationNameController.addListener(_validateForm);
    _groupController.addListener(_validateForm);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _addressController.dispose();
    _phoneController.dispose();
    _associationNameController.dispose();
    _groupController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Cercles décoratifs
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
          // Contenu principal
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 150),
                    Center(
                      child: Container(
                        width: 250,
                        child: ElevatedButton(
                          onPressed: () {
                            print('معلومات شخصية');
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.info,
                                size: 20,
                                color: Colors.black,
                              ),
                              SizedBox(width: 8),
                              Text(
                                'معلومات شخصية',
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
                            padding: EdgeInsets.symmetric(vertical: 8),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 8),
                    _buildTextField(
                        'اسم الطالب:', TextInputType.text, _nameController),
                    SizedBox(height: 4),
                    _buildTextField('البريد الإلكتروني:',
                        TextInputType.emailAddress, _emailController,
                        validateEmail: true),
                    SizedBox(height: 4),
                    _buildTextField(
                        'العنوان:', TextInputType.text, _addressController),
                    SizedBox(height: 4),
                    _buildTextField(
                        'رقم الهاتف:', TextInputType.phone, _phoneController),
                    SizedBox(height: 4),
                    _buildTextField('اسم الجمعية:', TextInputType.text,
                        _associationNameController),
                    SizedBox(height: 4),
                    _buildTextField(
                        'المجموعة:', TextInputType.text, _groupController),
                    SizedBox(height: 4),
                    _buildTextField(
                        'كلمة المرور:', TextInputType.text, _passwordController,
                        obscureText: true),
                    SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: _isButtonEnabled
                                ? () {
                                    // Processus de création de compte
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text('إنشاء حساب جاري...')),
                                    );
                                    // Navigate to the login page
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            LoginEtudiantPage(), // Replace with your actual login page widget
                                      ),
                                    );
                                  }
                                : null,
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.symmetric(vertical: 12),
                              backgroundColor: Color(0xFF50B3B3),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                            ),
                            child: Text(
                              'إنشاء حساب',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Helper method to build a rounded text field with right-aligned text and validation
  Widget _buildTextField(
    String labelText,
    TextInputType keyboardType,
    TextEditingController controller, {
    bool obscureText = false,
    bool validateEmail = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          label: RichText(
            text: TextSpan(
              text: labelText,
              style: TextStyle(
                fontSize: 16,
                color: Colors.black,
              ),
              children: [
                TextSpan(
                  text: ' *',
                  style: TextStyle(color: Colors.red),
                ),
              ],
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
        ),
        keyboardType: keyboardType,
        textAlign: TextAlign.right,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'هذا الحقل مطلوب';
          }
          if (validateEmail &&
              (!value.contains('@') || !value.contains('.com'))) {
            return 'يرجى إدخال بريد إلكتروني صالح';
          }
          return null;
        },
      ),
    );
  }
}
