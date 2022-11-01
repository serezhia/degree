// ignore_for_file: avoid_redundant_argument_values

import 'package:flutter/material.dart';

class TextFieldDegree extends StatelessWidget {
  const TextFieldDegree({
    super.key,
    required this.textFieldText,
    required this.obscureText,
    this.textEditingController,
    required this.maxlines,
  });
  final String textFieldText;
  final bool obscureText;
  final TextEditingController? textEditingController;
  final int maxlines;

  @override
  Widget build(BuildContext context) {
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
          child: TextField(
            controller: textEditingController,
            cursorColor: Colors.black,
            cursorWidth: 2,
            obscureText: obscureText,
            style: Theme.of(context).textTheme.bodyText1,
            textInputAction: TextInputAction.next,
            maxLines: maxlines,
            decoration: InputDecoration(
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
