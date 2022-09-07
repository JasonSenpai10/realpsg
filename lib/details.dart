import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'data.dart';
import 'databaseHelper.dart';

class Details extends StatefulWidget {
  const Details({
    Key? key,
    this.id = 0,
    this.latitude = '',
    this.longitude = '',
    required this.type,
    required this.price,
    required this.details,
    required this.photo,
  }) : super(key: key);

  @override
  State<Details> createState() => _DetailsState();
  final int id;
  final String latitude;
  final String longitude;
  final String type;
  final String price;
  final String details;
  final String photo;
}

class _DetailsState extends State<Details> {
  int? selectedId;
  final typeController = TextEditingController();

  final priceController = TextEditingController();
  final detailsController = TextEditingController();

  var photo = '';

  int id = 1;

  void initState() {
    // TODO: implement initState
    super.initState();

    // loadData();
  }

  XFile? file;
  @override
  Widget build(BuildContext context) {
    final textScale = MediaQuery.of(context).textScaleFactor;
    return Scaffold(
      body: Stack(
        children: [
          // ignore: avoid_unnecessary_containers
          Container(
              child: SingleChildScrollView(
            child: Column(
              children: [
                AppBar(
                    backgroundColor: Colors.blueAccent,
                    title: Text(widget.type),
                    actions: <Widget>[
                      IconButton(
                        // ignore: prefer_const_constructors
                        icon: Icon(
                          Icons.edit,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          typeController.text = widget.type;
                          priceController.text = widget.price;
                          detailsController.text = widget.details;

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
                                    Navigator.pop(context, 'Cancel');
                                  },
                                  child: Text('Cancel')),
                              TextButton(
                                  onPressed: () async {
                                    await DataBaseHelper.instance.update(
                                      Detail(
                                          id: widget.id,
                                          latitude: widget.latitude,
                                          longitude: widget.longitude,
                                          type: typeController.text,
                                          price: priceController.text,
                                          details: detailsController.text,
                                          photo: widget.photo),
                                    );

                                    Navigator.pop(context);
                                    setState(() {});
                                  },
                                  child: Text('Update')),
                            ],
                          );
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return alert;
                              });
                          // do something
                        },
                      )
                    ]),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(border: Border.all(width: 5)),
                        child: Image(
                            image: MemoryImage(base64.decode(widget.photo)),
                            height: 200,
                            width: MediaQuery.of(context).size.width * 0.8,
                            fit: BoxFit.fitWidth),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            // ignore: prefer_const_literals_to_create_immutables
                            children: [
                              // ignore: prefer_const_constructors
                              Text(
                                "Type:",
                                style: TextStyle(
                                    fontSize: 15 * textScale,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                width: 40,
                              ),
                              Text(
                                widget.type,
                                style: TextStyle(
                                    fontSize: 15 * textScale,
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            // ignore: prefer_const_literals_to_create_immutables
                            children: [
                              Text(
                                "Description:",
                                style: TextStyle(
                                    fontSize: 15 * textScale,
                                    fontWeight: FontWeight.bold),
                              ),

                              // ignore: sized_box_for_whitespace
                              Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.56,
                                  child: Text(
                                    widget.details,
                                    style: TextStyle(fontSize: 15 * textScale),
                                  ))
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            // ignore: prefer_const_literals_to_create_immutables
                            children: [
                              Text(
                                "Price:",
                                style: TextStyle(
                                    fontSize: 15 * textScale,
                                    fontWeight: FontWeight.bold),
                              ),

                              // ignore: sized_box_for_whitespace
                              Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.56,
                                  child: Text(
                                    widget.price,
                                    style: TextStyle(fontSize: 15 * textScale),
                                  ))
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          )),
        ],
      ),
    );
  }
}
