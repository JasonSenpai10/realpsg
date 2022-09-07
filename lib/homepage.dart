// ignore_for_file: prefer_const_constructors

import 'dart:async';
import 'dart:convert';
import 'dart:io';
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
  var photo = '';
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

    // loadData();
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
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: TextField(
            decoration: InputDecoration(
                suffixIcon:
                    IconButton(onPressed: () {}, icon: Icon(Icons.search)),
                hintText: 'Search your location '),
            maxLines: 5,
            minLines: 1,
          ),
        ),
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
                            Container(
                                height: 100,
                                width: 100,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(color: Colors.blueGrey),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  // ignore: prefer_const_literals_to_create_immutables
                                  children: [
                                    Text("Type: " +
                                        Detail(
                                                type: element.type,
                                                price: element.price,
                                                latitude: element.latitude,
                                                longitude: element.longitude,
                                                details: element.details ?? '',
                                                photo: element.photo)
                                            .type
                                            .toString()),
                                    Text("Price: " +
                                        Detail(
                                                type: element.type,
                                                price: element.price,
                                                latitude: element.latitude,
                                                longitude: element.longitude,
                                                details: element.details ?? '',
                                                photo: element.photo)
                                            .price
                                            .toString()),
                                    InkWell(
                                      child: Text(
                                        "More Details",
                                        style: TextStyle(
                                            color: Colors.blue,
                                            decoration:
                                                TextDecoration.underline),
                                      ),
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => Details(
                                                    id: element.id,
                                                    latitude: LatLng(
                                                            double.parse(element
                                                                .latitude),
                                                            double.parse(element
                                                                .longitude))
                                                        .latitude
                                                        .toString(),
                                                    longitude: LatLng(
                                                            double.parse(element
                                                                .latitude),
                                                            double.parse(element
                                                                .longitude))
                                                        .longitude
                                                        .toString(),
                                                    type: element.type.toString(),
                                                    price: element.price.toString(),
                                                    details: element.details.toString(),
                                                    photo: element.photo)));
                                      },
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        ElevatedButton(
                                          onPressed: () {
                                            setState(() {
                                              DataBaseHelper.instance
                                                  .remove(element.id!);
                                              _customInfoWindowController
                                                  .hideInfoWindow!();
                                            });
                                          },
                                          child: const Icon(Icons.delete),
                                        ),
                                      ],
                                    )
                                  ],
                                )),
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
                                  InkWell(
                                    onTap: () async {
                                      final ImagePicker _picker = ImagePicker();
                                      XFile? image = await _picker.pickImage(
                                          source: ImageSource.gallery);
                                      if (image != null) {
                                        // var selected = XFile(image.path);

                                        final bytes = await image.readAsBytes();
                                        final base64 = base64Encode(bytes);
                                        photo = base64.toString();

                                        setState(() {
                                          file = XFile(image.path);
                                        });
                                      }
                                    },
                                    child: Container(
                                      height: 100,
                                      width: 200,
                                      // decoration: BoxDecoration(
                                      //     border: Border.all(width: 1),
                                      //     image: file == null
                                      //         ? null
                                      //         : DecorationImage(
                                      //             image: FileImage(File(file!.path)
                                      //                 // base64Decode(photo.toString())
                                      //                 ))),
                                      child: file == null
                                          ? Text("photo")
                                          : Image.file(File(file!.path)

                                              // onPressed: () {
                                              //   pickImageFromGallery();
                                              // },
                                              // child: Text('Photo')

                                              //: Image.memory(base64Decode(photo)),
                                              ),
                                    ),
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
                                  photo = '';
                                  file = null;

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
                                        photo: photo),
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
                                  photo = '';
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
                      height: 100,
                      width: 250,
                      offset: 35,
                    )
                  ],
                );
              }
            }));
  }
}
