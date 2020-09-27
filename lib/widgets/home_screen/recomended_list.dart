import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poster/cubit/recomended_cubit.dart';
import 'package:poster/widgets/general/loading_poster_card.dart';
import 'package:poster/widgets/general/poster_card.dart'; // Poster card model

import '../../data/models/poster_card_model.dart';

class RecomendedList extends StatelessWidget {
  final String country;

  RecomendedList({this.country});

  // If data exist
  Widget setRecomendedWidget(List<PosterCardModel> recomendedList) {
    List<Widget> recomendedWidget = [];

    for (int i = 0; i < recomendedList.length; i++) {
      recomendedWidget.add(
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 25),
          child: PosterCard(
            posterCardModel: recomendedList[i],
          ),
        ),
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

  // If loading or data not exist
  Widget setRecomendedLoading() {
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
    return Container(
        height: 270,
        decoration: BoxDecoration(
            color: Color(0xFFD14081),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(50.0),
            )),
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: <Widget>[
            SizedBox(
              width: 25,
            ),
            Stack(
              children: <Widget>[
                Positioned(
                  top: 140,
                  child: Text(
                    'RECOMENDED',
                    style: TextStyle(
                        fontSize: 72,
                        fontWeight: FontWeight.bold,
                        color: Colors.white38),
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'RECOMENDED',
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    SizedBox(
                      width: 45,
                    ),
                    BlocConsumer<RecomendedCubit, RecomendedState>(
                        listener: (context, state) {
                      if (state is RecomendedError) {
                        Scaffold.of(context).showSnackBar(
                          SnackBar(
                            content: Text(state.message),
                          ),
                        );
                      }
                    }, builder: (context, state) {
                      if (state is RecomendedInitial) {
                        context
                            .bloc<RecomendedCubit>()
                            .getRecomendedList(country);

                        return setRecomendedLoading();
                      } else if (state is RecomendedLoading) {
                        return setRecomendedLoading();
                      } else if (state is RecomendedLoaded) {
                        return setRecomendedWidget(state.recomendedList);
                      } else {
                        return setRecomendedLoading();
                      }
                    })
                  ],
                ),
              ],
            ),
          ],
        ));
  }
}
