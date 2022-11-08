import 'package:degree_app/degree_ui/degree_ui.dart';

class ToggleDegree extends StatefulWidget {
  const ToggleDegree({
    required this.items,
    required this.currentIndex,
    required this.onTap,
    super.key,
  });

  final List<ToggleItem> items;
  final int currentIndex;
  final ValueChanged<int> onTap;

  @override
  State<ToggleDegree> createState() => _ToggleDegreeState();
}

class _ToggleDegreeState extends State<ToggleDegree> {
  List<ToggleItemWidget> _createItemWidgets() {
    final tiles = <ToggleItemWidget>[];
    for (var i = 0; i < widget.items.length; i++) {
      tiles.add(
        ToggleItemWidget(
          onTap: () {
            widget.onTap.call(i);
          },
          item: widget.items[i],
          isActive: widget.currentIndex == i,
        ),
      );
    }
    return tiles;
  }

  @override
  Widget build(BuildContext context) {
    if (MediaQuery.of(context).size.width < 700) {
      return Expanded(
        child: Container(
          height: 52,
          decoration: BoxDecoration(
            color: const Color(0xFFFFFFFF),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: _createItemWidgets(),
            ),
          ),
        ),
      );
    } else {
      return Container(
        constraints: const BoxConstraints(maxWidth: 350, maxHeight: 55),
        height: 52,
        decoration: BoxDecoration(
          color: const Color(0xFFFFFFFF),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            children: _createItemWidgets(),
          ),
        ),
      );
    }
  }
}

class ToggleItemWidget extends StatelessWidget {
  const ToggleItemWidget({
    required this.onTap,
    required this.item,
    required this.isActive,
    super.key,
  });

  final VoidCallback onTap;
  final ToggleItem item;
  final bool isActive;

  @override
  Widget build(BuildContext context) => Expanded(
        child: GestureDetector(
          onTap: onTap,
          child: DecoratedBox(
            decoration: BoxDecoration(
              color:
                  isActive ? const Color(0xFF000000) : const Color(0xFFFFFFFF),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Text(
                item.lable,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: isActive
                      ? const Color(0xFFFFFFFF)
                      : const Color(0xFF000000),
                ),
              ),
            ),
          ),
        ),
      );
}

class ToggleItem {
  ToggleItem({
    required this.lable,
  });

  final String lable;
}
