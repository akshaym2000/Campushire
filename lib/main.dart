
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rolebased/admin/update_jobs.dart';
import 'package:rolebased/register.dart';
import 'Admin/add_jobs.dart';
import 'Admin/admin_home.dart';
import 'Faculty/faculty_home.dart';
import 'Student/attend_aptitude.dart';
import 'Student/placement_data.dart';
import 'Student/student_home.dart';
import 'package:firebase_core/firebase_core.dart';

import 'Student/student_profile.dart';
import 'Student/view_jobs.dart';
import 'forgot.dart';
import 'login.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: 'AIzaSyCWuBkbG0SslK1eTovRphUYMza2c31VZuY',
          appId: '1:24333841394:android:a255e72821938de5cff16b',
          messagingSenderId: '',
          projectId: 'camphire-200c5')
  );
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent
  ));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Dashboard',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      routes: {
        'login': (context) =>  const LoginPage(),
        'signup': (context) => Register(),
        'forgot': (context) => Forgot(),
        'admin': (context) => AdminPage(),
        'faculty': (context) => FacultyPage(),
        'student': (context) => const StudentPage(),
        'student_profile': (context) => StudentProfile(),
        'add_jobs' : (context) => Add_jobs(),
        'view_jobs' : (context) => view_jobs(),
        'update':(context)=>Update(),
        'aptitude':(context) => QuizScreen(),
        'placement_data' : (context) =>ViewPlacementPage()
      },
      initialRoute: 'login',
    );
  }
}

