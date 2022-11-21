import 'package:degree_app/degree_ui/degree_ui.dart';

class SideBarDegree extends StatefulWidget {
  const SideBarDegree({
    required this.items,
    required this.onTapItem,
    required this.leading,
    this.isExpanded = false,
    this.currentIndex = 0,
    this.onTapLeading,
    super.key,
  });

  SideBarDegree copyWith({
    List<SideBarItem>? items,
    bool? isExpanded,
    ValueChanged<int>? onTapItem,
    int? currentIndex,
    SideBarLeading? leading,
    VoidCallback? onTapLeading,
  }) =>
      SideBarDegree(
        isExpanded: isExpanded ?? this.isExpanded,
        leading: leading ?? this.leading,
        items: items ?? this.items,
        currentIndex: currentIndex ?? this.currentIndex,
        onTapItem: onTapItem ?? this.onTapItem,
        onTapLeading: onTapLeading ?? this.onTapLeading,
      );

  /// "Test doc comment" List of [SideBarDegree] in the sidebar
  final List<SideBarItem> items;

  final bool isExpanded;

  final ValueChanged<int>? onTapItem;

  final int currentIndex;

  final SideBarLeading leading;

  final VoidCallback? onTapLeading;

  @override
  State<SideBarDegree> createState() => _SideBarDegreeState();
}

class _SideBarDegreeState extends State<SideBarDegree> {
  final Widget leading = const SizedBox();
  List<Widget> _createTiles() {
    final tiles = <Widget>[];
    for (var i = 0; i < widget.items.length; i++) {
      tiles.add(
        SideBarItemWidget(
          item: widget.items[i],
          onTap: () {
            widget.onTapItem?.call(i);
          },
          isExpanded: widget.isExpanded,
          isSelected: widget.currentIndex == i,
        ),
      );
    }
    return tiles;
  }

  Widget _createLeading() => SideBarLeadingWidget(
        leading: widget.leading,
        isExpanded: widget.isExpanded,
        onTap: widget.onTapLeading,
      );

  @override
  Widget build(BuildContext context) => Column(
        children: [
          Container(
            width: widget.isExpanded ? 200 : 64,
            height: 64,
            decoration: const BoxDecoration(
              color: Color(0xFFFFFFFF),
              border: Border(
                bottom: BorderSide(color: Color(0xFFF4F4F5), width: 2),
                right: BorderSide(color: Color(0xFFF4F4F5), width: 2),
              ),
            ),
            child: _createLeading(),
          ),
          Expanded(
            child: DecoratedBox(
              decoration: const BoxDecoration(
                color: Colors.white,
                border: Border(
                  right: BorderSide(color: Color(0xFFF4F4F5), width: 2),
                ),
              ),
              child: SingleChildScrollView(
                child: (widget.isExpanded)
                    ? Container(
                        width: 198,
                        color: Colors.white,
                        child: Column(
                          children: _createTiles(),
                        ),
                      )
                    : Container(
                        width: 64,
                        color: Colors.white,
                        child: Column(
                          children: _createTiles(),
                        ),
                      ),
              ),
            ),
          )
        ],
      );
}

class SideBarItemWidget extends StatelessWidget {
  const SideBarItemWidget({
    required this.isExpanded,
    required this.isSelected,
    required this.onTap,
    required this.item,
    super.key,
  });

  final SideBarItem item;

  final bool isExpanded;

  final bool isSelected;

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: onTap,
        child: Container(
          height: 64,
          color: isSelected ? const Color(0xFFF8F8F8) : Colors.white,
          child: isExpanded
              ? Stack(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 25),
                            child: Icon(
                              item.icon,
                              size: 24,
                              color: isSelected ? Colors.black : Colors.grey,
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 10, top: 2),
                              child: Text(
                                item.title,
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'Gilroy',
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (isSelected)
                      Align(
                        alignment: Alignment.centerRight,
                        child: Container(
                          width: 4,
                          decoration: const BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(4),
                              bottomLeft: Radius.circular(4),
                            ),
                          ),
                        ),
                      ),
                  ],
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Stack(
                        children: [
                          Align(
                            child: Icon(
                              item.icon,
                              size: 24,
                              color: isSelected ? Colors.black : Colors.grey,
                            ),
                          ),
                          if (isSelected)
                            Align(
                              alignment: Alignment.centerRight,
                              child: Container(
                                width: 4,
                                decoration: const BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(4),
                                    bottomLeft: Radius.circular(4),
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    )
                  ],
                ),
        ),
      );
}

class SideBarLeadingWidget extends StatelessWidget {
  const SideBarLeadingWidget({
    required this.leading,
    required this.isExpanded,
    required this.onTap,
    super.key,
  });

  final bool isExpanded;
  final SideBarLeading leading;

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    if (isExpanded) {
      return GestureDetector(
        onTap: onTap,
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 22),
              child: SvgPicture.asset(
                leading.pathLogo,
                width: 30,
                height: 30,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, top: 3),
              child: Text(
                leading.title,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Gilroy',
                ),
              ),
            ),
          ],
        ),
      );
    } else {
      return GestureDetector(
        onTap: onTap,
        child: Center(
          child: SvgPicture.asset(
            leading.pathLogo,
            width: 30,
            height: 30,
          ),
        ),
      );
    }
  }
}

class SideBarLeading {
  const SideBarLeading({
    required this.pathLogo,
    required this.title,
  });

  final String pathLogo;

  final String title;
}

class SideBarItem {
  const SideBarItem({
    required this.icon,
    required this.title,
  });

  final IconData icon;
  final String title;
}
