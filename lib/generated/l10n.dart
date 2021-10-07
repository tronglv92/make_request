// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `hello`
  String get hello {
    return Intl.message(
      'hello',
      name: 'hello',
      desc: 'Hello someone',
      args: [],
    );
  }

  /// `Evogate App Helps You Organize Your Visitors`
  String get titleSplash {
    return Intl.message(
      'Evogate App Helps You Organize Your Visitors',
      name: 'titleSplash',
      desc: 'Title of Splash screen',
      args: [],
    );
  }

  /// `Facilitating visitors coming to the company and`
  String get messageLabel {
    return Intl.message(
      'Facilitating visitors coming to the company and',
      name: 'messageLabel',
      desc: 'Message of Splash screen',
      args: [],
    );
  }

  /// `Email`
  String get labelEmailLogin {
    return Intl.message(
      'Email',
      name: 'labelEmailLogin',
      desc: 'TextField email label',
      args: [],
    );
  }

  /// `Password`
  String get labelPasswordLogin {
    return Intl.message(
      'Password',
      name: 'labelPasswordLogin',
      desc: '',
      args: [],
    );
  }

  /// `Remember Me`
  String get labelRememberMeLogin {
    return Intl.message(
      'Remember Me',
      name: 'labelRememberMeLogin',
      desc: 'Remember Me label of Login Screen',
      args: [],
    );
  }

  /// `Forgot your password?`
  String get labelForgotPasswordLogin {
    return Intl.message(
      'Forgot your password?',
      name: 'labelForgotPasswordLogin',
      desc: 'Forgot your password of Login Screen',
      args: [],
    );
  }

  /// `Forgotten Password By `
  String get labelForgotPasswordByLogin {
    return Intl.message(
      'Forgotten Password By ',
      name: 'labelForgotPasswordByLogin',
      desc: 'Forgotten Password By  of Login Screen',
      args: [],
    );
  }

  /// `Welcome \nTo Evograte`
  String get labelWellComeLogin {
    return Intl.message(
      'Welcome \nTo Evograte',
      name: 'labelWellComeLogin',
      desc: 'Welcome To Evograte of Login Screen',
      args: [],
    );
  }

  /// `Facilitating visitors coming to the`
  String get labelMessageLogin {
    return Intl.message(
      'Facilitating visitors coming to the',
      name: 'labelMessageLogin',
      desc: 'Facilitating visitors coming to the of Login Screen',
      args: [],
    );
  }

  /// `Sign In`
  String get btnLogin {
    return Intl.message(
      'Sign In',
      name: 'btnLogin',
      desc: 'Button login label',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'vi'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
