// ignore_for_file: prefer_const_constructors

import 'dart:async';
import 'package:custom_info_window/custom_info_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/data.dart';
import 'package:flutter_application_1/databaseHelper.dart';
import 'package:flutter_application_1/details.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'data.dart';


class Homepage extends StatefulWidget {
   Homepage({ Key? key }) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}
class _HomepageState extends State<Homepage> {
  int? selectedId;
  final typeController = TextEditingController();
  final priceController = TextEditingController();
  final List <LatLng> latLng = <LatLng>[];
  Completer<GoogleMapController> _controller = Completer();
  Future login() async {
    // ignore: unused_local_variable
    }
    
    // ignore: prefer_final_fields, unused_field
  CustomInfoWindowController _customInfoWindowController= CustomInfoWindowController(); 

   List <Marker> markers = [];
   int id = 1;
   Set <Polyline> _polylines = Set<Polyline>();
   List <LatLng> polylineCoordinates = [];
    void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }
  loadData () {
       for(int i = 0; i<latLng.length; i++){
        markers.add(Marker(markerId: MarkerId(i.toString()), 
      icon: BitmapDescriptor.defaultMarker,
      position: latLng[i],
    onTap: (){_customInfoWindowController.addInfoWindow!(
        Container
        (
          height: 100,
          width: 100,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.blueGrey
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              Row(
                children: [
                  Text("Type:"),SizedBox(width: 10,),
                  TextField(decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Type of Property'),
                    controller: typeController,
                    maxLines: 5,
                             minLines: 1,),
                ],
              ),
             
              InkWell(child: Text("More Details", style: TextStyle(color: Colors.blue, decoration: TextDecoration.underline),),
              onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Details()));
                            },
              ),
            ],
          )),
        latLng[i]
      );
      } 
      ),
      );
      setState(() {
        
      });
       }
  }
 
  @override
  
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: TextField( decoration: InputDecoration(
                      suffixIcon: IconButton(onPressed: (){}, icon: Icon(Icons.search)),
                  
                    hintText: 'Search your location '),
                   maxLines: 5,
                  minLines: 1, ),
      ),
      body: Stack(
        // ignore: prefer_const_literals_to_create_immutables
        children: [
          GoogleMap(
            myLocationEnabled: true,
            myLocationButtonEnabled: true,

            onTap: (LatLng latlng) async {
              print(latlng.longitude);
              print(latlng.latitude);
              
                await DataBaseHelper.instance.add(Detail(latitude: latlng.latitude !=null ? latlng.latitude.toString() :"", longitude: latlng.longitude.toString(), type: 'abc', price: "fgh"),);
        
            
              _customInfoWindowController.hideInfoWindow!();
              Marker firstMarker = Marker(markerId: MarkerId("$id"),
              position: LatLng(latlng.latitude, latlng.longitude),
              icon: BitmapDescriptor.defaultMarker
              );
              markers.add(firstMarker);
              setState(() {
                FutureBuilder(future:DataBaseHelper.instance.getDetails(), builder:  (context, detailsSnap){
                  if(detailsSnap.hasData) {
                     return detailsSnap.data.isNotEmpty
                     ListView.builder(
             itemCount: detailsSnap.data.length
            itemBuilder: (context, index) {
             ProjectModel project = detailsSnap.data[index];
              return Column(
            children: <Widget>[
              // Widget to display the list of project
            ],
          );
        },
      ): Text("abc") ;
      
                  }
                 
                }
                  
                );
                id = id +1;
                print('hero');
                print(DataBaseHelper.instance.getDetails());
              });
            },
            onCameraMove: (position){
            _customInfoWindowController.onCameraMove!();
          },
             onMapCreated: (GoogleMapController controller) {
            _customInfoWindowController.googleMapController = controller;
          },
            initialCameraPosition: CameraPosition
          (target: LatLng(28.2291235,83.977797),
          zoom: 15,
          ),
          markers: markers.map((e) => e).toSet(),
          polylines: _polylines,
         
      ),
       CustomInfoWindow(controller:_customInfoWindowController,
          height: 60,
          width: 150,
          offset: 35,
          ),
     
      
      ],
      )
    );
  }
  } 