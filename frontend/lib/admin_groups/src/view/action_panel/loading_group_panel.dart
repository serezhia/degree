import '../../../admin_groups.dart';

class LoadingGroupActionPanel extends StatelessWidget {
  const LoadingGroupActionPanel({super.key});

  @override
  Widget build(BuildContext context) => const ColoredBox(
        color: Colors.white,
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
}
