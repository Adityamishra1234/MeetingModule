import 'package:go_router/go_router.dart';
import 'package:meeting_module2/ui/screens/signin_view.dart';

// GoRouter configuration

class RoutesConfig {
  final router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => SignInView(),
      ),
    ],
  );
}
