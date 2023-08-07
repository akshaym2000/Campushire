import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StudentProfile extends StatefulWidget {
  @override
  _StudentProfileState createState() => _StudentProfileState();
}

class _StudentProfileState extends State<StudentProfile> {
  final studentProfile = FirebaseFirestore.instance.collection('Student_profile');
  final _formKey = GlobalKey<FormState>();
  TextEditingController _fullNameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _idController = TextEditingController();
  TextEditingController _branchController = TextEditingController();
  TextEditingController _semesterController = TextEditingController();
  TextEditingController _cgpaController = TextEditingController();
  TextEditingController _skillsController = TextEditingController();

  String fullName = 'N/A';
  String email = 'N/A';
  String id = 'N/A';
  String branch = 'N/A';
  String semester = 'N/A';
  double? cgpa;
  String skills = 'N/A';

  @override
  void initState() {
    super.initState();
    fetchStudentProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Student Profile',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.blue, // Change the app bar background color
        elevation: 0, // Remove the app bar elevation
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            _buildProfileInfoCard(),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _editProfile,
              child: Text(
                'Edit Profile',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue, // Set button background color
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }


  Widget _buildProfileInfoCard() {
    return Card(
      color: Colors.white,
      elevation: 2.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildProfileDetail('Full Name', fullName),
            _buildProfileDetail('Email', email),
            _buildProfileDetail('ID', id),
            _buildProfileDetail('Branch', branch),
            _buildProfileDetail('Semester', semester),
            _buildProfileDetail('CGPA', cgpa?.toString() ?? 'N/A'),
            _buildProfileDetail('Skills', skills),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileDetail(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16.0,
              color: Colors.black87,
            ),
          ),
          SizedBox(height: 4.0),
          Text(
            value,
            style: TextStyle(
              fontSize: 18.0,
              color: Colors.black54,
            ),
          ),
        ],
      ),
    );
  }

  void fetchStudentProfile() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      String userId = user.uid;
      DocumentSnapshot snapshot = await studentProfile.doc(userId).get();
      if (snapshot.exists) {
        Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
        fullName = data['fullname'] ?? 'N/A';
        email = data['email'] ?? 'N/A';
        id = data['id'] ?? 'N/A';
        branch = data['branch'] ?? 'N/A';
        semester = data['semester'] ?? 'N/A';
        cgpa = data['cgpa']?.toDouble();
        skills = data['skills'] ?? 'N/A';
        setState(() {});
      }
    }
  }

  void _editProfile() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit Profile'),
          content: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  TextFormField(
                    controller: _fullNameController,
                    decoration: InputDecoration(
                      labelText: 'Full Name',
                      filled: true,
                      fillColor: Colors.grey[200],
                    ),
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      filled: true,
                      fillColor: Colors.grey[200],
                    ),
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: _idController,
                    decoration: InputDecoration(
                      labelText: 'ID',
                      filled: true,
                      fillColor: Colors.grey[200],
                    ),
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: _branchController,
                    decoration: InputDecoration(
                      labelText: 'Branch',
                      filled: true,
                      fillColor: Colors.grey[200],
                    ),
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: _semesterController,
                    decoration: InputDecoration(
                      labelText: 'Semester',
                      filled: true,
                      fillColor: Colors.grey[200],
                    ),
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: _cgpaController,
                    decoration: InputDecoration(
                      labelText: 'CGPA',
                      filled: true,
                      fillColor: Colors.grey[200],
                    ),
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: _skillsController,
                    decoration: InputDecoration(
                      labelText: 'Skills',
                      filled: true,
                      fillColor: Colors.grey[200],
                    ),
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                _fullNameController.clear();
                _emailController.clear();
                _idController.clear();
                _branchController.clear();
                _semesterController.clear();
                _cgpaController.clear();
                _skillsController.clear();
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: _saveProfile,
              child: Text('Save'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
              ),
            ),
          ],
        );
      },
    );
  }

  void _saveProfile() async {
    if (_formKey.currentState!.validate()) {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        String userId = user.uid;
        await studentProfile.doc(userId).set({
          'fullname': _fullNameController.text,
          'email': _emailController.text,
          'id': _idController.text,
          'branch': _branchController.text,
          'semester': _semesterController.text,
          'cgpa': double.tryParse(_cgpaController.text),
          'skills': _skillsController.text,
        });
        Navigator.pop(context);
        fetchStudentProfile();
      }
    }
  }
}
