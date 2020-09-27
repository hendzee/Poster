import 'package:flutter/material.dart';
import 'package:poster/widgets/general/loading_poster_card.dart';

class TrendingContentLoading extends StatelessWidget {
  TrendingContentLoading();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 0, right: 25, bottom: 25, left: 25),
      child: LoadingPosterCard(),
    );
  }
}
