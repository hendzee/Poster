import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:poster/models/poster_card_model.dart'; // Poster card model
import '../widgets/general/poster_card.dart'; // Poster card widget
import '../widgets/home_screen/top_content.dart'; // Substance of home screen
import '../widgets/home_screen/trending_title_content.dart'; // Sunstance of home screen

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // This is dummy data for this page
  final PosterCardModel posterCardModel1 = new PosterCardModel(
    title: 'Harmony Concert 2020',
    date: '20 Sep, 2020',
    location: 'Embong anyar Street no 10, Malang',
    description: 'Ipsum is simply dummy of the printing and typesetting industry. Lorem Ipsum',
    posterImage: 'assets/dummy_images/poster1.png'
  );

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: const Color(0XFF40407A),
    ));

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TopContent(),
              TrendingTitleContent(),
              PosterCard(posterCardModel: this.posterCardModel1,),
              Container(
                padding: EdgeInsets.all(25.0),
                decoration: BoxDecoration(
                  color: Colors.redAccent,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.0),
                  )
                ),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      Text('Recomended'),
                      Text('This is item 2'),
                      Text('This is item 3'),
                      Text('This is item 4'),
                      Text('This is item 5'),
                      Text('This is item 6'),
                    ],
                  ),
                ),
              )
            ],
          ),
        )
      ),
    );
  }
}
