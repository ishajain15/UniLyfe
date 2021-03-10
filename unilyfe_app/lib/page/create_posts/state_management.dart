import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'text_field.dart';

class EditorProvider extends ChangeNotifier {
  SmartTextType selectedType;

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