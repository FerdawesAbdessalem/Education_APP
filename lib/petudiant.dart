import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'editpetudaint.dart'; // Import the edit page

class PEtudiant extends StatefulWidget {
  @override
  _PEtudiantState createState() => _PEtudiantState();
}

class _PEtudiantState extends State<PEtudiant> {
  String _studentName = 'اسم الطالب'; // Nom de l'étudiant
  String _location = 'سوسة سهلول4000'; // Emplacement
  String _email = 'student@example.com'; // Email
  File? _profileImage; // Pour stocker l'image de profil

  final ImagePicker _picker = ImagePicker(); // Instance de ImagePicker

  // Méthode pour choisir une image
  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _profileImage = File(pickedFile.path);
      });
    }
  }

  // Méthode pour naviguer vers la page d'édition
  Future<void> _navigateToEditPage() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditPEtudiant(
          initialName: _studentName,
          initialLocation: _location,
          initialEmail: _email,
        ),
      ),
    );

    if (result != null && result is Map<String, String>) {
      setState(() {
        _studentName = result['name'] ?? _studentName;
        _location = result['location'] ?? _location;
        _email = result['email'] ?? _email;
      });
    }
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
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Photo de couverture
              Container(
                height: 200,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/cover_photo.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(height: 10),
              // Photo de profil et nom de l'étudiant avec icône d'édition
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () => _showImageSourceActionSheet(context),
                    child: CircleAvatar(
                      radius: 60,
                      backgroundImage: _profileImage != null
                          ? FileImage(_profileImage!)
                          : AssetImage('assets/student1.jpg') as ImageProvider,
                    ),
                  ),
                  SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            _studentName,
                            style: TextStyle(
                                fontSize: 28, fontWeight: FontWeight.bold),
                          ),
                          IconButton(
                            icon: Icon(Icons.edit),
                            onPressed:
                                _navigateToEditPage, // Naviguer à la page d'édition
                          ),
                        ],
                      ),
                      SizedBox(height: 5),
                      Text(
                        _location,
                        style: TextStyle(fontSize: 16),
                      ),
                      Text(
                        _email,
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 20),
              // Boutons d'information personnelle
              Expanded(
                child: ListView(
                  children: [
                    _buildButton(context, ' تفاصيل أخرى', () {
                      // Naviguer vers la page des détails supplémentaires
                    }),
                    _buildButton(context, ' تعديل البيانات', () {
                      // Naviguer vers la page de modification des données de l'étudiant
                    }),
                    _buildButton(context, ' حذف الحساب', () {
                      // Fonctionnalité pour supprimer le compte
                    }),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Méthode pour afficher les options de source d'image
  void _showImageSourceActionSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(Icons.camera_alt),
              title: Text('Prendre une photo'),
              onTap: () {
                Navigator.pop(context);
                _pickImage(ImageSource.camera);
              },
            ),
            ListTile(
              leading: Icon(Icons.photo_library),
              title: Text('Choisir depuis la galerie'),
              onTap: () {
                Navigator.pop(context);
                _pickImage(ImageSource.gallery);
              },
            ),
          ],
        );
      },
    );
  }

  Widget _buildButton(
      BuildContext context, String title, VoidCallback onPressed) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text(title, style: TextStyle(fontSize: 18)),
        style: ElevatedButton.styleFrom(
          minimumSize: Size(double.infinity, 50),
          backgroundColor: Colors.grey[100], // Couleur du bouton
        ),
      ),
    );
  }
}
