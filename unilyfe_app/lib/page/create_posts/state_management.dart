import 'package:flutter/material.dart';

import 'text_field.dart';

class EditorProvider extends ChangeNotifier {
  SmartTextType selectedType;

  // ignore: sort_constructors_first
  EditorProvider({SmartTextType defaultType = SmartTextType.T})
    : selectedType = defaultType;

  void setType(SmartTextType type) {
    if (selectedType == type) {
      selectedType = SmartTextType.T;
    } else {
      selectedType = type;
    }
    notifyListeners();
  }
}