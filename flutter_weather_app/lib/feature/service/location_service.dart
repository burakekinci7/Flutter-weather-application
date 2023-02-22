import 'package:location/location.dart';

class LocaitonService {
  //long=longitude, lat=latitude
  double? long;
  double? lat;

  //Loaciton
  final Location location = Location();
  late bool _serviceEnabled;
  late PermissionStatus _permissionGranted;
  late LocationData _locationData;

  //Future
  Future getLocation() async {
    //serivce
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) _serviceEnabled = await location.requestService();

    //permissions for location
    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
    }
    //location
    _locationData = await location.getLocation();
    lat = _locationData.latitude;
    long = _locationData.longitude;
  }
}
