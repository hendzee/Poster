import 'dart:async';
import 'dart:io';

import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';

import '../cubit/user_cubit.dart';
import '../widgets/general/bottom_button.dart';

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
  bool _isUploadingPhoto = false;

  @override
  void initState() {
    _userCubit = BlocProvider.of<UserCubit>(context);

    super.initState();
  }

  // Handle image picker
  Future _handleImagePicker(ImagePickerType type, String userId) async {
    PickedFile pickedFile;
    final double MAX_WIDTH = 1080;
    final double MAX_HEIGHT = 1080;

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
        aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
        androidUiSettings: AndroidUiSettings(
          hideBottomControls: true,
        ),
      );

      if (croppedImage != null) {
        _userCubit.updatePhoto(userId, croppedImage.path.toString());

        setState(() {
          _isUploadingPhoto = true;
          _profileImage = File(croppedImage.path);
        });
      }
    }
  }

  // Asked to image picker
  Future _askedToImaegPicker(BuildContext context, String userId) async {
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
        _handleImagePicker(ImagePickerType.camera, userId);
        break;
      case ImagePickerType.file:
        _handleImagePicker(ImagePickerType.file, userId);
        break;
      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    FlutterStatusbarcolor.setStatusBarColor(Colors.white);

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
      body: BlocConsumer<UserCubit, UserState>(
        cubit: _userCubit,
        listener: (context, state) {
          if (state is UserError) {
            Scaffold.of(context)
                .showSnackBar(SnackBar(content: Text('Something went wrong')));
          } else if (state is UserLoaded && _isUploadingPhoto) {
            _isUploadingPhoto = false;
          }
        },
        builder: (context, state) {
          if (state is UserLoaded) {
            return SingleChildScrollView(
              child: Container(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 25),
                    GestureDetector(
                      onTap: () => _askedToImaegPicker(context, state.user.id),
                      child: Container(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 0),
                          child: Stack(
                            children: [
                              CircleAvatar(
                                radius: 40,
                                backgroundImage: state.user.photo != null
                                    ? NetworkImage(state.user.photo)
                                    : AssetImage('assets/images/profile.png'),
                              ),
                              Container(
                                width: 80,
                                height: 80,
                                child: Center(
                                  child: _isUploadingPhoto
                                      ? CircularProgressIndicator()
                                      : Container(),
                                ),
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
                    SizedBox(height: 25),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: Form(
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
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
          return Container();
        },
      ),
    );
  }
}
