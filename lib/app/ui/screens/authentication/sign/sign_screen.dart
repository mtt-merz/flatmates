import 'package:flatmates/app/ui/screens/authentication/sign/sign_cubit.dart';
import 'package:flatmates/app/ui/widget/field_container.dart';
import 'package:flatmates/app/ui/widget/screen_template.dart';
import 'package:flatmates/app/ui/widget/submit_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part '_sign_in_page.dart';

part '_sign_up_page.dart';

class SignScreen extends StatefulWidget {
  final int _initialPage;
  final bool _canChangePage;

  const SignScreen.signUp({Key? key})
      : _initialPage = 1,
        _canChangePage = true,
        super(key: key);

  const SignScreen.signIn({Key? key})
      : _initialPage = 0,
        _canChangePage = true,
        super(key: key);

  const SignScreen.check({Key? key})
      : _initialPage = 0,
        _canChangePage = false,
        super(key: key);

  @override
  State<SignScreen> createState() => _SignScreenState();
}

class _SignScreenState extends State<SignScreen> {
  late final PageController controller;

  @override
  initState() {
    super.initState();
    controller = PageController(initialPage: widget._initialPage);
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
          _SignInPage(
              goToSignUpScreen:
                  widget._canChangePage ? () => goToPage(1) : null),
          _SignUpPage(
              goToSignInScreen:
                  widget._canChangePage ? () => goToPage(0) : null),
        ],
      );

  void goToPage(int page) => controller.jumpToPage(page);
}
