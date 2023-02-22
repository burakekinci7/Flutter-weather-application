import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ThemeDarkLightMode extends ChangeNotifier {
  bool isChanged = false;

  void changeTheme() {
    isChanged = !isChanged;
    notifyListeners();
  }

  ThemeData get currentTheme => isChanged
      ? ThemeData.dark().copyWith(
          appBarTheme: const AppBarTheme(
            systemOverlayStyle: SystemUiOverlayStyle.light,
            elevation: 0,
            centerTitle: true,
          ),
        )
      : ThemeData.light().copyWith(
          appBarTheme: const AppBarTheme(
          systemOverlayStyle: SystemUiOverlayStyle.dark,
          color: Colors.transparent,
          elevation: 0,
          centerTitle: true,
        ));
}
