import 'package:firebase_realtime_chat_app/app/features/auth/presentation/screens/screens.dart';
import 'package:firebase_realtime_chat_app/app/features/home/presentation/screens/screens.dart';
import 'package:go_router/go_router.dart';

///
/// Routing configuration
///
class AppRouter {
  AppRouter._();
  static GoRouter appRoutes = GoRouter(
    initialLocation: '/start_screen',
    routes: [
      GoRoute(
        name: StartScreen.routeName,
        path: '/start_screen',
        builder: (_, state) => const StartScreen(),
        routes: [
          GoRoute(
            name: LoginScreen.routeName,
            path: 'login',
            builder: (_, state) => const LoginScreen(),
          ),
          GoRoute(
            name: RegisterScreen.routeName,
            path: 'register',
            builder: (_, state) => const RegisterScreen(),
          ),
        ],
      ),
      GoRoute(
        path: '/home',
        name: HomeScreen.routeName,
        builder: (_, state) => const HomeScreen(),
      )
    ],
  );
}
