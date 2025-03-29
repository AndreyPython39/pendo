import 'package:flutter/material.dart';
import 'package:pendo_mobile/core/navigation/route_names.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      // Auth Routes
      case Routes.splash:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(body: Center(child: Text('Splash'))),
        );
        
      case Routes.onboarding:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(body: Center(child: Text('Onboarding'))),
        );
        
      case Routes.login:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(body: Center(child: Text('Login'))),
        );
        
      case Routes.register:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(body: Center(child: Text('Register'))),
        );
        
      // Main Navigation Routes
      case Routes.home:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(body: Center(child: Text('Home'))),
        );
        
      case Routes.discover:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(body: Center(child: Text('Discover'))),
        );
        
      case Routes.matches:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(body: Center(child: Text('Matches'))),
        );
        
      case Routes.chat:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(body: Center(child: Text('Chat'))),
        );
        
      case Routes.profile:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(body: Center(child: Text('Profile'))),
        );
        
      // Default Route
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
