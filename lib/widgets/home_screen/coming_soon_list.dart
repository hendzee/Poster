import 'package:flutter/material.dart';
import 'package:poster/models/poster_card_model.dart';
import 'package:poster/widgets/general/poster_card.dart'; // Poster card model

class ComingSoonList extends StatelessWidget {
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
    return Container(
        height: 270,
        margin: EdgeInsets.only(bottom: 25),
        decoration: BoxDecoration(
            color: Color(0xFF40407A),
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(50.0),
            )
        ),
        child: ListView(
          scrollDirection:  Axis.horizontal,
          children: <Widget>[
            SizedBox(width: 25,),
            Stack(
              children: <Widget>[
                Positioned(
                  top: 140,
                  child: Text('COMING SOON',
                    style: TextStyle(
                        fontSize: 72,
                        fontWeight: FontWeight.bold,
                        color: Colors.white38
                    ),
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text('COMING SOON',
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white
                      ),
                    ),
                    SizedBox(width: 40,),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 25),
                      child: PosterCard(posterCardModel: this.posterCardModel1,),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(width: 25,),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 25),
              child: PosterCard(posterCardModel: this.posterCardModel1,),
            ),
            SizedBox(width: 25,),
          ],
        )
    );
  }
}