import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../presentation/blocs/meditation/meditation_bloc.dart';
import '../../presentation/blocs/user/user_bloc.dart';
import '../../data/datasources/user_local_data_source.dart';
import '../../domain/repositories/user_repository.dart';
import '../../data/repositories/user_repository_impl.dart';
import '../services/audio_service.dart';
import '../services/notification_service.dart';

final getIt = GetIt.instance;

Future<void> configureDependencies() async {
  // Registramos las dependencias externas primero
  final sharedPreferences = await SharedPreferences.getInstance();
  getIt.registerSingleton<SharedPreferences>(sharedPreferences);
  
  // Registramos servicios
  final notificationService = NotificationService();
  await notificationService.init();
  getIt.registerSingleton<NotificationService>(notificationService);
  getIt.registerSingleton<AudioService>(AudioService());
  
  // Registramos manualmente las dependencias
  _initializeDependencies();
}

void _initializeDependencies() {
  // Datasources
  getIt.registerLazySingleton<UserLocalDataSource>(
    () => UserLocalDataSourceImpl(getIt<SharedPreferences>()),
  );

  // Repositories
  // Usamos directamente MockUserRepository para simplificar por ahora
  getIt.registerLazySingleton<UserRepository>(
    () => MockUserRepository(),
  );

  // BLoCs
  getIt.registerFactory<UserBloc>(() => UserBloc(userRepository: getIt<UserRepository>()));
  getIt.registerFactory<MeditationBloc>(() => MeditationBloc());
} 