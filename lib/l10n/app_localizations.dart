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

  /// No description provided for @observatory.
  ///
  /// In en, this message translates to:
  /// **'Observatory & Rituals'**
  String get observatory;

  /// No description provided for @welcomeTitle.
  ///
  /// In en, this message translates to:
  /// **'Explore your inner universe'**
  String get welcomeTitle;

  /// No description provided for @welcomeBody.
  ///
  /// In en, this message translates to:
  /// **'Personal astrology, numerology, and mindful rituals crafted for your daily rhythm.'**
  String get welcomeBody;

  /// No description provided for @getStarted.
  ///
  /// In en, this message translates to:
  /// **'Get started'**
  String get getStarted;

  /// No description provided for @existingAccount.
  ///
  /// In en, this message translates to:
  /// **'I already have an account'**
  String get existingAccount;

  /// No description provided for @continueLabel.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get continueLabel;

  /// No description provided for @skip.
  ///
  /// In en, this message translates to:
  /// **'Explore as a guest'**
  String get skip;

  /// No description provided for @next.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get next;

  /// No description provided for @stepOne.
  ///
  /// In en, this message translates to:
  /// **'Step 1 of 2'**
  String get stepOne;

  /// No description provided for @stepTwo.
  ///
  /// In en, this message translates to:
  /// **'Step 2 of 2'**
  String get stepTwo;

  /// No description provided for @birthTitle.
  ///
  /// In en, this message translates to:
  /// **'Your cosmic coordinates'**
  String get birthTitle;

  /// No description provided for @birthBody.
  ///
  /// In en, this message translates to:
  /// **'The moment and place you arrived are part of your story. Explore an illustrative chart with your own details.'**
  String get birthBody;

  /// No description provided for @fullName.
  ///
  /// In en, this message translates to:
  /// **'Full name'**
  String get fullName;

  /// No description provided for @birthDate.
  ///
  /// In en, this message translates to:
  /// **'Birth date'**
  String get birthDate;

  /// No description provided for @birthTime.
  ///
  /// In en, this message translates to:
  /// **'Birth time'**
  String get birthTime;

  /// No description provided for @optional.
  ///
  /// In en, this message translates to:
  /// **'Optional'**
  String get optional;

  /// No description provided for @unknownTime.
  ///
  /// In en, this message translates to:
  /// **'I don’t know my birth time'**
  String get unknownTime;

  /// No description provided for @unknownTimeHelp.
  ///
  /// In en, this message translates to:
  /// **'You can add a time later. This preview does not calculate a solar or rising chart.'**
  String get unknownTimeHelp;

  /// No description provided for @birthplace.
  ///
  /// In en, this message translates to:
  /// **'Birthplace'**
  String get birthplace;

  /// No description provided for @chooseDate.
  ///
  /// In en, this message translates to:
  /// **'Choose a date'**
  String get chooseDate;

  /// No description provided for @chooseTime.
  ///
  /// In en, this message translates to:
  /// **'Choose a time'**
  String get chooseTime;

  /// No description provided for @requiredField.
  ///
  /// In en, this message translates to:
  /// **'Please complete this field.'**
  String get requiredField;

  /// No description provided for @invalidEmail.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid email address.'**
  String get invalidEmail;

  /// No description provided for @passwordRule.
  ///
  /// In en, this message translates to:
  /// **'Use at least 8 characters for this demo.'**
  String get passwordRule;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @signIn.
  ///
  /// In en, this message translates to:
  /// **'Demo sign in'**
  String get signIn;

  /// No description provided for @signUp.
  ///
  /// In en, this message translates to:
  /// **'Demo sign up'**
  String get signUp;

  /// No description provided for @recoverPassword.
  ///
  /// In en, this message translates to:
  /// **'Reset password'**
  String get recoverPassword;

  /// No description provided for @authNotice.
  ///
  /// In en, this message translates to:
  /// **'Demo only. No account is created and no credentials are sent or stored. Use sample information.'**
  String get authNotice;

  /// No description provided for @resetNotice.
  ///
  /// In en, this message translates to:
  /// **'No email was sent. In this offline demo, continue as a guest to explore.'**
  String get resetNotice;

  /// No description provided for @interestsTitle.
  ///
  /// In en, this message translates to:
  /// **'What draws you inward?'**
  String get interestsTitle;

  /// No description provided for @interestsBody.
  ///
  /// In en, this message translates to:
  /// **'Select the areas you’d like to explore. You can adjust these anytime.'**
  String get interestsBody;

  /// No description provided for @relationships.
  ///
  /// In en, this message translates to:
  /// **'Relationships'**
  String get relationships;

  /// No description provided for @journaling.
  ///
  /// In en, this message translates to:
  /// **'Journaling'**
  String get journaling;

  /// No description provided for @astrologyInterest.
  ///
  /// In en, this message translates to:
  /// **'Natal charts, transits & daily skies'**
  String get astrologyInterest;

  /// No description provided for @relationshipsInterest.
  ///
  /// In en, this message translates to:
  /// **'Synastry, compatibility & bonds'**
  String get relationshipsInterest;

  /// No description provided for @numerologyInterest.
  ///
  /// In en, this message translates to:
  /// **'Life path numbers & personal cycles'**
  String get numerologyInterest;

  /// No description provided for @meditationInterest.
  ///
  /// In en, this message translates to:
  /// **'Guided stillness & lunar breathwork'**
  String get meditationInterest;

  /// No description provided for @journalInterest.
  ///
  /// In en, this message translates to:
  /// **'Reflective prompts & dream logs'**
  String get journalInterest;

  /// No description provided for @enterCelestial.
  ///
  /// In en, this message translates to:
  /// **'Enter Celestial'**
  String get enterCelestial;

  /// No description provided for @selectArea.
  ///
  /// In en, this message translates to:
  /// **'Select at least one area'**
  String get selectArea;

  /// No description provided for @areasSelected.
  ///
  /// In en, this message translates to:
  /// **'areas selected'**
  String get areasSelected;

  /// No description provided for @introOne.
  ///
  /// In en, this message translates to:
  /// **'A new way to see your sky'**
  String get introOne;

  /// No description provided for @introTwo.
  ///
  /// In en, this message translates to:
  /// **'Make room for reflection'**
  String get introTwo;

  /// No description provided for @introThree.
  ///
  /// In en, this message translates to:
  /// **'Return to a gentler rhythm'**
  String get introThree;

  /// No description provided for @introBody.
  ///
  /// In en, this message translates to:
  /// **'Explore illustrative readings, meaningful questions, and quiet daily rituals. Your journey stays on this device.'**
  String get introBody;

  /// No description provided for @todayAlignment.
  ///
  /// In en, this message translates to:
  /// **'Today’s Alignment'**
  String get todayAlignment;

  /// No description provided for @alignmentBody.
  ///
  /// In en, this message translates to:
  /// **'Venus softens your seventh house tonight, inviting quiet honesty in close conversations. Let unspoken feelings surface gently without rushing to define them.'**
  String get alignmentBody;

  /// No description provided for @alignmentMore.
  ///
  /// In en, this message translates to:
  /// **'With the Moon drifting through intuitive Pisces, your emotional radar is especially clear. Step away from noisy spaces after dusk and trust the first quiet impression you receive.'**
  String get alignmentMore;

  /// No description provided for @readFull.
  ///
  /// In en, this message translates to:
  /// **'Read full reading'**
  String get readFull;

  /// No description provided for @showLess.
  ///
  /// In en, this message translates to:
  /// **'Show less'**
  String get showLess;

  /// No description provided for @insightQuote.
  ///
  /// In en, this message translates to:
  /// **'“Clarity rarely arrives in haste; it settles in when you allow the sky inside you to grow still.”'**
  String get insightQuote;

  /// No description provided for @sanctuary.
  ///
  /// In en, this message translates to:
  /// **'Sanctuary'**
  String get sanctuary;

  /// No description provided for @quickAccess.
  ///
  /// In en, this message translates to:
  /// **'Quick access'**
  String get quickAccess;

  /// No description provided for @housesAspects.
  ///
  /// In en, this message translates to:
  /// **'Houses & aspects'**
  String get housesAspects;

  /// No description provided for @lifePathSeven.
  ///
  /// In en, this message translates to:
  /// **'Life Path 7 — The Seeker'**
  String get lifePathSeven;

  /// No description provided for @eveningReflection.
  ///
  /// In en, this message translates to:
  /// **'Evening reflection'**
  String get eveningReflection;

  /// No description provided for @cosmicCalendar.
  ///
  /// In en, this message translates to:
  /// **'Cosmic Calendar'**
  String get cosmicCalendar;

  /// No description provided for @viewAll.
  ///
  /// In en, this message translates to:
  /// **'View all'**
  String get viewAll;

  /// No description provided for @seeAll.
  ///
  /// In en, this message translates to:
  /// **'See all'**
  String get seeAll;

  /// No description provided for @plus.
  ///
  /// In en, this message translates to:
  /// **'Celestial Plus'**
  String get plus;

  /// No description provided for @explore.
  ///
  /// In en, this message translates to:
  /// **'Explore'**
  String get explore;

  /// No description provided for @plusHome.
  ///
  /// In en, this message translates to:
  /// **'Explore Celestial Plus · illustrative plans'**
  String get plusHome;

  /// No description provided for @plusSummary.
  ///
  /// In en, this message translates to:
  /// **'Natal deep-dives, reflective reports & mindful rituals.'**
  String get plusSummary;

  /// No description provided for @sampleBigThree.
  ///
  /// In en, this message translates to:
  /// **'Libra Sun · Pisces Moon · Taurus Rising'**
  String get sampleBigThree;

  /// No description provided for @sampleSunMoon.
  ///
  /// In en, this message translates to:
  /// **'Libra Sun · Pisces Moon'**
  String get sampleSunMoon;

  /// No description provided for @waxing.
  ///
  /// In en, this message translates to:
  /// **'Waxing Gibbous'**
  String get waxing;

  /// No description provided for @greetingMorning.
  ///
  /// In en, this message translates to:
  /// **'Good morning'**
  String get greetingMorning;

  /// No description provided for @greetingAfternoon.
  ///
  /// In en, this message translates to:
  /// **'Good afternoon'**
  String get greetingAfternoon;

  /// No description provided for @greetingEvening.
  ///
  /// In en, this message translates to:
  /// **'Good evening'**
  String get greetingEvening;

  /// No description provided for @explorer.
  ///
  /// In en, this message translates to:
  /// **'explorer'**
  String get explorer;

  /// No description provided for @blueprint.
  ///
  /// In en, this message translates to:
  /// **'Celestial Blueprint'**
  String get blueprint;

  /// No description provided for @natalTitle.
  ///
  /// In en, this message translates to:
  /// **'Your Natal Birth Chart'**
  String get natalTitle;

  /// No description provided for @sun.
  ///
  /// In en, this message translates to:
  /// **'Sun'**
  String get sun;

  /// No description provided for @moon.
  ///
  /// In en, this message translates to:
  /// **'Moon'**
  String get moon;

  /// No description provided for @rising.
  ///
  /// In en, this message translates to:
  /// **'Rising'**
  String get rising;

  /// No description provided for @illustrativeReading.
  ///
  /// In en, this message translates to:
  /// **'Illustrative astrological reading'**
  String get illustrativeReading;

  /// No description provided for @numerologyLife.
  ///
  /// In en, this message translates to:
  /// **'Numerology & Life Path'**
  String get numerologyLife;

  /// No description provided for @seekerBody.
  ///
  /// In en, this message translates to:
  /// **'Driven by quiet contemplation, intuition, and a deep desire to uncover hidden truths beneath the surface.'**
  String get seekerBody;

  /// No description provided for @personalYear.
  ///
  /// In en, this message translates to:
  /// **'Personal Year 9 · Completion'**
  String get personalYear;

  /// No description provided for @upcoming.
  ///
  /// In en, this message translates to:
  /// **'Upcoming Astrological Events'**
  String get upcoming;

  /// No description provided for @zodiacExplore.
  ///
  /// In en, this message translates to:
  /// **'Explore Zodiac Signs'**
  String get zodiacExplore;

  /// No description provided for @horoscopeDetails.
  ///
  /// In en, this message translates to:
  /// **'Horoscope Details'**
  String get horoscopeDetails;

  /// No description provided for @daily.
  ///
  /// In en, this message translates to:
  /// **'Daily'**
  String get daily;

  /// No description provided for @weekly.
  ///
  /// In en, this message translates to:
  /// **'Weekly'**
  String get weekly;

  /// No description provided for @monthly.
  ///
  /// In en, this message translates to:
  /// **'Monthly'**
  String get monthly;

  /// No description provided for @loveCategory.
  ///
  /// In en, this message translates to:
  /// **'Love & Relationships'**
  String get loveCategory;

  /// No description provided for @careerCategory.
  ///
  /// In en, this message translates to:
  /// **'Career & Purpose'**
  String get careerCategory;

  /// No description provided for @wellnessCategory.
  ///
  /// In en, this message translates to:
  /// **'Wellness & Energy'**
  String get wellnessCategory;

  /// No description provided for @all.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get all;

  /// No description provided for @readingDailyTitle.
  ///
  /// In en, this message translates to:
  /// **'Quiet clarity in your conversations'**
  String get readingDailyTitle;

  /// No description provided for @readingWeeklyTitle.
  ///
  /// In en, this message translates to:
  /// **'Harmonies built on patient timing'**
  String get readingWeeklyTitle;

  /// No description provided for @readingMonthlyTitle.
  ///
  /// In en, this message translates to:
  /// **'Stepping into your quiet radiance'**
  String get readingMonthlyTitle;

  /// No description provided for @readingDaily.
  ///
  /// In en, this message translates to:
  /// **'With Venus softening the edges of today’s lunar transit, you may notice a gentle shift in how others receive your words. Rather than rushing to smooth over every silence, allow space for honest pauses. A thoughtful question asked in calm confidence will open a door that persistence alone could not.'**
  String get readingDaily;

  /// No description provided for @readingWeekly.
  ///
  /// In en, this message translates to:
  /// **'This week invites you to recalibrate your commitments around what nourishes you. Midweek brings a welcome clearing of mental fog, making it easier to articulate boundaries with grace. Trust steady, unhurried progress.'**
  String get readingWeekly;

  /// No description provided for @readingMonthly.
  ///
  /// In en, this message translates to:
  /// **'Honor both your need for connection and your need for solitude. Creative ideas that felt distant now take tangible shape. Move at a pace that feels sustainable, letting beauty and intention guide your choices.'**
  String get readingMonthly;

  /// No description provided for @loveDaily.
  ///
  /// In en, this message translates to:
  /// **'Shared stillness speaks louder than grand gestures tonight. Listen for what is left unsaid, and offer warmth without trying to fix the moment.'**
  String get loveDaily;

  /// No description provided for @careerDaily.
  ///
  /// In en, this message translates to:
  /// **'A collaborative project benefits from your natural sense of balance. Step back to review the broader structure before committing to next steps.'**
  String get careerDaily;

  /// No description provided for @wellnessDaily.
  ///
  /// In en, this message translates to:
  /// **'Protect your evening peace by dimming screens an hour earlier. Gentle breathwork or a slow walk under the night sky will restore your equilibrium.'**
  String get wellnessDaily;

  /// No description provided for @loveWeekly.
  ///
  /// In en, this message translates to:
  /// **'An honest conversation deepens mutual trust. Let curiosity lead when navigating different perspectives.'**
  String get loveWeekly;

  /// No description provided for @careerWeekly.
  ///
  /// In en, this message translates to:
  /// **'Focus on refining one meaningful task rather than scattering your attention. Patient collaboration creates room for better ideas.'**
  String get careerWeekly;

  /// No description provided for @wellnessWeekly.
  ///
  /// In en, this message translates to:
  /// **'Make room for restorative sleep, warm meals, and unhurried pauses as the week unfolds.'**
  String get wellnessWeekly;

  /// No description provided for @loveMonthly.
  ///
  /// In en, this message translates to:
  /// **'Celebrate small rituals of affection that anchor your closest bonds.'**
  String get loveMonthly;

  /// No description provided for @careerMonthly.
  ///
  /// In en, this message translates to:
  /// **'Align your daily habits with your longer-term creative vision.'**
  String get careerMonthly;

  /// No description provided for @wellnessMonthly.
  ///
  /// In en, this message translates to:
  /// **'Balance social warmth with quiet mornings, journaling, or gentle stretching.'**
  String get wellnessMonthly;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @saved.
  ///
  /// In en, this message translates to:
  /// **'Saved'**
  String get saved;

  /// No description provided for @favorites.
  ///
  /// In en, this message translates to:
  /// **'Favorites'**
  String get favorites;

  /// No description provided for @sharePreview.
  ///
  /// In en, this message translates to:
  /// **'Reading saved for this demo. Sharing is not connected.'**
  String get sharePreview;

  /// No description provided for @previous.
  ///
  /// In en, this message translates to:
  /// **'Previous'**
  String get previous;

  /// No description provided for @nextDate.
  ///
  /// In en, this message translates to:
  /// **'Next date'**
  String get nextDate;

  /// No description provided for @tryAgain.
  ///
  /// In en, this message translates to:
  /// **'Try again'**
  String get tryAgain;

  /// No description provided for @loadError.
  ///
  /// In en, this message translates to:
  /// **'This preview could not be loaded. Please try again.'**
  String get loadError;

  /// No description provided for @noResults.
  ///
  /// In en, this message translates to:
  /// **'No results found'**
  String get noResults;

  /// No description provided for @search.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get search;

  /// No description provided for @discover.
  ///
  /// In en, this message translates to:
  /// **'Discover'**
  String get discover;

  /// No description provided for @back.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get back;

  /// No description provided for @done.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get done;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @edit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get edit;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @start.
  ///
  /// In en, this message translates to:
  /// **'Start'**
  String get start;

  /// No description provided for @pause.
  ///
  /// In en, this message translates to:
  /// **'Pause'**
  String get pause;

  /// No description provided for @restart.
  ///
  /// In en, this message translates to:
  /// **'Restart'**
  String get restart;

  /// No description provided for @complete.
  ///
  /// In en, this message translates to:
  /// **'Complete'**
  String get complete;

  /// No description provided for @demoOnly.
  ///
  /// In en, this message translates to:
  /// **'Demo only · stored in this session'**
  String get demoOnly;

  /// No description provided for @noAccount.
  ///
  /// In en, this message translates to:
  /// **'Guest demo · no online account'**
  String get noAccount;

  /// No description provided for @synastry.
  ///
  /// In en, this message translates to:
  /// **'Synastry & Transits'**
  String get synastry;

  /// No description provided for @loveCompatibility.
  ///
  /// In en, this message translates to:
  /// **'Love & Compatibility'**
  String get loveCompatibility;

  /// No description provided for @loveHeroBody.
  ///
  /// In en, this message translates to:
  /// **'Explore how two natal charts converse, align, and illuminate each other’s path.'**
  String get loveHeroBody;

  /// No description provided for @compareCharts.
  ///
  /// In en, this message translates to:
  /// **'Compare birth charts'**
  String get compareCharts;

  /// No description provided for @recentComparisons.
  ///
  /// In en, this message translates to:
  /// **'Recent Comparisons'**
  String get recentComparisons;

  /// No description provided for @harmony.
  ///
  /// In en, this message translates to:
  /// **'Harmony · demo'**
  String get harmony;

  /// No description provided for @communication.
  ///
  /// In en, this message translates to:
  /// **'Communication'**
  String get communication;

  /// No description provided for @emotional.
  ///
  /// In en, this message translates to:
  /// **'Emotional connection'**
  String get emotional;

  /// No description provided for @values.
  ///
  /// In en, this message translates to:
  /// **'Shared values'**
  String get values;

  /// No description provided for @relationshipInsights.
  ///
  /// In en, this message translates to:
  /// **'Relationship Insights'**
  String get relationshipInsights;

  /// No description provided for @curated.
  ///
  /// In en, this message translates to:
  /// **'Curated for you'**
  String get curated;

  /// No description provided for @venusTransit.
  ///
  /// In en, this message translates to:
  /// **'Venus Transit'**
  String get venusTransit;

  /// No description provided for @venusTitle.
  ///
  /// In en, this message translates to:
  /// **'Venus in Taurus: Grounded Affection'**
  String get venusTitle;

  /// No description provided for @venusBody.
  ///
  /// In en, this message translates to:
  /// **'Slow down and savor tactile presence. Shared rituals and unhurried conversations carry extra warmth under this transit.'**
  String get venusBody;

  /// No description provided for @synastryTheme.
  ///
  /// In en, this message translates to:
  /// **'Synastry Theme'**
  String get synastryTheme;

  /// No description provided for @moonMercuryTitle.
  ///
  /// In en, this message translates to:
  /// **'The Art of Moon–Mercury Aspects'**
  String get moonMercuryTitle;

  /// No description provided for @moonMercuryBody.
  ///
  /// In en, this message translates to:
  /// **'Emotional fluency often begins when one person’s curiosity meets the other’s unspoken feelings.'**
  String get moonMercuryBody;

  /// No description provided for @relationshipNote.
  ///
  /// In en, this message translates to:
  /// **'Venus trine Moon offers a reflective lens for intuitive understanding and quiet emotional safety.'**
  String get relationshipNote;

  /// No description provided for @partnerDetails.
  ///
  /// In en, this message translates to:
  /// **'Partner details'**
  String get partnerDetails;

  /// No description provided for @partnerName.
  ///
  /// In en, this message translates to:
  /// **'Their name (optional)'**
  String get partnerName;

  /// No description provided for @compare.
  ///
  /// In en, this message translates to:
  /// **'Compare'**
  String get compare;

  /// No description provided for @comparisonResult.
  ///
  /// In en, this message translates to:
  /// **'Your Connection'**
  String get comparisonResult;

  /// No description provided for @comparisonDemo.
  ///
  /// In en, this message translates to:
  /// **'Illustrative comparison. These scores are sample design data, not measured compatibility.'**
  String get comparisonDemo;

  /// No description provided for @editProfiles.
  ///
  /// In en, this message translates to:
  /// **'Edit profiles'**
  String get editProfiles;

  /// No description provided for @readReport.
  ///
  /// In en, this message translates to:
  /// **'Read the full report'**
  String get readReport;

  /// No description provided for @compatibilityReport.
  ///
  /// In en, this message translates to:
  /// **'Compatibility Report'**
  String get compatibilityReport;

  /// No description provided for @communicationBody.
  ///
  /// In en, this message translates to:
  /// **'Make space for different communication rhythms. Ask a clear question, listen fully, and check what each of you understood. This prepared example invites reflection rather than prediction.'**
  String get communicationBody;

  /// No description provided for @emotionalBody.
  ///
  /// In en, this message translates to:
  /// **'Small acts of care can make closeness feel safer. Share what helps you feel supported, and give each other time to respond without pressure.'**
  String get emotionalBody;

  /// No description provided for @valuesBody.
  ///
  /// In en, this message translates to:
  /// **'Notice where your priorities meet and where they differ. A shared ritual, an honest boundary, or a practical plan can turn curiosity into everyday understanding.'**
  String get valuesBody;

  /// No description provided for @quietRestore.
  ///
  /// In en, this message translates to:
  /// **'A quiet space to restore'**
  String get quietRestore;

  /// No description provided for @eveningLabel.
  ///
  /// In en, this message translates to:
  /// **'Evening'**
  String get eveningLabel;

  /// No description provided for @featuredRitual.
  ///
  /// In en, this message translates to:
  /// **'Featured Ritual'**
  String get featuredRitual;

  /// No description provided for @moonriseMeditation.
  ///
  /// In en, this message translates to:
  /// **'Evening Moonrise Meditation'**
  String get moonriseMeditation;

  /// No description provided for @guided.
  ///
  /// In en, this message translates to:
  /// **'Guided'**
  String get guided;

  /// No description provided for @breathingExercises.
  ///
  /// In en, this message translates to:
  /// **'Breathing Exercises'**
  String get breathingExercises;

  /// No description provided for @calmBreath.
  ///
  /// In en, this message translates to:
  /// **'4-7-8 Calm Breath'**
  String get calmBreath;

  /// No description provided for @calmBreathBody.
  ///
  /// In en, this message translates to:
  /// **'A gentle, unhurried breathing rhythm'**
  String get calmBreathBody;

  /// No description provided for @boxBreathing.
  ///
  /// In en, this message translates to:
  /// **'Box Breathing'**
  String get boxBreathing;

  /// No description provided for @boxBody.
  ///
  /// In en, this message translates to:
  /// **'Steady focus & clarity'**
  String get boxBody;

  /// No description provided for @lunarResonance.
  ///
  /// In en, this message translates to:
  /// **'Lunar Resonance'**
  String get lunarResonance;

  /// No description provided for @lunarBody.
  ///
  /// In en, this message translates to:
  /// **'Prepare for deep rest'**
  String get lunarBody;

  /// No description provided for @journalMood.
  ///
  /// In en, this message translates to:
  /// **'Personal Journal & Mood'**
  String get journalMood;

  /// No description provided for @energyQuestion.
  ///
  /// In en, this message translates to:
  /// **'How is your energy feeling tonight?'**
  String get energyQuestion;

  /// No description provided for @calm.
  ///
  /// In en, this message translates to:
  /// **'Calm'**
  String get calm;

  /// No description provided for @reflective.
  ///
  /// In en, this message translates to:
  /// **'Reflective'**
  String get reflective;

  /// No description provided for @grounded.
  ///
  /// In en, this message translates to:
  /// **'Grounded'**
  String get grounded;

  /// No description provided for @energized.
  ///
  /// In en, this message translates to:
  /// **'Energized'**
  String get energized;

  /// No description provided for @writeEntry.
  ///
  /// In en, this message translates to:
  /// **'Write today’s entry'**
  String get writeEntry;

  /// No description provided for @communityReflections.
  ///
  /// In en, this message translates to:
  /// **'Community Reflections'**
  String get communityReflections;

  /// No description provided for @communityQuote.
  ///
  /// In en, this message translates to:
  /// **'“Letting go of today’s noise feels easier under a quiet sky. Wishing everyone a gentle evening.”'**
  String get communityQuote;

  /// No description provided for @communityPreview.
  ///
  /// In en, this message translates to:
  /// **'Community preview · fictional people'**
  String get communityPreview;

  /// No description provided for @readMore.
  ///
  /// In en, this message translates to:
  /// **'Read more'**
  String get readMore;

  /// No description provided for @minutes.
  ///
  /// In en, this message translates to:
  /// **'min'**
  String get minutes;

  /// No description provided for @sleep.
  ///
  /// In en, this message translates to:
  /// **'Sleep'**
  String get sleep;

  /// No description provided for @focus.
  ///
  /// In en, this message translates to:
  /// **'Focus'**
  String get focus;

  /// No description provided for @duration.
  ///
  /// In en, this message translates to:
  /// **'Duration'**
  String get duration;

  /// No description provided for @allDurations.
  ///
  /// In en, this message translates to:
  /// **'All durations'**
  String get allDurations;

  /// No description provided for @shortSessions.
  ///
  /// In en, this message translates to:
  /// **'Up to 10 min'**
  String get shortSessions;

  /// No description provided for @longSessions.
  ///
  /// In en, this message translates to:
  /// **'Over 10 min'**
  String get longSessions;

  /// No description provided for @meditationBody.
  ///
  /// In en, this message translates to:
  /// **'Settle into a comfortable place. Notice the support beneath you, soften your shoulders, and let your attention rest on the natural rhythm of your breath. A quiet ritual for reflection.'**
  String get meditationBody;

  /// No description provided for @meditationGoals.
  ///
  /// In en, this message translates to:
  /// **'A softer evening · mindful attention · a moment of stillness'**
  String get meditationGoals;

  /// No description provided for @audioUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Audio preview unavailable'**
  String get audioUnavailable;

  /// No description provided for @audioUnavailableBody.
  ///
  /// In en, this message translates to:
  /// **'No licensed audio is bundled in this prototype. Playback is disabled; you can explore the visual player without simulating sound.'**
  String get audioUnavailableBody;

  /// No description provided for @viewPlayer.
  ///
  /// In en, this message translates to:
  /// **'View player'**
  String get viewPlayer;

  /// No description provided for @playAudio.
  ///
  /// In en, this message translates to:
  /// **'Play audio'**
  String get playAudio;

  /// No description provided for @dawnMeditation.
  ///
  /// In en, this message translates to:
  /// **'First Light Stillness'**
  String get dawnMeditation;

  /// No description provided for @sleepMeditation.
  ///
  /// In en, this message translates to:
  /// **'A Softer Landing'**
  String get sleepMeditation;

  /// No description provided for @focusMeditation.
  ///
  /// In en, this message translates to:
  /// **'The Quiet Center'**
  String get focusMeditation;

  /// No description provided for @calmMeditation.
  ///
  /// In en, this message translates to:
  /// **'Room to Breathe'**
  String get calmMeditation;

  /// No description provided for @nightMeditation.
  ///
  /// In en, this message translates to:
  /// **'Under a Quiet Sky'**
  String get nightMeditation;

  /// No description provided for @inhale.
  ///
  /// In en, this message translates to:
  /// **'Inhale'**
  String get inhale;

  /// No description provided for @hold.
  ///
  /// In en, this message translates to:
  /// **'Hold'**
  String get hold;

  /// No description provided for @exhale.
  ///
  /// In en, this message translates to:
  /// **'Exhale'**
  String get exhale;

  /// No description provided for @rest.
  ///
  /// In en, this message translates to:
  /// **'Rest'**
  String get rest;

  /// No description provided for @breathingHelp.
  ///
  /// In en, this message translates to:
  /// **'Breathe comfortably. Skip any hold and return to your natural breath whenever you need. This is a wellness demo, not medical guidance.'**
  String get breathingHelp;

  /// No description provided for @cycles.
  ///
  /// In en, this message translates to:
  /// **'cycles completed'**
  String get cycles;

  /// No description provided for @journalTitle.
  ///
  /// In en, this message translates to:
  /// **'Your Reflections'**
  String get journalTitle;

  /// No description provided for @journalEmpty.
  ///
  /// In en, this message translates to:
  /// **'Your next chapter starts here'**
  String get journalEmpty;

  /// No description provided for @journalEmptyBody.
  ///
  /// In en, this message translates to:
  /// **'Capture a feeling, a small discovery, or one thing you want to remember.'**
  String get journalEmptyBody;

  /// No description provided for @newEntry.
  ///
  /// In en, this message translates to:
  /// **'New reflection'**
  String get newEntry;

  /// No description provided for @editEntry.
  ///
  /// In en, this message translates to:
  /// **'Edit reflection'**
  String get editEntry;

  /// No description provided for @entryTitle.
  ///
  /// In en, this message translates to:
  /// **'Title'**
  String get entryTitle;

  /// No description provided for @entryBody.
  ///
  /// In en, this message translates to:
  /// **'What’s on your mind?'**
  String get entryBody;

  /// No description provided for @journalPrompt.
  ///
  /// In en, this message translates to:
  /// **'What felt grounding today, and what are you ready to let go of?'**
  String get journalPrompt;

  /// No description provided for @entrySaved.
  ///
  /// In en, this message translates to:
  /// **'Reflection saved in this session.'**
  String get entrySaved;

  /// No description provided for @entryDeleted.
  ///
  /// In en, this message translates to:
  /// **'Reflection removed.'**
  String get entryDeleted;

  /// No description provided for @communityFeed.
  ///
  /// In en, this message translates to:
  /// **'Community'**
  String get communityFeed;

  /// No description provided for @createPost.
  ///
  /// In en, this message translates to:
  /// **'Create a post'**
  String get createPost;

  /// No description provided for @postTitle.
  ///
  /// In en, this message translates to:
  /// **'A thought to share'**
  String get postTitle;

  /// No description provided for @postBody.
  ///
  /// In en, this message translates to:
  /// **'Write your reflection'**
  String get postBody;

  /// No description provided for @publish.
  ///
  /// In en, this message translates to:
  /// **'Publish in demo'**
  String get publish;

  /// No description provided for @localPostNotice.
  ///
  /// In en, this message translates to:
  /// **'Visible only in this demo. Nothing is posted online.'**
  String get localPostNotice;

  /// No description provided for @comments.
  ///
  /// In en, this message translates to:
  /// **'Comments'**
  String get comments;

  /// No description provided for @addComment.
  ///
  /// In en, this message translates to:
  /// **'Add a comment'**
  String get addComment;

  /// No description provided for @sendComment.
  ///
  /// In en, this message translates to:
  /// **'Add in demo'**
  String get sendComment;

  /// No description provided for @like.
  ///
  /// In en, this message translates to:
  /// **'Like'**
  String get like;

  /// No description provided for @liked.
  ///
  /// In en, this message translates to:
  /// **'Liked'**
  String get liked;

  /// No description provided for @report.
  ///
  /// In en, this message translates to:
  /// **'Report'**
  String get report;

  /// No description provided for @block.
  ///
  /// In en, this message translates to:
  /// **'Block this author in demo'**
  String get block;

  /// No description provided for @reportPost.
  ///
  /// In en, this message translates to:
  /// **'Report post'**
  String get reportPost;

  /// No description provided for @reportWhy.
  ///
  /// In en, this message translates to:
  /// **'Why are you reporting this post?'**
  String get reportWhy;

  /// No description provided for @spam.
  ///
  /// In en, this message translates to:
  /// **'Spam'**
  String get spam;

  /// No description provided for @unkind.
  ///
  /// In en, this message translates to:
  /// **'Unkind or harmful language'**
  String get unkind;

  /// No description provided for @misleading.
  ///
  /// In en, this message translates to:
  /// **'Misleading content'**
  String get misleading;

  /// No description provided for @reportConfirmation.
  ///
  /// In en, this message translates to:
  /// **'Report recorded only in this demo. Nothing was sent.'**
  String get reportConfirmation;

  /// No description provided for @blocked.
  ///
  /// In en, this message translates to:
  /// **'Author hidden for this session.'**
  String get blocked;

  /// No description provided for @communityPostOne.
  ///
  /// In en, this message translates to:
  /// **'A slow walk helped me notice how much I was carrying. Tonight I’m choosing one small thing to release.'**
  String get communityPostOne;

  /// No description provided for @communityPostTwo.
  ///
  /// In en, this message translates to:
  /// **'My journal prompt today: where can I be a little kinder to myself?'**
  String get communityPostTwo;

  /// No description provided for @communityPostThree.
  ///
  /// In en, this message translates to:
  /// **'I made room for five quiet minutes before the day began. A small ritual can change the pace.'**
  String get communityPostThree;

  /// No description provided for @communityPostFour.
  ///
  /// In en, this message translates to:
  /// **'Learning that rest does not need to be earned. Sending a little encouragement to anyone who needs it.'**
  String get communityPostFour;

  /// No description provided for @communityPostFive.
  ///
  /// In en, this message translates to:
  /// **'Watching the moon reminded me that changing phases are natural. I can begin again tomorrow.'**
  String get communityPostFive;

  /// No description provided for @communityPostSix.
  ///
  /// In en, this message translates to:
  /// **'A cup of tea and a page in my notebook. That was enough for today.'**
  String get communityPostSix;

  /// No description provided for @communityPostSeven.
  ///
  /// In en, this message translates to:
  /// **'Today I listened before responding, and our conversation felt more spacious.'**
  String get communityPostSeven;

  /// No description provided for @communityPostEight.
  ///
  /// In en, this message translates to:
  /// **'I’m grateful for the small, steady things: morning light, a familiar song, a kind message.'**
  String get communityPostEight;

  /// No description provided for @mockComment.
  ///
  /// In en, this message translates to:
  /// **'Thank you for sharing this quiet reminder.'**
  String get mockComment;

  /// No description provided for @natalDeepDive.
  ///
  /// In en, this message translates to:
  /// **'Natal Chart Deep Dive'**
  String get natalDeepDive;

  /// No description provided for @bigThree.
  ///
  /// In en, this message translates to:
  /// **'Big Three'**
  String get bigThree;

  /// No description provided for @planets.
  ///
  /// In en, this message translates to:
  /// **'Planets'**
  String get planets;

  /// No description provided for @houses.
  ///
  /// In en, this message translates to:
  /// **'Houses'**
  String get houses;

  /// No description provided for @aspects.
  ///
  /// In en, this message translates to:
  /// **'Aspects'**
  String get aspects;

  /// No description provided for @coreArchetype.
  ///
  /// In en, this message translates to:
  /// **'Core Archetype'**
  String get coreArchetype;

  /// No description provided for @sunLibra.
  ///
  /// In en, this message translates to:
  /// **'Sun in Libra'**
  String get sunLibra;

  /// No description provided for @moonPisces.
  ///
  /// In en, this message translates to:
  /// **'Moon in Pisces'**
  String get moonPisces;

  /// No description provided for @risingTaurus.
  ///
  /// In en, this message translates to:
  /// **'Rising in Taurus'**
  String get risingTaurus;

  /// No description provided for @sunDescription.
  ///
  /// In en, this message translates to:
  /// **'The Harmonic Core: diplomacy, aesthetic appreciation, and relational equilibrium. A prepared reflection on finding grace and balance in hidden spaces.'**
  String get sunDescription;

  /// No description provided for @moonDescription.
  ///
  /// In en, this message translates to:
  /// **'The Intuitive Ocean: empathy, receptive dreams, and a quiet sanctuary. A prepared reflection on turning impressions into creative expression.'**
  String get moonDescription;

  /// No description provided for @risingDescription.
  ///
  /// In en, this message translates to:
  /// **'The Earthly Vessel: grounded presence, tactile comfort, and deliberate grace. A prepared reflection on finding steadiness in a changing world.'**
  String get risingDescription;

  /// No description provided for @airWater.
  ///
  /// In en, this message translates to:
  /// **'Air & Water Dominant'**
  String get airWater;

  /// No description provided for @primaryElement.
  ///
  /// In en, this message translates to:
  /// **'Primary Element'**
  String get primaryElement;

  /// No description provided for @modalBalance.
  ///
  /// In en, this message translates to:
  /// **'Modal Balance'**
  String get modalBalance;

  /// No description provided for @fixedCardinal.
  ///
  /// In en, this message translates to:
  /// **'5 Fixed · 4 Cardinal'**
  String get fixedCardinal;

  /// No description provided for @keyAspects.
  ///
  /// In en, this message translates to:
  /// **'Key Aspects & Alignments'**
  String get keyAspects;

  /// No description provided for @venusNeptune.
  ///
  /// In en, this message translates to:
  /// **'Venus Trine Neptune'**
  String get venusNeptune;

  /// No description provided for @sunMars.
  ///
  /// In en, this message translates to:
  /// **'Sun Sextile Mars'**
  String get sunMars;

  /// No description provided for @aspectDescription.
  ///
  /// In en, this message translates to:
  /// **'Creative sensitivity and balanced action offer useful themes for reflection. These illustrative positions are not calculated from your birth information.'**
  String get aspectDescription;

  /// No description provided for @housePreview.
  ///
  /// In en, this message translates to:
  /// **'House Placements Preview'**
  String get housePreview;

  /// No description provided for @viewHouses.
  ///
  /// In en, this message translates to:
  /// **'View all 12'**
  String get viewHouses;

  /// No description provided for @selfHouse.
  ///
  /// In en, this message translates to:
  /// **'Self & physical presence'**
  String get selfHouse;

  /// No description provided for @partnershipHouse.
  ///
  /// In en, this message translates to:
  /// **'Partnerships & connection'**
  String get partnershipHouse;

  /// No description provided for @vocationHouse.
  ///
  /// In en, this message translates to:
  /// **'Vocation & social innovation'**
  String get vocationHouse;

  /// No description provided for @houseMeaning.
  ///
  /// In en, this message translates to:
  /// **'An editorial introduction to this area of life. Notice what resonates, and leave room for your own experience.'**
  String get houseMeaning;

  /// No description provided for @chartDetails.
  ///
  /// In en, this message translates to:
  /// **'Chart Details'**
  String get chartDetails;

  /// No description provided for @planetDetail.
  ///
  /// In en, this message translates to:
  /// **'Planetary Meaning'**
  String get planetDetail;

  /// No description provided for @insight.
  ///
  /// In en, this message translates to:
  /// **'Astrological Insight'**
  String get insight;

  /// No description provided for @mercury.
  ///
  /// In en, this message translates to:
  /// **'Mercury'**
  String get mercury;

  /// No description provided for @venus.
  ///
  /// In en, this message translates to:
  /// **'Venus'**
  String get venus;

  /// No description provided for @mars.
  ///
  /// In en, this message translates to:
  /// **'Mars'**
  String get mars;

  /// No description provided for @jupiter.
  ///
  /// In en, this message translates to:
  /// **'Jupiter'**
  String get jupiter;

  /// No description provided for @saturn.
  ///
  /// In en, this message translates to:
  /// **'Saturn'**
  String get saturn;

  /// No description provided for @uranus.
  ///
  /// In en, this message translates to:
  /// **'Uranus'**
  String get uranus;

  /// No description provided for @neptune.
  ///
  /// In en, this message translates to:
  /// **'Neptune'**
  String get neptune;

  /// No description provided for @pluto.
  ///
  /// In en, this message translates to:
  /// **'Pluto'**
  String get pluto;

  /// No description provided for @numerologyHub.
  ///
  /// In en, this message translates to:
  /// **'Your Numbers, Your Rhythm'**
  String get numerologyHub;

  /// No description provided for @lifePath.
  ///
  /// In en, this message translates to:
  /// **'Life Path'**
  String get lifePath;

  /// No description provided for @lifePathPreview.
  ///
  /// In en, this message translates to:
  /// **'A symbolic lens for self-discovery. Numbers and cycles here are illustrative, not predictions.'**
  String get lifePathPreview;

  /// No description provided for @numerologyReport.
  ///
  /// In en, this message translates to:
  /// **'Numerology Report'**
  String get numerologyReport;

  /// No description provided for @calculatePreview.
  ///
  /// In en, this message translates to:
  /// **'Explore a sample number'**
  String get calculatePreview;

  /// No description provided for @expressionNumber.
  ///
  /// In en, this message translates to:
  /// **'Expression number'**
  String get expressionNumber;

  /// No description provided for @heartNumber.
  ///
  /// In en, this message translates to:
  /// **'Heart’s desire'**
  String get heartNumber;

  /// No description provided for @cyclesTitle.
  ///
  /// In en, this message translates to:
  /// **'Personal Cycles'**
  String get cyclesTitle;

  /// No description provided for @numerologyBody.
  ///
  /// In en, this message translates to:
  /// **'The Seeker is an invitation to value contemplation, curiosity, and your own pace. Make room for a question you have not yet answered. This prepared report uses sample numbers and is not a calculation from your details.'**
  String get numerologyBody;

  /// No description provided for @aries.
  ///
  /// In en, this message translates to:
  /// **'Aries'**
  String get aries;

  /// No description provided for @taurus.
  ///
  /// In en, this message translates to:
  /// **'Taurus'**
  String get taurus;

  /// No description provided for @gemini.
  ///
  /// In en, this message translates to:
  /// **'Gemini'**
  String get gemini;

  /// No description provided for @cancer.
  ///
  /// In en, this message translates to:
  /// **'Cancer'**
  String get cancer;

  /// No description provided for @leo.
  ///
  /// In en, this message translates to:
  /// **'Leo'**
  String get leo;

  /// No description provided for @virgoName.
  ///
  /// In en, this message translates to:
  /// **'Virgo'**
  String get virgoName;

  /// No description provided for @libra.
  ///
  /// In en, this message translates to:
  /// **'Libra'**
  String get libra;

  /// No description provided for @scorpio.
  ///
  /// In en, this message translates to:
  /// **'Scorpio'**
  String get scorpio;

  /// No description provided for @sagittarius.
  ///
  /// In en, this message translates to:
  /// **'Sagittarius'**
  String get sagittarius;

  /// No description provided for @capricorn.
  ///
  /// In en, this message translates to:
  /// **'Capricorn'**
  String get capricorn;

  /// No description provided for @aquarius.
  ///
  /// In en, this message translates to:
  /// **'Aquarius'**
  String get aquarius;

  /// No description provided for @pisces.
  ///
  /// In en, this message translates to:
  /// **'Pisces'**
  String get pisces;

  /// No description provided for @fire.
  ///
  /// In en, this message translates to:
  /// **'Fire'**
  String get fire;

  /// No description provided for @earth.
  ///
  /// In en, this message translates to:
  /// **'Earth'**
  String get earth;

  /// No description provided for @air.
  ///
  /// In en, this message translates to:
  /// **'Air'**
  String get air;

  /// No description provided for @water.
  ///
  /// In en, this message translates to:
  /// **'Water'**
  String get water;

  /// No description provided for @cardinal.
  ///
  /// In en, this message translates to:
  /// **'Cardinal'**
  String get cardinal;

  /// No description provided for @fixed.
  ///
  /// In en, this message translates to:
  /// **'Fixed'**
  String get fixed;

  /// No description provided for @mutable.
  ///
  /// In en, this message translates to:
  /// **'Mutable'**
  String get mutable;

  /// No description provided for @allEvents.
  ///
  /// In en, this message translates to:
  /// **'All Events'**
  String get allEvents;

  /// No description provided for @moonPhases.
  ///
  /// In en, this message translates to:
  /// **'Moon Phases'**
  String get moonPhases;

  /// No description provided for @planetaryTransits.
  ///
  /// In en, this message translates to:
  /// **'Planetary Transits'**
  String get planetaryTransits;

  /// No description provided for @personalAspects.
  ///
  /// In en, this message translates to:
  /// **'Personal Aspects'**
  String get personalAspects;

  /// No description provided for @celestialShifts.
  ///
  /// In en, this message translates to:
  /// **'Celestial Shifts'**
  String get celestialShifts;

  /// No description provided for @calendarDemo.
  ///
  /// In en, this message translates to:
  /// **'Preview events · illustrative dates in your device’s time zone'**
  String get calendarDemo;

  /// No description provided for @newMoonScorpio.
  ///
  /// In en, this message translates to:
  /// **'New Moon in Scorpio'**
  String get newMoonScorpio;

  /// No description provided for @marsLeo.
  ///
  /// In en, this message translates to:
  /// **'Mars enters Leo'**
  String get marsLeo;

  /// No description provided for @venusCapricorn.
  ///
  /// In en, this message translates to:
  /// **'Venus enters Capricorn'**
  String get venusCapricorn;

  /// No description provided for @fullMoonTaurus.
  ///
  /// In en, this message translates to:
  /// **'Full Moon in Taurus'**
  String get fullMoonTaurus;

  /// No description provided for @plutoAquarius.
  ///
  /// In en, this message translates to:
  /// **'Pluto enters Aquarius'**
  String get plutoAquarius;

  /// No description provided for @newMoonBody.
  ///
  /// In en, this message translates to:
  /// **'A window for inward reflection, intention setting, and clearing emotional clutter beneath still waters.'**
  String get newMoonBody;

  /// No description provided for @marsBody.
  ///
  /// In en, this message translates to:
  /// **'Creative fires awaken. Bold expression and courageous vitality invite a fresh approach to the everyday.'**
  String get marsBody;

  /// No description provided for @venusEventBody.
  ///
  /// In en, this message translates to:
  /// **'Grounded affection, long-term commitments, and emotional accountability invite a slower, thoughtful rhythm.'**
  String get venusEventBody;

  /// No description provided for @fullMoonBody.
  ///
  /// In en, this message translates to:
  /// **'A symbolic moment for grounding, sensory attention, and reflecting on material intentions.'**
  String get fullMoonBody;

  /// No description provided for @plutoBody.
  ///
  /// In en, this message translates to:
  /// **'Reflect on community, shared responsibility, and the structures that help people feel connected.'**
  String get plutoBody;

  /// No description provided for @lunarPhase.
  ///
  /// In en, this message translates to:
  /// **'Lunar Phase'**
  String get lunarPhase;

  /// No description provided for @planetaryShift.
  ///
  /// In en, this message translates to:
  /// **'Planetary Shift'**
  String get planetaryShift;

  /// No description provided for @supermoon.
  ///
  /// In en, this message translates to:
  /// **'Supermoon'**
  String get supermoon;

  /// No description provided for @majorEra.
  ///
  /// In en, this message translates to:
  /// **'Major Era'**
  String get majorEra;

  /// No description provided for @celestialSync.
  ///
  /// In en, this message translates to:
  /// **'Celestial Sync'**
  String get celestialSync;

  /// No description provided for @syncUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Calendar connections are not available in this offline prototype. Save events here to revisit them during this session.'**
  String get syncUnavailable;

  /// No description provided for @syncDisabled.
  ///
  /// In en, this message translates to:
  /// **'Calendar sync unavailable'**
  String get syncDisabled;

  /// No description provided for @selectedDay.
  ///
  /// In en, this message translates to:
  /// **'Selected day'**
  String get selectedDay;

  /// No description provided for @monthEvents.
  ///
  /// In en, this message translates to:
  /// **'Events this month'**
  String get monthEvents;

  /// No description provided for @dayEvents.
  ///
  /// In en, this message translates to:
  /// **'Events on this day'**
  String get dayEvents;

  /// No description provided for @clearDay.
  ///
  /// In en, this message translates to:
  /// **'Show entire month'**
  String get clearDay;

  /// No description provided for @noDayEvents.
  ///
  /// In en, this message translates to:
  /// **'A quiet day in this preview'**
  String get noDayEvents;

  /// No description provided for @noDayEventsBody.
  ///
  /// In en, this message translates to:
  /// **'No sample events match this date and filter. Try another day or view the entire month.'**
  String get noDayEventsBody;

  /// No description provided for @sanctuaryLabel.
  ///
  /// In en, this message translates to:
  /// **'Celestial Sanctuary'**
  String get sanctuaryLabel;

  /// No description provided for @unlockCosmos.
  ///
  /// In en, this message translates to:
  /// **'Unlock the Entire Cosmos'**
  String get unlockCosmos;

  /// No description provided for @subscriptionBody.
  ///
  /// In en, this message translates to:
  /// **'Explore deeper reflections, chart perspectives, and mindful rituals in one quiet place.'**
  String get subscriptionBody;

  /// No description provided for @harmonicCycle.
  ///
  /// In en, this message translates to:
  /// **'Harmonic Transit Cycle'**
  String get harmonicCycle;

  /// No description provided for @fullChartBenefit.
  ///
  /// In en, this message translates to:
  /// **'Natal chart & aspect deep dives'**
  String get fullChartBenefit;

  /// No description provided for @fullChartBenefitBody.
  ///
  /// In en, this message translates to:
  /// **'Explore illustrative houses, planetary themes, and reflective interpretations.'**
  String get fullChartBenefitBody;

  /// No description provided for @compatibilityBenefit.
  ///
  /// In en, this message translates to:
  /// **'Relationship reflections'**
  String get compatibilityBenefit;

  /// No description provided for @compatibilityBenefitBody.
  ///
  /// In en, this message translates to:
  /// **'Explore communication, emotional connection, and shared values through sample reports.'**
  String get compatibilityBenefitBody;

  /// No description provided for @wellnessBenefit.
  ///
  /// In en, this message translates to:
  /// **'Mindful rituals & breathwork'**
  String get wellnessBenefit;

  /// No description provided for @wellnessBenefitBody.
  ///
  /// In en, this message translates to:
  /// **'A meditation library, animated breathing exercises, and a personal journal.'**
  String get wellnessBenefitBody;

  /// No description provided for @calendarBenefit.
  ///
  /// In en, this message translates to:
  /// **'Cosmic calendar perspectives'**
  String get calendarBenefit;

  /// No description provided for @calendarBenefitBody.
  ///
  /// In en, this message translates to:
  /// **'Browse illustrative lunar phases and transit themes, with saved events.'**
  String get calendarBenefitBody;

  /// No description provided for @quietBenefit.
  ///
  /// In en, this message translates to:
  /// **'A quiet sanctuary'**
  String get quietBenefit;

  /// No description provided for @quietBenefitBody.
  ///
  /// In en, this message translates to:
  /// **'An uncluttered space for daily self-discovery and reflection.'**
  String get quietBenefitBody;

  /// No description provided for @annual.
  ///
  /// In en, this message translates to:
  /// **'Annual Access'**
  String get annual;

  /// No description provided for @monthlyAccess.
  ///
  /// In en, this message translates to:
  /// **'Monthly Access'**
  String get monthlyAccess;

  /// No description provided for @perMonth.
  ///
  /// In en, this message translates to:
  /// **'/ month'**
  String get perMonth;

  /// No description provided for @perYear.
  ///
  /// In en, this message translates to:
  /// **'/ year'**
  String get perYear;

  /// No description provided for @saveHalf.
  ///
  /// In en, this message translates to:
  /// **'Save 50%'**
  String get saveHalf;

  /// No description provided for @billedAnnually.
  ///
  /// In en, this message translates to:
  /// **'Illustrative · billed annually'**
  String get billedAnnually;

  /// No description provided for @flexibleMonthly.
  ///
  /// In en, this message translates to:
  /// **'Illustrative monthly rhythm'**
  String get flexibleMonthly;

  /// No description provided for @comingSoon.
  ///
  /// In en, this message translates to:
  /// **'Coming soon'**
  String get comingSoon;

  /// No description provided for @paymentNotice.
  ///
  /// In en, this message translates to:
  /// **'Illustrative prices in USD. No payment, subscription, or free trial is available in this prototype.'**
  String get paymentNotice;

  /// No description provided for @free.
  ///
  /// In en, this message translates to:
  /// **'Free'**
  String get free;

  /// No description provided for @premiumPlus.
  ///
  /// In en, this message translates to:
  /// **'Premium Plus'**
  String get premiumPlus;

  /// No description provided for @freeBody.
  ///
  /// In en, this message translates to:
  /// **'Daily reflection, breathing, and journal'**
  String get freeBody;

  /// No description provided for @premiumBodyPlan.
  ///
  /// In en, this message translates to:
  /// **'Chart and relationship report previews'**
  String get premiumBodyPlan;

  /// No description provided for @plusBodyPlan.
  ///
  /// In en, this message translates to:
  /// **'All illustrative reports and rituals'**
  String get plusBodyPlan;

  /// No description provided for @comparePlans.
  ///
  /// In en, this message translates to:
  /// **'Compare plans'**
  String get comparePlans;

  /// No description provided for @terms.
  ///
  /// In en, this message translates to:
  /// **'Terms of Service'**
  String get terms;

  /// No description provided for @privacy.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get privacy;

  /// No description provided for @credits.
  ///
  /// In en, this message translates to:
  /// **'Credits'**
  String get credits;

  /// No description provided for @creditsBody.
  ///
  /// In en, this message translates to:
  /// **'Sample balance · no monetary value'**
  String get creditsBody;

  /// No description provided for @creditHistory.
  ///
  /// In en, this message translates to:
  /// **'Demo credit history'**
  String get creditHistory;

  /// No description provided for @welcomeCredit.
  ///
  /// In en, this message translates to:
  /// **'Welcome sample credits'**
  String get welcomeCredit;

  /// No description provided for @reportCredit.
  ///
  /// In en, this message translates to:
  /// **'Illustrative report preview'**
  String get reportCredit;

  /// No description provided for @celestialMember.
  ///
  /// In en, this message translates to:
  /// **'Celestial Member · demo'**
  String get celestialMember;

  /// No description provided for @upgrade.
  ///
  /// In en, this message translates to:
  /// **'Explore Plus'**
  String get upgrade;

  /// No description provided for @cosmicBlueprint.
  ///
  /// In en, this message translates to:
  /// **'Cosmic Blueprint'**
  String get cosmicBlueprint;

  /// No description provided for @astrologicalData.
  ///
  /// In en, this message translates to:
  /// **'Illustrative data'**
  String get astrologicalData;

  /// No description provided for @natalSummary.
  ///
  /// In en, this message translates to:
  /// **'Natal Chart Summary'**
  String get natalSummary;

  /// No description provided for @natalSummaryBody.
  ///
  /// In en, this message translates to:
  /// **'Planetary themes & house perspectives'**
  String get natalSummaryBody;

  /// No description provided for @transitArchive.
  ///
  /// In en, this message translates to:
  /// **'Transit Archive'**
  String get transitArchive;

  /// No description provided for @transitArchiveBody.
  ///
  /// In en, this message translates to:
  /// **'Sample lunar phases and planetary themes'**
  String get transitArchiveBody;

  /// No description provided for @savedSanctuary.
  ///
  /// In en, this message translates to:
  /// **'Saved & Sanctuary'**
  String get savedSanctuary;

  /// No description provided for @savedHoroscopes.
  ///
  /// In en, this message translates to:
  /// **'Saved Horoscopes'**
  String get savedHoroscopes;

  /// No description provided for @bookmarkedMeditations.
  ///
  /// In en, this message translates to:
  /// **'Bookmarked Meditations'**
  String get bookmarkedMeditations;

  /// No description provided for @relationshipCharts.
  ///
  /// In en, this message translates to:
  /// **'Synastry & Charts'**
  String get relationshipCharts;

  /// No description provided for @preferencesSettings.
  ///
  /// In en, this message translates to:
  /// **'Preferences & Settings'**
  String get preferencesSettings;

  /// No description provided for @dailyNotification.
  ///
  /// In en, this message translates to:
  /// **'Daily horoscope reminders'**
  String get dailyNotification;

  /// No description provided for @notificationDemo.
  ///
  /// In en, this message translates to:
  /// **'Simulated preference · no notifications are sent'**
  String get notificationDemo;

  /// No description provided for @houseSystem.
  ///
  /// In en, this message translates to:
  /// **'House System'**
  String get houseSystem;

  /// No description provided for @houseSystemBody.
  ///
  /// In en, this message translates to:
  /// **'Illustrative chart preference'**
  String get houseSystemBody;

  /// No description provided for @placidus.
  ///
  /// In en, this message translates to:
  /// **'Tropical / Placidus'**
  String get placidus;

  /// No description provided for @wholeSign.
  ///
  /// In en, this message translates to:
  /// **'Whole Sign'**
  String get wholeSign;

  /// No description provided for @privacyVault.
  ///
  /// In en, this message translates to:
  /// **'Privacy & Help'**
  String get privacyVault;

  /// No description provided for @privacyVaultBody.
  ///
  /// In en, this message translates to:
  /// **'Local demo information'**
  String get privacyVaultBody;

  /// No description provided for @signOut.
  ///
  /// In en, this message translates to:
  /// **'Leave demo session'**
  String get signOut;

  /// No description provided for @signOutBody.
  ///
  /// In en, this message translates to:
  /// **'Your session will reset. Your language preference will remain on this device.'**
  String get signOutBody;

  /// No description provided for @insightsRead.
  ///
  /// In en, this message translates to:
  /// **'Insights'**
  String get insightsRead;

  /// No description provided for @minutesCalm.
  ///
  /// In en, this message translates to:
  /// **'Min calm'**
  String get minutesCalm;

  /// No description provided for @reflections.
  ///
  /// In en, this message translates to:
  /// **'Reflections'**
  String get reflections;

  /// No description provided for @pastMonth.
  ///
  /// In en, this message translates to:
  /// **'Past 30 days · demo'**
  String get pastMonth;

  /// No description provided for @sessions.
  ///
  /// In en, this message translates to:
  /// **'Sessions'**
  String get sessions;

  /// No description provided for @sessionOnly.
  ///
  /// In en, this message translates to:
  /// **'This session'**
  String get sessionOnly;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @editProfile.
  ///
  /// In en, this message translates to:
  /// **'Edit profile'**
  String get editProfile;

  /// No description provided for @languageSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Choose your reading language'**
  String get languageSubtitle;

  /// No description provided for @theme.
  ///
  /// In en, this message translates to:
  /// **'Appearance'**
  String get theme;

  /// No description provided for @themeDark.
  ///
  /// In en, this message translates to:
  /// **'Celestial night'**
  String get themeDark;

  /// No description provided for @themeDusk.
  ///
  /// In en, this message translates to:
  /// **'Soft dusk'**
  String get themeDusk;

  /// No description provided for @themeBody.
  ///
  /// In en, this message translates to:
  /// **'A softer contrast for your evening ritual.'**
  String get themeBody;

  /// No description provided for @notificationsSetting.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notificationsSetting;

  /// No description provided for @privacyTitle.
  ///
  /// In en, this message translates to:
  /// **'Your space, your pace'**
  String get privacyTitle;

  /// No description provided for @privacyBody.
  ///
  /// In en, this message translates to:
  /// **'This is an offline frontend prototype. Your name and birth details stay in session memory. Language and appearance preferences are stored on this device. Journal entries, posts, reports, and comparisons are local demonstrations and reset when the app restarts. No account, server, calendar connection, or payment service is connected.'**
  String get privacyBody;

  /// No description provided for @legalPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Provisional copy. Final terms and privacy policies will be provided before publication. Astrology and numerology content is illustrative and is not medical, legal, or financial advice.'**
  String get legalPlaceholder;

  /// No description provided for @support.
  ///
  /// In en, this message translates to:
  /// **'Support'**
  String get support;

  /// No description provided for @supportBody.
  ///
  /// In en, this message translates to:
  /// **'Support messaging is not connected in this prototype. You can review this demo’s privacy and data information here.'**
  String get supportBody;

  /// No description provided for @achievements.
  ///
  /// In en, this message translates to:
  /// **'Achievements'**
  String get achievements;

  /// No description provided for @achievementOne.
  ///
  /// In en, this message translates to:
  /// **'First intention'**
  String get achievementOne;

  /// No description provided for @achievementTwo.
  ///
  /// In en, this message translates to:
  /// **'A moment of calm'**
  String get achievementTwo;

  /// No description provided for @achievementThree.
  ///
  /// In en, this message translates to:
  /// **'A page of your own'**
  String get achievementThree;

  /// No description provided for @achievementFour.
  ///
  /// In en, this message translates to:
  /// **'Curious observer'**
  String get achievementFour;

  /// No description provided for @achievementFive.
  ///
  /// In en, this message translates to:
  /// **'Shared reflection'**
  String get achievementFive;

  /// No description provided for @achievementSix.
  ///
  /// In en, this message translates to:
  /// **'Quiet collector'**
  String get achievementSix;

  /// No description provided for @achievementBody.
  ///
  /// In en, this message translates to:
  /// **'A small milestone in your local demo journey.'**
  String get achievementBody;

  /// No description provided for @unlocked.
  ///
  /// In en, this message translates to:
  /// **'Unlocked'**
  String get unlocked;

  /// No description provided for @inProgress.
  ///
  /// In en, this message translates to:
  /// **'In progress'**
  String get inProgress;

  /// No description provided for @markAllRead.
  ///
  /// In en, this message translates to:
  /// **'Mark all read'**
  String get markAllRead;

  /// No description provided for @notificationOne.
  ///
  /// In en, this message translates to:
  /// **'Your daily reflection is ready'**
  String get notificationOne;

  /// No description provided for @notificationTwo.
  ///
  /// In en, this message translates to:
  /// **'A moment of stillness'**
  String get notificationTwo;

  /// No description provided for @notificationThree.
  ///
  /// In en, this message translates to:
  /// **'Explore this month’s sky'**
  String get notificationThree;

  /// No description provided for @notificationBody.
  ///
  /// In en, this message translates to:
  /// **'A sample reminder for your own daily rhythm.'**
  String get notificationBody;

  /// No description provided for @notificationEmpty.
  ///
  /// In en, this message translates to:
  /// **'A quiet inbox'**
  String get notificationEmpty;

  /// No description provided for @notificationEmptyBody.
  ///
  /// In en, this message translates to:
  /// **'There are no unread sample reminders.'**
  String get notificationEmptyBody;

  /// No description provided for @unread.
  ///
  /// In en, this message translates to:
  /// **'Unread'**
  String get unread;

  /// No description provided for @read.
  ///
  /// In en, this message translates to:
  /// **'Read'**
  String get read;

  /// No description provided for @removeAll.
  ///
  /// In en, this message translates to:
  /// **'Clear read reminders'**
  String get removeAll;

  /// No description provided for @versionLabel.
  ///
  /// In en, this message translates to:
  /// **'Celestial · offline prototype'**
  String get versionLabel;

  /// No description provided for @builtReverence.
  ///
  /// In en, this message translates to:
  /// **'Grounded in the stars · made for reflection'**
  String get builtReverence;

  /// No description provided for @noFavorites.
  ///
  /// In en, this message translates to:
  /// **'Nothing saved yet'**
  String get noFavorites;

  /// No description provided for @noFavoritesBody.
  ///
  /// In en, this message translates to:
  /// **'Save a reading, meditation, or calendar event to find it here.'**
  String get noFavoritesBody;

  /// No description provided for @resetDemo.
  ///
  /// In en, this message translates to:
  /// **'Reset demo'**
  String get resetDemo;

  /// No description provided for @confirmReset.
  ///
  /// In en, this message translates to:
  /// **'Reset this local session?'**
  String get confirmReset;

  /// No description provided for @sampleName.
  ///
  /// In en, this message translates to:
  /// **'Elena Vance'**
  String get sampleName;

  /// No description provided for @samplePartner.
  ///
  /// In en, this message translates to:
  /// **'Marcus'**
  String get samplePartner;

  /// No description provided for @sampleCity.
  ///
  /// In en, this message translates to:
  /// **'Seattle, WA, USA'**
  String get sampleCity;

  /// No description provided for @friend.
  ///
  /// In en, this message translates to:
  /// **'A friend'**
  String get friend;

  /// No description provided for @futureBirth.
  ///
  /// In en, this message translates to:
  /// **'Choose a date in the past.'**
  String get futureBirth;
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
