import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:makerequest/models/remote/error_response.dart';

import 'package:makerequest/services/app/api_call.dart';
import 'package:makerequest/services/app/app_dialog.dart';
import 'package:makerequest/services/app/app_loading.dart';
import 'package:makerequest/services/app/auth_provider.dart';
import 'package:makerequest/services/app/auth_provider_firestore.dart';

import 'package:makerequest/services/safety/page_stateful.dart';
import 'package:makerequest/utils/app_asset.dart';
import 'package:makerequest/utils/app_extension.dart';

import 'package:makerequest/utils/app_log.dart';
import 'package:makerequest/utils/app_route.dart';
import 'package:makerequest/utils/app_style.dart';
import 'package:makerequest/widgets/a_button_rounded_long.dart';
import 'package:makerequest/widgets/a_input_form.dart';
import 'package:makerequest/widgets/p_appbar_transparency.dart';

import 'package:makerequest/widgets/w_keyboard_dismiss.dart';
import 'package:provider/provider.dart';

import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends PageStateful<LoginPage>
    with WidgetsBindingObserver, ApiCall {
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();

  late TextEditingController _emailController;
  late TextEditingController _passwordController;

  // late LoginProvider loginProvider;
  late AuthProviderFireStore _authProviderFireStore;
  late AuthProvider authProvider;
  bool isAvailable = false;

  @override
  void initDependencies(BuildContext context) {
    super.initDependencies(context);
    // loginProvider = Provider.of(context, listen: false);
    _authProviderFireStore = Provider.of(context, listen: false);
    authProvider=Provider.of(context, listen: false);
  }

  @override
  void afterFirstBuild(BuildContext context) {
    // loginProvider.resetState();

    /// Init email focus
    /// autofocus in TextField has an issue on next keyboard button
    // _emailFocusNode.requestFocus();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addObserver(this);

    _emailController = TextEditingController(text: "");
    _passwordController = TextEditingController(text: "");
    checkAppleSignInAvailable();
  }

  Future<void> checkAppleSignInAvailable() async {
    bool avail = await SignInWithApple.isAvailable();

    setState(() {
      isAvailable = avail;
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance?.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    /// Log app life cycle state
    logger.d(state);
  }

  Future<void> onPressLogin() async {
    await apiCallSafety<bool>(
      () => _authProviderFireStore.signInWithEmailAndPassword(
          _emailController.text, _passwordController.text),
      onStart: () async {
        AppLoading.show(context);
      },
      onCompleted: (bool status, bool? res) async {
        AppLoading.hide(context);
        if (status == true) {
          Navigator.of(context).pushNamed(AppRoute.routeHome);
        }
      },
    );
  }

  Future<void> onPressRegister() async {
    // await apiCallSafety<UserResponse>(
    //       () =>
    //       _authProviderFireStore.registerWithEmailAndPassword(
    //           _emailController.text, _passwordController.text),
    //   onStart: () async {
    //     AppLoading.show(context);
    //   },
    //   onCompleted: (bool status, UserResponse? res) async {
    //     AppLoading.hide(context);
    //     if (status == true) {
    //       onLoginSuccess();
    //     }
    //   },
    //
    // );
  }

  Future<void> onPressFacebook() async {
    await apiCallSafety<UserCredential?>(
      () => _authProviderFireStore.signInWithFacebook(),
      onStart: () async {
        AppLoading.show(context);
      },
      onCompleted: (bool status, UserCredential? res) async {
        AppLoading.hide(context);
        if (status == true) {
          onLoginSuccess();
        }
      },
    );
  }

  Future<void> onPressGoogle() async {
    await apiCallSafety<UserCredential?>(
      () => _authProviderFireStore.signInWithGoogle(),
      onStart: () async {
        AppLoading.show(context);
      },
      onCompleted: (bool status, UserCredential? res) async {
        AppLoading.hide(context);
        if (status == true && res != null) {
          onLoginSuccess();
        }
      },
    );
  }

  Future<void> onPressApple() async {
    await apiCallSafety<UserCredential?>(
      () => _authProviderFireStore.signInWithApple(),
      onStart: () async {
        AppLoading.show(context);
      },
      onCompleted: (bool status, UserCredential? res) async {
        AppLoading.hide(context);
        if (status == true && res != null) {
          onLoginSuccess();
        }
      },
    );
  }

  Future<void> onLoginSuccess() async {
    Navigator.of(context).pushNamed(AppRoute.routeProfile);
  }

  @override
  Future<int> onApiError(dynamic error) async {
    // TODO: implement onApiError

    if (error is ErrorResponse) {
      logger.e("error 1 ", error);
      final ErrorResponse errorResponse = error;
      await AppDialog.show(context, errorResponse.message??'');
    } else {
      logger.e("error 2 ", error);
      await AppDialog.show(context, error.toString());
    }
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return PAppBarTransparency(
      child: WKeyboardDismiss(
        child: SafeArea(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 30.W),
            child: SingleChildScrollView(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(left: 20.W),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 50.H),
                        Container(
                          height: 80.H,
                          width: 80.W,
                          color: Colors.red,
                        ),
                        SizedBox(height: 30.H),
                        Text(
                          context.strings.labelWellComeLogin,
                          style: txt32BoldRoboto(),
                        ),
                        SizedBox(height: 10.H),
                        Text(
                          context.strings.labelMessageLogin,
                          style: txt18RegularRoboto(
                              color: AppAssets.colorGrayOfText),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 50.H),
                  Padding(
                    padding: EdgeInsets.only(left: 30.W),
                    child: Text(
                      context.strings.labelEmailLogin,
                      style: TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                          fontFamily: AppAssets.fontRoboto,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                  SizedBox(height: 10.H),
                  AInputForm.email(
                    focusNode: _emailFocusNode,
                    controller: _emailController,
                  ),
                  SizedBox(height: 20.H),
                  AInputForm.password(
                    focusNode: _passwordFocusNode,
                    controller: _passwordController,
                  ),

                  SizedBox(
                    height: 20.H,
                  ),
                  // REMEMBER ME
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 15.W,
                      ),
                      Container(
                        height: 20.H,
                        width: 20.W,
                        color: Colors.red,
                      ),
                      SizedBox(
                        width: 10.W,
                      ),
                      Text(
                        context.strings.labelRememberMeLogin,
                        style: txt16RegularRoboto(color: Colors.black),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 40.H,
                  ),
                  AButtonRoundedLong(
                    onPress: onPressLogin,
                    child: Center(
                      child: Text(
                        'Login',
                        style: txt18RegularRoboto(color: Colors.white),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10.H,
                  ),
                  AButtonRoundedLong(
                    onPress: onPressRegister,
                    child: Center(
                      child: Text(
                        'Register',
                        style: txt18RegularRoboto(color: Colors.white),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10.H,
                  ),
                  AButtonRoundedLong(
                    onPress: onPressFacebook,
                    child: Center(
                      child: Text(
                        'Facebook',
                        style: txt18RegularRoboto(color: Colors.white),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10.H,
                  ),
                  AButtonRoundedLong(
                    onPress: onPressGoogle,
                    child: Center(
                      child: Text(
                        'Google',
                        style: txt18RegularRoboto(color: Colors.white),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10.H,
                  ),
                  if (isAvailable == true)
                    AButtonRoundedLong(
                      onPress: onPressApple,
                      child: Center(
                        child: Text(
                          'Apple',
                          style: txt18RegularRoboto(color: Colors.white),
                        ),
                      ),
                    ),

                  // SizedBox(height: 30.H,)
                ])),
          ),
        ),
      ),
    );
  }
}
