part of 'sign_screen.dart';

class _SignInPage extends StatefulWidget {
  final VoidCallback? goToSignUpScreen;

  const _SignInPage({Key? key, required this.goToSignUpScreen})
      : super(key: key);

  @override
  State<_SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<_SignInPage> {
  final cubit = SignInCubit();

  final TextEditingController mailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool hidePassword = true;

  @override
  void dispose() {
    super.dispose();
    cubit.close();

    mailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) => BlocBuilder(
      bloc: cubit,
      builder: (context, state) {
        if (state is! Editing) throw Exception();
        return ScreenTemplate(
          title: 'Login',
          subtitle: 'Enter your account',
          onPop: Navigator.of(context).pop,
          children: [
            // Email
            FieldContainer(
              label: 'e-mail',
              child: TextField(
                controller: mailController,
                onChanged: (_) => setState(() {}),
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
              ),
            ),

            // Password
            FieldContainer(
              label: 'password',
              child: TextField(
                controller: passwordController,
                onChanged: (_) => setState(() {}),
                keyboardType: TextInputType.visiblePassword,
                textInputAction: TextInputAction.done,
                obscureText: hidePassword,
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    icon: Icon(hidePassword
                        ? Icons.visibility_outlined
                        : Icons.visibility_off_outlined),
                    onPressed: () =>
                        setState(() => hidePassword = !hidePassword),
                  ),
                ),
                onSubmitted: (_) => submit(),
              ),
            ),

            // Register account
            if (widget.goToSignUpScreen != null)
              Row(children: [
                const Text('You don\'t have an account?'),
                TextButton(
                  child: const Text('Sign up'),
                  onPressed: widget.goToSignUpScreen,
                ),
              ]),
          ],
          footer: SubmitButton(
            child: const Text('CONTINUE'),
            onPressed: submit,
            loading: state.isLoading,
            error: state.error,
          ),
        );
      });

  void submit() => cubit.loginWithEmailAndPassword(
        email: mailController.value.text,
        password: passwordController.value.text,
        onSucceed: (userId) => Navigator.of(context).pop(userId),
      );
}
