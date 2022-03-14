part of 'init_screen.dart';

class _SetNamePage extends StatefulWidget {
  final void Function(String) setName;
  final bool hasError;

  const _SetNamePage({Key? key, required this.setName, required this.hasError}) : super(key: key);

  @override
  State<_SetNamePage> createState() => _SetNamePageState();
}

class _SetNamePageState extends State<_SetNamePage> {
  final controller = TextEditingController();

  @override
  void dispose() {
    super.dispose();

    controller.dispose();
  }

  @override
  Widget build(BuildContext context) => ScreenTemplate(
        title: 'Set your name',
        subtitle: 'You will be able to change those info later',
        children: [
          FieldContainer(
              label: 'NAME*',
              // padding: EdgeInsets.symmetric(vertical: SizeUtils.of(context).getScaledHeight(3)),
              child: TextField(
                controller: controller,
                autofocus: true,
                textCapitalization: TextCapitalization.words,
                onChanged: (_) => setState(() {}),
                onSubmitted: submit,
              )),

          // [Error text]
          if (widget.hasError) const Text('Name not accepted, please check it or find a new one'),

          ElevatedButton(
            child: const Text('CONFIRM'),
            onPressed: controller.value.text.isNotEmpty ? submit : null,
          )
        ],
      );

  void submit([String? value]) {
    final name = value ?? controller.value.text;
    widget.setName(name);
  }
}
