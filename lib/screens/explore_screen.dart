import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:poster/widgets/general/poster_card.dart';

import '../data/models/poster_card_model.dart';

class ExplreScreen extends StatefulWidget {
  @override
  _ExplreScreenState createState() => _ExplreScreenState();
}

class _ExplreScreenState extends State<ExplreScreen> {
  // This is dummy data for this page
  final PosterCardModel posterCardModel1 = new PosterCardModel(
      title: 'Harmony Concert 2020',
      date: '20 Sep, 2020',
      location: 'Embong anyar Street no 10, Malang',
      description:
          'Ipsum is simply dummy of the printing and typesetting industry. Lorem Ipsum',
      posterImage: 'assets/dummy_images/poster1.png');

  // Set categories tab
  Widget _setCategoriesTab(String title, bool isActive) {
    return (Container(
        decoration: BoxDecoration(
            color: Color(isActive ? 0xFF40407A : 0xFFABABD3),
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10),
                topRight: Radius.circular(10))),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        child: Text(
          title,
          style: TextStyle(color: Colors.white),
        )));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: Container(),
          centerTitle: true,
          title: Text('Explore'),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 25),
              child: Icon(EvaIcons.searchOutline),
            )
          ],
        ),
        body: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                height: 30,
                margin: EdgeInsets.symmetric(vertical: 10),
                child: ListView(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  children: <Widget>[
                    SizedBox(
                      width: 25,
                    ),
                    _setCategoriesTab('Around World', true),
                    SizedBox(
                      width: 25,
                    ),
                    _setCategoriesTab('Another Trend', false),
                    SizedBox(
                      width: 25,
                    ),
                    _setCategoriesTab('Recomended', false),
                    SizedBox(
                      width: 25,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(
                          right: 25, left: 25, bottom: 25),
                      child: PosterCard(
                        posterCardModel: posterCardModel1,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          right: 25, left: 25, bottom: 25),
                      child: PosterCard(
                        posterCardModel: posterCardModel1,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          right: 25, left: 25, bottom: 25),
                      child: PosterCard(
                        posterCardModel: posterCardModel1,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
