import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:takeit/utils/app_constants.dart';

class MapWidget extends StatefulWidget {
  const MapWidget({super.key});

  @override
  State<MapWidget> createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {
  final Location _location = Location(); // Location service instance

  // Initial camera position with a default location (adjust later)
  CameraPosition _initialCameraPosition = const CameraPosition(
    target: LatLng(0, 0),
    zoom: 14.0,
  );

  late GoogleMapController _mapController;
  Marker? _userLocationMarker;
  bool isLoadingMap = false;

  String? _darkMapStyle;

  @override
  void initState() {
    super.initState();
    _getUserLocation();
    _loadMapStyles();
  }

  Future _loadMapStyles() async {
    _darkMapStyle =
        await rootBundle.loadString('assets/map/dark_map_style.json');
  }

  Future<void> _getUserLocation() async {
    bool serviceEnabled;
    PermissionStatus permissionGranted;

    // Check if location service is enabled
    serviceEnabled = await _location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await _location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    // Check and request location permissions
    permissionGranted = await _location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await _location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    // Get current location
    final currentLocation = await _location.getLocation();

    setState(() {
      _initialCameraPosition = CameraPosition(
        target: LatLng(currentLocation.latitude!, currentLocation.longitude!),
        zoom: 14.0,
      );

      _userLocationMarker = Marker(
        markerId: const MarkerId('user_location'),
        position: LatLng(currentLocation.latitude!, currentLocation.longitude!),
        // Customize your marker icon here
      );
    });

    // Listen for location updates and update the map
    _location.onLocationChanged.listen((LocationData newLocation) {
      if (mounted) {
        setState(() {
          _userLocationMarker = _userLocationMarker?.copyWith(
            positionParam:
                LatLng(newLocation.latitude!, newLocation.longitude!),
          );
        });

        _mapController.animateCamera(CameraUpdate.newCameraPosition(
          CameraPosition(
            target: LatLng(newLocation.latitude!, newLocation.longitude!),
            zoom: 16,
          ),
        ));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
        color: AppConstants.appSecondColor,
      ),
      padding: const EdgeInsets.all(10),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20.0),
        child: GoogleMap(
          minMaxZoomPreference: MinMaxZoomPreference.unbounded,
          zoomGesturesEnabled: true,
          scrollGesturesEnabled: true,
          zoomControlsEnabled: true,
          mapType: MapType.normal,
          gestureRecognizers: {
            Factory<OneSequenceGestureRecognizer>(
                () => EagerGestureRecognizer())
          },
          onMapCreated: (controller) {
            _mapController = controller;
            // ignore: deprecated_member_use
            _mapController.setMapStyle(_darkMapStyle);
          },
          myLocationEnabled: true,
          initialCameraPosition: _initialCameraPosition,
          markers: _userLocationMarker != null ? {_userLocationMarker!} : {},
        ),
      ),
    );
  }
}
