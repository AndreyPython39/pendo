import 'package:flutter/material.dart';

void main() {
  runApp(const PendoApp());
}

class PendoApp extends StatelessWidget {
  const PendoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pendo',
      theme: ThemeData(primarySwatch: Colors.pink),
      home: const SplashScreen(),
    );
  }
}

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text("Welcome to Pendo MVP")),
    );
  }
}