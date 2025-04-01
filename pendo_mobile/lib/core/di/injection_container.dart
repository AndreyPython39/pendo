import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pendo_mobile/core/config/app_config.dart';
import 'package:pendo_mobile/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:pendo_mobile/features/auth/domain/repositories/auth_repository.dart';
import 'package:pendo_mobile/features/auth/presentation/bloc/auth_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Core
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerSingleton<SharedPreferences>(sharedPreferences);

  final dio = Dio(
    BaseOptions(
      baseUrl: AppConfig.instance.apiUrl,
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 3),
      headers: {'Content-Type': 'application/json'},
    ),
  );
  sl.registerSingleton<Dio>(dio);

  // Repositories
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(sl(), sl()),
  );

  // BLoCs
  sl.registerFactory(
    () => AuthBloc(sl()),
  );
}
