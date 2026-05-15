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

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
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
    Locale('es')
  ];

  /// No description provided for @hello.
  ///
  /// In en, this message translates to:
  /// **'Hello'**
  String get hello;

  /// No description provided for @proyectRealized.
  ///
  /// In en, this message translates to:
  /// **'Realized Projects'**
  String get proyectRealized;

  /// No description provided for @selectLanguage.
  ///
  /// In en, this message translates to:
  /// **'Select language'**
  String get selectLanguage;

  /// No description provided for @company.
  ///
  /// In en, this message translates to:
  /// **'Company:'**
  String get company;

  /// No description provided for @country.
  ///
  /// In en, this message translates to:
  /// **'Country:'**
  String get country;

  /// No description provided for @employment.
  ///
  /// In en, this message translates to:
  /// **'Employment:'**
  String get employment;

  /// No description provided for @skills.
  ///
  /// In en, this message translates to:
  /// **'Skills:'**
  String get skills;

  /// No description provided for @administratorIt.
  ///
  /// In en, this message translates to:
  /// **'IT Administrator'**
  String get administratorIt;

  /// No description provided for @seeProject.
  ///
  /// In en, this message translates to:
  /// **'see project'**
  String get seeProject;

  /// No description provided for @webDeveloperAndDataAnalyst.
  ///
  /// In en, this message translates to:
  /// **'Web developer and data analyst'**
  String get webDeveloperAndDataAnalyst;

  /// No description provided for @services.
  ///
  /// In en, this message translates to:
  /// **'Services'**
  String get services;

  /// No description provided for @servicesApp.
  ///
  /// In en, this message translates to:
  /// **'Hi Alberto, I want more information about app development:'**
  String get servicesApp;

  /// No description provided for @servicesAppTitle.
  ///
  /// In en, this message translates to:
  /// **'App development'**
  String get servicesAppTitle;

  /// No description provided for @servicesDevWeb.
  ///
  /// In en, this message translates to:
  /// **'Hi Alberto, I would like more information about website development:'**
  String get servicesDevWeb;

  /// No description provided for @servicesDevWebTitle.
  ///
  /// In en, this message translates to:
  /// **'Website development'**
  String get servicesDevWebTitle;

  /// No description provided for @servicesDisWeb.
  ///
  /// In en, this message translates to:
  /// **'Hi Alberto, I want more information about web site design:'**
  String get servicesDisWeb;

  /// No description provided for @servicesDisWebTitle.
  ///
  /// In en, this message translates to:
  /// **'Website design'**
  String get servicesDisWebTitle;

  /// No description provided for @madeWithFlutter.
  ///
  /// In en, this message translates to:
  /// **'Made with Flutter'**
  String get madeWithFlutter;

  /// No description provided for @desingFlutter.
  ///
  /// In en, this message translates to:
  /// **'Flutter Designs'**
  String get desingFlutter;

  /// No description provided for @resource.
  ///
  /// In en, this message translates to:
  /// **'Resources'**
  String get resource;

  /// No description provided for @portfolioStyle.
  ///
  /// In en, this message translates to:
  /// **'My portfolio in the style of'**
  String get portfolioStyle;

  /// No description provided for @professionalWebsite.
  ///
  /// In en, this message translates to:
  /// **'Professional Website'**
  String get professionalWebsite;

  /// No description provided for @informationAbout.
  ///
  /// In en, this message translates to:
  /// **'Hello Alberto, I would like more information about:'**
  String get informationAbout;

  /// No description provided for @meetMe.
  ///
  /// In en, this message translates to:
  /// **'Meet with me'**
  String get meetMe;

  /// No description provided for @open.
  ///
  /// In en, this message translates to:
  /// **'Open'**
  String get open;

  /// No description provided for @googlePlay.
  ///
  /// In en, this message translates to:
  /// **'Google Play'**
  String get googlePlay;

  /// No description provided for @github.
  ///
  /// In en, this message translates to:
  /// **'GitHub'**
  String get github;

  /// No description provided for @original.
  ///
  /// In en, this message translates to:
  /// **'original'**
  String get original;

  /// No description provided for @readMyBlog.
  ///
  /// In en, this message translates to:
  /// **'Read my Blog'**
  String get readMyBlog;

  /// No description provided for @view.
  ///
  /// In en, this message translates to:
  /// **'View'**
  String get view;

  /// No description provided for @descriptionAbout.
  ///
  /// In en, this message translates to:
  /// **'A proactive professional with experience in operational management, business consulting, technology product promotion, technical support, and helpdesk coordination. I have managed administrative and business processes, providing strategic customer service, driving sales, and ensuring efficient operations through organization, monitoring, and continuous oversight. I have experience in personalized consulting, sales promotion, customer management, technical issue resolution, digital platform administration, and user training, enhancing both the customer experience and the operational efficiency of the departments under my responsibility. I complement my profile with knowledge of web and mobile development, databases, and technological tools, which allows me to quickly adapt to new systems, understand digital processes holistically, and provide commercial, administrative, and technical solutions focused on results and continuous improvement.'**
  String get descriptionAbout;

  /// No description provided for @experience.
  ///
  /// In en, this message translates to:
  /// **'Experience'**
  String get experience;

  /// No description provided for @project.
  ///
  /// In en, this message translates to:
  /// **'Projects'**
  String get project;

  /// No description provided for @publications.
  ///
  /// In en, this message translates to:
  /// **'Publications'**
  String get publications;

  /// No description provided for @contacMe.
  ///
  /// In en, this message translates to:
  /// **'Contact me'**
  String get contacMe;

  /// No description provided for @aboutMe.
  ///
  /// In en, this message translates to:
  /// **'About Me'**
  String get aboutMe;

  /// No description provided for @helloWordIam.
  ///
  /// In en, this message translates to:
  /// **'Hello, World! I am'**
  String get helloWordIam;

  /// No description provided for @freelancer.
  ///
  /// In en, this message translates to:
  /// **'Freelancer '**
  String get freelancer;

  /// No description provided for @helpdeskManagement.
  ///
  /// In en, this message translates to:
  /// **'Helpdesk management and issue resolution, efficiently solving technical problems.'**
  String get helpdeskManagement;

  /// No description provided for @dataAnalysisAndMaintenance.
  ///
  /// In en, this message translates to:
  /// **'Data analysis and maintenance of educational sites with Moodle.'**
  String get dataAnalysisAndMaintenance;

  /// No description provided for @processAutomation.
  ///
  /// In en, this message translates to:
  /// **'Process automation and preventive maintenance of equipment.'**
  String get processAutomation;

  /// No description provided for @flutterDevelopment.
  ///
  /// In en, this message translates to:
  /// **'Development and implementation of software using Flutter.'**
  String get flutterDevelopment;

  /// No description provided for @mobileWebInstructor.
  ///
  /// In en, this message translates to:
  /// **'Instructor of mobile and web application courses.'**
  String get mobileWebInstructor;

  /// No description provided for @mobileWebDevelopment.
  ///
  /// In en, this message translates to:
  /// **'Development of mobile and web applications using Flutter.'**
  String get mobileWebDevelopment;

  /// No description provided for @mobileConsulting.
  ///
  /// In en, this message translates to:
  /// **'Consulting on the development of mobile applications with Flutter.'**
  String get mobileConsulting;

  /// No description provided for @webDevelopment.
  ///
  /// In en, this message translates to:
  /// **'Web development with HTML, JavaScript, CSS, and Webflow.'**
  String get webDevelopment;

  /// No description provided for @onlineStoreCreation.
  ///
  /// In en, this message translates to:
  /// **'Creation of online stores using Odoo, WooCommerce, and WordPress.'**
  String get onlineStoreCreation;

  /// No description provided for @mobileWebInstructorRepeat.
  ///
  /// In en, this message translates to:
  /// **'Instructor of mobile and web application courses.'**
  String get mobileWebInstructorRepeat;
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
      'that was used.');
}
