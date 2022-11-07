import 'package:degree_app/auth/view/registration/registration_screen.dart';
import 'package:degree_app/l10n/l10n.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

// ignore: body_might_complete_normally_nullable
String? registrationValidateLogin(String? value, BuildContext context) {
  if (value == null || value.isEmpty) {
  } else if (!RegExp(
    r'^[a-zA-Z0-9](_(?!(\.|_))|\.(?!(_|\.))|[a-zA-Z0-9]){3,18}[a-zA-Z0-9]$',
  ).hasMatch(
    Provider.of<LoginController>(
      context,
      listen: false,
    ).text,
  )) {
    return AppLocalizations.of(context).inCorrectLoginTextField;
  } else {
    return null;
  }
}

String? registrationValidatePassword(String? value, BuildContext context) {
  if (value == null || value.isEmpty) {
    return AppLocalizations.of(context).requiredFieldText;
  } else if (!RegExp(
    r'^(?=.*\d)(?=.*[A-Z])(?=.*[a-z])(?=.*[^\w\d\s:])([^\s]){8,}$',
  ).hasMatch(
    Provider.of<PasswordController>(
      context,
      listen: false,
    ).text,
  )) {
    return AppLocalizations.of(context).inCorrectPasswordTextField;
  } else {
    return null;
  }
}

String? registrationValidateCode(String? value, BuildContext context) {
  if (value == null || value.isEmpty) {
    return AppLocalizations.of(context).requiredFieldText;
  } else {
    return null;
  }
}
