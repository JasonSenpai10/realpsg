// ignore_for_file: prefer_const_constructors

import 'dart:async';
import 'package:custom_info_window/custom_info_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/data.dart';
import 'package:flutter_application_1/databaseHelper.dart';
import 'package:flutter_application_1/details.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'data.dart';

class Homepage extends StatefulWidget {
  Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  int? selectedId;
  final typeController = TextEditingController();
  final priceController = TextEditingController();
  final detailsController = TextEditingController();
  final List<LatLng> latLng = <LatLng>[];
  Completer<GoogleMapController> _controller = Completer();
  Future login() async {
    // ignore: unused_local_variable
  }

  // ignore: prefer_final_fields, unused_field
  CustomInfoWindowController _customInfoWindowController =
      CustomInfoWindowController();

  List<Marker> markers = [];
  int id = 1;
  Set<Polyline> _polylines = Set<Polyline>();
  List<LatLng> polylineCoordinates = [];

  void initState() {
    // TODO: implement initState
    super.initState();
  }

  XFile? file;
  pickImageFromGallery() async {
    // var imgFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    // final bytes = await imgFile!.readAsBytes();
    // final base64 = base64Encode(bytes);
    // photo = base64.toString();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
            future: DataBaseHelper.instance.getDetails(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (!snapshot.hasData) {
                return (Center(child: CircularProgressIndicator()));
              } else {
                markers = snapshot.data.map<Marker>((element) {
                  return Marker(
                      markerId: MarkerId(element.id.toString()),
                      draggable: false,
                      onTap: () {
                        _customInfoWindowController.addInfoWindow!(
                            SingleChildScrollView(
                              child: Container(
                                  decoration: BoxDecoration(
                                    color: Color(0xffF2F2F2),
                                    border: Border.all(color: Colors.blueGrey),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      // ignore: prefer_const_literals_to_create_immutables
                                      children: [
                                        Text(
                                          "Type: " +
                                              Detail(
                                                type: element.type,
                                                price: element.price,
                                                latitude: element.latitude,
                                                longitude: element.longitude,
                                                details: element.details ?? '',
                                              ).type.toString(),
                                          style: TextStyle(fontSize: 20),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          "Price: " +
                                              Detail(
                                                type: element.type,
                                                price: element.price,
                                                latitude: element.latitude,
                                                longitude: element.longitude,
                                                details: element.details ?? '',
                                              ).price.toString(),
                                          style: TextStyle(fontSize: 20),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        InkWell(
                                          child: Text(
                                            "More Details",
                                            style: TextStyle(
                                              fontSize: 20,
                                              color: Color(0xff5CB8E4),
                                              decorationColor: Colors.black,
                                              decoration:
                                                  TextDecoration.underline,
                                            ),
                                          ),
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        Details(
                                                          id: element.id,
                                                          latitude: LatLng(
                                                                  double.parse(
                                                                      element
                                                                          .latitude),
                                                                  double.parse(
                                                                      element
                                                                          .longitude))
                                                              .latitude
                                                              .toString(),
                                                          longitude: LatLng(
                                                                  double.parse(
                                                                      element
                                                                          .latitude),
                                                                  double.parse(
                                                                      element
                                                                          .longitude))
                                                              .longitude
                                                              .toString(),
                                                          type: element.type
                                                              .toString(),
                                                          price: element.price
                                                              .toString(),
                                                          details: element
                                                              .details
                                                              .toString(),
                                                        )));
                                          },
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                  primary: Color(0xff5CB8E4)),
                                              onPressed: () {
                                                AlertDialog alert = AlertDialog(
                                                  title: Text(
                                                      "Do you really want to delete?"),
                                                  content: StatefulBuilder(
                                                      builder:
                                                          (context, setState) {
                                                    return Container(
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          TextButton(
                                                              onPressed: () {
                                                                setState(() {
                                                                  DataBaseHelper
                                                                      .instance
                                                                      .remove(element
                                                                          .id!);
                                                                  _customInfoWindowController
                                                                      .hideInfoWindow!();
                                                                  Navigator.pop(
                                                                      context);
                                                                });
                                                              },
                                                              child:
                                                                  Text("Yes")),
                                                          TextButton(
                                                              onPressed: () {
                                                                Navigator.pop(
                                                                    context);
                                                              },
                                                              child: Text("No"))
                                                        ],
                                                      ),
                                                    );
                                                  }),
                                                );

                                                showDialog(
                                                    context: context,
                                                    builder:
                                                        (BuildContext context) {
                                                      return alert;
                                                    });
                                              },
                                              child: const Icon(Icons.delete),
                                            ),
                                            ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                  primary: Color(0xff5CB8E4)),
                                              onPressed: () {
                                                setState(() {
                                                  _customInfoWindowController
                                                      .hideInfoWindow!();
                                                });
                                              },
                                              child: const Icon(Icons.close),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  )),
                            ),
                            LatLng(double.parse(element.latitude),
                                double.parse(element.longitude)));

                        setState(() {});
                      },
                      position: LatLng(double.parse(element.latitude),
                          double.parse(element.longitude)));
                }).toList();
                return Stack(
                  children: [
                    GoogleMap(
                      myLocationEnabled: true,
                      myLocationButtonEnabled: true,
                      onTap: (LatLng latlng) async {
                        AlertDialog alert = AlertDialog(
                          title: Text('Detail form'),
                          content:
                              StatefulBuilder(builder: (context, setState) {
                            return SingleChildScrollView(
                              scrollDirection: Axis.vertical,
                              reverse: true,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  TextField(
                                    controller: typeController,
                                    decoration:
                                        InputDecoration(hintText: 'Type '),
                                    maxLines: 5,
                                    minLines: 1,
                                  ),
                                  TextField(
                                    controller: priceController,
                                    decoration:
                                        InputDecoration(hintText: 'Price '),
                                    maxLines: 5,
                                    minLines: 1,
                                  ),
                                  TextField(
                                    controller: detailsController,
                                    decoration: InputDecoration(
                                        hintText: 'More details'),
                                    maxLines: 10,
                                    minLines: 1,
                                  ),
                                ],
                              ),
                            );
                          }),
                          actions: [
                            TextButton(
                                onPressed: () {
                                  typeController.clear();
                                  priceController.clear();
                                  detailsController.clear();

                                  Navigator.pop(context, 'Cancel');
                                },
                                child: Text('Cancel')),
                            TextButton(
                                onPressed: () async {
                                  await DataBaseHelper.instance.add(
                                    Detail(
                                      latitude: latlng.latitude != null
                                          ? latlng.latitude.toString()
                                          : "",
                                      longitude: latlng.longitude.toString(),
                                      type: typeController.text,
                                      price: priceController.text,
                                      details: detailsController.text,
                                    ),
                                  );

                                  Marker firstMarker = Marker(
                                      markerId: MarkerId("$id"),
                                      position: LatLng(
                                          latlng.latitude, latlng.longitude),
                                      icon: BitmapDescriptor.defaultMarker);
                                  markers.add(firstMarker);
                                  _customInfoWindowController.hideInfoWindow!();
                                  typeController.clear();
                                  priceController.clear();
                                  detailsController.clear();

                                  file = null;
                                  Navigator.pop(context);
                                  setState(() {});
                                },
                                child: Text('Add')),
                          ],
                        );

                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return alert;
                            });
                      },
                      onCameraMove: (position) {
                        _customInfoWindowController.onCameraMove!();
                      },
                      onMapCreated: (GoogleMapController controller) {
                        _customInfoWindowController.googleMapController =
                            controller;
                      },
                      initialCameraPosition: CameraPosition(
                        target: LatLng(28.2291235, 83.977797),
                        zoom: 15,
                      ),
                      markers: markers.map((e) => e).toSet(),
                      polylines: _polylines,
                    ),
                    CustomInfoWindow(
                      controller: _customInfoWindowController,
                      height: 200,
                      width: 250,
                      offset: 35,
                    )
                  ],
                );
              }
            }));
  }
}
