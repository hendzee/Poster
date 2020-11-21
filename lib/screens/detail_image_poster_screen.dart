import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';

class DetailImagePosterScreen extends StatefulWidget {
  @override
  _DetailImagePosterScreenState createState() =>
      _DetailImagePosterScreenState();
}

class _DetailImagePosterScreenState extends State<DetailImagePosterScreen> {
  @override
  Widget build(BuildContext context) {
    FlutterStatusbarcolor.setStatusBarColor(Colors.white);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            EvaIcons.arrowBackOutline,
          ),
          onPressed: () => Navigator.pop(context, false),
        ),
        title: Text('Detail Poster'),
        centerTitle: true,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.black,
        child: InteractiveViewer(
          boundaryMargin: EdgeInsets.all(30),
          maxScale: 3.0,
          child: Image(
            image: AssetImage('assets/dummy_images/poster2.png'),
          ),
        ),
      ),
    );
  }
}
