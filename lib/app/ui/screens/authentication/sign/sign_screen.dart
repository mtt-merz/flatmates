import 'package:flatmates/app/ui/screens/authentication/sign/sign_cubit.dart';
import 'package:flatmates/app/ui/widget/field_container.dart';
import 'package:flatmates/app/ui/widget/screen_template.dart';
import 'package:flatmates/app/ui/widget/submit_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part '_sign_in_page.dart';

part '_sign_up_page.dart';

class SignScreen extends StatefulWidget {
  final int initialPage;
  final bool canChangePage;

  const SignScreen.signUp({Key? key})
      : initialPage = 1,
        canChangePage = true,
        super(key: key);

  const SignScreen.signIn({Key? key})
      : initialPage = 0,
        canChangePage = true,
        super(key: key);

  const SignScreen.check({Key? key})
      : initialPage = 0,
        canChangePage = false,
        super(key: key);

  @override
  State<SignScreen> createState() => _SignScreenState();
}

class _SignScreenState extends State<SignScreen> {
  late final PageController controller;

  @override
  initState() {
    super.initState();
    controller = PageController(initialPage: widget.initialPage);
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) => PageView(
        controller: controller,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          _SignInPage(goToSignUpScreen: widget.canChangePage ? () => goToPage(1) : null),
          _SignUpPage(goToSignInScreen: widget.canChangePage ? () => goToPage(0) : null),
        ],
      );

  void goToPage(int page) => controller.jumpToPage(page);
}
