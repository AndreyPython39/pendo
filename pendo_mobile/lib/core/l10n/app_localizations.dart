import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart';

abstract class AppLocalizations {
  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = [
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  static const List<Locale> supportedLocales = [
    Locale('en'), // English
    Locale('sw'), // Swahili
    Locale('zu'), // Zulu
    Locale('ru'), // Russian
  ];

  String get appName;
  String get welcomeMessage;
  String get loginTitle;
  String get registerTitle;
  String get email;
  String get password;
  String get name;
  String get age;
  String get bio;
  String get interests;
  String get location;

  String get matchingTabTitle;
  String get chatTabTitle;
  String get tribesTabTitle;
  String get profileTabTitle;

  String get noMoreProfiles;
  String get refreshProfiles;

  String get itsAMatch;
  String matchDescription(String name);
  String get sendMessage;
  String get keepSwiping;

  String get noMessages;
  String get startChatting;
  String get typeMessage;
  String get sendingImage;

  String get createTribe;
  String get joinTribe;
  String get leaveTribe;
  String get tribeName;
  String get tribeDescription;
  String tribeMembers(int count);

  String get createEvent;
  String get joinEvent;
  String get leaveEvent;
  String get eventTitle;
  String get eventDescription;
  String get eventDate;
  String get eventTime;
  String get eventLocation;
  String attendees(int count);

  String get createVote;
  String get castVote;
  String get voteTitle;
  String get voteDescription;
  String get voteOptions;
  String voteEndsIn(int days);

  String get errorTitle;
  String get networkError;
  String get unexpectedError;
  String get tryAgain;

  String get settings;
  String get editProfile;
  String get notifications;
  String get privacy;
  String get language;
  String get theme;
  String get about;
  String get logout;

  String get cancel;
  String get save;
  String get delete;
  String get confirm;
  String get loading;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['en', 'sw', 'zu', 'ru'].contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) async {
    switch (locale.languageCode) {
      case 'en':
        return EnglishLocalizations();
      case 'sw':
        return SwahiliLocalizations();
      case 'zu':
        return ZuluLocalizations();
      case 'ru':
        return RussianLocalizations();
      default:
        return EnglishLocalizations();
    }
  }

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

class EnglishLocalizations extends AppLocalizations {
  @override
  String get appName => 'Pendo';

  @override
  String get welcomeMessage => 'Find your perfect match';

  // ... implement all other getters
}

class SwahiliLocalizations extends AppLocalizations {
  @override
  String get appName => 'Pendo';

  @override
  String get welcomeMessage => 'Pata mshikamano wako kamili';

  // ... implement all other getters
}

class ZuluLocalizations extends AppLocalizations {
  @override
  String get appName => 'Pendo';

  @override
  String get welcomeMessage => 'Thola isikamano sakho esijabule';

  // ... implement all other getters
}

class RussianLocalizations extends AppLocalizations {
  @override
  String get appName => 'Pendo';

  @override
  String get welcomeMessage => 'Найди свою идеальную пару';

  // ... implement all other getters
}
