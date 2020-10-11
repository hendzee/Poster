import 'package:flutter/material.dart';

import '../../widgets/general/loading_poster_card.dart';

class MineListLoading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(children: [
        Padding(
          padding: const EdgeInsets.only(right: 25, left: 25, bottom: 25),
          child: LoadingPosterCard(),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 25, left: 25, bottom: 25),
          child: LoadingPosterCard(),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 25, left: 25, bottom: 25),
          child: LoadingPosterCard(),
        ),
      ]),
    );
  }
}
