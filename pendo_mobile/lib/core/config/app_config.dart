import 'package:flutter/material.dart';

enum Environment { dev, staging, prod }

class AppConfig {
  final String apiUrl;
  final String appName;
  final Environment environment;
  final bool enableAnalytics;
  final String sentryDsn;
  final String googleMapsKey;

  static AppConfig? _instance;

  AppConfig._({
    required this.apiUrl,
    required this.appName,
    required this.environment,
    required this.enableAnalytics,
    required this.sentryDsn,
    required this.googleMapsKey,
  });

  static AppConfig get instance {
    _instance ??= AppConfig._dev();
    return _instance!;
  }

  factory AppConfig._dev() {
    return AppConfig._(
      apiUrl: 'http://localhost:8000',
      appName: 'Pendo (Dev)',
      environment: Environment.dev,
      enableAnalytics: false,
      sentryDsn: '',
      googleMapsKey: '',
    );
  }

  factory AppConfig.staging() {
    return AppConfig._(
      apiUrl: 'https://api.staging.pendo.africa',
      appName: 'Pendo (Staging)',
      environment: Environment.staging,
      enableAnalytics: true,
      sentryDsn: const String.fromEnvironment('SENTRY_DSN'),
      googleMapsKey: const String.fromEnvironment('GOOGLE_MAPS_KEY'),
    );
  }

  factory AppConfig.production() {
    return AppConfig._(
      apiUrl: 'https://api.pendo.africa',
      appName: 'Pendo',
      environment: Environment.prod,
      enableAnalytics: true,
      sentryDsn: const String.fromEnvironment('SENTRY_DSN'),
      googleMapsKey: const String.fromEnvironment('GOOGLE_MAPS_KEY'),
    );
  }

  static void setEnvironment(Environment env) {
    switch (env) {
      case Environment.dev:
        _instance = AppConfig._dev();
        break;
      case Environment.staging:
        _instance = AppConfig.staging();
        break;
      case Environment.prod:
        _instance = AppConfig.production();
        break;
    }
  }

  bool get isDevelopment => environment == Environment.dev;
  bool get isStaging => environment == Environment.staging;
  bool get isProduction => environment == Environment.prod;
}
