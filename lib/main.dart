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

// const kGoogleApiKey = AppData.api_key;

// main() {
//   runApp(RoutesWidget());
// }

// final customTheme = ThemeData(
//   primarySwatch: Colors.blue,
//   brightness: Brightness.dark,
//   accentColor: Colors.redAccent,
//   inputDecorationTheme: InputDecorationTheme(
//     border: OutlineInputBorder(
//       borderRadius: BorderRadius.all(Radius.circular(4.00)),
//     ),
//     contentPadding: EdgeInsets.symmetric(
//       vertical: 12.50,
//       horizontal: 10.00,
//     ),
//   ),
// );

// class RoutesWidget extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) => MaterialApp(
//         title: "My App",
//         theme: customTheme,
//         routes: {
//           "/": (_) => MyApp(),
//           "/search": (_) => CustomSearchScaffold(),
//         },
//       );
// }

// class MyApp extends StatefulWidget {
//   @override
//   _MyAppState createState() => _MyAppState();
// }

// final homeScaffoldKey = GlobalKey<ScaffoldState>();
// final searchScaffoldKey = GlobalKey<ScaffoldState>();

// class _MyAppState extends State<MyApp> {
//   Mode _mode = Mode.overlay;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       key: homeScaffoldKey,
//       appBar: AppBar(
//         title: Text("My App"),
//       ),
//       body: Center(
//           child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: <Widget>[
//           _buildDropdownMenu(),
//           RaisedButton(
//             onPressed: _handlePressButton,
//             child: Text("Search places"),
//           ),
//           RaisedButton(
//             child: Text("Custom"),
//             onPressed: () {
//               Navigator.of(context).pushNamed("/search");
//             },
//           ),
//         ],
//       )),
//     );
//   }

//   Widget _buildDropdownMenu() => DropdownButton(
//         value: _mode,
//         items: <DropdownMenuItem<Mode>>[
//           DropdownMenuItem<Mode>(
//             child: Text("Overlay"),
//             value: Mode.overlay,
//           ),
//           DropdownMenuItem<Mode>(
//             child: Text("Fullscreen"),
//             value: Mode.fullscreen,
//           ),
//         ],
//         onChanged: (m) {
//           setState(() {
//             _mode = m;
//           });
//         },
//       );

//   void onError(PlacesAutocompleteResponse response) {
//     homeScaffoldKey.currentState.showSnackBar(
//       SnackBar(content: Text(response.errorMessage)),
//     );
//   }

//   Future<void> _handlePressButton() async {
//     // show input autocomplete with selected mode
//     // then get the Prediction selected
//     Prediction p = await PlacesAutocomplete.show(
//       context: context,
//       apiKey: AppData.api_key,
//       onError: onError,
//       mode: _mode,
//       language: "en",
//       components: [Component(Component.country, "in")],
//     );

//     displayPrediction(p, homeScaffoldKey.currentState);
//   }
// }

// // Future<Null> displayPrediction(Prediction p, ScaffoldState scaffold) async {
// //   if (p != null) {
// //     // get detail (lat/lng)
// //     PlacesDetailsResponse detail = await _places.getDetailsByPlaceId(p.placeId);
// //     final lat = detail.result.geometry.location.lat;
// //     final lng = detail.result.geometry.location.lng;

// //     scaffold.showSnackBar(
// //       SnackBar(content: Text("${p.description} - $lat/$lng")),
// //     );
// //   }
// // }
