import 'package:app_sqflite/screen/about_hour.dart';
import 'package:app_sqflite/screen/add.dart';
import 'package:app_sqflite/screen/all_hour.dart';
import 'package:app_sqflite/screen/ava_hour.dart';
import 'package:app_sqflite/screen/home.dart';
import 'package:app_sqflite/screen/start.dart';
import 'package:app_sqflite/sqflite/db.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';

import 'component/shared_prefernces.dart';
void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  createDatabase();
  await SharedClass.inti();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'الملعب',
      theme: ThemeData(
        primarySwatch: Colors.indigo,

      ),
      home: const HomeScreen(),
    );
  }
}

