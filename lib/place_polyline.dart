import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:zamask/app_data.dart';

import 'package:http/http.dart' as http;

class PlacePolylineBody extends StatefulWidget {
  const PlacePolylineBody();

  @override
  State<StatefulWidget> createState() => PlacePolylineBodyState();
}

class PlacePolylineBodyState extends State<PlacePolylineBody> {
  PlacePolylineBodyState();

  String _directions = '';

  GoogleMapController controller;
  int _polylineCount = 0;
  Polyline _selectedPolyline;

  // Values when toggling polyline color
  int colorsIndex = 0;
  List<int> colors = <int>[
    0xFF000000,
    0xFF2196F3,
    0xFFF44336,
  ];

  // Values when toggling polyline width
  int widthsIndex = 0;
  List<double> widths = <double>[10.0, 20.0, 5.0];

  int jointTypesIndex = 0;
  List<int> jointTypes = <int>[
    JointType.mitered,
    JointType.bevel,
    JointType.round
  ];

  // Values when toggling polyline end cap type
  int endCapsIndex = 0;
  List<Cap> endCaps = <Cap>[Cap.buttCap, Cap.squareCap, Cap.roundCap];

  // Values when toggling polyline start cap type
  int startCapsIndex = 0;
  List<Cap> startCaps = <Cap>[Cap.buttCap, Cap.squareCap, Cap.roundCap];

  // Values when toggling polyline pattern
  int patternsIndex = 0;
  List<List<PatternItem>> patterns = <List<PatternItem>>[
    <PatternItem>[],
    <PatternItem>[
      PatternItem.dash(30.0),
      PatternItem.gap(20.0),
      PatternItem.dot,
      PatternItem.gap(20.0)
    ],
    <PatternItem>[PatternItem.dash(30.0), PatternItem.gap(20.0)],
    <PatternItem>[PatternItem.dot, PatternItem.gap(10.0)],
  ];

  void _onMapCreated(GoogleMapController controller) {
    this.controller = controller;
    controller.onPolylineTapped.add(_onPolylineTapped);
  }

  @override
  void dispose() {
    controller?.onPolylineTapped?.remove(_onPolylineTapped);
    super.dispose();
  }

  void _onPolylineTapped(Polyline polyline) {
    setState(() {
      _selectedPolyline = polyline;
    });
  }

  TextEditingController _origin = TextEditingController();
  TextEditingController _destination = TextEditingController();

  Future<void> fetchAPI() async {
    {
      if (_origin.text.isNotEmpty &&
          _destination.text.isNotEmpty &&
          _origin.text != _destination.text) {
        print('fetching api data');
        var url =
            'https://maps.googleapis.com/maps/api/directions/json?origin=${_origin.text}&destination=${_destination.text}&key=${AppData.api_key}';
        var client = new http.Client();
        try {
          var response = await client.get(url);
          if (response.statusCode == 200) {
            var data = jsonDecode(response.body);
            if (data['status'] == 'OK') {
              double lat = data['routes'][0]['legs'][0]['end_location']['lat'];
              double lng = data['routes'][0]['legs'][0]['end_location']['lng'];

              final LatLng _center = LatLng(lat, lng);
              //moving camera
              controller.animateCamera(CameraUpdate.newCameraPosition(
                CameraPosition(
                  bearing: 270.0,
                  target: _center,
                  tilt: 30.0,
                  zoom: 17.0,
                ),
              ));
              // add polylines
              final List<LatLng> _points = <LatLng>[];

              print(data['routes'][0]['legs'][0]['steps'][0]['end_location']);
              for (var i = 0;
                  i < data['routes'][0]['legs'][0]['steps'].length;
                  i++) {
                _points.add(_createLatLng(
                    data['routes'][0]['legs'][0]['steps'][i]['end_location']
                        ['lat'],
                    data['routes'][0]['legs'][0]['steps'][i]['end_location']
                        ['lng']));
                        _directions +=data['routes'][0]['legs'][0]['steps'][i]['html_instructions'];
                        _directions+='\n';
              }
              controller.addPolyline(PolylineOptions(
                consumeTapEvents: true,
                points: _points,
                color: 0xFFF44336,
                jointType: JointType.round,
                geodesic: true,
              ));
              _origin.clear();
              _destination.clear();
              setState(() {
                
              });
            }
          }
        } finally {
          client.close();
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Center(
          child: SizedBox(
            width: double.infinity,
            height: 500.0,
            child: GoogleMap(
              onMapCreated: _onMapCreated,
              options: GoogleMapOptions(
                cameraPosition: const CameraPosition(
                  target: LatLng(20.0082678, 64.4103554),
                  zoom: 4.0,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                TextField(
                  decoration: InputDecoration(hintText: '  Origin'),
                  controller: _origin,
                ),
                SizedBox(
                  height: 5,
                ),
                TextField(
                  decoration: InputDecoration(hintText: '  Destination'),
                  controller: _destination,
                ),
                RaisedButton(
                  onPressed: fetchAPI,
                  child: Text('Direction'),
                ),
                if(_directions != '')
                Html(
                  data: _directions,
                )
                // Text(_directions),
              ],
            ),
          ),
        ),
      ],
    );
  }

  LatLng _createLatLng(double lat, double lng) {
    return LatLng(lat, lng);
  }
}
