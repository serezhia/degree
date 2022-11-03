// ignore_for_file: avoid_redundant_argument_values

import 'package:degree_app/app/app.dart';

class TextFieldDegree extends StatelessWidget {
  const TextFieldDegree({
    super.key,
    required this.textFieldText,
    required this.obscureText,
    this.textEditingController,
    required this.maxlines,
    this.validator,
  });
  final String textFieldText;
  final bool obscureText;
  final TextEditingController? textEditingController;
  final int maxlines;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    // ignore: no_leading_underscores_for_local_identifiers
    String? _emptyFieldValidator(String? value) {
      if (value == null || value.isEmpty) {
        return AppLocalizations.of(context).requiredFieldText;
      }
      return null;
    }

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(10, 0, 10, 5),
          child: Align(
            alignment: Alignment.topLeft,
            child: Text(
              textFieldText,
              style: Theme.of(context).textTheme.headline1,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 15),
          child: TextFormField(
            validator: validator ?? _emptyFieldValidator,
            controller: textEditingController,
            cursorColor: Colors.black,
            cursorWidth: 2,
            obscureText: obscureText,
            style: Theme.of(context).textTheme.bodyText1,
            textInputAction: TextInputAction.next,
            maxLines: maxlines,
            decoration: InputDecoration(
              errorStyle: Theme.of(context)
                  .textTheme
                  .subtitle1
                  ?.copyWith(color: Colors.red),
              contentPadding: const EdgeInsets.all(10),
              filled: true,
              fillColor: const Color(0xFFFAFAFA),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Color(0xFFF4F4F4),
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Color(0xFFF4F4F4),
                ),
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            enabled: true,
          ),
        ),
      ],
    );
  }
}
