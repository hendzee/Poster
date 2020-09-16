import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'share_button.dart';
import 'subscribe_button.dart';

class SearchBar extends SearchDelegate<String> {
  // List Dummy Data
  final listData = [
    'Malang Tempoe Doeloe 2020',
    'Pengajian Akbar, Every Friday',
    'Car Free Day',
    'Concert 2020',
    'Indonesian Flower Festival',
    'Food Festival'
  ];

  // Recent Dummy Data
  final recents = [
    'Concert 2020',
    'Indonesian Flower Festival',
  ];

  @override
  ThemeData appBarTheme(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return theme.copyWith(
      textTheme: TextTheme(headline6: TextStyle(color: Colors.white)),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestionList = query.isEmpty
        ? recents
        : listData
            .where((element) => (element
                .toUpperCase()
                .trim()
                .startsWith((query.toUpperCase().trim()))))
            .toList();

    return ListView.builder(
        itemCount: suggestionList.length,
        itemBuilder: (context, index) => ListTile(
              onTap: () {
                showResults(context);
              },
              leading: Icon(EvaIcons.clockOutline),
              title: RichText(
                text: TextSpan(
                    text: suggestionList[index].substring(0, query.length),
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.black),
                    children: [
                      TextSpan(
                          text: suggestionList[index].substring(query.length),
                          style: TextStyle(color: Colors.grey))
                    ]),
              ),
            ));
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(EvaIcons.closeOutline),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(EvaIcons.arrowBackOutline),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: GridView.builder(
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
                      SizedBox(height: 15,),
                      Text('Paradise After Night', style: TextStyle(fontWeight: FontWeight.bold),),
                      SizedBox(height: 5,),
                      Text('20 Sep, 2020'),
                      Text('Matos, Malang'),
                    ],
                  ),
                ),
              )),
    );
  }
}
