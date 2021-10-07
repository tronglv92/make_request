import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:makerequest/models/local/role.dart';
import 'package:makerequest/models/remote/user_response.dart';
import 'package:makerequest/services/app/app_loading.dart';
import 'package:makerequest/services/app/auth_provider_firestore.dart';
import 'package:makerequest/services/app/user_provider.dart';
import 'package:makerequest/services/safety/page_stateful.dart';
import 'package:makerequest/utils/app_asset.dart';
import 'package:makerequest/utils/app_constant.dart';
import 'package:makerequest/utils/app_file.dart';
import 'package:makerequest/utils/app_log.dart';
import 'package:makerequest/utils/app_route.dart';
import 'package:makerequest/utils/app_style.dart';
import 'package:makerequest/widgets/a_button_rounded_long.dart';
import 'package:makerequest/widgets/a_circle_photo.dart';
import 'package:makerequest/widgets/a_input_form.dart';
import 'package:makerequest/widgets/a_option_normal.dart';
import 'package:makerequest/widgets/a_option_selected.dart';
import 'package:makerequest/widgets/a_popup_picker_image.dart';
import 'package:makerequest/widgets/p_appbar_transparency.dart';
import 'package:makerequest/widgets/w_button_circle.dart';
import 'package:makerequest/widgets/w_divider_line.dart';
import 'package:makerequest/widgets/w_keyboard_dismiss.dart';
import 'package:makerequest/utils/app_extension.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends PageStateful<ProfilePage> {
  late AuthProviderFireStore _auth;
  late UserProvider _userProvider;
  late TextEditingController _nameController;
  late TextEditingController _phoneController;
  late TextEditingController _emailController;
  late int roleId;
  late String photoUrl;
   UserResponse? currentUser;
  bool showLoadingPhoto = false;
  final PageController _pageController=PageController();

  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _auth = context.read();
    _userProvider = context.read();
    _nameController = TextEditingController();
    _phoneController = TextEditingController();
    _emailController = TextEditingController();
  }

  @override
  void afterFirstBuild(BuildContext context) {
    // TODO: implement afterFirstBuild
    super.afterFirstBuild(context);

    if (_auth.currentUser != null) {
      logger.e('afterFirstBuild auth email = ', _auth.currentUser?.email);
      setUpProfile(_auth.currentUser);
    }
  }

  void setUpProfile(UserResponse? user) {
    logger.e('setUpProfile = ');
    setState(() {
      currentUser = user;
      _nameController.text = user?.displayName??'';
      _phoneController.text = user?.phoneNumber??'';
      _emailController.text = user?.email??'';
      roleId = user?.roleId??0;
      photoUrl = user?.photoUrl??'';
    });
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    if (currentUser != _auth.currentUser && _auth.currentUser != null) {
      logger.e(
          'didChangeDependencies auth email = ', _auth.currentUser?.email);
      setUpProfile(_auth.currentUser);
    }
  }

  @override
  void didUpdateWidget(covariant ProfilePage oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
    // logger.e("didUpdateWidget auth ",_auth?.currentUser);
  }

  @override
  void initDependencies(BuildContext context) {
    super.initDependencies(context);

  }

  void onCompletedProfile() {
    if(_auth.currentUser?.uid==null)
      return;
    final UserResponse user = UserResponse(
        uid: _auth.currentUser?.uid??'',
        email: _auth.currentUser?.email??'',
        displayName: _nameController.text,
        phoneNumber: _phoneController.text,
        photoUrl: photoUrl,
        roleId: roleId);

    apiCallSafety(() => _userProvider.updateProfile(user),
        onStart: () async {
          AppLoading.show(context);
        },
        onCompleted: (bool status, void res) async {
          AppLoading.hide(context);
          Navigator.of(context).pushNamedAndRemoveUntil(
              AppRoute.routeHome, (Route<dynamic> route) => false);
        },
        skipOnError: true,
        onError: (dynamic error) async {
          logger.e('onCompletedProfile error = ', error);
        });
  }

  Future<void> onPressTakePhoto() async {
    Navigator.pop(context);
    if(_auth.currentUser?.uid!=null)
      {
        apiCallSafety<String?>(() => _userProvider.updatePhotoUser(context: context,uuid: _auth.currentUser?.uid??''),
            onStart: () async {
              setState(() {
                showLoadingPhoto=true;
              });
            },

            onCompleted: (bool status, String? res) async {


              // setState(() {
              //   showLoadingPhoto=false;
              //   if(res!=null)
              //     photoUrl=res;
              // });
            },
            skipOnError: true,
            onError: (dynamic error) async {
              logger.e('onCompletedProfile error = ', error);
            });

      }

  }

  Future<void> onPressChooseLibrary() async {}

  Future<void> onPressCancelImage() async {
    Navigator.of(context).pop();
  }

  Future<void> onPressEdit() async {
    showModalBottomSheet<void>(
        context: context,
        // isDismissible: false,
        // enableDrag: false,
        backgroundColor: Colors.transparent,
        builder: (BuildContext context) {
          return APopupPickerImage(
              onPressTakePhoto: onPressTakePhoto,
              onPressChooseLibrary: onPressChooseLibrary,
              onPressCancelImage: onPressCancelImage);
        });
  }
  Future<void> onPressPhoto(String photo) async {
    showDialog<void>(context: context, builder:(BuildContext context){
      return Container(
          child: PhotoViewGallery.builder(
            // scrollPhysics: const BouncingScrollPhysics(),
            builder: (BuildContext context, int index) {
              return PhotoViewGalleryPageOptions(
                imageProvider: CachedNetworkImageProvider(photo),
                initialScale: PhotoViewComputedScale.contained * 0.8,
                heroAttributes: PhotoViewHeroAttributes(tag: index),
              );
            },
            itemCount: 3,
            loadingBuilder: (BuildContext context, ImageChunkEvent? event) => Center(
              child: Container(
                width: 20.0,
                height: 20.0,
                child: Container(),
              ),
            ),
            backgroundDecoration: const BoxDecoration(
              color: Colors.black
            ),
            pageController: _pageController,
            onPageChanged: (int index){

            },
          )
      );
    });
  }
  @override
  Widget build(BuildContext context) {
    print('RENDER PROFILE == ');
    super.build(context);

    return PAppBarTransparency(
      child: WKeyboardDismiss(
        child: SafeArea(
          child: Container(
            color: Colors.transparent,
            padding: EdgeInsets.symmetric(horizontal: 30.W),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.close),
                      iconSize: 30.W,
                      color: Colors.black,
                    ),
                    Text(
                      'Profile Info',
                      style: txt18RegularRoboto(),
                    ),
                    SizedBox(
                      width: 30.W,
                    )
                  ],
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 30.H),

                        Center(
                          child: ACirclePhoto(
                            onPressPhoto: (){
                              onPressPhoto(photoUrl);
                            },
                            photoUrl: photoUrl,
                            showLoading: showLoadingPhoto,
                              onPressEdit:onPressEdit
                          ),
                        ),
                        SizedBox(height: 30.H),
                        //FIRST NAME
                        Padding(
                          padding: EdgeInsets.only(left: 30.W),
                          child: Text(
                            'Name',
                            style: TextStyle(
                                fontSize: 14,
                                color: Colors.black,
                                fontFamily: AppAssets.fontRoboto,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                        SizedBox(height: 10.H),
                        AInputForm(
                          hintText: 'Enter your name',
                          controller: _nameController,
                        ),

                        //PHONE
                        SizedBox(height: 25.H),

                        Padding(
                          padding: EdgeInsets.only(left: 30.W),
                          child: Text(
                            'Mobile number',
                            style: TextStyle(
                                fontSize: 14,
                                color: Colors.black,
                                fontFamily: AppAssets.fontRoboto,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                        SizedBox(height: 10.H),
                        AInputForm.phone(
                          hintText: 'Enter your phone',
                          controller: _phoneController,
                        ),
                        //EMAIL
                        SizedBox(height: 25.H),
                        Padding(
                          padding: EdgeInsets.only(left: 30.W),
                          child: Text(
                            'Email',
                            style: TextStyle(
                                fontSize: 14,
                                color: Colors.black,
                                fontFamily: AppAssets.fontRoboto,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                        SizedBox(height: 10.H),
                        AInputForm.email(
                          hintText: 'Enter your email',
                          controller: _emailController,
                          enabled: false,
                        ),

                        //Role
                        SizedBox(height: 25.H),
                        Padding(
                          padding: EdgeInsets.only(left: 30.W),
                          child: Text(
                            'You are',
                            style: TextStyle(
                                fontSize: 14,
                                color: Colors.black,
                                fontFamily: AppAssets.fontRoboto,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                        SizedBox(height: 10.H),
                        Row(
                          children: [
                            AOption(
                              label: 'User',
                              isSelected: roleId == Role.user.value,
                              onPress: () {
                                if (roleId != Role.user.value) {
                                  setState(() {
                                    roleId = Role.user.value;
                                  });
                                }
                              },
                            ),
                            SizedBox(
                              width: 50.W,
                            ),
                            AOption(
                              label: 'Store',
                              isSelected: roleId == Role.store.value,
                              onPress: () {
                                if (roleId != Role.store.value) {
                                  setState(() {
                                    roleId = Role.store.value;
                                  });
                                }
                              },
                            )
                          ],
                        ),

                        //Role
                        SizedBox(height: 80.H),

                        AButtonRoundedLong(
                          onPress: onCompletedProfile,
                          child: Text(
                            'Complete',
                            style: txt14RegularRoboto(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
