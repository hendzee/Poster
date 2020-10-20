import 'package:flutter/material.dart';
import 'search_result_card.dart';

class SearchbarResult extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: GridView.builder(
        itemCount: 10,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 5 / 7,
        ),
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.all(10),
          child: SearchResultCard(),
        ),
      ),
    );
  }
}
