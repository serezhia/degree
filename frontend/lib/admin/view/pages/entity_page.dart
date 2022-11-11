import 'package:degree_app/admin/cubit/pages/entities/entity_page_cubit.dart';
import 'package:degree_app/admin_subjects/admin_subjects.dart';

class EntityPage extends StatelessWidget {
  const EntityPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final currentIndex = context.watch<EntityPageCubit>().currentIndex;
    return Column(
      children: [
        Row(
          children: [
            ToggleDegree(
              items: [
                ToggleItem(lable: 'Группы'),
                ToggleItem(lable: 'Предметы'),
              ],
              currentIndex: currentIndex,
              onTap: (value) {
                context.read<EntityPageCubit>().setIndex(value);
              },
            ),
            const SizedBox(
              width: 10,
            ),
            GestureDetector(
              onTap: () {
                if (context.read<EntitiesState>().currentIndex == 0) {
                  context.read<ActionPanelCubit>().openSubjectPanel();
                  context.read<SubjectPanelCubit>().openAddPanel();
                }
              },
              child: Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  color: const Color(0xFFFFFFFF),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.person_add_alt_1_outlined),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 15,
        ),
        if (currentIndex == 0) const GroupList(),
        if (currentIndex == 1) const SubjectList(),
      ],
    );
  }
}

class EntitiesState extends ChangeNotifier {
  final PageStorageKey<String> listSubjectsKey =
      const PageStorageKey('list_subjects');

  ScrollController scrollTeacherController = ScrollController();

  int _currentIndex = 0;

  int get currentIndex => _currentIndex;

  set currentIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }
}

class GroupList extends StatelessWidget {
  const GroupList({super.key});

  @override
  Widget build(BuildContext context) => const Expanded(
        child: CustomScrollView(
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: ColoredBox(
                color: Color(0xFFFFFFFF),
                child: Center(
                  child: Text('Список групп пуст'),
                ),
              ),
            )
          ],
        ),
      );
}
