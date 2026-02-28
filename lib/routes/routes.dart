import 'package:go_router/go_router.dart';

import '../features/authentication/signin_screen.dart';
import '../features/home/presentation/home_screen.dart';

class AppRoutes {
  AppRoutes._(); // private constructor

  // Route names
  static const String signin = '/signin';
  static const String homeScreen = '/homeScreen';

  // GoRouter instance
  static final GoRouter router = GoRouter(
    initialLocation: signin,
    routes: [
      GoRoute(path: signin, builder: (context, state) => const SigninScreen()),
     GoRoute(
        path: homeScreen,
        builder: (context, state) {
          final data = state.extra as Map<String, dynamic>;

          return HomeScreen(data: data);
        },
      ),
    ],
  );
}
