import 'package:flutter/material.dart';
import 'share_button.dart';
import 'subscribe_button.dart';

class SearchbarResult extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        itemCount: 2,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 4 / 5,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10),
        itemBuilder: (context, index) => Card(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            child: Container(
                              width: 55,
                              height: 75,
                              child: Image(
                                fit: BoxFit.cover,
                                image: AssetImage(
                                    'assets/dummy_images/poster1.png'),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Expanded(
                            child: Container(
                              height: 75,
                              child: Column(
                                children: [
                                  SubscribeButton(),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  ShareButton()
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      'Paradise After Night',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text('20 Sep, 2020'),
                    Text('Matos, Malang'),
                  ],
                ),
              ),
            ));
  }
}
