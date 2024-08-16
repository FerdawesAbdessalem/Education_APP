import 'package:flutter/material.dart';

class LoginEtudiantPage extends StatefulWidget {
  @override
  _LoginEtudiantPageState createState() => _LoginEtudiantPageState();
}

class _LoginEtudiantPageState extends State<LoginEtudiantPage> {
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
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    // Champ d'email
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
                    // Champ de mot de passe
                    _buildTextField(
                      'كلمة المرور',
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
                    // Bouton
                    Center(
                      child: ElevatedButton(
                        onPressed: _isButtonEnabled
                            ? () {
                                if (_formKey.currentState?.validate() ??
                                    false) {
                                  Navigator.pushNamed(
                                      context, '/home_etudiant');
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
                                BorderRadius.circular(30.0), // Coins arrondis
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
                    SizedBox(height: 8), // Espace entre les boutons
                    Center(
                      child: TextButton(
                        onPressed: () {
                          // Gestion de l'action mot de passe oublié
                        },
                        child: Text(
                          'نسيت كلمة السر؟',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                            decoration:
                                TextDecoration.underline, // Souligner le texte
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

  // Méthode pour construire un champ texte avec des coins arrondis, texte aligné à droite, et label comme texte d'indice
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
            borderRadius: BorderRadius.circular(30.0), // Coins arrondis
          ),
          contentPadding: EdgeInsets.symmetric(
              horizontal: 12.0, vertical: 8.0), // Padding intérieur
        ),
        keyboardType: keyboardType,
        textAlign: TextAlign.right, // Aligner le texte à droite
        validator: validator,
      ),
    );
  }
}
