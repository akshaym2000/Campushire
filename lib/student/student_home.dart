
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:rolebased/Login.dart';
import 'package:rolebased/student/placement_data.dart';
import 'package:rolebased/student/student_profile.dart';
import 'package:rolebased/student/view_jobs.dart';

import 'attend_aptitude.dart';

class StudentPage extends StatefulWidget {
  const StudentPage({Key? key}) : super(key: key);

  @override
  State<StudentPage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<StudentPage> {



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(

        padding: EdgeInsets.zero,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: const BorderRadius.only(
                bottomRight: Radius.circular(50),
              ),
            ),
            child: Column(
              children: [
                const SizedBox(height: 50),
                ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 30),
                  title: Text(
                    'STUDENT',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      color: Colors.white,
                    ),
                  ),

                  trailing: const CircleAvatar(
                    radius: 30,
                    backgroundImage: AssetImage('assets/images/user.JPG'),
                  ),
                ),
                const SizedBox(height: 30)
              ],
            ),
          ),
          Container(
            color: Theme.of(context).primaryColor,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(200),
                  )),
              child: GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                crossAxisSpacing: 40,
                mainAxisSpacing: 30,
                children: [
                  itemDashboard(
                    'PROFILE',
                    CupertinoIcons.person,
                    Colors.deepOrange,
                        () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => StudentProfile(),
                        ),
                      );
                    },
                  ),
                  itemDashboard('JOBS', CupertinoIcons.briefcase, Colors.green,
                          () {Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => view_jobs(),
                            ),
                          );}),
                  itemDashboard(
                      'INTERNSHIP',
                      CupertinoIcons.briefcase_fill,
                      Colors.purple,
                          () {}),
                  itemDashboard(
                      'APTITUDE TEST',
                      CupertinoIcons.square_grid_2x2_fill,
                      Colors.brown,
                          () {Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => QuizScreen(),
                            ),
                          );}),
                  itemDashboard('RESUME BUILDER',
                      CupertinoIcons.doc_plaintext, Colors.indigo, () {}),
                  itemDashboard('PLACEMENT DATA', CupertinoIcons.question_circle,
                      Colors.blue, () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ViewPlacementPage(),
                          ),
                        );
                      }),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          Container(
            alignment: Alignment.bottomCenter,
            margin: const EdgeInsets.only(bottom: 20),
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              },
              child: const Text('Logout'),
            ),
          ),
        ],
      ),
    );
  }

  Widget itemDashboard(
      String title, IconData iconData, Color background, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, 5),
              color: Theme.of(context).primaryColor.withOpacity(.2),
              spreadRadius: 2,
              blurRadius: 5,
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: background,
                shape: BoxShape.circle,
              ),
              child: Icon(iconData, color: Colors.white),
            ),
            const SizedBox(height: 8),
            Text(
              title.toUpperCase(),
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ],
        ),
      ),
    );
  }
}
