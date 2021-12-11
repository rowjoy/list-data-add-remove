// ignore_for_file: avoid_unnecessary_containers, prefer_const_constructors, avoid_print, unrelated_type_equality_checks

import 'package:contactlis/contactlist.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';

class Sleash extends StatefulWidget {
  static const String path = "Sleashpage";
  const Sleash({Key? key}) : super(key: key);

  @override
  _SleashState createState() => _SleashState();
}

class _SleashState extends State<Sleash> {
  Future allpermisson() async {
    if (await Permission.contacts.request().isGranted) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => Contactlist()));
    } else if (await Permission.contacts.isDenied) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Access  Contact'),
              content:
                  Text('Don\'t worry, Please Allow access than use this apps'),
              actions: [
                TextButton(
                    onPressed: () async {
                      Map<Permission, PermissionStatus> statuses = await [
                        Permission.location,
                        Permission.storage,
                        Permission.contacts,
                        Permission.calendar,
                        Permission.bluetooth,
                      ].request();
                      if (statuses.isNotEmpty) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Contactlist()));
                      }
                    },
                    child: Text('Use Apps')),
                TextButton(
                  onPressed: () {
                    SystemNavigator.pop();
                  },
                  child: Text('Exit'),
                ),
              ],
            );
          },);
    }
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3), () {
      // getpermisson();
      allpermisson();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Text('Wating.........'),
        ),
      ),
    );
  }
}
