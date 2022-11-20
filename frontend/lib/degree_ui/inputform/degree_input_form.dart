import 'package:degree_app/degree_ui/degree_ui.dart';
import 'package:degree_app/l10n/l10n.dart';
import 'package:flutter/services.dart';

class TextFieldDegree extends StatelessWidget {
  const TextFieldDegree({
    required this.textFieldText,
    required this.obscureText,
    required this.maxlines,
    this.validator,
    this.textEditingController,
    this.onChanged,
    this.autofocus,
    this.onTap,
    this.onEditingComplete,
    this.focusNode,
    this.inputFormatters,
    this.keyboardType,
    super.key,
  });
  final String textFieldText;
  final bool obscureText;
  final TextEditingController? textEditingController;
  final int maxlines;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final bool? autofocus;
  final void Function()? onTap;
  final void Function()? onEditingComplete;
  final FocusNode? focusNode;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? keyboardType;

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
            keyboardType: keyboardType,
            inputFormatters: inputFormatters,
            focusNode: focusNode,
            onTap: onTap,
            onEditingComplete: onEditingComplete,
            autofocus: autofocus ?? false,
            onChanged: onChanged,
            validator: validator ?? _emptyFieldValidator,
            controller: textEditingController,
            cursorColor: Colors.black,
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
