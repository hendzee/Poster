import 'package:flutter/material.dart';

import '../general/loading_poster_card.dart';

class ComingSoonListLoading extends StatelessWidget {
  // If loading or data not exist
  Widget _setComingSoonLoading() {
    List<Widget> recomendedWidget = [];

    for (int i = 0; i < 3; i++) {
      recomendedWidget.add(
        Padding(
            padding: const EdgeInsets.symmetric(vertical: 25),
            child: LoadingPosterCard()),
      );

      recomendedWidget.add(
        SizedBox(
          width: 25,
        ),
      );
    }

    return (Row(
      children: recomendedWidget,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return _setComingSoonLoading();
  }
}
