import 'package:flutter/material.dart';

class CreatePage extends StatefulWidget {
  @override
  _CreatePageState createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {
  final _formKey = GlobalKey<FormState>();
  final _associationNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _addressController = TextEditingController();
  final _phoneController = TextEditingController();
  final _supervisorController = TextEditingController();
  final _passwordController = TextEditingController();

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
    _associationNameController.addListener(_validateForm);
    _emailController.addListener(_validateForm);
    _addressController.addListener(_validateForm);
    _phoneController.addListener(_validateForm);
    _supervisorController.addListener(_validateForm);
    _passwordController.addListener(_validateForm);
  }

  @override
  void dispose() {
    _associationNameController.dispose();
    _emailController.dispose();
    _addressController.dispose();
    _phoneController.dispose();
    _supervisorController.dispose();
    _passwordController.dispose();
    super.dispose();
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
                color: Color(0xFF499DA2).withOpacity(0.5), // Updated color
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
                color: Color(0xFF499DA2).withOpacity(0.5), // Updated color
              ),
            ),
          ),
          // Main content, positioned below the decorative circles
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                        height: 150), // Adjusted spacer for the circular design
                    Center(
                      child: Container(
                        width: 250, // Fixed width for the button
                        child: ElevatedButton(
                          onPressed: () {
                            print('معلومات شخصية');
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.info, // Changed icon
                                size: 20,
                                color: Colors
                                    .black, // Icon color same as text color
                              ),
                              SizedBox(
                                  width: 8), // Spacing between icon and text
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
                            backgroundColor:
                                Colors.grey[100], // Background color changed
                            padding: EdgeInsets.symmetric(
                                vertical: 8), // Reduced padding
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                        height:
                            8), // Reduced spacing between the button and the form fields
                    _buildTextField('إسم الجمعية:', TextInputType.text,
                        _associationNameController),
                    SizedBox(height: 4), // Reduced spacing between fields
                    _buildTextField('البريد الإلكتروني:',
                        TextInputType.emailAddress, _emailController,
                        validateEmail: true),
                    SizedBox(height: 4),
                    _buildTextField(
                        'العنوان:', TextInputType.text, _addressController),
                    SizedBox(height: 4),
                    _buildTextField(
                        'رقم الهاتف:', TextInputType.phone, _phoneController,
                        validatePhone: true),
                    SizedBox(height: 4),
                    _buildTextField('المشرف على الجمعية:', TextInputType.text,
                        _supervisorController),
                    SizedBox(height: 4),
                    _buildTextField(
                        'الرقم السري:', TextInputType.text, _passwordController,
                        obscureText: true),
                    SizedBox(height: 16), // Reduced spacing before buttons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: _isButtonEnabled
                                ? () {
                                    Navigator.pushNamed(context,
                                        '/login'); // Navigate to login page
                                  }
                                : null,
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.symmetric(
                                  vertical: 12), // Reduced padding
                              backgroundColor:
                                  Color(0xFF50B3B3), // Button background color
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
    bool validatePhone = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0), // Reduced padding
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
            borderRadius: BorderRadius.circular(30.0), // Rounded corners
          ),
          contentPadding: EdgeInsets.symmetric(
              horizontal: 12.0, vertical: 8.0), // Padding inside the field
        ),
        keyboardType: keyboardType,
        textAlign: TextAlign.right, // Align text to the right
        validator: (value) {
          if (value == null || value.isEmpty) {
            return '';
          }
          if (validateEmail &&
              (!value.contains('@') || !value.contains('.com'))) {
            return 'يرجى إدخال بريد إلكتروني صالح';
          }
          if (validatePhone &&
              (value.length != 8 || !RegExp(r'^\d+$').hasMatch(value))) {
            return 'يرجى إدخال رقم هاتف مكون من 8 أرقام';
          }
          return null;
        },
      ),
    );
  }
}
