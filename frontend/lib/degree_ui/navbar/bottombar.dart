import 'package:degree_app/degree_ui/degree_ui.dart';

class BottomBarDegree extends StatefulWidget {
  const BottomBarDegree({
    required this.items,
    required this.onTapItem,
    this.currentIndex = 0,
    super.key,
  });

  BottomBarDegree copyWith({
    List<BottomBarItem>? items,
    ValueChanged<int>? onTapItem,
    int? currentIndex,
  }) =>
      BottomBarDegree(
        items: items ?? this.items,
        currentIndex: currentIndex ?? this.currentIndex,
        onTapItem: onTapItem ?? this.onTapItem,
      );

  /// "Test doc comment" List of [BottomBarDegree] in the sidebar
  final List<BottomBarItem> items;

  final ValueChanged<int>? onTapItem;

  final int currentIndex;

  @override
  State<BottomBarDegree> createState() => _BottomBarDegreeState();
}

class _BottomBarDegreeState extends State<BottomBarDegree> {
  List<Widget> _createTiles() {
    final tiles = <Widget>[];
    for (var i = 0; i < widget.items.length; i++) {
      tiles.add(
        BottomBarItemWidget(
          item: widget.items[i],
          onTap: () {
            widget.onTapItem?.call(i);
          },
          isSelected: widget.currentIndex == i,
        ),
      );
    }
    return tiles;
  }

  @override
  Widget build(BuildContext context) => Row(
        children: [
          Expanded(
            child: Container(
              height: 64 + MediaQuery.of(context).padding.bottom,
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 17),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: _createTiles(),
                ),
              ),
            ),
          )
        ],
      );
}

class BottomBarItemWidget extends StatelessWidget {
  const BottomBarItemWidget({
    required this.isSelected,
    required this.onTap,
    required this.item,
    super.key,
  });

  final BottomBarItem item;

  final bool isSelected;

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => Expanded(
        child: GestureDetector(
          onTap: onTap,
          child: Container(
            height: 64 + MediaQuery.of(context).padding.bottom,
            color: Colors.white,
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.bottom == 0 ? 0 : 7,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: 40,
                  child: Icon(
                    item.icon,
                    size: 24,
                    color: isSelected ? Colors.black : Colors.grey,
                  ),
                ),
                Text(
                  item.title,
                  maxLines: 1,
                  style: TextStyle(
                    color: isSelected ? Colors.black : Colors.grey,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}

class BottomBarItem {
  const BottomBarItem({
    required this.icon,
    required this.title,
  });

  final IconData icon;
  final String title;
}
