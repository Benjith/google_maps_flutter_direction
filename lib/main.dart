
import 'package:flutter/material.dart';

import 'package:zamask/place_polyline.dart';

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      appBar: AppBar(title: const Text('Google Maps flutter testing ')),
      body: PlacePolylineBody(),
    ),
  ));
}

