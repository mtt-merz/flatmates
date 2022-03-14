import 'package:flatmates/app/ui/screens/authentication/sign/sign_cubit.dart';
import 'package:flatmates/app/ui/widget/field_container.dart';
import 'package:flatmates/app/ui/widget/screen_template.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final cubit = GetIt.I<SignCubit>();

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => ScreenTemplate(
        title: 'New account',
        subtitle: 'Create a personal account and join the flatmates family!',
        // onSubmit: () {},
        onClose: Navigator.of(context).pop,
        children: [
          FieldContainer(
            label: 'e-mail',
            child: TextField(
              onChanged: (value) => cubit.mail = value,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
            ),
          ),
          FieldContainer(
            label: 'password',
            description: 'The password should be at least 6 characters long.',
            child: TextField(
              onChanged: (value) => cubit.password = value,
              keyboardType: TextInputType.visiblePassword,
              textInputAction: TextInputAction.next,
            ),
          ),
          FieldContainer(
            label: 'repeat password',
            child: TextField(
              onChanged: (value) => cubit.repeatPassword = value,
              onSubmitted: (_) => cubit.submit(Navigator.of(context).pop),
              keyboardType: TextInputType.visiblePassword,
              textInputAction: TextInputAction.done,
            ),
          ),
          BlocBuilder(
              bloc: cubit,
              builder: (context, state) {
                if (state is Editing && state.hasError)
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    child: Text('We encountered an issue, please check the fields.',
                        textAlign: TextAlign.center,
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall!
                            .copyWith(color: Theme.of(context).colorScheme.error)),
                  );
                return const SizedBox();
              }),
          BlocBuilder(
              bloc: cubit,
              builder: (context, state) {
                if (state is Loading)
                  return const ElevatedButton(
                    onPressed: null,
                    child: CircularProgressIndicator(),
                  );

                return ElevatedButton(
                  child: const Text('CONTINUE'),
                  onPressed: (state as Editing).canSubmit
                      ? () => cubit.submit(Navigator.of(context).pop)
                      : null,
                );
              })
        ],
      );
}
