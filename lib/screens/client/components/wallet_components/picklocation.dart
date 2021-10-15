import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:location/location.dart';
import 'package:rider/constants.dart';
//import 'package:place_picker/place_picker.dart' as place;
import 'package:google_maps_place_picker/google_maps_place_picker.dart';

class LocationPicker extends StatefulWidget {
  LocationPicker({Key? key}) : super(key: key);

  @override
  _LocationPickerState createState() => _LocationPickerState();
}

class _LocationPickerState extends State<LocationPicker> {
  Completer<GoogleMapController> _controller = Completer();

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(6.4513919, 3.6643836),
    zoom: 19.4746,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      extendBodyBehindAppBar: true,
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          Positioned(
            child: Container(
              child: Icon(
                Icons.arrow_back_ios,
                color: kDarkGreen,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(1000),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    offset: Offset(3, 3),
                    blurRadius: 10,
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 0,
            bottom: MediaQuery.of(context).size.height * 0.3 - 10,
            left: 0,
            right: 0,
            child: Container(
              color: Color.fromARGB(100, 100, 100, 100),
              child: GoogleMap(
                mapType: MapType.normal,
                initialCameraPosition: _kGooglePlex,
                compassEnabled: true,
                onMapCreated: (GoogleMapController controller) {
                  _controller.complete(controller);
                },
              ),
            ),
          ),
          DraggableScrollableSheet(
            initialChildSize: 0.3,
            maxChildSize: 0.95,
            minChildSize: 0.3,
            builder: (context, scrollController) {
              return Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      offset: Offset(3, 3),
                      blurRadius: 10,
                    ),
                  ],
                ),
                child: SingleChildScrollView(
                  controller: scrollController,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          onTap: () {
                            DraggableScrollableActuator.reset(context);
                          },
                          child: Container(
                            height: 5,
                            width: 50,
                            decoration: BoxDecoration(
                              color: Colors.grey[400],
                              borderRadius: BorderRadius.circular(50),
                            ),
                          ),
                        ),
                      ),
                      Text(
                        'PICK A DESTINATION',
                        style: GoogleFonts.getFont(
                          'Overlock',
                          textStyle: TextStyle(
                            color: kDarkGreen,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () async {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PlacePicker(
                                apiKey: kgoogleApiKey, // Put YOUR OWN KEY here.
                                onPlacePicked: (result) {
                                  print(result);
                                  Navigator.of(context).pop();
                                },
                                initialPosition: LatLng(6.4513919, 3.6643836),
                                useCurrentLocation: true,
                              ),
                            ),
                          );
                          /*place.LocationResult result =
                              await Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => place.PlacePicker(
                                "AIzaSyAX6XvI1txGzBbbkl73YsH1JfcbgI41C4g",

                              ),
                            ),
                          );

                          // Handle the result in your way
                          print(result);*/
                        },
                        child: Container(
                          height: 200,
                          color: Colors.amber,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          )
        ],
      ),
    );
  }

  Future<void> _goToTheLake() async {
    Location location = new Location();

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
    _locationData = await location.getLocation();
    print('${_locationData.latitude!}, ${_locationData.longitude!}');
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(_locationData.latitude!, _locationData.longitude!),
          bearing: 0,
          tilt: 0,
          zoom: 19,
        ),
      ),
    );
  }
}
