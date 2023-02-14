import 'package:campus_market/navigation/paths.dart';
import 'package:campus_market/pages/login_page.dart';
import 'package:go_router/go_router.dart';

class RouterWrapper {
  late final GoRouter _router;

  RouteWrapper() {
    setUpRouter();
  }

  get routerDelegate => _router.routerDelegate;
  get routingInfoParser => _router.routeInformationParser;

  void setUpRouter() {
    _router = GoRouter(initialLocation: RoutePaths.login, routes: [
      GoRoute(path: RoutePaths.login, builder: ((context, state) => const LoginPage())),
      GoRoute(
        path: RoutePaths.home,
      )
    ]);
  }
}
