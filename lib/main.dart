
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:zamask/place_polyline.dart';

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      appBar: AppBar(title: const Text('Google Maps demo')),
      body: PlacePolylineBody(),
    ),
  ));
}

class MapsDemo extends StatefulWidget {
  @override
  State createState() => MapsDemoState();
}

class MapsDemoState extends State<MapsDemo> {

  GoogleMapController mapController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(15.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Center(
            child: SizedBox(
              width: double.infinity,
              height: 500.0,
              child: GoogleMap(
                onMapCreated: _onMapCreated,
              ),
            ),
          ),
          RaisedButton(
            child: const Text('Go to Londons'),
            onPressed: mapController == null ? null : () {
              // mapController.animateCamera(CameraUpdate.newCameraPosition(
              //   // const CameraPosition(
              //   //   bearing: 270.0,
              //   //   target:new LatLng(51.5160895, -0.1294527),
              //   //   tilt: 30.0,
              //   //   zoom: 17.0,
              //   // ),
              // ));

      mapController.addPolyline(
  PolylineOptions(
    color: 0x88000000,
    width: 1.0,
    points: [
      LatLng(51.5160895, -0.1294527),
      // LatLng(2.0, 30.0),
      // LatLng(30.0, 20.0),
      // LatLng(10.0, 10.0),
    ],
  ),
);


            },
          ),
        ],
      ),
    );
  }

  void _onMapCreated(GoogleMapController controller) {
    setState(() { mapController = controller; });
  }
}