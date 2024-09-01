import 'package:flutter/material.dart';

class EditPEtudiant extends StatefulWidget {
  final String initialName;
  final String initialLocation;
  final String initialEmail;

  EditPEtudiant({
    required this.initialName,
    required this.initialLocation,
    required this.initialEmail,
  });

  @override
  _EditPEtudiantState createState() => _EditPEtudiantState();
}

class _EditPEtudiantState extends State<EditPEtudiant> {
  final _formKey = GlobalKey<FormState>();
  late String _name;
  late String _location;
  late String _email;

  @override
  void initState() {
    super.initState();
    _name = widget.initialName;
    _location = widget.initialLocation;
    _email = widget.initialEmail;
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
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 220.0, horizontal: 16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextFormField(
                      initialValue: _name,
                      decoration: InputDecoration(
                        labelText: 'اسم',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      onSaved: (value) {
                        _name = value ?? '';
                      },
                    ),
                    SizedBox(height: 16),
                    TextFormField(
                      initialValue: _location,
                      decoration: InputDecoration(
                        labelText: 'العنوان',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      onSaved: (value) {
                        _location = value ?? '';
                      },
                    ),
                    SizedBox(height: 16),
                    TextFormField(
                      initialValue: _email,
                      decoration: InputDecoration(
                        labelText: 'البريد الإلكتروني',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      keyboardType: TextInputType.emailAddress,
                      onSaved: (value) {
                        _email = value ?? '';
                      },
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState?.validate() ?? false) {
                          _formKey.currentState?.save();
                          // Pass updated data back to previous page
                          Navigator.pop(context, {
                            'name': _name,
                            'location': _location,
                            'email': _email,
                          });
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        padding:
                            EdgeInsets.symmetric(vertical: 15, horizontal: 50),
                        backgroundColor: Color(0xFF50B3B3),
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                      ),
                      child: Text(
                        'حفظ ',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
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
}
