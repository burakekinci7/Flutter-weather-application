import 'package:flutter/material.dart';

enum ImageEnum {
  clear,
  broken_clouds,
  mist,
  thunderstorm,
  overcast_clouds,
  sunny,
  rain,
  snow,
}

extension ImagePathExtnasion on ImageEnum {
  String path() {
    //jpeg
    return "assets/images/$name.jpeg";
  }

  Image toWidget(double height, double width) {
    return Image.asset(
      path(),
      fit: BoxFit.cover,
      height: height,
      width: width,
    );
  }
}

class ImageAssets extends StatelessWidget {
  const ImageAssets({super.key});

  @override
  Widget build(BuildContext context) {
    return ImageEnum.rain.toWidget(1, 1);
  }
}
