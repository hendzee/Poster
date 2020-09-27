import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class LoadingPosterCard extends StatelessWidget {
  // Set empty wiedget
  Widget setEmptyWidget() {
    return Shimmer.fromColors(
      baseColor: Color(0xFFECF0F1),
      highlightColor: Colors.white,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 5),
        width: double.infinity,
        height: 15,
        color: Color(0xFFECF0F1),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 310,
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
                      border: Border.all(
                        width: 2,
                        color: Color(0xFFECF0F1),
                      ),
                    ),
                    child: Stack(
                      children: <Widget>[
                        Positioned(
                          right: 0,
                          child: Container(
                            padding: EdgeInsets.all(5),
                            width: 160,
                            height: 180,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 10.0),
                                  child: setEmptyWidget(),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 5.0),
                                  child: setEmptyWidget(),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 5.0),
                                  child: setEmptyWidget(),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 0, bottom: 5.0),
                                  child: setEmptyWidget(),
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
            child: Shimmer.fromColors(
              baseColor: Color(0xFFECF0F1),
              highlightColor: Colors.white,
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: Container(
                    width: 50,
                    height: 10,
                    color: Color(0xFFECF0F1),
                  )),
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Shimmer.fromColors(
                baseColor: Color(0xFFECF0F1),
                highlightColor: Colors.white,
                child: CircleAvatar(
                  backgroundColor: Color(0xFFECF0F1),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
