import 'dart:convert';

import 'package:flutter/material.dart';

class Details extends StatefulWidget {
  const Details({
    Key? key,
    required this.type,
    required this.price,
    required this.details,
    required this.photo,
  }) : super(key: key);

  @override
  State<Details> createState() => _DetailsState();

  final String type;
  final String price;
  final String details;
  final String photo;
}

class _DetailsState extends State<Details> {
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
                ),
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
                          fit: BoxFit.contain,
                        ),
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
