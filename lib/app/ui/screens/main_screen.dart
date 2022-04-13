import 'package:flatmates/app/ui/screens/chores/chores_screen.dart';
import 'package:flatmates/app/ui/screens/expenses/expenses_screen/expenses_screen.dart';
import 'package:flatmates/app/ui/screens/home/home_page.dart';
import 'package:flatmates/app/ui/screens/profile/profile_screen.dart';
import 'package:flatmates/app/ui/utils/size_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({this.initialPage = 0, Key? key}) : super(key: key);

  final int initialPage;

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late int page;
  late final PageController pageController;

  @override
  void initState() {
    super.initState();

    page = widget.initialPage;
    pageController = PageController(initialPage: page);
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: PageView(
          controller: pageController,
          physics: const NeverScrollableScrollPhysics(),
          onPageChanged: (page) => setState(() => this.page = page),
          children: [HomePage(), const ExpensesPage(), const ChoresPage(), ProfileScreen()],
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: page,
          onTap: (page) => setState(() {
            try {
              this.page = page;
              pageController.jumpToPage(page);
            } on Object catch (_) {}
          }),
          items: [
            buildBottomNavigatorBarItem('Home', icon: Icons.home_outlined, activeIcon: Icons.home),
            buildBottomNavigatorBarItem('Expenses',
                icon: Icons.circle_outlined, activeIcon: Icons.circle),
            buildBottomNavigatorBarItem('Chores',
                icon: Icons.circle_outlined, activeIcon: Icons.circle),
            buildBottomNavigatorBarItem('Account',
                icon: Icons.account_circle_outlined, activeIcon: Icons.account_circle),
          ],
        ),
      );

  BottomNavigationBarItem buildBottomNavigatorBarItem(String label,
          {required IconData icon, IconData? activeIcon}) =>
      BottomNavigationBarItem(
        label: label,
        icon: Icon(icon),
        activeIcon: SizedBox(
          height: SizeUtils.of(context).getScaledHeight(4),
          width: double.infinity,
          child: Center(
            child: ListView(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              children: [
                Icon(activeIcon ?? icon),
                const SizedBox(width: 5),
                Center(
                  child: Text(label,
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            color: Theme.of(context).bottomNavigationBarTheme.selectedItemColor,
                          )),
                )
              ],
            ),
          ),
        ),
      );
}
