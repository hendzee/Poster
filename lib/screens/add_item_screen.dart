import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';

// Enum radio button price
enum PriceType{ free, paid }

class AddItemScreen extends StatefulWidget {
  @override
  _AddItemScreenState createState() => _AddItemScreenState();
}

class _AddItemScreenState extends State<AddItemScreen> {
  PriceType _priceType = PriceType.free;

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
          color: Color(0xFFD14081),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20)
          )
        ),
        child: Center(
          child: Text('PUBLISH',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Event Title',
                    prefixIcon: Icon(EvaIcons.plusOutline)
                  ),
                ),
                TextField(decoration: InputDecoration(
                    labelText: 'Event Location',
                    prefixIcon: Icon(EvaIcons.pinOutline)
                  ),
                ),
                TextField(
                  maxLines: 3,
                  decoration: InputDecoration(
                    labelText: 'Detail Location',
                    prefixIcon: Icon(EvaIcons.mapOutline)
                  ),
                ),
                TextField(
                  maxLines: 3,
                  decoration: InputDecoration(
                    labelText: 'Detail Location',
                    prefixIcon: Icon(EvaIcons.mapOutline)
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  margin: EdgeInsets.only(top: 25),
                  decoration: BoxDecoration(
                    color: Color(0XFFf1f2f6),
                    borderRadius: BorderRadius.all(Radius.circular(20))
                  ),
                  child: Row(
                    children: [
                      Radio(
                        activeColor: Color(0xFF40407A),
                        value: PriceType.free,
                        groupValue: _priceType,
                        onChanged: (selectedValue) {
                          setState(() {
                            _priceType = selectedValue;
                          });
                        },
                      ),
                      SizedBox(width: 3,),
                      GestureDetector(
                          child: Text('Free Admission')
                      ),
                      SizedBox(width: 15,),
                      Radio(
                        activeColor: Color(0xFF40407A),
                        value: PriceType.paid,
                        groupValue: _priceType,
                        onChanged: (selectedValue) {
                          setState(() {
                            _priceType = selectedValue;
                          });
                        },
                      ),
                      SizedBox(width: 3,),
                      Text('Paid')
                    ],
                  ),
                ),
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Price (If not Free)',
                    prefixIcon: Icon(EvaIcons.creditCardOutline)
                  ),
                ),
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Twitter',
                    prefixIcon: Icon(EvaIcons.twitterOutline)
                  ),
                ),
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Facebook',
                    prefixIcon: Icon(EvaIcons.facebookOutline)
                  ),
                ),
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Instagram',
                    prefixIcon: Icon(EvaIcons.cameraOutline)
                  ),
                ),
              ],
            ),
          ),
        ),
      )
    );
  }
}
