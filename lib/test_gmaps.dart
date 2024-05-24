import 'package:flutter/material.dart';
// ignore: unnecessary_import
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:takeit/utils/app_constants.dart';
import 'package:takeit/widgets/checkin_widget.dart';
import './services/locations.dart' as locations;

class IosGmap extends StatefulWidget {
  const IosGmap({super.key});

  @override
  State<IosGmap> createState() => _IosGmapState();
}

class _IosGmapState extends State<IosGmap> {
  final Map<String, Marker> _markers = {};
  Future<void> _onMapCreated(GoogleMapController controller) async {
    final googleOffices = await locations.getGoogleOffices();
    setState(() {
      _markers.clear();
      for (final office in googleOffices.offices) {
        final marker = Marker(
          markerId: MarkerId(office.name),
          position: LatLng(office.lat, office.lng),
          infoWindow: InfoWindow(
            title: office.name,
            snippet: office.address,
          ),
        );
        _markers[office.name] = marker;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: AppConstants.appMainColor,
          title: const Text(
            'Check In ',
            style: TextStyle(color: AppConstants.appSecondColor),
          ),
          actions: <Widget>[
            IconButton(
              icon: const Icon(
                Icons.search,
                color: AppConstants.appSecondColor,
              ),
              onPressed: () {
                // do something
              },
            )
          ],
          elevation: 2,
        ),
        body: Container(
          height: screenSize.height,
          color: AppConstants.appMainColor,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.vertical,
            child: Container(
              color: AppConstants.appMainColor,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(25)),
                      child: SizedBox(
                        height: screenSize.height / 1.5,
                        width: screenSize.width,
                        child: GoogleMap(
                          onMapCreated: _onMapCreated,
                          initialCameraPosition: const CameraPosition(
                            target: LatLng(0, 0),
                            zoom: 2,
                          ),
                          markers: _markers.values.toSet(),
                        ),
                      ),
                    ),
                  ),
                  Text("Where You wanna check in?",
                      style: GoogleFonts.spaceGrotesk(
                        textStyle: const TextStyle(
                            color: AppConstants.appSecondColor,
                            fontSize: 25,
                            //letterSpacing: .5,
                            fontWeight: FontWeight.w500),
                      )),
                  const CheckinWidget(
                    adImageUrls: [
                      'Hotels',
                      'Bars & Cafes',
                      'Restraunts',
                      'Movies',
                      'Clubs & Lounge',
                    ],
                    adiconList: [],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
