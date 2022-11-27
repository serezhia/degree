import 'dart:developer';

import '../degree_ui.dart';

class DropDownTextFieldDegree extends StatefulWidget {
  const DropDownTextFieldDegree({
    required this.controller,
    required this.nameField,
    required this.getItems,
    required this.onTapItem,
    required this.pickedItem,
    this.createItem,
    this.deleteItem,
    super.key,
  });

  final TextEditingController controller;

  final String nameField;

  final Future<List<DropDownItemDegree>> Function() getItems;

  final ValueChanged<DropDownItemDegree>? onTapItem;

  final DropDownItemDegree? pickedItem;

  final void Function()? createItem;

  final ValueChanged<DropDownItemDegree>? deleteItem;

  @override
  _DropDownTextFieldDegreeState createState() =>
      _DropDownTextFieldDegreeState();
}

class _DropDownTextFieldDegreeState extends State<DropDownTextFieldDegree> {
  bool hintIsActive = false;

  final _focus = FocusNode();

  List<DropDownItemDegree> localItems = [];

  @override
  void initState() {
    super.initState();
    _focus.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    super.dispose();
    _focus
      ..removeListener(_onFocusChange)
      ..dispose();
  }

  Future<void> _onFocusChange() async {
    setState(() {
      hintIsActive = true;
    });
  }

  Future<void> onChangeTextField(String text) async {
    log(text);
    localItems = await widget.getItems().then(
          (item) => item
              .where(
                (element) =>
                    element.text.toLowerCase().contains(text.toLowerCase()),
              )
              .toList(),
        );

    setState(() {});
  }

  final tiles = <DropDownTileWidget>[];

  List<DropDownTileWidget> _createTiles({
    required List<DropDownItemDegree> items,
  }) {
    tiles.clear();
    if (widget.controller.text.isNotEmpty) {
      for (var i = 0; i < localItems.length; i++) {
        {
          tiles.add(
            DropDownTileWidget(
              delete: widget.deleteItem != null,
              onTapDelete: () {
                widget.deleteItem?.call(localItems[i]);
                setState(() {});
              },
              item: localItems[i],
              onTap: () {
                widget.onTapItem?.call(localItems[i]);
                hintIsActive = false;
                setState(() {});
              },
            ),
          );
        }
      }
      if (widget.createItem != null) {
        tiles.add(
          DropDownTileWidget(
            delete: false,
            item: DropDownItemDegree(
              text: 'Добавить "${widget.controller.text}"',
              value: 'add',
            ),
            onTap: () {
              widget.createItem!();
              hintIsActive = false;
              setState(() {});
            },
          ),
        );
      }
    } else {
      for (var i = 0; i < items.length; i++) {
        tiles.add(
          DropDownTileWidget(
            delete: widget.deleteItem != null,
            onTapDelete: () {
              widget.deleteItem?.call(localItems[i]);
              setState(() {});
            },
            item: items[i],
            onTap: () {
              widget.onTapItem?.call(items[i]);
              hintIsActive = false;
              setState(() {});
            },
          ),
        );
      }
    }
    return tiles;
  }

  @override
  // ignore: prefer_expression_function_bodies
  Widget build(BuildContext context) {
    return Stack(
      children: [
        if (hintIsActive)
          FutureBuilder(
            future: widget.getItems(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final tiles = _createTiles(items: snapshot.data!);
                return Column(
                  children: [
                    const SizedBox(
                      height: 75,
                    ),
                    Container(
                      height: 150,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: const Color.fromARGB(255, 239, 239, 239),
                        ),
                      ),
                      child: ListView.builder(
                        itemBuilder: (context, index) => tiles[index],
                        itemCount: tiles.length,
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                  ],
                );
              } else {
                return Column(
                  children: [
                    const SizedBox(
                      height: 75,
                    ),
                    Container(
                      height: 150,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: const Color.fromARGB(255, 239, 239, 239),
                        ),
                      ),
                      child: const Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                  ],
                );
              }
            },
          ),
        TextFieldDegree(
          textFieldText: widget.nameField,
          obscureText: false,
          focusNode: _focus,
          textEditingController: widget.controller,
          maxlines: 1,
          onChanged: onChangeTextField,
        ),
      ],
    );
  }
}

class DropDownItemDegree {
  const DropDownItemDegree({
    required this.value,
    required this.text,
  });

  final Object value;
  final String text;
}

class DropDownTileWidget extends StatelessWidget {
  const DropDownTileWidget({
    required this.onTap,
    required this.item,
    required this.delete,
    this.onTapDelete,
    super.key,
  });
  final VoidCallback onTap;

  final DropDownItemDegree item;

  final VoidCallback? onTapDelete;

  final bool delete;

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 10,
              ),
              child: Row(
                mainAxisAlignment: onTapDelete == null
                    ? MainAxisAlignment.start
                    : MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Container(
                      color: Colors.white,
                      child: Text(
                        item.text,
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  if (delete)
                    GestureDetector(
                      onTap: onTapDelete,
                      child: Container(
                        width: 30,
                        color: Colors.white,
                        child: const Icon(
                          Icons.delete,
                          color: Colors.black,
                        ),
                      ),
                    ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Divider(
                color: Color.fromARGB(255, 239, 239, 239),
                height: 3,
              ),
            ),
          ],
        ),
      );
}
