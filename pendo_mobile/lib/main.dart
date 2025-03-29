import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pendo_mobile/core/config/app_config.dart';
import 'package:pendo_mobile/core/config/theme_config.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Set environment
  AppConfig.setEnvironment(Environment.dev);
  
  runApp(const PendoApp());
}

class PendoApp extends StatelessWidget {
  const PendoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppConfig.instance.appName,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      // TODO: Add routes
      home: const Scaffold(
        body: Center(
          child: Text('Welcome to Pendo!'),
        ),
      ),
    );
  }
}
