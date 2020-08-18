import 'package:flutter/material.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';

class AddItemScreen extends StatefulWidget {
  @override
  _AddItemScreenState createState() => _AddItemScreenState();
}

class _AddItemScreenState extends State<AddItemScreen> {
  // Navigate back
  void _toBack(BuildContext context) {
      Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            EvaIcons.closeOutline
          ),
          onPressed: () => this._toBack(context),
        ),
        centerTitle: true,
        title: Text('New Event'),
      ),
      bottomSheet: Container(
        height: 50,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.deepPurple,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20)
          )
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextField(decoration: InputDecoration(labelText: 'Event Title'),)
              ],
            ),
          ),
        ),
      )
    );
  }
}
