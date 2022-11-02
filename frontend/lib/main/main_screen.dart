import 'package:degree_app/auth/auth.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.read<AuthCubit>().getProfile();

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                context.read<AuthCubit>().logOut();
              },
              icon: const Icon(Icons.exit_to_app_rounded))
        ],
        title: const Text('Main'),
      ),
      body: Center(
        child: FutureBuilder(
          future: user,
          builder: ((context, snapshot) {
            if (snapshot.hasData) {
              return Column(
                children: [
                  Text('Hello, ${snapshot.data?.username}'),
                  Text('Your role is ${snapshot.data?.role}'),
                ],
              );
            } else {
              return const CircularProgressIndicator();
            }
          }),
        ),
      ),
    );
  }
}
