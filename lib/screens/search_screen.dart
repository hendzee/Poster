import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import '../widgets/general/search_bar.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Row(
          children: <Widget>[
            Icon(EvaIcons.arrowBackOutline),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: Form(
                child: TextField(
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Color(0xFFECF0F1),
                      hintText: 'Search',
                      suffixIcon:
                          IconButton(
                              icon: Icon(EvaIcons.searchOutline)
                          )),
                ),
              ),
            ),
          ],
        ),
      ),
      body: Center(
        child: Text('This is search page'),
      ),
    );
  }
}
