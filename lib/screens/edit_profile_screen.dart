import 'dart:io';
import 'dart:async';

import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:poster/cubit/user_cubit.dart';

import '../widgets/general/bottom_button.dart';

import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';

// Enum for camera and gallery
enum ImagePickerType { camera, file }

class EditProfileScreen extends StatefulWidget {
  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  File _profileImage; // Photo profile image
  final _formKey = GlobalKey<FormState>();
  final _picker = ImagePicker(); // Poster image picker function
  UserCubit _userCubit;

  @override
  void initState() {
    print('Kesini Broo');
    _userCubit = BlocProvider.of<UserCubit>(context);

    _userCubit.getDataLogin();
    super.initState();
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
        _profileImage = File(pickedFile.path);
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

  @override
  Widget build(BuildContext context) {
    FlutterStatusbarcolor.setStatusBarColor(Colors.white);

    _userCubit.getDataLogin();

    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context, false);
          },
          icon: Icon(
            EvaIcons.arrowBackOutline,
          ),
        ),
      ),
      bottomSheet: BottomButton(
        title: 'SAVE',
      ),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () => _askedToImaegPicker(context),
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 40),
                    child: Stack(
                      children: [
                        CircleAvatar(
                          radius: 40,
                          backgroundImage:
                              AssetImage('assets/dummy_images/user1.png'),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: InkResponse(
                            onTap: null,
                            child: Container(
                              width: 30,
                              height: 30,
                              decoration: BoxDecoration(
                                color: Color(0xFFBDC3C7),
                                shape: BoxShape.circle,
                              ),
                              child: IconButton(
                                icon: Icon(
                                  EvaIcons.cameraOutline,
                                  color: Colors.black,
                                  size: 15,
                                ),
                                onPressed: null,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: BlocConsumer<UserCubit, UserState>(
                  cubit: _userCubit,
                  listener: (context, state) {},
                  builder: (context, state) {
                    if (state is UserLoaded) {
                      return Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: TextField(
                                    controller: TextEditingController()
                                      ..text = state.user.firstName.toString(),
                                    decoration: InputDecoration(
                                      labelText: 'First Name',
                                      prefixIcon: Icon(EvaIcons.personOutline),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 15),
                                Expanded(
                                  child: TextField(
                                    controller: TextEditingController()
                                      ..text = state.user.lastName.toString(),
                                    decoration: InputDecoration(
                                      labelText: 'Last Name',
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            TextField(
                              controller: TextEditingController()
                                ..text = state.user.phone != null
                                    ? state.user.phone.toString()
                                    : '',
                              decoration: InputDecoration(
                                labelText: 'Phone',
                                prefixIcon: Icon(
                                  EvaIcons.phoneOutline,
                                ),
                              ),
                            ),
                            TextField(
                              controller: TextEditingController()
                                ..text = state.user.email.toString(),
                              decoration: InputDecoration(
                                labelText: 'Email',
                                prefixIcon: Icon(EvaIcons.emailOutline),
                              ),
                            )
                          ],
                        ),
                      );
                    }
                    return Container();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
