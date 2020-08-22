import 'package:flutter/material.dart';
import 'package:poster/models/poster_card_model.dart'; // Poster card model
import '../widgets/general/poster_card.dart'; // Poster card widget
import '../widgets/home_screen/top_content.dart'; // Substance of home screen
import '../widgets/home_screen/trending_title_content.dart'; // Substance of home screen
import '../widgets/home_screen/recomended_list.dart'; // Substance of home screen
import '../widgets/home_screen/coming_soon_list.dart'; // Substance of home screen

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // This is dummy data for this page
  final PosterCardModel _posterCardModel1 = new PosterCardModel(
    title: 'Harmony Concert 2020',
    date: '20 Sep, 2020',
    location: 'Embong anyar Street no 10, Malang',
    description: 'Ipsum is simply dummy of the printing and typesetting industry. Lorem Ipsum',
    posterImage: 'assets/dummy_images/poster1.png'
  );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TopContent(),
              TrendingTitleContent(),
              Padding(
                padding: const EdgeInsets.only(top: 0, right: 25, bottom: 25, left: 25),
                child: PosterCard(posterCardModel: _posterCardModel1,),
              ),
              RecomendedList(),
              ComingSoonList()
            ],
          ),
        )
    );
  }
}
