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
// ignore_for_file: avoid_redundant_argument_values

class S {
  S();
  
  static S current;
  
  static const AppLocalizationDelegate delegate =
    AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false) ? locale.languageCode : locale.toString();
    final localeName = Intl.canonicalizedLocale(name); 
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      S.current = S();
      
      return S.current;
    });
  } 

  static S of(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Enter the IP or the hostname of the server`
  String get welcome_message {
    return Intl.message(
      'Enter the IP or the hostname of the server',
      name: 'welcome_message',
      desc: '',
      args: [],
    );
  }

  /// `You are not connected to the internet, check your connection`
  String get no_internet {
    return Intl.message(
      'You are not connected to the internet, check your connection',
      name: 'no_internet',
      desc: '',
      args: [],
    );
  }

  /// `Can't resolve hostname / IP`
  String get wrong_ip {
    return Intl.message(
      'Can\'t resolve hostname / IP',
      name: 'wrong_ip',
      desc: '',
      args: [],
    );
  }

  /// `Hostname : {responseHostname}`
  String hostname(Object responseHostname) {
    return Intl.message(
      'Hostname : $responseHostname',
      name: 'hostname',
      desc: '',
      args: [responseHostname],
    );
  }

  /// `Players : {responsePlayerCount} / {responseMaxPlayers}`
  String players(Object responsePlayerCount, Object responseMaxPlayers) {
    return Intl.message(
      'Players : $responsePlayerCount / $responseMaxPlayers',
      name: 'players',
      desc: '',
      args: [responsePlayerCount, responseMaxPlayers],
    );
  }

  /// `Hostname or IP`
  String get hostname_imput {
    return Intl.message(
      'Hostname or IP',
      name: 'hostname_imput',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'fr'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    if (locale != null) {
      for (var supportedLocale in supportedLocales) {
        if (supportedLocale.languageCode == locale.languageCode) {
          return true;
        }
      }
    }
    return false;
  }
}