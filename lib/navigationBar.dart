import 'package:flutter/material.dart';
import 'package:flutter_application_1/homepage.dart';

class Navbar extends StatefulWidget {
  const Navbar({Key? key}) : super(key: key);

  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: TextField(
            decoration: InputDecoration(
                suffixIcon: IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.search,
                      color: Colors.white,
                    )),
                hintText: 'Search your location',
                hintStyle: const TextStyle(color: Colors.white)),
            maxLines: 5,
            minLines: 1,
          ),
          backgroundColor: const Color(0xff5CB8E4),
        ),
        drawer: Drawer(
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: [
              const DrawerHeader(
                decoration: BoxDecoration(color: Color(0xff5CB8E4)),
                child: CircleAvatar(
                  radius: 100,
                  backgroundImage: AssetImage("assets/images/u.jpg"),
                ),
              ),
              ListTile(
                leading: const Icon(
                  Icons.upload,
                ),
                title: const Text('Export'),
                onTap: () {},
              ),
              ListTile(
                leading: Icon(Icons.add_to_home_screen_outlined),
                title: const Text('Import'),
                onTap: () {
                  //Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
        body: Homepage());
  }
}
