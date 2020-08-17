import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:poster/models/poster_card_model.dart';

class PosterCard extends StatelessWidget {
  final PosterCardModel posterCardModel;

  PosterCard({ this.posterCardModel });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 25.0, right: 25.0, top: 10.0, bottom: 25.0),
      width: double.infinity,
      height: 220,
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Positioned.fill(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Wrap(
                children: <Widget>[
                  Container(
                    width: double.infinity,
                    height: 190,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 5.0,
                              blurRadius: 7.0,
                              offset: Offset(0, 3)
                          )
                        ]
                    ),
                    child: Stack(
                      children: <Widget>[
                        Positioned(
                          right: 0,
                          child: Container(
                            padding: EdgeInsets.all(5.0),
                            width: 160,
                            height: 180,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 10.0),
                                  child: Text(this.posterCardModel.title,
                                    style: TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 5.0),
                                  child: Row(
                                    children: <Widget>[
                                      Icon(
                                        EvaIcons.calendarOutline,
                                        size: 13.0,
                                      ),
                                      SizedBox(width: 5.0,),
                                      Text(this.posterCardModel.date,
                                        style: TextStyle(fontSize: 12.0),
                                      )
                                    ],
                                  ),
                                ),Padding(
                                  padding: const EdgeInsets.only(bottom: 5.0),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Icon(
                                        EvaIcons.pinOutline,
                                        size: 13.0,
                                      ),
                                      SizedBox(width: 5,),
                                      Flexible(
                                        child: Text(this.posterCardModel.location,
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 2,
                                          style: TextStyle(fontSize: 12.0),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 10.0, bottom: 5.0),
                                  child: RichText(
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 3,
                                    text: TextSpan(text: 'Desc: ',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                          fontSize: 12.0
                                      ),
                                      children: [
                                        TextSpan(text: this.posterCardModel.description,
                                          style: TextStyle(fontWeight: FontWeight.normal,)
                                        )
                                      ]
                                    )
                                  )
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 15,
            left: 15,
            width: 135,
            height: 200,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: Image(
                image: AssetImage(this.posterCardModel.posterImage),
                fit: BoxFit.contain,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
