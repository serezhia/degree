import '../../../teacher.dart';

class ActionPanelBuilder extends StatelessWidget {
  const ActionPanelBuilder({super.key});

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<ActionPanelCubit, ActionPanelState>(
          builder: (context, state) {
        return const SizedBox();
      });
}
