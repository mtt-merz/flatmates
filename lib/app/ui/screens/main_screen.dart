import 'package:flatmates/app/ui/screens/chores/chores_screen.dart';
import 'package:flatmates/app/ui/screens/expenses/expenses_screen.dart';
import 'package:flatmates/app/ui/screens/home/home_page.dart';
import 'package:flutter/material.dart';

import 'chat/chat_page.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({this.initialPage = 1, Key? key}) : super(key: key);

  final int initialPage;

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late int page;
  late final PageController pageController;

  final pages = const [HomePage(), ExpensesPage(), ChoresPage(), ChatPage()];

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
          onPageChanged: (page) => setState(() => this.page = page),
          children: pages,
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: page,
          onTap: (page) => setState(() {
            this.page = page;
            pageController.jumpToPage(page);
          }),
          items: const [
            BottomNavigationBarItem(
              label: 'Home',
              icon: Icon(Icons.home),
            ),
            BottomNavigationBarItem(
              label: 'Expenses',
              icon: Icon(Icons.euro),
            ),
            BottomNavigationBarItem(
              label: 'Chores',
              icon: Icon(Icons.cleaning_services),
            ),
            BottomNavigationBarItem(
              label: 'Messages',
              icon: Icon(Icons.chat),
            ),
          ],
        ),
      );

  void onPageSwiped;
}
