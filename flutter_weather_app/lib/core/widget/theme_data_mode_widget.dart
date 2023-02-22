import 'package:flutter/material.dart';
import 'package:flutter_weather_app/core/product/icon_custom.dart'; //-
import 'package:flutter_weather_app/core/theme/dark_light_mode.dart';
import 'package:provider/provider.dart';

class ThemeModeWidget extends StatelessWidget {
  const ThemeModeWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: () {
            //provider widget tree
            context.read<ThemeDarkLightMode>().changeTheme();
          },
          icon: IconCustom.darkModeICon, //-
        ),
      ],
    );
  }
}
