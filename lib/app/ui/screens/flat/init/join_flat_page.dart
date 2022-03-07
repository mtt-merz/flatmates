part of 'flat_init_screen.dart';

class JoinFlatPage extends StatelessWidget {
  final void Function(String) onJoinFlat;
  final void Function() onCreateFlat;

  JoinFlatPage({Key? key, required this.onJoinFlat, required this.onCreateFlat}) : super(key: key);

  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) => Padding(
      padding: SizeUtils.of(context).defaultPadding,
      child: ListView(
        children: [
          // Join flat
          Text('Join Flat',
              textAlign: TextAlign.start, style: Theme.of(context).textTheme.headline4),
          const SizedBox(height: 8),
          const Text('Enter the invitation code to join an existent flat'),
          TextInputFieldContainer(
            padding: const EdgeInsets.symmetric(vertical: 24),
            label: 'INVITATION CODE',
            field: TextField(
              controller: controller,
              decoration: const InputDecoration(hintText: '000 000 00'),
            ),
          ),
          ElevatedButton(
            child: const SizedBox(
                width: double.infinity, child: Text('CONTINUE', textAlign: TextAlign.center)),
            onPressed: () => onJoinFlat(controller.value.text),
          ),

          const SizedBox(width: double.infinity, height: 60, child: Center(child: Text('or'))),

          // Create a new flat
          OutlinedButton(
            child: const SizedBox(
                width: double.infinity,
                child: Text('CREATE A NEW FLAT', textAlign: TextAlign.center)),
            onPressed: onCreateFlat,
          ),
        ],
      ));
}
