import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_realtime_chat_app/app/features/auth/data/datasources/firebase_datasource_impl.dart';
import 'package:firebase_realtime_chat_app/app/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:firebase_realtime_chat_app/app/features/auth/domain/domain.dart';
import 'package:firebase_realtime_chat_app/app/features/auth/presentation/bloc/auth_cubit/auth_cubit.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

class ServiceLocator {
  ServiceLocator._();
  static void setup() {
    ///
    /// Services
    ///
    sl.registerSingleton<FirebaseAuth>(FirebaseAuth.instance);
    sl.registerSingleton<FirebaseFirestore>(FirebaseFirestore.instance);

    ///
    /// Repositories
    ///
    //* Auth
    sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(sl()));

    ///
    /// Datasources
    ///
    sl.registerLazySingleton<AuthDatasource>(() => FirebaseDatasourceImpl(sl(), sl()));

    ///
    /// Use cases
    ///
    //* Auth
    sl.registerLazySingleton<UserRegisterUsecase>(() => UserRegisterUsecase(sl()));
    sl.registerLazySingleton<UserSigninUsecase>(() => UserSigninUsecase(sl()));
    sl.registerLazySingleton<UserSignoutUsecase>(() => UserSignoutUsecase(sl()));

    //* Global
    sl.registerLazySingleton<ListenAuthUsecase>(() => ListenAuthUsecase(sl()));

    ///
    /// blocs
    ///

    sl.registerLazySingleton<AuthCubit>(() => AuthCubit(sl(), sl()));
  }
}
