import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pendo_mobile/core/navigation/route_names.dart';
import 'package:pendo_mobile/features/splash/presentation/pages/splash_page.dart';
import 'package:pendo_mobile/features/onboarding/presentation/pages/onboarding_page.dart';
import 'package:pendo_mobile/features/auth/presentation/pages/login_page.dart';
import 'package:pendo_mobile/features/auth/presentation/pages/create_profile_page.dart';
import 'package:pendo_mobile/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:pendo_mobile/core/di/injection_container.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      // Auth Routes
      case Routes.splash:
        return MaterialPageRoute(
          builder: (_) => const SplashPage(),
        );
        
      case Routes.onboarding:
        return MaterialPageRoute(
          builder: (_) => const OnboardingPage(),
        );
        
      case Routes.login:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => sl<AuthBloc>(),
            child: const LoginPage(),
          ),
        );
        
      case Routes.createProfile:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => sl<AuthBloc>(),
            child: const CreateProfilePage(),
          ),
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
