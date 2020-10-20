import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class NotificationListLoading extends StatelessWidget {
  Widget setLoadingContent() {
    List<Widget> loadingList = [];

    final loadingWidget = Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(10)),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                spreadRadius: 2,
                blurRadius: 5,
                offset: Offset(0, 3),
              )
            ]),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Shimmer.fromColors(
              baseColor: Color(0xFFECF0F1),
              highlightColor: Colors.white,
              child: Container(
                width: 50,
                height: 70,
                decoration: BoxDecoration(
                  color: Color(0xFFECF0F1),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Column(
              children: [
                Shimmer.fromColors(
                  baseColor: Color(0xFFECF0F1),
                  highlightColor: Colors.white,
                  child: Container(
                    width: 90,
                    height: 10,
                    margin: EdgeInsets.only(bottom: 15),
                    color: Color(0xFFECF0F1),
                  ),
                ),
                Shimmer.fromColors(
                  baseColor: Color(0xFFECF0F1),
                  highlightColor: Colors.white,
                  child: Container(
                    width: 90,
                    height: 10,
                    margin: EdgeInsets.only(bottom: 15),
                    color: Color(0xFFECF0F1),
                  ),
                ),
                Shimmer.fromColors(
                  baseColor: Color(0xFFECF0F1),
                  highlightColor: Colors.white,
                  child: Container(
                    width: 90,
                    height: 10,
                    margin: EdgeInsets.only(bottom: 15),
                    color: Color(0xFFECF0F1),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );

    for (int i = 0; i < 3; i++) {
      loadingList.add(loadingWidget);
    }

    return Column(children: loadingList);
  }

  @override
  Widget build(BuildContext context) {
    return setLoadingContent();
  }
}
