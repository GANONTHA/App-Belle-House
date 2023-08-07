import 'package:bellehouse/utilities/dialogs/generic_dialog.dart';
import 'package:flutter/material.dart';

Future<bool> showLougOutDialog(BuildContext context) {
  return showGenericDialog(
    context: context,
    title: 'Deconnecter',
    content: 'Vous-vous vraiment vous deconnecter ?',
    optionBuilder: () => {'Annuler': false, 'Me deconnecter': true},
  ).then(
    (value) => value ?? false,
  );
}
