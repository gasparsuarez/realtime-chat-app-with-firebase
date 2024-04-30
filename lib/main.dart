import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_realtime_chat_app/app/core/core.dart';
import 'package:firebase_realtime_chat_app/app/features/auth/domain/domain.dart';
import 'package:firebase_realtime_chat_app/app/features/auth/presentation/screens/screens.dart';
import 'package:firebase_realtime_chat_app/app/features/auth/presentation/bloc/auth_cubit/auth_cubit.dart';
import 'package:firebase_realtime_chat_app/app/features/messaging/presentation/screens/screens.dart';
import 'package:firebase_realtime_chat_app/firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  ServiceLocator.setup();
  runApp(
    const MainApp(),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl.get<AuthCubit>()..listenAuthState(),
      child: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) async {
          switch (state.state) {
            case Authenticated():
              await context.read<AuthCubit>().fetchUserData();
              return AppRouter.appRoutes.goNamed(MessagingScreen.routeName);
            case Unauthenticated():
              return AppRouter.appRoutes.goNamed(StartScreen.routeName);
            default:
              AppRouter.appRoutes.goNamed(StartScreen.routeName);
          }
        },
        builder: (context, state) {
          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            routerConfig: AppRouter.appRoutes,
            theme: appTheme,
          );
        },
      ),
    );
  }
}
