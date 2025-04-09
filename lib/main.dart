import 'package:flutter/material.dart';

import 'package:flutter_gsheets/pages/home.dart';


// Global declaration to access inside widget

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Ensure binding before async
  runApp(
    MaterialApp(
      theme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      home: Home(),
    ),
  );
}

