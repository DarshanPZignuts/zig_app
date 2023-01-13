import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class CommonSnackbar {
  static showSnakbar(BuildContext snackbarContext, String content) {
    return ScaffoldMessenger.of(snackbarContext)
        .showSnackBar(SnackBar(content: Text(content)));
  }
}
