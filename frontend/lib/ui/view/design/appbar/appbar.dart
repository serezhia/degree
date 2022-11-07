import 'package:degree_app/degree_ui/degree_ui.dart';

class AppBarDegree extends StatelessWidget implements PreferredSizeWidget {
  const AppBarDegree({
    super.key,
    this.title,
    this.leading,
    this.actions,
  });

  AppBarDegree copyWith({
    Key? key,
    String? title,
    Widget? leading,
    List<Widget>? actions,
  }) {
    return AppBarDegree(
      key: key ?? this.key,
      title: title ?? this.title,
      leading: leading ?? this.leading,
      actions: actions ?? this.actions,
    );
  }

  final String? title;
  final Widget? leading;
  final List<Widget>? actions;
  @override
  Size get preferredSize => const Size(double.infinity, 64);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64,
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(color: Color(0xFFF4F4F5), width: 2),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                if (leading != null) leading!,
                if (title != null)
                  Text(
                    title!,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Gilroy',
                    ),
                  ),
              ],
            ),
            Row(
              children: (actions != null) ? actions! : [],
            ),
          ],
        ),
      ),
    );
  }
}
