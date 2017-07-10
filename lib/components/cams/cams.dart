import 'dart:async';
import 'package:flutter/material.dart';
import 'package:ski_park/model/camera.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';

class Cams extends StatefulWidget {

  @override
  State createState() => new CamsState();
}

class CamsState extends State<Cams> {

  List<Camera> cameras = new List();
  final reference = FirebaseDatabase.instance.reference().child('cams');

  @override
  Widget build(BuildContext context) {
    return new FirebaseAnimatedList(
        query: reference,
       itemBuilder: buildCamViews,
       padding: new EdgeInsets.all(8.0)
    );
  }


  @override
  void initState() {
    super.initState();
  }

  Widget buildCamViews(BuildContext context, DataSnapshot snapshot, Animation<double> animation) {
    Map<String, String> map = snapshot.value;
    Camera camera = new Camera(map["name"], map["url"]);
    var camView = buildCamView(context, camera);
    return camView;
  }

//  Future<List<Camera>> _getCams() async {
//    var cams = new List();
//    cams.add(
//        new Camera("Base Cam", "https://www.skipark.com/images/mtncam4.jpg"));
//    cams.add(new Camera(
//        "Terrain Cam", "https://www.skipark.com/images/mtncam2.jpg"));
//    cams.add(
//        new Camera("Coyote Cam", "https://www.skipark.com/images/mtncam3.jpg"));
//    cams.add(new Camera("Hwy 89 at Snowman Summit",
//        "http://www.dot.ca.gov/cwwp2/data/d2/cctv/image/snowman/snowman.jpg"));
//    cams.add(new Camera("I-5 Hwy 89 Overpass",
//        "http://www.dot.ca.gov/cwwp2/data/d2/cctv/image/i5sr89/i5sr89.jpg"));
//    return cams;
//  }

  Widget buildCamView(BuildContext context, Camera camera) {
    var cardView = new Card(
      child: new Column(
        children: <Widget>[
          new Image.network(camera.url),
          new Text(camera.name)
        ],
      ),
    );
    return cardView;
  }
}