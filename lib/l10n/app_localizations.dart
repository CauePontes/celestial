import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_es.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('en', 'US'),
    Locale('es'),
    Locale('es', 'US'),
  ];

  /// No description provided for @appName.
  ///
  /// In en, this message translates to:
  /// **'Celestial'**
  String get appName;

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @astrology.
  ///
  /// In en, this message translates to:
  /// **'Astrology'**
  String get astrology;

  /// No description provided for @love.
  ///
  /// In en, this message translates to:
  /// **'Love'**
  String get love;

  /// No description provided for @wellness.
  ///
  /// In en, this message translates to:
  /// **'Wellness'**
  String get wellness;

  /// No description provided for @profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// No description provided for @morning.
  ///
  /// In en, this message translates to:
  /// **'Good morning, explorer'**
  String get morning;

  /// No description provided for @afternoon.
  ///
  /// In en, this message translates to:
  /// **'Good afternoon, explorer'**
  String get afternoon;

  /// No description provided for @evening.
  ///
  /// In en, this message translates to:
  /// **'Good evening, explorer'**
  String get evening;

  /// No description provided for @homeSubtitle.
  ///
  /// In en, this message translates to:
  /// **'A little perspective. A little possibility.'**
  String get homeSubtitle;

  /// No description provided for @outlook.
  ///
  /// In en, this message translates to:
  /// **'Your cosmic\noutlook'**
  String get outlook;

  /// No description provided for @outlookBody.
  ///
  /// In en, this message translates to:
  /// **'Make space for what matters.'**
  String get outlookBody;

  /// No description provided for @virgo.
  ///
  /// In en, this message translates to:
  /// **'Virgo · Earth'**
  String get virgo;

  /// No description provided for @sampleProfile.
  ///
  /// In en, this message translates to:
  /// **'Sample zodiac profile'**
  String get sampleProfile;

  /// No description provided for @preview.
  ///
  /// In en, this message translates to:
  /// **'Preview'**
  String get preview;

  /// No description provided for @demoNotice.
  ///
  /// In en, this message translates to:
  /// **'An offline design preview. Insights and profiles are illustrative.'**
  String get demoNotice;

  /// No description provided for @insightTitle.
  ///
  /// In en, this message translates to:
  /// **'Today’s insight'**
  String get insightTitle;

  /// No description provided for @insightBody.
  ///
  /// In en, this message translates to:
  /// **'You don’t have to have every answer. Start with one small intention, and let the day unfold from there.'**
  String get insightBody;

  /// No description provided for @yourRituals.
  ///
  /// In en, this message translates to:
  /// **'Your daily rituals'**
  String get yourRituals;

  /// No description provided for @horoscope.
  ///
  /// In en, this message translates to:
  /// **'Horoscope'**
  String get horoscope;

  /// No description provided for @birthChart.
  ///
  /// In en, this message translates to:
  /// **'Birth chart'**
  String get birthChart;

  /// No description provided for @compatibility.
  ///
  /// In en, this message translates to:
  /// **'Compatibility'**
  String get compatibility;

  /// No description provided for @meditate.
  ///
  /// In en, this message translates to:
  /// **'Meditate'**
  String get meditate;

  /// No description provided for @exploreMore.
  ///
  /// In en, this message translates to:
  /// **'Explore more'**
  String get exploreMore;

  /// No description provided for @numerology.
  ///
  /// In en, this message translates to:
  /// **'Numerology'**
  String get numerology;

  /// No description provided for @journal.
  ///
  /// In en, this message translates to:
  /// **'Journal'**
  String get journal;

  /// No description provided for @community.
  ///
  /// In en, this message translates to:
  /// **'Community'**
  String get community;

  /// No description provided for @premium.
  ///
  /// In en, this message translates to:
  /// **'Celestial Premium'**
  String get premium;

  /// No description provided for @premiumBody.
  ///
  /// In en, this message translates to:
  /// **'A little more space for self-discovery.'**
  String get premiumBody;

  /// No description provided for @foundation.
  ///
  /// In en, this message translates to:
  /// **'Foundation preview'**
  String get foundation;

  /// No description provided for @foundationBody.
  ///
  /// In en, this message translates to:
  /// **'This space is taking shape. Explore the visual foundation today; complete experiences will arrive in later stages.'**
  String get foundationBody;

  /// No description provided for @astrologyTitle.
  ///
  /// In en, this message translates to:
  /// **'A new perspective,\nwritten in the stars.'**
  String get astrologyTitle;

  /// No description provided for @astrologyBody.
  ///
  /// In en, this message translates to:
  /// **'Explore the language of the sky, at your own pace.'**
  String get astrologyBody;

  /// No description provided for @chartNotice.
  ///
  /// In en, this message translates to:
  /// **'Illustrative chart — calculations will be connected later.'**
  String get chartNotice;

  /// No description provided for @loveTitle.
  ///
  /// In en, this message translates to:
  /// **'Space for a\ndeeper connection.'**
  String get loveTitle;

  /// No description provided for @loveBody.
  ///
  /// In en, this message translates to:
  /// **'A thoughtful look at how two people relate, communicate, and grow.'**
  String get loveBody;

  /// No description provided for @wellnessTitle.
  ///
  /// In en, this message translates to:
  /// **'Come back\nto yourself.'**
  String get wellnessTitle;

  /// No description provided for @wellnessBody.
  ///
  /// In en, this message translates to:
  /// **'Small rituals for a calmer mind and a gentler day.'**
  String get wellnessBody;

  /// No description provided for @profileTitle.
  ///
  /// In en, this message translates to:
  /// **'Your own\nlittle universe.'**
  String get profileTitle;

  /// No description provided for @profileBody.
  ///
  /// In en, this message translates to:
  /// **'Your preferences, in one quiet place.'**
  String get profileBody;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @deviceLanguage.
  ///
  /// In en, this message translates to:
  /// **'Use device language'**
  String get deviceLanguage;

  /// No description provided for @english.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get english;

  /// No description provided for @spanish.
  ///
  /// In en, this message translates to:
  /// **'Español'**
  String get spanish;

  /// No description provided for @languageHelp.
  ///
  /// In en, this message translates to:
  /// **'Your choice is saved on this device. You can change it at any time.'**
  String get languageHelp;

  /// No description provided for @guest.
  ///
  /// In en, this message translates to:
  /// **'Guest preview'**
  String get guest;

  /// No description provided for @guestBody.
  ///
  /// In en, this message translates to:
  /// **'No account is required. No birth details have been collected.'**
  String get guestBody;

  /// No description provided for @backHome.
  ///
  /// In en, this message translates to:
  /// **'Back to Home'**
  String get backHome;

  /// No description provided for @notifications.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notifications;

  /// No description provided for @notificationsBody.
  ///
  /// In en, this message translates to:
  /// **'You’re all caught up. This foundation preview does not send notifications.'**
  String get notificationsBody;

  /// No description provided for @close.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get close;

  /// No description provided for @viewPreview.
  ///
  /// In en, this message translates to:
  /// **'Explore the preview'**
  String get viewPreview;

  /// No description provided for @breathing.
  ///
  /// In en, this message translates to:
  /// **'Breathing'**
  String get breathing;

  /// No description provided for @meditationLibrary.
  ///
  /// In en, this message translates to:
  /// **'Meditation library'**
  String get meditationLibrary;

  /// No description provided for @comingLater.
  ///
  /// In en, this message translates to:
  /// **'Available in a later stage'**
  String get comingLater;

  /// No description provided for @loading.
  ///
  /// In en, this message translates to:
  /// **'Loading preview'**
  String get loading;

  /// No description provided for @noEntries.
  ///
  /// In en, this message translates to:
  /// **'A fresh beginning'**
  String get noEntries;

  /// No description provided for @noEntriesBody.
  ///
  /// In en, this message translates to:
  /// **'Your personal space will take shape here.'**
  String get noEntriesBody;

  /// No description provided for @saveError.
  ///
  /// In en, this message translates to:
  /// **'Your language could not be saved. Please try again.'**
  String get saveError;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'es'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when language+country codes are specified.
  switch (locale.languageCode) {
    case 'en':
      {
        switch (locale.countryCode) {
          case 'US':
            return AppLocalizationsEnUs();
        }
        break;
      }
    case 'es':
      {
        switch (locale.countryCode) {
          case 'US':
            return AppLocalizationsEsUs();
        }
        break;
      }
  }

  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
