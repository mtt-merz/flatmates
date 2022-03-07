part of 'flat_init_screen.dart';

class _CreateFlatPage extends StatefulWidget {
  final FlatInitCubit cubit;

  const _CreateFlatPage(this.cubit, {Key? key}) : super(key: key);

  @override
  State<_CreateFlatPage> createState() => _CreateFlatPageState();
}

class _CreateFlatPageState extends State<_CreateFlatPage> {
  int currentStep = 0;

  @override
  Widget build(BuildContext context) => Padding(
        padding: SizeUtils.of(context).defaultPadding,
        child: ListView(
          children: [
            Text('Create Flat',
                textAlign: TextAlign.start, style: Theme.of(context).textTheme.headline4),
            const SizedBox(height: 8),
            const Text('You will be able to change those info when you want'),
            Stepper(
              elevation: 0,
              type: StepperType.vertical,
              currentStep: currentStep,
              // margin: EdgeInsets.zero,

              controlsBuilder: (context, details) {
                details.currentStep;

                return Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    TextButton(
                      child: const Text('CANCEL'),
                      onPressed: () {},
                    ),
                    TextButton(
                      child: const Text('CONTINUE'),
                      onPressed: () {},
                    )
                  ],
                );
              },

              steps: [
                // Set NICKNAME
                Step(
                    title: const Text('What\'s your name?'),
                    subtitle: const Text('Your name in the context of this flat'),
                    content: TextInputFieldContainer(
                      label: 'NICKNAME',
                      field: TextField(
                        controller: TextEditingController(),
                      ),
                    ),
                    isActive: true),

                // Set MATES
                Step(
                  title: const Text('Which are the other mates?'),
                  content: TextInputFieldContainer(
                    label: 'NICKNAME',
                    field: TextField(
                      controller: TextEditingController(),
                    ),
                  ),
                ),

                // Set COMMON SPACES
                Step(
                  title: const Text('Which are the flat common spaces?'),
                  content: TextInputFieldContainer(
                    label: 'NICKNAME',
                    field: TextField(
                      controller: TextEditingController(),
                    ),
                  ),
                ),
              ],
            ),

          ],
        ),
      );
}
