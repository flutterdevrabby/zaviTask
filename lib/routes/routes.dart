import 'package:go_router/go_router.dart';

import '../features/authentication/signin_screen.dart';

class AppRoutes {
  AppRoutes._(); // private constructor

  // Route names
  static const String signin = '/signin';

  // GoRouter instance
  static final GoRouter router = GoRouter(
    initialLocation: signin,
    routes: [
      GoRoute(path: signin, builder: (context, state) => const SigninScreen()),
    ],
  );
}
