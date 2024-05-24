// ignore_for_file: unused_local_variable

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

Future<void> fetchLocationUpdates() async {
  final locationController = Location();
  LatLng? currentPosition;
  bool serviceEnabled;
  PermissionStatus permissionGranted;
  serviceEnabled = await locationController.serviceEnabled();
  if (serviceEnabled) {
    serviceEnabled = await locationController.requestService();
  } else {
    return;
  }

  permissionGranted = await locationController.hasPermission();
  if (permissionGranted == PermissionStatus.denied) {
    permissionGranted = await locationController.requestPermission();
    if (permissionGranted != PermissionStatus.granted) {
      return;
    }
  }

  locationController.onLocationChanged.listen((currentLocation) {
    if (currentLocation.latitude != null && currentLocation.longitude != null) {
      currentPosition =
          LatLng(currentLocation.latitude!, currentLocation.longitude!);
    }
  });
}
