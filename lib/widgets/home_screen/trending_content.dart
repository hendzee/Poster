import 'package:flutter/material.dart';

import '../../data/models/poster_card_model.dart';
import '../general/poster_card.dart';

class TrendingContent extends StatelessWidget {
  final PosterCardModel posterCardModel;

  TrendingContent({this.posterCardModel});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 0, right: 25, bottom: 25, left: 25),
      child: PosterCard(
        posterCardModel: posterCardModel,
      ),
    );
  }
}
