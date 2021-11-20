import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rider/constants.dart';
import 'package:rider/logic/apis/get_booking_details.dart';
import 'package:rider/screens/client/components/history_components/booking_info_card.dart';
import 'package:rider/screens/client/components/history_components/deliver_details_card.dart';
import 'package:rider/screens/client/components/history_components/payment_details_card.dart';
import 'package:rider/screens/client/components/wallet_components/directions_model.dart';
import 'package:rider/screens/client/components/wallet_components/directions_repository.dart';
import 'package:rider/util/app_url.dart';
import 'package:simple_shadow/simple_shadow.dart';

class HistoryDetails extends StatefulWidget {
  final String? bookingId;

  const HistoryDetails({
    Key? key,
    this.bookingId,
  }) : super(key: key);

  @override
  _HistoryDetailsState createState() => _HistoryDetailsState();
}

class _HistoryDetailsState extends State<HistoryDetails> {
  late Future<BookingDetails> data;
  @override
  void initState() {
    super.initState();
    data = getBookingsDetails(bookingId: widget.bookingId);
  }

  Directions? finalDirection;
  Completer<GoogleMapController> _controller = Completer();
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          'Booking Details',
          style: GoogleFonts.getFont(
            'Overlock',
            textStyle: TextStyle(
              color: kPrimaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        iconTheme: IconThemeData(color: kPrimaryColor),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: FutureBuilder(
            future: data,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                BookingDetails _data = snapshot.data;

                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Route',
                        style: GoogleFonts.getFont(
                          'Overlock',
                          textStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      SimpleShadow(
                        opacity: 0.5, // Default: 0.5
                        color: Colors.grey,
                        offset: Offset(3, 3), // Default: Offset(2, 2)
                        sigma: 7,
                        child: Card(
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Container(
                            width: size.width * 0.95,
                            height: 300,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: GoogleMap(
                                mapType: MapType.hybrid,
                                onMapCreated:
                                    (GoogleMapController controller) async {
                                  _controller.complete(controller);
                                  Directions? direction =
                                      await DirectionsRepository()
                                          .getDirections(
                                    origin: LatLng(
                                      double.parse(_data.data!.bookingDetails!
                                          .pickupLatitude!),
                                      double.parse(_data.data!.bookingDetails!
                                          .pickupLongitude!),
                                    ),
                                    destination: LatLng(
                                      double.parse(_data.data!.bookingDetails!
                                          .dropoffLatitude!),
                                      double.parse(_data.data!.bookingDetails!
                                          .dropoffLongitude!),
                                    ),
                                  );
                                  setState(() {
                                    if (direction!.hasDir!) {
                                      finalDirection = direction;
                                    }
                                  });
                                },
                                polylines: {
                                  if (finalDirection != null)
                                    Polyline(
                                      polylineId:
                                          const PolylineId('Directions'),
                                      color: Colors.red,
                                      width: 5,
                                      points: finalDirection!.polylinePoints!
                                          .map((e) =>
                                              LatLng(e.latitude, e.longitude))
                                          .toList(),
                                    ),
                                },
                                initialCameraPosition: CameraPosition(
                                  target: LatLng(
                                    double.parse(_data.data!.bookingDetails!
                                        .dropoffLatitude!),
                                    double.parse(_data.data!.bookingDetails!
                                        .dropoffLongitude!),
                                  ),
                                  zoom: 15,
                                ),
                                markers: {
                                  Marker(
                                    markerId: MarkerId('Dropoff location'),
                                    position: LatLng(
                                      double.parse(_data.data!.bookingDetails!
                                          .dropoffLatitude!),
                                      double.parse(_data.data!.bookingDetails!
                                          .dropoffLongitude!),
                                    ),
                                  ),
                                  Marker(
                                    markerId: MarkerId('Pickup location'),
                                    position: LatLng(
                                      double.parse(_data.data!.bookingDetails!
                                          .pickupLatitude!),
                                      double.parse(_data.data!.bookingDetails!
                                          .pickupLongitude!),
                                    ),
                                  ),
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                      Text(
                        'Package Image',
                        style: GoogleFonts.getFont(
                          'Overlock',
                          textStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      _data.data!.bookingDetails!.packageImage != null
                          ? Center(
                              child: SizedBox(
                                height: 350,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.network(
                                    AppUrl.baseURL +
                                        _data.data!.bookingDetails!
                                            .packageImage!,
                                  ),
                                ),
                              ),
                            )
                          : Padding(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: SelectableText(
                                'Image does not exist.',
                                style: GoogleFonts.getFont(
                                  'Overlock',
                                  textStyle: TextStyle(
                                    fontSize: 25,
                                  ),
                                ),
                              ),
                            ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Payment Details',
                        style: GoogleFonts.getFont(
                          'Overlock',
                          textStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      PaymentDetailscard(
                        serviceFee:
                            _data.data!.bookingDetails!.serviceFee ?? '',
                        paymentmethod:
                            _data.data!.bookingDetails!.paymentMethod ?? '',
                        distance: _data.data!.bookingDetails!.distance ?? '',
                        weight: _data.data!.bookingDetails!.weight ?? '',
                        paymentStatus:
                            _data.data!.bookingDetails!.paymentStatus ?? '',
                        bookingStatus:
                            _data.data!.bookingDetails!.bookingStatus ?? '',
                        bookingId: widget.bookingId ?? '',
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      DeliverDetailsCard(data: _data),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Booking Details',
                        style: GoogleFonts.getFont(
                          'Overlock',
                          textStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      BookingDetailsCard(
                        bookingId:
                            _data.data!.bookingDetails!.bookingNumber ?? '',
                        bookingStatus:
                            _data.data!.bookingDetails!.bookingStatus ?? '',
                        date: _data.data!.bookingDetails!.date ?? '',
                        dropoffAddress:
                            _data.data!.bookingDetails!.dropoffPoint ?? '',
                        taskDescription:
                            _data.data!.bookingDetails!.taskDescription ?? '',
                        pickupAddress:
                            _data.data!.bookingDetails!.pickupPoint ?? '',
                        packageDetails:
                            _data.data!.bookingDetails!.packageDetails ?? '',
                        pickupName:
                            _data.data!.bookingDetails!.pickupName ?? '',
                        pickupContact:
                            _data.data!.bookingDetails!.pickupPhoneNumber ?? '',
                        dropoffName:
                            _data.data!.bookingDetails!.deliveryName ?? '',
                        dropoffContact:
                            _data.data!.bookingDetails!.deliveryPhoneNumber ??
                                '',
                      ),
                    ],
                  ),
                );
              }
              return Column(
                children: [
                  CircularProgressIndicator(),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
