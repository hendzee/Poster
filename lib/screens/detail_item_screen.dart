import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:poster/data/models/poster_card_model.dart';

import '../data/models/item_model.dart';
import '../widgets/general/bottom_button.dart';

import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';

class DetailItemScreen extends StatefulWidget {
  @override
  _DetailItemScreenState createState() => _DetailItemScreenState();
}

class _DetailItemScreenState extends State<DetailItemScreen> {
  PosterCardModel _dataDetail;

  // Navigate to poster image detail
  _toPosterImage(BuildContext context, String image) {
    Navigator.pushNamed(context, '/detail_poster_image', arguments: image);
  }

  // Set info
  Widget _setInfo(Icon icon, String info) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          icon,
          SizedBox(
            width: 10,
          ),
          Text(info)
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    PosterCardModel _dataDetail = ModalRoute.of(context).settings.arguments;
    FlutterStatusbarcolor.setStatusBarColor(Colors.white);

    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Item'),
        centerTitle: true,
      ),
      bottomSheet: BottomButton(
        title: 'SUBSCRIBE',
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 410,
              child: Stack(
                children: [
                  Positioned(
                    left: 30,
                    top: 30,
                    child: Container(
                      width: 200,
                      height: 350,
                      decoration: BoxDecoration(
                        color: Color(0xFFF0EBF4),
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: -60,
                    top: 50,
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      child: Container(
                        width: 200,
                        height: 350,
                        child: Image(
                          fit: BoxFit.cover,
                          image: NetworkImage(_dataDetail.posterImage),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 100,
                    top: 70,
                    child: GestureDetector(
                      onTap: () =>
                          _toPosterImage(context, _dataDetail.posterImage),
                      child: CircleAvatar(
                          radius: 15,
                          backgroundColor: Colors.white,
                          child: Icon(
                            EvaIcons.expandOutline,
                            color: Colors.grey,
                          )),
                    ),
                  ),
                  Positioned(
                      top: 60,
                      left: 150,
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        width: 195,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              _dataDetail.title,
                              style: TextStyle(
                                  fontSize: 24, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            _setInfo(Icon(EvaIcons.calendarOutline),
                                _dataDetail.startDate),
                            _setInfo(Icon(EvaIcons.pinOutline),
                                _dataDetail.location),
                            _setInfo(Icon(EvaIcons.creditCardOutline),
                                _dataDetail.price),
                            _setInfo(Icon(EvaIcons.twitterOutline),
                                _dataDetail.twitter),
                            _setInfo(Icon(EvaIcons.cameraOutline),
                                _dataDetail.instagram),
                            _setInfo(Icon(EvaIcons.facebookOutline),
                                _dataDetail.facebook),
                          ],
                        ),
                      ))
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
              child: Text(
                'Description',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 25),
              child: Text(_dataDetail.description),
            ),
            SizedBox(
              height: 90,
            )
          ],
        ),
      ),
    );
  }
}
