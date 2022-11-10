// import 'package:degree_app/admin/cubit/action_panel_cubit.dart';
// import 'package:degree_app/degree_ui/degree_ui.dart';

// class AddStudentActionPanel extends StatelessWidget {
//   const AddStudentActionPanel({super.key});

//   @override
//   Widget build(BuildContext context) => ActionPanel(
//         leading: ActionPanelItem(
//           icon: Icons.arrow_back,
//           onTap: () {
//             context.read<ActionPanelCubit>().closePanel();
//           },
//         ),
//         title: 'Добавить студента',
//         body: CustomScrollView(
//           slivers: [
//             SliverFillRemaining(
//               hasScrollBody: false,
//               child: ColoredBox(
//                 color: Colors.white,
//                 child: Padding(
//                   padding: const EdgeInsets.all(25),
//                   child: Column(
//                     children: const [
//                       TextFieldDegree(
//                         textFieldText: 'ФИО',
//                         obscureText: false,
//                         maxlines: 1,
//                       ),
//                       TextFieldDegree(
//                         textFieldText: 'Группа',
//                         obscureText: false,
//                         maxlines: 1,
//                       ),
//                       TextFieldDegree(
//                         textFieldText: 'Подруппа',
//                         obscureText: false,
//                         maxlines: 1,
//                       ),
//                       TextFieldDegree(
//                         textFieldText: 'Примечание',
//                         obscureText: false,
//                         maxlines: 5,
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             )
//           ],
//         ),
//         actions: [
//           ActionPanelItem(
//             icon: Icons.save,
//             onTap: () {},
//           ),
//         ],
//       );
// }
