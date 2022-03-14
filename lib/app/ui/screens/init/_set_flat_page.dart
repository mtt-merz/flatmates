part of 'init_screen.dart';

class _SetFlatPage extends StatefulWidget {
  final void Function(String) onJoinFlat;
  final void Function() onCreateFlat;

  final bool hasError;

  const _SetFlatPage({
    Key? key,
    required this.onJoinFlat,
    required this.onCreateFlat,
    required this.hasError,
  }) : super(key: key);

  @override
  State<_SetFlatPage> createState() => _SetFlatPageState();
}

class _SetFlatPageState extends State<_SetFlatPage> {
  final controller = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) => ScreenTemplate(
        title: 'Join flat',
        subtitle: 'Enter the invitation code to join an existent flat',
        children: [
          // Join flat
          FieldContainer(
            padding: const EdgeInsets.symmetric(vertical: 24),
            label: 'INVITATION CODE',
            child: TextField(
              controller: controller,
              decoration: const InputDecoration(hintText: '000 000 00'),
            ),
          ),

          // [Error text]
          if (widget.hasError)
            const Text('Invitation code not recognized, please check it or ask for a new one'),

          ElevatedButton(
            child: const SizedBox(
                width: double.infinity, child: Text('CONTINUE', textAlign: TextAlign.center)),
            onPressed: () => widget.onJoinFlat(controller.value.text),
          ),

          const SizedBox(width: double.infinity, height: 60, child: Center(child: Text('or'))),

          // Create a new flat
          OutlinedButton(
            child: const SizedBox(
                width: double.infinity,
                child: Text('CREATE A NEW FLAT', textAlign: TextAlign.center)),
            onPressed: widget.onCreateFlat,
          ),
        ],
      );
}
