import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poster/cubit/comingsoon_cubit.dart';

import '../../data/models/poster_card_model.dart';
import '../general/poster_card.dart'; // Poster card model
import 'coming_soon_list_loading.dart';

class ComingSoonList extends StatelessWidget {
  final String country;
  const ComingSoonList({this.country});

  // If data exist
  Widget setComingSoonWidget(List<PosterCardModel> recomendedList) {
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

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 270,
      margin: EdgeInsets.only(bottom: 25),
      decoration: BoxDecoration(
          color: Color(0xFF40407A),
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(50.0),
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
                  'COMING SOON',
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
                    'COMING SOON',
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  SizedBox(
                    width: 45,
                  ),
                  BlocConsumer<ComingsoonCubit, ComingsoonState>(
                    listener: (context, state) {
                      if (state is ComingsoonError) {
                        Scaffold.of(context).showSnackBar(SnackBar(
                          content: Text(state.message),
                        ));
                      }
                    },
                    builder: (context, state) {
                      if (state is ComingsoonInitial) {
                        BlocProvider.of<ComingsoonCubit>(context)
                            .getComingSoonList(country);
                        return ComingSoonListLoading();
                      } else if (state is ComingsoonLoading) {
                        return ComingSoonListLoading();
                      } else if (state is ComingsoonLoaded) {
                        return setComingSoonWidget(state.comingSoonList);
                      } else {
                        return ComingSoonListLoading();
                      }
                    },
                  )
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
