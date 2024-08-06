import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isButtonEnabled = false;

  void _validateFields() {
    setState(() {
      _isButtonEnabled = _formKey.currentState?.validate() ?? false;
    });
  }

  @override
  void initState() {
    super.initState();
    _emailController.addListener(_validateFields);
    _passwordController.addListener(_validateFields);
  }

  @override
  void dispose() {
    _emailController.dispose();
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
          // Main content
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    // Email input
                    _buildTextField(
                      'البريد الإلكتروني',
                      TextInputType.emailAddress,
                      true,
                      controller: _emailController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return '';
                        }
                        if (!RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$')
                            .hasMatch(value)) {
                          return 'البريد الإلكتروني غير صالح';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 8),
                    // Password input
                    _buildTextField(
                      'الرقم السري',
                      TextInputType.text,
                      true,
                      obscureText: true,
                      controller: _passwordController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return '';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20),
                    // Button
                    Center(
                      child: ElevatedButton(
                        onPressed: _isButtonEnabled
                            ? () {
                                if (_formKey.currentState?.validate() ??
                                    false) {
                                  Navigator.pushNamed(context,
                                      '/home_j'); // Navigate to home_j page
                                }
                              }
                            : null,
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(
                              vertical: 15, horizontal: 50),
                          backgroundColor: Color(0xFF50B3B3),
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(30.0), // Rounded corners
                          ),
                        ),
                        child: Text(
                          'تسجيل الدخول',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 8), // Space between buttons
                    Center(
                      child: TextButton(
                        onPressed: () {
                          // Handle forgot password action
                        },
                        child: Text(
                          'نسيت كلمة السر؟',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                            decoration:
                                TextDecoration.underline, // Underline the text
                          ),
                        ),
                      ),
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

  // Helper method to build a rounded text field with right-aligned text and label inside the field as hint text
  Widget _buildTextField(
    String hintText,
    TextInputType keyboardType,
    bool isRequired, {
    bool obscureText = false,
    required TextEditingController controller,
    String? Function(String?)? validator,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        obscureText: obscureText,
        controller: controller,
        decoration: InputDecoration(
          hintText: isRequired ? null : hintText,
          hintStyle: TextStyle(
            fontSize: 16,
            color: Colors.black,
          ),
          labelText: isRequired ? null : hintText,
          label: isRequired
              ? RichText(
                  text: TextSpan(
                    text: hintText,
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
                )
              : null,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0), // Rounded corners
          ),
          contentPadding: EdgeInsets.symmetric(
              horizontal: 12.0, vertical: 8.0), // Padding inside the field
        ),
        keyboardType: keyboardType,
        textAlign: TextAlign.right, // Align text to the right
        validator: validator,
      ),
    );
  }
}
