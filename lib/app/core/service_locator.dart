import 'package:firebase_realtime_chat_app/app/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:firebase_realtime_chat_app/app/features/auth/domain/domain.dart';
import 'package:firebase_realtime_chat_app/app/features/global/data/data.dart';
import 'package:firebase_realtime_chat_app/app/features/global/domain/domain.dart';
import 'package:firebase_realtime_chat_app/app/features/global/presentation/bloc/auth_cubit/auth_cubit.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

class ServiceLocator {
  ServiceLocator._();
  static void setup() {
    ///
    /// Repositories
    ///
    //* Auth
    sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl());
    //* Global
    sl.registerLazySingleton<AuthStateRepository>(() => AuthStateRepositoryImpl());

    ///
    /// Use cases
    ///
    //* Auth
    sl.registerLazySingleton<UserRegisterUsecase>(() => UserRegisterUsecase(sl()));
    sl.registerLazySingleton<UserSigninUsecase>(() => UserSigninUsecase(sl()));

    //* Global
    sl.registerLazySingleton<ListenAuthUsecase>(() => ListenAuthUsecase(sl()));

    ///
    /// blocs
    ///

    sl.registerLazySingleton<AuthCubit>(() => AuthCubit(sl()));
  }
}
