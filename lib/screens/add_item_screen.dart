import 'dart:async';
import 'dart:io';

import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:image_picker/image_picker.dart';
import 'package:poster/cubit/add_poster_cubit.dart';
import 'package:poster/cubit/user_cubit.dart';
import 'package:poster/data/add_poster_repository.dart';
import 'package:image_cropper/image_cropper.dart';

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
  AddPosterCubit _addPosterCubit = AddPosterCubit(ImpAddPosterRepository());
  File _poster; // Poster image
  String _posterPath;
  final _picker = ImagePicker(); // Poster image picker function
  PriceType _priceType = PriceType.free;
  bool _isPaid = false;
  final _formKey = GlobalKey<FormState>();
  String _userId = '';
  String _category = '';
  String _country = '';
  String _title = '';
  String _location = '';
  String _detailLocation = '';
  String _description = '';
  DateTime _startDate = DateTime.now();
  DateTime _endDate = DateTime.now().add(Duration(days: 1));
  String _price = '';
  String _twitter = '';
  String _facebook = '';
  String _instagram = '';
  bool _loading = false;

  @override
  void initState() {
    _userId = BlocProvider.of<UserCubit>(context).user.id;
    _country = BlocProvider.of<UserCubit>(context).user.country;

    super.initState();
  }

  // Handle datepicker
  Future _handleDatePicker(BuildContext context) async {
    DateTimeRange picked = await showDateRangePicker(
      context: context,
      firstDate: _startDate,
      lastDate: DateTime(DateTime.now().year + 3),
      saveText: 'SAVE',
    );

    if (picked != null) {
      setState(() {
        _startDate = picked.start;
        _endDate = picked.end;
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

    final double MAX_WIDTH = 1200;
    final double MAX_HEIGHT = 1700;

    if (type == ImagePickerType.camera) {
      pickedFile = await _picker.getImage(
        maxHeight: MAX_HEIGHT,
        maxWidth: MAX_WIDTH,
        source: ImageSource.camera,
      );
    } else {
      pickedFile = await _picker.getImage(
        maxHeight: MAX_HEIGHT,
        maxWidth: MAX_WIDTH,
        source: ImageSource.gallery,
      );
    }

    if (pickedFile != null) {
      // Crop image
      File croppedImage = await ImageCropper.cropImage(
        sourcePath: pickedFile.path,
        maxWidth: MAX_WIDTH.round(), // parse double to int with round()
        maxHeight: MAX_HEIGHT.round(), // parse double to int with round()
        aspectRatio: CropAspectRatio(ratioX: 12, ratioY: 17),
        androidUiSettings: AndroidUiSettings(
          hideBottomControls: true,
        ),
      );

      if (croppedImage != null) {
        setState(() {
          _poster = File(pickedFile.path);
        });
      }
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

  // Publish poster
  void _publish() {
    setState(() {
      _loading = true;
    });

    _addPosterCubit.addPoster(
      userId: _userId,
      country: _country,
      category: _category,
      title: _title,
      photo: _poster.path.toString(),
      description: _description,
      location: _location,
      detailLocation: _detailLocation,
      startDate: _startDate.toString(),
      endDate: _endDate.toString(),
      price: _priceType == PriceType.free ? '0' : _price,
      twitter: _twitter,
      facebook: _facebook,
      instagram: _instagram,
    );
  }

  @override
  Widget build(BuildContext context) {
    FlutterStatusbarcolor.setStatusBarColor(Colors.white);

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
        onTap: _publish,
      ),
      body: BlocListener<AddPosterCubit, AddPosterState>(
        cubit: _addPosterCubit,
        listener: (context, state) {
          if (state is AddPosterLoading) {
            showDialog(
              context: context,
              builder: (context) => Container(
                alignment: Alignment.center,
                child: CircularProgressIndicator(),
              ),
            );
          } else if (state is AddPosterLoaded) {
            if (_loading) {
              setState(() {
                _loading = false;
                Navigator.pop(context);
              });
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Poster was published.')));
            }
          }
        },
        child: SingleChildScrollView(
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
                          _poster == null
                              ? Text('Please select your image poster')
                              : Icon(Icons.check),
                        ],
                      ),
                    ),
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Event Title',
                      prefixIcon: Icon(EvaIcons.plusOutline),
                    ),
                    onChanged: (value) {
                      _title = value;
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Category',
                      prefixIcon: Icon(EvaIcons.pricetagsOutline),
                    ),
                    onChanged: (value) {
                      _category = value;
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Event Location',
                      prefixIcon: Icon(EvaIcons.pinOutline),
                    ),
                    onChanged: (value) {
                      _location = value;
                    },
                  ),
                  TextFormField(
                    maxLines: 3,
                    decoration: InputDecoration(
                      labelText: 'Detail Location',
                      prefixIcon: Icon(EvaIcons.mapOutline),
                    ),
                    onChanged: (value) {
                      _detailLocation = value;
                    },
                  ),
                  Theme(
                    data: Theme.of(context).copyWith(
                      appBarTheme: AppBarTheme(color: Color(0xFF40407A)),
                    ),
                    child: Builder(
                      builder: (context) {
                        return GestureDetector(
                          onTap: () async {
                            await _handleDatePicker(context);
                          },
                          child: Container(
                            width: double.infinity,
                            padding: EdgeInsets.symmetric(
                                horizontal: 25, vertical: 20),
                            margin: EdgeInsets.only(top: 25),
                            decoration: BoxDecoration(
                                color: Color(0XFFF1F2F6),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
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
                        );
                      },
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
                  TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Price (If not Free)',
                      prefixIcon: Icon(EvaIcons.creditCardOutline),
                      enabled: _isPaid,
                    ),
                    onChanged: (value) {
                      _price = value;
                    },
                  ),
                  TextFormField(
                    maxLines: 3,
                    decoration: InputDecoration(
                      labelText: 'Description',
                      prefixIcon: Icon(EvaIcons.fileTextOutline),
                    ),
                    onChanged: (value) {
                      _description = value;
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Twitter',
                      prefixIcon: Icon(EvaIcons.twitterOutline),
                    ),
                    onChanged: (value) {
                      _twitter = value;
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Facebook',
                      prefixIcon: Icon(EvaIcons.facebookOutline),
                    ),
                    onChanged: (value) {
                      _facebook = value;
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Instagram',
                      prefixIcon: Icon(EvaIcons.cameraOutline),
                    ),
                    onChanged: (value) {
                      _instagram = value;
                    },
                  ),
                  SizedBox(
                    height: 100,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
