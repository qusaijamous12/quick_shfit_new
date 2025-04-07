import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class MapController extends GetxController{

  final _myPosition=Rxn<Position>();


  @override
  void onInit() async{

    await getLocationPermission();

    super.onInit();

  }


  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {

      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {

        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }



    return await Geolocator.getCurrentPosition();
  }

  Future<void> getLocationPermission() async {
    var permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse &&
          permission != LocationPermission.always) {
        return;
      }
    }
    await _getLocation();
  }

  Future<void> _getLocation() async {
    print('WILL GET CURRENT LOCATION!!');

    var position;
    try {
      position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.bestForNavigation);
    } catch (e) {
      position = await Geolocator.getLastKnownPosition();
    }
    print('1');
    if (position == null) {
      return;
    }
    _myPosition(position);
    print('${_myPosition.value}');


  }


  Position ?get myPosition=>_myPosition.value;

}