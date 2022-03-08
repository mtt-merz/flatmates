part of 'initialize_flat_screen.dart';

class _SetUsernamePage extends StatefulWidget {
  final Function(String) onUsernameSet;

  const _SetUsernamePage({Key? key, required this.onUsernameSet}) : super(key: key);

  @override
  State<_SetUsernamePage> createState() => _SetUsernamePageState();
}

class _SetUsernamePageState extends State<_SetUsernamePage> {
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) => Padding(
        padding: SizeUtils.of(context).defaultPadding,
        child: ListView(
          children: [
            Text('Your profile',
                textAlign: TextAlign.start, style: Theme.of(context).textTheme.headline5),
            const SizedBox(height: 8),
            const Text('You will be able to change those info later'),

            // Username
            TextFieldContainer(
                label: 'USERNAME*',
                padding: EdgeInsets.symmetric(vertical: SizeUtils.of(context).getScaledHeight(3)),
                field: TextField(
                  controller: controller,
                  textCapitalization: TextCapitalization.words,
                )),

            ElevatedButton(
              child: const Text('OK'),
              onPressed: () => widget.onUsernameSet(controller.value.text),
            )
          ],
        ),
      );
}
