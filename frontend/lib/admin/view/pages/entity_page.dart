// import 'package:degree_app/degree_ui/degree_ui.dart';
// import 'package:degree_app/degree_ui/toggle/toggle.dart';

// class EntityPage extends StatelessWidget {
//   const EntityPage({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final currentIndex = context.watch<UserPageCubit>().currentIndex;
//     return Column(
//       children: [
//         Row(
//           children: [
//             ToggleDegree(
//               items: [
//                 ToggleItem(lable: 'Группы'),
//                 ToggleItem(lable: 'Предметы'),
//               ],
//               currentIndex: currentIndex,
//               onTap: (value) {
//                 context.read<UserPageCubit>().setIndex(value);
//               },
//             ),
//             const SizedBox(
//               width: 10,
//             ),
//             GestureDetector(
//               onTap: () {},
//               child: Container(
//                 width: 52,
//                 height: 52,
//                 decoration: BoxDecoration(
//                   color: const Color(0xFFFFFFFF),
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//                 child: const Icon(Icons.person_add_alt_1_outlined),
//               ),
//             ),
//           ],
//         ),
//         const SizedBox(
//           height: 15,
//         ),
//         if (currentIndex == 0) const GroupsList(),
//         if (currentIndex == 1) const SubjectsList(),
//       ],
//     );
//   }
// }

// class GroupsList extends StatelessWidget {
//   const GroupsList({super.key});

//   @override
//   Widget build(BuildContext context) => const Expanded(
//         child: CustomScrollView(
//           slivers: [
//             SliverFillRemaining(
//               hasScrollBody: false,
//               child: ColoredBox(
//                 color: Color(0xFFFFFFFF),
//                 child: Center(
//                   child: Text('Список групп пуст'),
//                 ),
//               ),
//             )
//           ],
//         ),
//       );
// }

// class SubjectsList extends StatelessWidget {
//   const SubjectsList({super.key});

//   @override
//   Widget build(BuildContext context) => const Expanded(
//         child: CustomScrollView(
//           slivers: [
//             SliverFillRemaining(
//               hasScrollBody: false,
//               child: ColoredBox(
//                 color: Color(0xFFFFFFFF),
//                 child: Center(
//                   child: Text('Список предметов пуст'),
//                 ),
//               ),
//             )
//           ],
//         ),
//       );
// }
