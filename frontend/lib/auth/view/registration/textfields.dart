import 'package:degree_app/auth/view/registration/registration_code_screen.dart';
import 'package:degree_app/auth/view/registration/registration_screen.dart';
import 'package:degree_app/auth/view/registration/validates.dart';
import 'package:degree_app/degree_ui/degree_ui.dart';
import 'package:degree_app/l10n/l10n.dart';
import 'package:flutter/services.dart';

class RegisterCodeInput extends StatelessWidget {
  RegisterCodeInput({super.key});

  final firtInputfocus = FocusNode();
  final secondInputfocus = FocusNode();
  final thirdInputfocus = FocusNode();
  final bool allOkay = false;
  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 5),
            child: Text(
              AppLocalizations.of(context).registrationCodeText,
              style: Theme.of(context).textTheme.headline1,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: SizedBox(
                  height: 48,
                  child: TextFormField(
                    validator: (value) => registrationValidateCode(
                      value,
                      context,
                    ),
                    controller: Provider.of<FirstTextConroller>(context),
                    textAlign: TextAlign.center,
                    textInputAction: TextInputAction.next,
                    autofocus: true,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(3),
                      FilteringTextInputFormatter.allow(RegExp('[0-9]'))
                    ],
                    onChanged: (value) {
                      if (value.length == 3) {
                        FocusScope.of(context).requestFocus(secondInputfocus);
                      }
                    },
                    style: Theme.of(context).textTheme.bodyText1,
                    keyboardType: TextInputType.number,
                    focusNode: firtInputfocus,
                    cursorColor: Colors.black,
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
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(5),
                child: Container(
                  width: 10,
                  height: 2,
                  color: Colors.black,
                ),
              ),
              Expanded(
                child: SizedBox(
                  height: 48,
                  child: TextFormField(
                    validator: (value) => registrationValidateCode(
                      value,
                      context,
                    ),
                    controller: Provider.of<SecondTextConroller>(context),
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyText1,
                    textInputAction: TextInputAction.next,
                    autofocus: true,
                    cursorColor: Colors.black,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(3),
                      FilteringTextInputFormatter.allow(RegExp('[0-9]'))
                    ],
                    onChanged: (value) {
                      if (value.length == 3) {
                        FocusScope.of(context).requestFocus(thirdInputfocus);
                      }
                      if (value.isEmpty) {
                        FocusScope.of(context).requestFocus(firtInputfocus);
                      }
                    },
                    keyboardType: TextInputType.number,
                    focusNode: secondInputfocus,
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
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(5),
                child: Container(
                  width: 10,
                  height: 2,
                  color: Colors.black,
                ),
              ),
              Expanded(
                child: SizedBox(
                  height: 48,
                  child: TextFormField(
                    controller: Provider.of<ThirdTextConroller>(context),
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyText1,
                    textInputAction: TextInputAction.next,
                    autofocus: true,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(3),
                      FilteringTextInputFormatter.allow(RegExp('[0-9]'))
                    ],
                    onChanged: (value) {
                      if (value.isEmpty) {
                        FocusScope.of(context).requestFocus(secondInputfocus);
                      }
                    },
                    validator: (value) => registrationValidateCode(
                      value,
                      context,
                    ),
                    cursorColor: Colors.black,
                    keyboardType: TextInputType.number,
                    focusNode: thirdInputfocus,
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
                  ),
                ),
              ),
            ],
          ),
          if (!Provider.of<IsValid>(context).isValid)
            Padding(
              padding: const EdgeInsets.all(8),
              child: Text(
                AppLocalizations.of(context).requiredFieldText,
                style: const TextStyle(
                  color: Colors.red,
                ),
              ),
            ),
        ],
      );
}

class RegistrationLoginTextField extends StatelessWidget {
  const RegistrationLoginTextField({super.key});

  @override
  Widget build(BuildContext context) => TextFieldDegree(
        autofocus: true,
        validator: (value) => registrationValidateLogin(value, context),
        textFieldText: AppLocalizations.of(context).loginText,
        obscureText: false,
        maxlines: 1,
        textEditingController: Provider.of<LoginController>(context),
      );
}

class RegistrationPasswordTextField extends StatelessWidget {
  const RegistrationPasswordTextField({super.key});

  @override
  Widget build(BuildContext context) => TextFieldDegree(
        validator: (value) => registrationValidatePassword(value, context),
        textFieldText: AppLocalizations.of(context).passwordText,
        obscureText: true,
        maxlines: 1,
        textEditingController: Provider.of<PasswordController>(context),
      );
}
