import 'package:firebase_realtime_chat_app/app/features/auth/domain/domain.dart';
import 'package:firebase_realtime_chat_app/app/features/auth/presentation/screens/screens.dart';
import 'package:firebase_realtime_chat_app/app/features/messaging/messaging.dart';
import 'package:firebase_realtime_chat_app/app/features/profile/profile.dart';
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
        path: '/messaging',
        name: MessagingScreen.routeName,
        builder: (_, state) => const MessagingScreen(),
        routes: [
          GoRoute(
            path: 'chat_view',
            name: ChatView.routeName,
            builder: (_, state) => ChatView(
              contact: state.extra as UserEntity,
            ),
          ),
          GoRoute(
            path: 'profile',
            name: UserProfileScreen.routeName,
            builder: (_, state) => const UserProfileScreen(),
          ),
        ],
      )
    ],
  );
}
