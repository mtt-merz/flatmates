import 'package:flatmates/app/ui/screens/chores/chores_screen.dart';
import 'package:flatmates/app/ui/screens/expenses/expenses_screen/expenses_screen.dart';
import 'package:flatmates/app/ui/screens/flat/flat_screen.dart';
import 'package:flatmates/app/ui/screens/main_screen.dart';
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
        return buildRoute((_) => const ExpensesScreen());
      case '/chores':
        return buildRoute((_) => const ChoresScreen());
      case '/flat':
        return buildRoute((_) => const FlatScreen());
      case '/expense/detail':
        // TODO: fix this
        return buildRoute((_) => const MainScreen());

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
