import 'package:firebase_realtime_chat_app/app/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:firebase_realtime_chat_app/app/features/auth/domain/repositories/auth_repository.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

class ServiceLocator {
  void setup() {
    // Repositories

    sl.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(),
    );
  }
}
