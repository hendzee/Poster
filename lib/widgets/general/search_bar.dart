import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../searchbar_explore/searchbar_result.dart';

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
      textTheme: TextTheme(headline6: TextStyle(color: Colors.black)),
      inputDecorationTheme: InputDecorationTheme(
        hintStyle: TextStyle(
          color: Colors.grey,
        ),
      ),
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
    return SearchbarResult();
  }
}
