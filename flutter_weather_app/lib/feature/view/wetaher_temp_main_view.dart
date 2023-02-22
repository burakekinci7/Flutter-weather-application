import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_weather_app/core/constants/image_extansion.dart';
import 'package:flutter_weather_app/core/global/titles.dart';
import 'package:flutter_weather_app/core/product/icon_custom.dart';
import 'package:flutter_weather_app/core/product/padding.dart';
import 'package:flutter_weather_app/core/product/text_style.dart';
import 'package:flutter_weather_app/core/widget/theme_data_mode_widget.dart';
import 'package:flutter_weather_app/feature/model/weather_model.dart';
import 'package:flutter_weather_app/feature/service/location_service.dart';
import 'package:flutter_weather_app/feature/service/weather_service_dio.dart';
import 'package:flutter_weather_app/feature/service/weather_service_http.dart';

class WeatherHomeWidgetView extends StatefulWidget {
  const WeatherHomeWidgetView({Key? key}) : super(key: key);
  @override
  State<WeatherHomeWidgetView> createState() => _WeatherHomeWidgetViewState();
}

class _WeatherHomeWidgetViewState extends State<WeatherHomeWidgetView> {
  //TextEditinControlller
  TextEditingController? citySelectContoller = TextEditingController();

  //weather Model
  WeatherAppModel? weatherAppModel;

  //CircularProgressIndicator
  bool _isLoading = false;
  void _onChangeLoading() {
    _isLoading = !_isLoading;
  }

  //locaitonService
  double? long;
  double? lat;
  LocaitonService? locaitonService;
  Future<void> getLocationData() async {
    locaitonService = LocaitonService();
    await locaitonService?.getLocation();
    lat = locaitonService?.lat;
    long = locaitonService?.long;
  }

  //Dio get data - Service
  Future _getDataDio(String city) async {
    _onChangeLoading();

    final ret = await WeatherSerivceDio.getDataDio(city);
    setState(() {
      weatherAppModel = ret;
    });
    _onChangeLoading();
  }

  //http get data - Service(The two services are no different.)
  Future<void> _getDatahttp(double lat, double long) async {
    _onChangeLoading();
    final responce = await WeatherServiceHttp().getData(lat, long);

    setState(() {
      weatherAppModel = responce;
    });
    _onChangeLoading();
  }

  //First we have to find the location and then find out the weather.(used Future for it)
  Future<void> getweatherData() async {
    _onChangeLoading();
    await getLocationData();
    _getDatahttp(lat ?? 0, long ?? 0);
    _onChangeLoading();
  }

  //first running method of the app
  @override
  void initState() {
    super.initState();
    getweatherData();
  }

  @override
  Widget build(BuildContext context) {
    //background image
    //weather id
    int weatherID = weatherAppModel?.weather?[0].id ?? 0;
    //screen size of the mobile phone
    double imageSizeWidth = MediaQuery.of(context).size.width;
    double imageSizeHeight = MediaQuery.of(context).size.height;
    //temp iamge
    Image tempImage;

    //Images to Weather Id
    if (weatherID < 200) {
      tempImage = ImageEnum.clear.toWidget(imageSizeHeight, imageSizeWidth);
    } else if (weatherID < 300) {
      tempImage =
          ImageEnum.thunderstorm.toWidget(imageSizeHeight, imageSizeWidth);
    } else if (weatherID < 600) {
      tempImage = ImageEnum.rain.toWidget(imageSizeHeight, imageSizeWidth);
    } else if (weatherID < 700) {
      tempImage = ImageEnum.snow.toWidget(imageSizeHeight, imageSizeWidth);
    } else if (weatherID < 800) {
      tempImage = ImageEnum.mist.toWidget(imageSizeHeight, imageSizeWidth);
    } else if (weatherID == 800) {
      tempImage = ImageEnum.clear.toWidget(imageSizeHeight, imageSizeWidth);
    } else if (weatherID < 804) {
      tempImage =
          ImageEnum.broken_clouds.toWidget(imageSizeHeight, imageSizeWidth);
    } else if (weatherID == 804) {
      tempImage =
          ImageEnum.overcast_clouds.toWidget(imageSizeHeight, imageSizeWidth);
    } else {
      tempImage = ImageEnum.clear.toWidget(imageSizeHeight, imageSizeWidth);
    }

    return Stack(
      //https://api.flutter.dev/flutter/widgets/Stack-class.html
      children: [
        tempImage,
        SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const ThemeModeWidget(),
              Padding(
                padding: PaddingCustom.paddingHorizontalVertival,
                child: TextField(
                  keyboardType: TextInputType.streetAddress,
                  decoration: InputDecoration(
                    focusedBorder: PaddingCustom.borderRadiusCircular,
                    labelStyle: const TextStyle(color: Colors.black),
                    enabledBorder: PaddingCustom.borderRadiusCircular,
                    border: PaddingCustom.borderRadiusCircular,
                    label: const Text(Titles.serachTextFieldLAbel),
                    focusColor: Colors.black,
                    suffixIconColor: Colors.black,
                    suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            _getDataDio(citySelectContoller?.text ?? "");
                          });
                        },
                        icon: IconCustom.searchICon),
                  ),
                  controller: citySelectContoller,
                ),
              ),
              weatherBody(),
            ],
          ),
        ),
      ],
    );
  }

  Visibility weatherBody() {
    return Visibility(
      replacement: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                weatherAppModel?.name.toString() ?? "Bulunamadı",
                style: TextStyleCustom.cityTextStyle,
              ),
              Text(weatherAppModel?.sys?.country.toString() ?? "Ülke"),
            ],
          ),
          Text(
            "${weatherAppModel?.main?.temp?.toInt().toString() ?? " - -"}°",
            style: TextStyleCustom.tempTextStyle,
          ),
          Text(
            weatherAppModel?.weather?[0].description.toString().toUpperCase() ??
                "Tahmin Edilemedi",
            style: TextStyleCustom.descriptionTextStyle,
          ),
          /* Text(
            weatherAppModel?.weather?[0].id.toString() ?? "Tahmin Edilemedi",
            style: TextStyleCustom.descriptionTextStyle,
          ), */
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "En Y: ${weatherAppModel?.main?.tempMax?.toInt().toString() ?? " - -"}°",
                style: TextStyleCustom.maxminTempTextStyle,
              ),
              const SizedBox(width: 20),
              Text(
                "En D: ${weatherAppModel?.main?.tempMin?.toInt().toString() ?? " - -"}°",
                style: TextStyleCustom.maxminTempTextStyle,
              ),
            ],
          ),
          Text(
            "Rüzgarın Hızı: ${weatherAppModel?.wind?.speed ?? "0 "}km/h",
            style: TextStyleCustom.windSpeedTextStyle,
          )
        ],
      ),
      visible: _isLoading,
      child: Platform.isAndroid
          ? const CircularProgressIndicator()
          : const CupertinoActivityIndicator(),
    );
  }
}



