// ignore_for_file: prefer_single_quotes

import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:makerequest/models/remote/error_response.dart';
import 'package:makerequest/models/remote/user_response.dart';
import 'package:makerequest/services/firebase/fcm_database.dart';
import 'package:makerequest/services/firebase/user_database.dart';
import 'package:makerequest/services/safety/change_notifier_safety.dart';
import 'package:makerequest/utils/app_log.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

enum AccountType { EMAIL, GOOGLE, FACEBOOK, APPLE }

class AuthProviderFireStore extends ChangeNotifierSafety {
  AuthProviderFireStore() {
    //initialise object
    _auth = FirebaseAuth.instance;
    _userDb = UserDatabase();
   
    //listener for authentication changes such as user sign in and sign out
    _auth.authStateChanges().listen(onAuthStateChanged);
  }

  //Firebase Auth object
  late FirebaseAuth _auth;
  late UserDatabase _userDb;
  
  AccountType accountType = AccountType.EMAIL;

  //Default status

  // Stream<Future<UserResponse>> get currentUser => _auth.authStateChanges().map(_userFromFirebase);
  UserResponse? currentUser;

  Future<UserResponse?> getCurrentUser({String? fcmToken}) async {
    final User? user = FirebaseAuth.instance.currentUser;

    await setCurrentUser(user);
    return currentUser;
  }

  Future<void> setCurrentUser(User? user) async {
    if (user == null) {
      currentUser = null;
      notifyListeners();
      return;
    } else {
      UserResponse? userDb = await _userDb.userStream(user.uid).first;

      // add new profile if new user
      if (userDb == null) {
        userDb = UserResponse.fromUserFirebase(user);
        _userDb.setUser(user: userDb, uid: user.uid);
      }
      currentUser = userDb;
      
      notifyListeners();

     
    }
  }

  void updateUser(UserResponse? user) {
    currentUser = user;
    notifyListeners();
  }

 

  //
  // //Method to detect live auth changes such as user sign in and sign out
  Future<void> onAuthStateChanged(User? firebaseUser) async {
    logger.e('onAuthStateChanged user = ', firebaseUser);
    await setCurrentUser(firebaseUser);
  }

  // //Method for new user registration using email and password
  // Future<UserResponse> registerWithEmailAndPassword(
  //     String email, String password) async {
  //   // try {
  //   //   notifyListeners();
  //   //   final UserCredential result = await _auth.createUserWithEmailAndPassword(
  //   //       email: email, password: password);
  //   //
  //   //   return _userFromFirebase(result.user);
  //   // } on FirebaseAuthException catch (e) {
  //   //   print('Error on the sign in = ');
  //   //   print('Failed with error code: ${e.code}');
  //   //   print(e.message);
  //   //   print('========================== ');
  //   //   throw ErrorResponse(message: e.message, code: e.code);
  //   // } catch (e) {
  //   //   print('Error signInWithApple3 = ' + e.toString());
  //   //   throw ErrorResponse(message: e.toString());
  //   // }
  // }

  //Method to handle user sign in using email and password
  Future<UserCredential> signInWithEmailAndPassword(String email, String password) async {
    try {
      final UserCredential userCredential = await _auth.signInWithEmailAndPassword(email: email, password: password);
      accountType = AccountType.EMAIL;
      return userCredential;
    } on FirebaseAuthException catch (e) {
      print('Error on the sign in = ');
      print('Failed with error code: ${e.code}');
      print(e.message);
      print('========================== ');
      String? message = e.message;
      if (e.code == 'user-not-found') {
        message = 'You have not register yet!';
      }
      throw ErrorResponse(message: message, code: e.code);
    } catch (e) {
      print('Error signInWithApple3 = ' + e.toString());
      throw ErrorResponse(message: e.toString());
    }
  }

  //Method to handle password reset email
  Future<void> sendPasswordResetEmail(String email) async {
    await _auth.sendPasswordResetEmail(email: email);
  }

  Future<UserCredential?> signInWithGoogle() async {
    try {
      GoogleSignIn _googleSignIn = GoogleSignIn(
        scopes: [
          'email',
          'https://www.googleapis.com/auth/userinfo.profile',
        ],
      );
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if (googleUser == null) return null;

      // Obtain the auth details from the request
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // Create a new credential
      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Once signed in, return the UserCredential
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
      accountType = AccountType.GOOGLE;
     
      return userCredential;
    } on FirebaseAuthException catch (e) {
      print('Error on the sign in = ');
      print('Failed with error code: ${e.code}');
      print(e.message);
      print('========================== ');
      throw ErrorResponse(message: e.message, code: e.code);
    } catch (e) {
      print('Error on the sign in3 = ' + e.toString());
      throw ErrorResponse(message: e.toString());
    }
  }

