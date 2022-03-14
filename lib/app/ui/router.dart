import 'package:flatmates/app/ui/screens/authentication/sign/sign_up_screen.dart';
import 'package:flatmates/app/ui/screens/chores/chores_screen.dart';
import 'package:flatmates/app/ui/screens/expenses/expenses_screen/expenses_screen.dart';
import 'package:flatmates/app/ui/screens/flat/flat_screen.dart';
import 'package:flatmates/app/ui/screens/main_screen.dart';
import 'package:flatmates/app/ui/screens/profile/editor/profile_editor_dialog.dart';
import 'package:flatmates/app/ui/screens/profile/profile_page.dart';
import 'package:flutter/material.dart';

class CustomRouter {
  static MaterialPageRoute onGenerateRoute(RouteSettings routeSettings) {
    final args = routeSettings.arguments;

    MaterialPageRoute buildRoute(WidgetBuilder builder) =>
        MaterialPageRoute(builder: builder, settings: routeSettings);

    switch (routeSettings.name) {
      case '/':
        return buildRoute((_) => const MainScreen());
      case '/expenses':
        return buildRoute((_) => const ExpensesPage());
      case '/expenses/detail':
        // TODO: fix this
        return buildRoute((_) => const MainScreen());
      case '/chores':
        return buildRoute((_) => const ChoresPage());
      case '/flat':
        return buildRoute((_) => const FlatScreen());
      case '/profile':
        return buildRoute((_) => ProfilePage());
      case '/profile/editor':
        return buildRoute((_) => const ProfileEditorDialog());
      case '/authentication/sign_up':
        return buildRoute((_) => const SignUpScreen());
      // case '/authentication/sign_in':
      //   return buildRoute((_) => const SigInScreen());

      default:
        throw Exception('The route \'${routeSettings.name}\' does not exists');
    }
  }
}

class NoAnimationPageRoute<T> extends MaterialPageRoute<T> {
  NoAnimationPageRoute({required WidgetBuilder builder}) : super(builder: builder);

  @override
  Widget buildTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) =>
      child;
}
