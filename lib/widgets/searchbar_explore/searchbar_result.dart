import 'package:flutter/material.dart';
import 'package:poster/data/models/poster_card_model.dart';
import 'package:poster/widgets/general/poster_card.dart';

class SearchbarResult extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0),
      child: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
            child: PosterCard(
              posterCardModel: PosterCardModel(
                description: 'dfa',
                detailLocation: 'dfasdfa',
                endDate: 'dfasdfasd',
                facebook: 'dfadfa',
                id: '3',
                instagram: 'fdadfas',
                location: 'dfadfa',
                posterImage:
                    'https://static-cse.canva.com/image/84694/music-poster.png',
                price: '342342',
                startDate: 'dfadfa',
                title: 'fdadaf',
                twitter: 'fdasdfa',
                userPhoto:
                    'https://pixinvent.com/materialize-material-design-admin-template/app-assets/images/user/12.jpg',
                website: 'dfasdfa',
              ),
            ),
          );
        },
      ),
    );
  }
}
