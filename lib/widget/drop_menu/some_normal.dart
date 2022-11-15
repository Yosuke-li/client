import 'package:flutter/material.dart';

class NormalInput {
  static Decoration normal = _normal();

  static Decoration _normal() {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(3),
      border: Border.all(
        color: const Color(0xff797979),
        width: 1.0,
        style: BorderStyle.solid,
      ),
    );
  }
}
