// import 'package:degree_app/admin/cubit/action_panel_cubit.dart';
// import 'package:degree_app/auth/auth.dart';

// class ProfileActionPanel extends StatelessWidget {
//   const ProfileActionPanel({super.key});

//   @override
//   Widget build(BuildContext context) => ActionPanel(
//         leading: ActionPanelItem(
//           icon: Icons.close,
//           onTap: () {
//             context.read<ActionPanelCubit>().closePanel();
//           },
//         ),
//         title: 'Профиль',
//         body: const CustomScrollView(
//           slivers: [
//             SliverFillRemaining(
//               hasScrollBody: false,
//               child: ColoredBox(
//                 color: Colors.white,
//                 child: Padding(
//                   padding: EdgeInsets.all(25),
//                   child: ColoredBox(
//                     color: Color(0xFF000000),
//                   ),
//                 ),
//               ),
//             )
//           ],
//         ),
//         actions: [
//           ActionPanelItem(
//             icon: Icons.exit_to_app_rounded,
//             onTap: () {
//               context.read<AuthCubit>().logOut();
//             },
//           ),
//         ],
//       );
// }
