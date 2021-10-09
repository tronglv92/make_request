import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:makerequest/generated/l10n.dart';
import 'package:makerequest/models/remote/user_response.dart';
import 'package:makerequest/services/app/app_dialog.dart';
import 'package:makerequest/services/app/app_loading.dart';
import 'package:makerequest/services/app/auth_provider.dart';

import 'package:makerequest/services/app/locale_provider.dart';
import 'package:makerequest/services/app/user_provider.dart';
import 'package:makerequest/services/cache/cache.dart';
import 'package:makerequest/services/cache/cache_preferences.dart';
import 'package:makerequest/services/cache/credential.dart';
import 'package:makerequest/services/rest_api/api_user.dart';
import 'package:makerequest/utils/app_extension.dart';
import 'package:makerequest/utils/app_file.dart';
import 'package:makerequest/utils/app_log.dart';
import 'package:makerequest/utils/app_route.dart';
import 'package:makerequest/utils/app_theme.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import 'services/app/auth_provider_firestore.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();
  print('Handling a background message ${message.messageId}');
}
/// Create a [AndroidNotificationChannel] for heads up notifications
late AndroidNotificationChannel channel;

/// Initialize the [FlutterLocalNotificationsPlugin] package.
late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
Future<void> myMain() async {


  // Start services later
  WidgetsFlutterBinding.ensureInitialized();


  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  if (!kIsWeb) {
    channel = const AndroidNotificationChannel(
      'high_importance_channel', // id
      'High Importance Notifications', // title
      description: 'This channel is used for important notifications.',
      importance: Importance.high,
    );

    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    // Create an Android Notification Channel.
    NotificationSettings settings = await FirebaseMessaging.instance.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');
    } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
      print('User granted provisional permission');
    } else {
      print('User declined or has not accepted permission');
    }
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    // Update the iOS foreground notification presentation options to allow
    // heads up notifications.
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  // Force portrait mode
  await SystemChrome.setPreferredOrientations(
      <DeviceOrientation>[DeviceOrientation.portraitUp]);

  // Run Application
  runApp(
    MultiProvider(
      providers: <SingleChildWidget>[
        Provider<AppRoute>(create: (_) => AppRoute()),
        Provider<Cache>(create: (_) => CachePreferences()),
        ChangeNotifierProvider<Credential>(
            create: (BuildContext context) => Credential(
                  Provider.of(context, listen: false),
                )),
        // Provider<ApiUser>(create: (_) => ApiUser()),
        ProxyProvider<Credential, ApiUser?>(
            create: (_) => ApiUser(),

            update: (_, Credential credential, ApiUser? userApi) {

              // logger.e("credential ",credential);
              // logger.e("credential.token ",credential.token);
              return userApi?..token=credential.token;
            }
            ),
        Provider<AppLoading>(create: (_) => AppLoading()),
        Provider<AppDialog>(create: (_) => AppDialog()),
        Provider<AppFile>(create: (_) => AppFile()),
        ChangeNotifierProvider<LocaleProvider>(
            create: (BuildContext context) => LocaleProvider()),
        ChangeNotifierProvider<AppThemeProvider>(
            create: (BuildContext context) => AppThemeProvider()),
        // ChangeNotifierProvider<AuthProvider>(
        //     create: (BuildContext context) => AuthProvider(
        //           Provider.of(context, listen: false),
        //           Provider.of(context, listen: false),
        //         )),
        ChangeNotifierProvider<AuthProvider>(
            create: (BuildContext context) => AuthProvider(
                Provider.of(context, listen: false),
                Provider.of(context, listen: false)!)),
        ChangeNotifierProvider<AuthProviderFireStore>(
            create: (BuildContext context) => AuthProviderFireStore()),
        ChangeNotifierProvider<UserProvider>(
            create: (BuildContext context) =>
                UserProvider(Provider.of(context, listen: false))),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late AuthProviderFireStore _auth;

  @override
  void initState() {
    super.initState();
    _auth = context.read();

    /// Init page
    WidgetsBinding.instance?.addPostFrameCallback((_) async {
      // final UserResponse? currentUser = await _auth.getCurrentUser();
      // if(currentUser!=null)
      //   {
      //     Future.delayed(const Duration(milliseconds: 3), () {
      //       context.navigator()?.pushReplacementNamed(AppRoute.routeProfile);
      //     });
      //   }

    });

    // firebase message

    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage? message) {
      if (message != null) {
        logger.d('message ',message);
      }
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null && !kIsWeb) {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                 channelDescription: channel.description,

                icon: 'launch_background',
              ),
            ));
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('A new onMessageOpenedApp event was published!');

    });

    getToken();
  }

  Future<void> getToken() async{
    FirebaseMessaging.instance.getToken().then((token) {
      print('FCM Token : $token');
    });
    if (defaultTargetPlatform == TargetPlatform.iOS ||
        defaultTargetPlatform == TargetPlatform.macOS) {
      print('FlutterFire Messaging Example: Getting APNs token...');
      String? token = await FirebaseMessaging.instance.getAPNSToken();
      print('FlutterFire Messaging Example: Got APNs token: $token');
    } else {
      print(
          'FlutterFire Messaging Example: Getting an APNs token is only supported on iOS and macOS platforms.');
    }
  }

  @override
  Widget build(BuildContext context) {
    /// Get providers
    final AppRoute appRoute = context.watch<AppRoute>();
    final LocaleProvider localeProvider = context.watch<LocaleProvider>();
    final AppTheme appTheme = context.appTheme();

    /// Init dynamic size
    /// https://pub.dev/packages/flutter_screenutil
    ///    ScreenUtil().pixelRatio       //Device pixel density
    ///    ScreenUtil().screenWidth   (sdk>=2.6 : 1.sw)    //Device width
    ///    ScreenUtil().screenHeight  (sdk>=2.6 : 1.sh)    //Device height
    ///    ScreenUtil().bottomBarHeight  //Bottom safe zone distance, suitable forƒ√ buttons with full screen
    ///    ScreenUtil().statusBarHeight  //Status bar height , Notch will be higher Unit px
    ///    ScreenUtil().textScaleFactor  //System font scaling factor
    ///
    ///    ScreenUtil().scaleWidth //Ratio of actual width dp to design draft px
    ///    ScreenUtil().scaleHeight //Ratio of actual height dp to design draft px
    ///
    ///    0.2.sw  //0.2 times the screen width
    ///    0.5.sh  //50% of screen height
    /// Set the fit size (fill in the screen size of the device in the design)
    /// https://www.paintcodeapp.com/news/ultimate-guide-to-iphone-resolutions
    ///    iPhone 2, 3, 4, 4s                => 3.5": 320 x 480 (points)
    ///    iPhone 5, 5s, 5C, SE (1st Gen)    => 4": 320 × 568 (points)
    ///    iPhone 6, 6s, 7, 8, SE (2st Gen)  => 4.7": 375 x 667 (points)
    ///    iPhone 6+, 6s+, 7+, 8+            => 5.5": 414 x 736 (points)
    ///    iPhone 11Pro, X, Xs               => 5.8": 375 x 812 (points)
    ///    iPhone 11, Xr                     => 6.1": 414 × 896 (points)
    ///    iPhone 11Pro Max, Xs Max          => 6.5": 414 x 896 (points)
    ///    iPhone 12 mini                    => 5.4": 375 x 812 (points)
    ///    iPhone 12, 12 Pro                 => 6.1": 390 x 844 (points)
    ///    iPhone 12 Pro Max                 => 6.7": 428 x 926 (points)
    return ScreenUtilInit(
      designSize: const Size(414, 896),
      builder: () => MaterialApp(
        navigatorKey: appRoute.navigatorKey,
        locale: localeProvider.locale,
        supportedLocales: S.delegate.supportedLocales,
        localizationsDelegates: const <LocalizationsDelegate<dynamic>>[
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        debugShowCheckedModeBanner: false,
        theme: appTheme.buildThemeData(),
        //https://stackoverflow.com/questions/57245175/flutter-dynamic-initial-route
        //https://github.com/flutter/flutter/issues/12454
        //home: (appRoute.generateRoute(
        ///            const RouteSettings(name: AppRoute.rootPageRoute))
        ///        as MaterialPageRoute<dynamic>)
        ///    .builder(context),
        initialRoute: AppRoute.routeSplash,
        onGenerateRoute: appRoute.generateRoute,
        navigatorObservers: <NavigatorObserver>[appRoute.routeObserver],
      ),
    );
  }
}