/* 
 Text(weatherAppModel?.name.toString() ??
     "Şehir Adi Verilemedi"), //
 Text(weatherAppModel?.base.toString() ?? "stations write"),
 Text(weatherAppModel?.clouds?.all.toString() ?? "Bulutlar "),
 Text(weatherAppModel?.cod.toString() ?? "status cod"),
 Text(weatherAppModel?.coord?.lat.toString() ?? "coord lat"),
 Text(weatherAppModel?.coord?.lon.toString() ?? "coordmlon"),
 Text(weatherAppModel?.dt.toString() ?? "Veri hesaplama zamani"),
 Text(weatherAppModel?.id.toString() ?? "Sehir Kimliği"),
 Text(weatherAppModel?.sys?.country.toString() ?? "Ulke Kodu"), //
 Text(weatherAppModel?.sys?.id.toString() ?? "dahili ID"),
 Text(weatherAppModel?.sys?.sunrise.toString() ??
     "Gün doğumu zamani"), //
 Text(weatherAppModel?.sys?.sunset.toString() ??
     "Gün batimi zaman,"), //
 Text(
     weatherAppModel?.sys?.type.toString() ?? "Dahili parameters"),
 Text(weatherAppModel?.main?.feelsLike.toString() ??
     "Hissedilen Sıcaklık"), //
 Text(weatherAppModel?.main?.humidity.toString() ?? "NEM"), //%
 Text(weatherAppModel?.main?.pressure.toString() ??
     "ATMOSFER BASINCI"), //hpascal
 Text(weatherAppModel?.main?.temp.toString() ?? "sıcaklık"), //
 Text(weatherAppModel?.main?.tempMax.toString() ??
     "bu Günkü en yüksek sıcaklık"), //
 Text(weatherAppModel?.main?.tempMin.toString() ??
     "bu günkü min sıkcalık"), //
 Text(weatherAppModel?.timezone.toString() ??
     "UTC de saniye cinsinden kayma"),
 Text(weatherAppModel?.wind?.deg.toString() ?? "Rüzgar yönü"), //
 Text(weatherAppModel?.wind?.speed.toString() ??
     "Rüzgarın hızı"), //
 Text(weatherAppModel?.weather?[0].description.toString() ??
     "sun broken clouds etc."), //
 Text(weatherAppModel?.weather?[0].icon.toString() ??
      "hava simgesi kimliği"),
  Text(weatherAppModel?.weather?[0].id.toString() ??
      "Hava durumu kimliği"),
  Text(weatherAppModel?.weather?[0].main.toString() ??
      "Hava parametreleri grubu (Yağmur, Kar, Aşırı vb.)"),
  Text(weatherAppModel?.visibility.toString() ??
      "Görünürlük( maksimum değeri 10km'dir.)"),
*****/