  Future<UserCredential?> signInWithFacebook() async {
    try {
      // Trigger the sign-in flow
      final LoginResult loginResult = await FacebookAuth.instance.login();
      if (loginResult.status == LoginStatus.success) {
        // Create a credential from the access token
        if (loginResult.accessToken?.token == null) return null;
        final OAuthCredential facebookAuthCredential =
            FacebookAuthProvider.credential(loginResult.accessToken!.token);

        // Once signed in, return the UserCredential
        UserCredential userCredential = await FirebaseAuth.instance
            .signInWithCredential(facebookAuthCredential);
        accountType = AccountType.FACEBOOK;
        return userCredential;
      } else if (loginResult.status == LoginStatus.cancelled) {
        throw ErrorResponse(message: 'User cancel login by facebook');
      } else {
        throw ErrorResponse(message: 'Have error! Please login again!');
      }
    } on FirebaseAuthException catch (e) {
      print('Error signInWithFacebook = ');
      print('Failed with error code: ${e.code}');
      print(e.message);
      print('========================== ');
      // print('Failed with error code: ');
      // print(e.message);
      // print('========================== ');
      throw ErrorResponse(message: e.message, code: e.code);
    } catch (e) {
      print('Error signInWithApple3 = ' + e.toString());
      throw ErrorResponse(message: e.toString());
    }
  }

  /// Generates a cryptographically secure random nonce, to be included in a
  /// credential request.
  String generateNonce([int length = 32]) {
    final String charset =
        '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
    final Random random = Random.secure();
    return List.generate(length, (_) => charset[random.nextInt(charset.length)])
        .join();
  }

  /// Returns the sha256 hash of [input] in hex notation.
  String sha256ofString(String input) {
    final List<int> bytes = utf8.encode(input);
    final Digest digest = sha256.convert(bytes);
    return digest.toString();
  }

  Future<UserCredential?> signInWithApple() async {
    try {
      if (Platform.isIOS) {
        // To prevent replay attacks with the credential returned from Apple, we
        // include a nonce in the credential request. When signing in with
        // Firebase, the nonce in the id token returned by Apple, is expected to
        // match the sha256 hash of `rawNonce`.
        final String rawNonce = generateNonce();
        final String nonce = sha256ofString(rawNonce);

        // Request credential for the currently signed in Apple account.
        final AuthorizationCredentialAppleID appleCredential =
            await SignInWithApple.getAppleIDCredential(
          scopes: [
            AppleIDAuthorizationScopes.email,
            AppleIDAuthorizationScopes.fullName,
          ],
          nonce: nonce,
        );

        // Create an `OAuthCredential` from the credential returned by Apple.
        final OAuthCredential oauthCredential =
            OAuthProvider("apple.com").credential(
          idToken: appleCredential.identityToken,
          rawNonce: rawNonce,
        );

        // Sign in the user with Firebase. If the nonce we generated earlier does
        // not match the nonce in `appleCredential.identityToken`, sign in will fail.
        UserCredential userCredential =
            await FirebaseAuth.instance.signInWithCredential(oauthCredential);
        accountType = AccountType.APPLE;
        return userCredential;
      } else if (Platform.isAndroid) {
        const String redirectURL =
            'https://slow-common-chimpanzee.glitch.me/callbacks/sign_in_with_apple';
        const String clientID = "2UD3WQS2VS.com.tronglv.makerequest";
        final AuthorizationCredentialAppleID appleIdCredential =
            await SignInWithApple.getAppleIDCredential(
                scopes: [
              AppleIDAuthorizationScopes.email,
              AppleIDAuthorizationScopes.fullName,
            ],
                webAuthenticationOptions: WebAuthenticationOptions(
                    clientId: clientID, redirectUri: Uri.parse(redirectURL)));

        // Create an `OAuthCredential` from the credential returned by Apple.
        final OAuthCredential oauthCredential =
            OAuthProvider("apple.com").credential(
          idToken: appleIdCredential.identityToken,
          accessToken: appleIdCredential.authorizationCode,
        );

        // Sign in the user with Firebase. If the nonce we generated earlier does
        // not match the nonce in `appleCredential.identityToken`, sign in will fail.
        UserCredential userCredential =
            await FirebaseAuth.instance.signInWithCredential(oauthCredential);
        accountType = AccountType.APPLE;
        return userCredential;
      }
      return null;
    } on SignInWithAppleAuthorizationException catch (e) {
      print('Error signInWithApple1 = ');
      print('Failed with error code: ${e.code}');
      print(e.message);
      print('========================== ');
      if (e.code == AuthorizationErrorCode.canceled) {
        throw ErrorResponse(message: 'You cancel your login');
      } else if (e.code == AuthorizationErrorCode.failed) {
        throw ErrorResponse(message: 'You failed your login');
      } else if (e.code == AuthorizationErrorCode.invalidResponse) {
        throw ErrorResponse(message: 'invalidResponse');
      } else {
        throw ErrorResponse(message: e.message);
      }
    } on FirebaseAuthException catch (e) {
      print('Error signInWithApple2 = ');
      print('Failed with error code: ${e.code}');
      print(e.message);
      print('========================== ');
      // print('Failed with error code: ');
      // print(e.message);
      // print('========================== ');
      throw ErrorResponse(message: e.message, code: e.code);
    } catch (e) {
      print('Error signInWithApple3 = ' + e.toString());
      throw ErrorResponse(message: e.toString());
    }
  }

  Future<void> signOut() async {
    logger.d('signOut ', accountType);
    final GoogleSignIn _googleSignIn = GoogleSignIn();
    if (accountType == AccountType.GOOGLE) await _googleSignIn.signOut();
    if (accountType == AccountType.FACEBOOK)
      await FacebookAuth.instance.logOut();
    await FirebaseAuth.instance.signOut();
  }

  @override
  void resetState() {
    // TODO: implement resetState
  }
}
