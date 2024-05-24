import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CustomMarkerShop {
  Future<Marker> createMarker(
      LatLng latlng, String markerIdVal, String shopName) async {
    final ui.PictureRecorder pictureRecorder = ui.PictureRecorder();
    final Canvas canvas = Canvas(pictureRecorder);

    // Define your marker's size
    final Size markerSize = const Size(200, 100);

    // Draw the marker image
    final ByteData markerImageBytes = await rootBundle
        .load("assets/images/marker_icon.png"); // Your marker image
    final ui.Codec markerImageCodec = await ui.instantiateImageCodec(
      markerImageBytes.buffer.asUint8List(),
      targetWidth: markerSize.width.toInt(),
      targetHeight: markerSize.height.toInt(),
    );
    final ui.FrameInfo markerImageFrameInfo =
        await markerImageCodec.getNextFrame();
    canvas.drawImage(markerImageFrameInfo.image, Offset.zero, Paint());

    // Draw the shop name text
    const textStyle = TextStyle(
      color: Colors.black,
      fontSize: 20,
      fontWeight: FontWeight.bold,
    );

    final textSpan = TextSpan(
      text: shopName,
      style: textStyle,
    );
    final textPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
    );
    textPainter.layout(minWidth: 0, maxWidth: markerSize.width);
    textPainter.paint(
        canvas,
        Offset(markerSize.width / 2 - textPainter.width / 2,
            markerSize.height / 2 - textPainter.height / 2));

    // Convert the marker to an image
    final ui.Image markerAsImage = await pictureRecorder
        .endRecording()
        .toImage(markerSize.width.toInt(), markerSize.height.toInt());
    final ByteData? byteData =
        await markerAsImage.toByteData(format: ui.ImageByteFormat.png);
    final Uint8List uint8List = byteData!.buffer.asUint8List();

    return Marker(
      markerId: MarkerId(markerIdVal),
      position: latlng,
      icon: BitmapDescriptor.fromBytes(uint8List),
    );
  }
}
