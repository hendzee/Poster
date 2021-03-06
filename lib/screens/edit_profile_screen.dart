import 'dart:async';
import 'dart:io';

import 'package:country_code_picker/country_code_picker.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

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
  String _userId;
  String _firstName;
  String _lastName;
  String _country;
  String _phone;
  String _email;
  TextEditingController _firstNameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _emailController = TextEditingController();

  @override
  void initState() {
    _userCubit = BlocProvider.of<UserCubit>(context);
    _userId = _userCubit.user.id;
    _country = _userCubit.user.country == null ? 'ID' : _userCubit.user.country;
    _firstNameController.text = _userCubit.user.firstName;
    _lastNameController.text = _userCubit.user.lastName;
    _phoneController.text = _userCubit.user.phone;
    _emailController.text = _userCubit.user.email;

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

  // Updata profile
  void _updateProfile() {
    _userCubit.updateProfile(
      _userId,
      _firstName,
      _lastName,
      _country,
      _phone,
      _email,
    );
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
        onTap: () {
          if (_formKey.currentState.validate()) {
            _updateProfile();
          }
        },
      ),
      body: BlocConsumer<UserCubit, UserState>(
        cubit: _userCubit,
        listener: (context, state) {
          if (state is UserLoading) {
            showDialog(
              context: context,
              builder: (context) => Container(
                alignment: Alignment.center,
                child: CircularProgressIndicator(),
              ),
            );
          } else if (state is UserError) {
            Scaffold.of(context)
                .showSnackBar(SnackBar(content: Text('Something went wrong')));
          } else if (state is UserLoaded && _isUploadingPhoto) {
            _isUploadingPhoto = false;
          } else if (state is UserLoaded) {
            Navigator.pop(context);
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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: TextFormField(
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'First name must be filled';
                                      }
                                      return null;
                                    },
                                    onChanged: (value) {
                                      setState(() {
                                        _firstName = value;
                                      });
                                    },
                                    controller: _firstNameController,
                                    decoration: InputDecoration(
                                      labelText: 'First Name',
                                      prefixIcon: Icon(EvaIcons.personOutline),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 15),
                                Expanded(
                                  child: TextFormField(
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'Last name must be filled';
                                      }
                                      return null;
                                    },
                                    onChanged: (value) {
                                      setState(() {
                                        _lastName = value;
                                      });
                                    },
                                    controller: _lastNameController,
                                    decoration: InputDecoration(
                                      labelText: 'Last Name',
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            CountryCodePicker(
                              initialSelection: _country,
                              showCountryOnly: true,
                              boxDecoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              onChanged: (value) {
                                setState(() {
                                  _country = value.code.toString();
                                });
                              },
                              dialogSize: Size(
                                MediaQuery.of(context).size.width - 10,
                                MediaQuery.of(context).size.height - 80,
                              ),
                              closeIcon: Icon(
                                EvaIcons.closeOutline,
                                size: 36,
                              ),
                              builder: (data) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 12,
                                  ),
                                  child: Row(
                                    children: [
                                      Icon(Icons.flag_outlined,
                                          color: Colors.grey[500]),
                                      SizedBox(width: 13),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text('Country',
                                              style: TextStyle(fontSize: 11)),
                                          SizedBox(height: 5),
                                          Text(
                                            data.name,
                                            style: TextStyle(fontSize: 17),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                            Divider(
                              height: 2,
                              color: Colors.grey[700],
                            ),
                            TextFormField(
                              controller: _phoneController,
                              onChanged: (value) {
                                setState(() {
                                  _phone = value;
                                });
                              },
                              decoration: InputDecoration(
                                labelText: 'Phone',
                                prefixIcon: Icon(
                                  EvaIcons.phoneOutline,
                                ),
                              ),
                            ),
                            TextFormField(
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Email must be filled';
                                }
                                return null;
                              },
                              onChanged: (value) {
                                setState(() {
                                  _email = value;
                                });
                              },
                              controller: _emailController,
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
