import 'dart:async';
import 'dart:io';

import 'package:date_range_picker/date_range_picker.dart' as DateRagePicker;
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../modules/date_formater.dart'; // Date formater
import '../widgets/general/bottom_button.dart';

// Enum radio button price
enum PriceType { free, paid }
// Enum for camera and gallery
enum ImagePickerType { camera, file }

class AddItemScreen extends StatefulWidget {
  @override
  _AddItemScreenState createState() => _AddItemScreenState();
}

class _AddItemScreenState extends State<AddItemScreen> {
  File _poster; // Poster image
  final _picker = ImagePicker(); // Poster image picker function
  PriceType _priceType = PriceType.free;
  bool _isPaid = false;
  DateTime _startDate = DateTime.now();
  DateTime _endDate = DateTime.now().add(Duration(days: 1));
  final _formKey = GlobalKey<FormState>();

  // Handle datepicker
  Future _handleDatePicker(BuildContext context) async {
    final List<DateTime> picked = await DateRagePicker.showDatePicker(
        context: context,
        initialFirstDate: _startDate,
        initialLastDate: _endDate,
        firstDate: _startDate,
        lastDate: DateTime(DateTime.now().year + 3));
    if (picked != null && picked.length == 2) {
      setState(() {
        _startDate = picked[0];
        _endDate = picked[1];
      });
    } else if (picked != null && picked.length == 1) {
      setState(() {
        _startDate = picked[0];
        _endDate = picked[0];
      });
    }
  }

  // Asked to image picker
  Future _askedToImaegPicker(BuildContext context) async {
    switch (await showDialog<ImagePickerType>(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            title: Text('Choose Poster Image'),
            children: [
              SimpleDialogOption(
                onPressed: () {
                  Navigator.pop(context, ImagePickerType.camera);
                },
                child: Text('Open Camera'),
              ),
              SimpleDialogOption(
                onPressed: () {
                  Navigator.pop(context, ImagePickerType.file);
                },
                child: Text('Open Gallery'),
              ),
              SimpleDialogOption(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Cancel'),
              )
            ],
          );
        })) {
      case ImagePickerType.camera:
        _handleImagePicker(ImagePickerType.camera);
        break;
      case ImagePickerType.file:
        _handleImagePicker(ImagePickerType.file);
        break;
      default:
    }
  }

  // Handle image picker
  Future _handleImagePicker(ImagePickerType type) async {
    PickedFile pickedFile;

    if (type == ImagePickerType.camera) {
      pickedFile = await _picker.getImage(source: ImageSource.camera);
    } else {
      pickedFile = await _picker.getImage(source: ImageSource.gallery);
    }

    if (pickedFile != null) {
      setState(() {
        _poster = File(pickedFile.path);
      });
    }
  }

  // Set image poster
  Widget _setImagePoster() {
    if (_poster == null) {
      return Container(
        width: 30,
        height: 35,
        decoration: BoxDecoration(color: Color(0XFFF1F2F6)),
        child: Center(
          child: Icon(EvaIcons.imageOutline),
        ),
      );
    }
    return Image.file(
      _poster,
      width: 30,
      height: 35,
    );
  }

  // Navigate back
  void _toBack(BuildContext context) {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(EvaIcons.closeOutline),
            onPressed: () => _toBack(context),
          ),
          centerTitle: true,
          title: Text('New Event'),
        ),
        bottomSheet: BottomButton(
          title: 'PUBLISH',
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () async {
                      _askedToImaegPicker(context);
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 25),
                      child: Row(
                        children: [
                          _setImagePoster(),
                          SizedBox(
                            width: 15,
                          ),
                          Text('Please select your image poster')
                        ],
                      ),
                    ),
                  ),
                  TextField(
                    decoration: InputDecoration(
                        labelText: 'Event Title',
                        prefixIcon: Icon(EvaIcons.plusOutline)),
                  ),
                  TextField(
                    decoration: InputDecoration(
                        labelText: 'Event Location',
                        prefixIcon: Icon(EvaIcons.pinOutline)),
                  ),
                  TextField(
                    maxLines: 3,
                    decoration: InputDecoration(
                        labelText: 'Detail Location',
                        prefixIcon: Icon(EvaIcons.mapOutline)),
                  ),
                  GestureDetector(
                    onTap: () async {
                      await _handleDatePicker(context);
                    },
                    child: Container(
                      width: double.infinity,
                      padding:
                          EdgeInsets.symmetric(horizontal: 25, vertical: 20),
                      margin: EdgeInsets.only(top: 25),
                      decoration: BoxDecoration(
                          color: Color(0XFFF1F2F6),
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      child: Row(
                        children: <Widget>[
                          Icon(EvaIcons.calendarOutline),
                          SizedBox(
                            width: 10,
                          ),
                          Text(DateFormater.standardDateRange(
                              _startDate, _endDate)),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    margin: EdgeInsets.only(top: 25),
                    decoration: BoxDecoration(
                        color: Color(0XFFF1F2F6),
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    child: Row(
                      children: [
                        Radio(
                          activeColor: Color(0xFF40407A),
                          value: PriceType.free,
                          groupValue: _priceType,
                          onChanged: (selectedValue) {
                            setState(() {
                              _priceType = selectedValue;
                              _isPaid = false;
                            });
                          },
                        ),
                        SizedBox(
                          width: 3,
                        ),
                        GestureDetector(
                          child: Text('Free Admission'),
                          onTap: () {
                            setState(() {
                              _priceType = PriceType.free;
                              _isPaid = false;
                            });
                          },
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Radio(
                          activeColor: Color(0xFF40407A),
                          value: PriceType.paid,
                          groupValue: _priceType,
                          onChanged: (selectedValue) {
                            setState(() {
                              _priceType = selectedValue;
                              _isPaid = true;
                            });
                          },
                        ),
                        SizedBox(
                          width: 3,
                        ),
                        GestureDetector(
                          child: Text('Paid'),
                          onTap: () {
                            setState(() {
                              _priceType = PriceType.paid;
                              _isPaid = true;
                            });
                          },
                        )
                      ],
                    ),
                  ),
                  TextField(
                    decoration: InputDecoration(
                        labelText: 'Price (If not Free)',
                        prefixIcon: Icon(EvaIcons.creditCardOutline),
                        enabled: _isPaid),
                  ),
                  TextField(
                    decoration: InputDecoration(
                        labelText: 'Twitter',
                        prefixIcon: Icon(EvaIcons.twitterOutline)),
                  ),
                  TextField(
                    decoration: InputDecoration(
                        labelText: 'Facebook',
                        prefixIcon: Icon(EvaIcons.facebookOutline)),
                  ),
                  TextField(
                    decoration: InputDecoration(
                        labelText: 'Instagram',
                        prefixIcon: Icon(EvaIcons.cameraOutline)),
                  ),
                  SizedBox(
                    height: 100,
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
