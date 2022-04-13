part of 'sign_screen.dart';

class _SignUpPage extends StatefulWidget {
  final VoidCallback? goToSignInScreen;

  const _SignUpPage({Key? key, required this.goToSignInScreen}) : super(key: key);

  @override
  State<_SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<_SignUpPage> {
  final cubit = SignUpCubit();

  final TextEditingController mailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController repeatPasswordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    cubit.close();

    mailController.dispose();
    passwordController.dispose();
    repeatPasswordController.dispose();
  }

  @override
  Widget build(BuildContext context) => BlocBuilder(
      bloc: cubit,
      builder: (context, state) {
        if (state is! Editing) throw Exception();
        return ScreenTemplate(
          title: 'New account',
          subtitle: 'Create a personal account and join the flatmates family!',
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

            //Password
            FieldContainer(
              label: 'password',
              description: 'The password should be at least 6 characters long.',
              child: TextField(
                controller: passwordController,
                onChanged: (_) => setState(() {}),
                keyboardType: TextInputType.visiblePassword,
                textInputAction: TextInputAction.next,
              ),
            ),

            // Repeat password
            FieldContainer(
              label: 'repeat password',
              child: TextField(
                controller: repeatPasswordController,
                onChanged: (_) => setState(() {}),
                onEditingComplete: submit,
                keyboardType: TextInputType.visiblePassword,
                textInputAction: TextInputAction.done,
              ),
            ),

            // Login
            if (widget.goToSignInScreen != null)
              Row(children: [
                const Text('You already have an account?'),
                TextButton(
                  child: const Text('Login'),
                  onPressed: widget.goToSignInScreen,
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

  void submit() {
    return cubit.registerWithEmailAndPassword(
      email: mailController.value.text,
      password: passwordController.value.text,
      repeatPassword: repeatPasswordController.value.text,
      onSucceed: () => Navigator.of(context).pop(true),
    );
  }
}
