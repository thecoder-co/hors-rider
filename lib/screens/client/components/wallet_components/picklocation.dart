import 'dart:async';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:rider/components/rounded_button.dart';
import 'package:rider/constants.dart';
import 'package:rider/logic/apis/process_booking.dart';
import 'package:rider/screens/client/components/wallet_components/finish_booking.dart';
import 'package:select_form_field/select_form_field.dart';
import 'package:google_maps_place_picker/google_maps_place_picker.dart';
import 'package:rider/screens/client/components/wallet_components/directions_model.dart';
import 'package:rider/screens/client/components/wallet_components/directions_repository.dart';

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
  PickResult? pickupLocation;
  PickResult? dropoffLocation;
  Marker? origin;
  Marker? destination;
  Directions? finalDirection;

  String? packageDetailsText;
  String? taskDescriptionText;
  int? packageWeight;
  DateTime? pickupDate;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      extendBodyBehindAppBar: true,
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          Positioned(
            top: 0,
            bottom: MediaQuery.of(context).size.height * 0.3 - 10,
            left: 0,
            right: 0,
            child: Container(
              color: Color.fromARGB(100, 100, 100, 100),
              child: GoogleMap(
                mapType: MapType.hybrid,
                initialCameraPosition: _kGooglePlex,
                compassEnabled: true,
                markers: {
                  if (origin != null) origin!,
                  if (destination != null) destination!,
                },
                onMapCreated: (GoogleMapController controller) {
                  _controller.complete(controller);
                },
                polylines: {
                  if (finalDirection != null)
                    Polyline(
                      polylineId: const PolylineId('Directions'),
                      color: Colors.red,
                      width: 5,
                      points: finalDirection!.polylinePoints!
                          .map((e) => LatLng(e.latitude, e.longitude))
                          .toList(),
                    ),
                },
              ),
            ),
          ),
          if (finalDirection != null)
            Positioned(
              top: 40.0,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 6.0,
                  horizontal: 12.0,
                ),
                decoration: BoxDecoration(
                  color: Colors.yellowAccent,
                  borderRadius: BorderRadius.circular(20.0),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      offset: Offset(0, 2),
                      blurRadius: 6.0,
                    )
                  ],
                ),
                child: Text(
                  '${finalDirection!.totalDistance}',
                  style: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w600,
                  ),
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
                        'Pick your route',
                        style: GoogleFonts.getFont(
                          'Overlock',
                          textStyle: TextStyle(
                            color: kDarkGreen,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      InkWell(
                        onTap: () async {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PlacePicker(
                                apiKey:
                                    'AIzaSyBcNIqkYa-XqjQJiTtQTXSTWo_GT4n3WKE',
                                onPlacePicked: (result) async {
                                  PickResult placeData = result;
                                  setState(() {
                                    pickupLocation = placeData;
                                  });
                                  origin = Marker(
                                    markerId: MarkerId('Pickup location'),
                                    position: LatLng(
                                      placeData.geometry!.location.lat,
                                      placeData.geometry!.location.lng,
                                    ),
                                  );
                                  if (origin != null && destination != null) {
                                    Directions? direction =
                                        await DirectionsRepository()
                                            .getDirections(
                                      origin: origin!.position,
                                      destination: destination!.position,
                                    );
                                    setState(() {
                                      if (direction!.hasDir!) {
                                        finalDirection = direction;
                                      }
                                    });
                                  }
                                  final GoogleMapController controller =
                                      await _controller.future;
                                  controller.animateCamera(
                                    CameraUpdate.newCameraPosition(
                                      CameraPosition(
                                        target: LatLng(
                                          placeData.geometry!.location.lat,
                                          placeData.geometry!.location.lng,
                                        ),
                                        zoom: 17,
                                      ),
                                    ),
                                  );
                                  Navigator.of(context).pop();
                                },
                                initialPosition: LatLng(6.4513919, 3.6643836),
                                useCurrentLocation: true,
                              ),
                            ),
                          );
                        },
                        child: Container(
                          padding: EdgeInsets.only(left: 20, right: 20),
                          alignment: Alignment.centerLeft,
                          height: 60,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Pickup Location',
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 14,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Expanded(
                                    child: Text(
                                      '${pickupLocation != null ? pickupLocation!.formattedAddress : "Select a pickup location"}',
                                      style: GoogleFonts.getFont(
                                        'Overlock',
                                        textStyle: TextStyle(
                                          color: kDarkGreen,
                                          fontSize: 18,
                                        ),
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                              Spacer(),
                              Icon(
                                Icons.arrow_forward_ios_rounded,
                                color: Colors.grey,
                                size: 18,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                        child: Divider(
                          height: 1,
                          color: Colors.grey[400],
                        ),
                      ),
                      InkWell(
                        onTap: () async {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PlacePicker(
                                apiKey:
                                    'AIzaSyBcNIqkYa-XqjQJiTtQTXSTWo_GT4n3WKE', // Put YOUR OWN KEY here.
                                onPlacePicked: (result) async {
                                  PickResult placeData = result;
                                  setState(() {
                                    dropoffLocation = placeData;
                                    destination = Marker(
                                      markerId: MarkerId('Delivery location'),
                                      position: LatLng(
                                        placeData.geometry!.location.lat,
                                        placeData.geometry!.location.lng,
                                      ),
                                    );
                                  });
                                  if (origin != null && destination != null) {
                                    Directions? direction =
                                        await DirectionsRepository()
                                            .getDirections(
                                                origin: origin!.position,
                                                destination:
                                                    destination!.position);
                                    setState(() {
                                      if (direction!.hasDir!) {
                                        finalDirection = direction;
                                      }
                                    });
                                  }
                                  Navigator.of(context).pop();
                                  final GoogleMapController controller =
                                      await _controller.future;
                                  controller.animateCamera(
                                    CameraUpdate.newCameraPosition(
                                      CameraPosition(
                                        target: LatLng(
                                          placeData.geometry!.location.lat,
                                          placeData.geometry!.location.lng,
                                        ),
                                        zoom: 17,
                                      ),
                                    ),
                                  );
                                },
                                initialPosition: LatLng(6.4513919, 3.6643836),
                                useCurrentLocation: true,
                              ),
                            ),
                          );
                        },
                        child: Container(
                          padding: EdgeInsets.only(left: 20, right: 20),
                          alignment: Alignment.centerLeft,
                          height: 60,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Dropoff location',
                                    style: GoogleFonts.getFont(
                                      'Overlock',
                                      textStyle: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Flexible(
                                    child: Container(
                                      child: Text(
                                        '${dropoffLocation != null ? dropoffLocation!.formattedAddress : "Select a dropoff location"}',
                                        style: GoogleFonts.getFont(
                                          'Overlock',
                                          textStyle: TextStyle(
                                            color: kDarkGreen,
                                            fontSize: 18,
                                          ),
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                        softWrap: false,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Spacer(),
                              Icon(
                                Icons.arrow_forward_ios_rounded,
                                color: Colors.grey,
                                size: 18,
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: Get.height * 0.05),
                      Container(
                        padding: EdgeInsets.only(
                          left: 20,
                          right: 20,
                          bottom: 10,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Package Details',
                              style: GoogleFonts.getFont(
                                'Overlock',
                                textStyle: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                            TextField(
                              style: TextStyle(
                                color: kDarkGreen,
                                fontSize: 18,
                              ),
                              onChanged: (val) {
                                setState(() {
                                  packageDetailsText = val;
                                });
                              },
                              onSubmitted: (val) {
                                setState(() {
                                  packageDetailsText = val;
                                });
                              },
                              decoration: InputDecoration(
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.grey,
                                  ),
                                ),
                                border: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.grey,
                                  ),
                                ),
                                hintText:
                                    'a sealed envelope containing bluetooth',
                                hintStyle: GoogleFonts.getFont(
                                  'Overlock',
                                  textStyle: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(
                          left: 20,
                          right: 20,
                          bottom: 10,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Task Description',
                              style: GoogleFonts.getFont(
                                'Overlock',
                                textStyle: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                            TextField(
                              style: TextStyle(
                                color: kDarkGreen,
                                fontSize: 18,
                              ),
                              onChanged: (val) {
                                setState(() {
                                  taskDescriptionText = val;
                                });
                              },
                              onSubmitted: (val) {
                                setState(() {
                                  taskDescriptionText = val;
                                });
                              },
                              decoration: InputDecoration(
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.grey,
                                  ),
                                ),
                                border: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.grey,
                                  ),
                                ),
                                hintText: 'House at the back of the compound',
                                hintStyle: GoogleFonts.getFont(
                                  'Overlock',
                                  textStyle: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(
                          left: 20,
                          right: 20,
                          bottom: 10,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Weight',
                              style: GoogleFonts.getFont(
                                'Overlock',
                                textStyle: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                            SelectFormField(
                              type: SelectFormFieldType
                                  .dropdown, // or can be dialog
                              decoration: InputDecoration(
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.grey,
                                  ),
                                ),
                                border: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.grey,
                                  ),
                                ),
                                hintStyle: GoogleFonts.getFont(
                                  'Overlock',
                                  textStyle: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 14,
                                  ),
                                ),
                                hintText: 'Weight of package',
                              ),

                              items: List.generate(20, (index) {
                                return {
                                  'value': "${index + 1}",
                                  'label': "${index + 1}"
                                };
                              }),

                              onChanged: (val) {
                                setState(() {
                                  packageWeight = int.parse(val);
                                });
                              },
                              onSaved: (val) {
                                setState(() {
                                  packageWeight = int.parse(val!);
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(
                          left: 20,
                          right: 20,
                          bottom: 10,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Pickup Date',
                              style: GoogleFonts.getFont(
                                'Overlock',
                                textStyle: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                            DateTimeField(
                              format: DateFormat("yyyy-MM-dd hh:mm:ss"),
                              onChanged: (val) {
                                pickupDate = val;
                              },
                              onSaved: (val) {
                                pickupDate = val;
                              },
                              decoration: InputDecoration(
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.grey,
                                  ),
                                ),
                                border: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                              onShowPicker: (context, currentValue) async {
                                final date = await showDatePicker(
                                  context: context,
                                  firstDate: DateTime.now(),
                                  initialDate: currentValue ?? DateTime.now(),
                                  lastDate: DateTime(2100),
                                );
                                if (date != null) {
                                  final time = await showTimePicker(
                                    context: context,
                                    initialTime: TimeOfDay.fromDateTime(
                                        currentValue ?? DateTime.now()),
                                  );
                                  return DateTimeField.combine(date, time);
                                } else {
                                  return currentValue;
                                }
                              },
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      RoundedButton(
                        press: () {
                          Future<ProcessBooking> data = processBooking(
                            distance:
                                finalDirection!.totalDistance!.split(' ')[0],
                            dropoffLatitude: dropoffLocation!
                                .geometry!.location.lat
                                .toString(),
                            droppffLongitude: dropoffLocation!
                                .geometry!.location.lng
                                .toString(),
                            dropoffPoint: dropoffLocation!.formattedAddress,
                            packageDetails: packageDetailsText,
                            pickupDate: pickupDate.toString(),
                            pickupLatitude: pickupLocation!
                                .geometry!.location.lat
                                .toString(),
                            pickupLongitude: pickupLocation!
                                .geometry!.location.lng
                                .toString(),
                            pickupPoint: pickupLocation!.formattedAddress,
                            weight: packageWeight.toString(),
                            taskDescription: taskDescriptionText,
                          );
                          data.then((value) {
                            if (value.code == 200) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => FinishBookingPage(
                                    data: value,
                                  ),
                                ),
                              );
                            } else {}
                          });
                        },
                        text: 'Book Delivery',
                      )
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
}
