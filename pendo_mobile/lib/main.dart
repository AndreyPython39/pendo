import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pendo_mobile/core/config/app_config.dart';
import 'package:pendo_mobile/core/config/theme_config.dart';
import 'package:pendo_mobile/core/navigation/app_router.dart';
import 'package:pendo_mobile/core/navigation/route_names.dart';
import 'package:pendo_mobile/core/di/injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Set environment
  AppConfig.setEnvironment(Environment.dev);
  
  // Initialize dependencies
  await di.init();
  
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
      onGenerateRoute: AppRouter.generateRoute,
      initialRoute: Routes.splash,
    );
  }
}
