import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

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
  static const List<Locale> supportedLocales = <Locale>[Locale('es')];

  /// No description provided for @hello.
  ///
  /// In es, this message translates to:
  /// **'Hola'**
  String get hello;

  /// No description provided for @proyectRealized.
  ///
  /// In es, this message translates to:
  /// **'Proyectos Realiados'**
  String get proyectRealized;

  /// No description provided for @selectLanguage.
  ///
  /// In es, this message translates to:
  /// **'Seleccionar idioma'**
  String get selectLanguage;

  /// No description provided for @company.
  ///
  /// In es, this message translates to:
  /// **'Empresa:'**
  String get company;

  /// No description provided for @country.
  ///
  /// In es, this message translates to:
  /// **'País:'**
  String get country;

  /// No description provided for @employment.
  ///
  /// In es, this message translates to:
  /// **'Empleo:'**
  String get employment;

  /// No description provided for @skills.
  ///
  /// In es, this message translates to:
  /// **'Herramientas'**
  String get skills;

  /// No description provided for @gallery.
  ///
  /// In es, this message translates to:
  /// **'Galería'**
  String get gallery;

  /// No description provided for @galleryHint.
  ///
  /// In es, this message translates to:
  /// **'Una mirada a algunos momentos de mi día a día.'**
  String get galleryHint;

  /// No description provided for @clients.
  ///
  /// In es, this message translates to:
  /// **'Clientes'**
  String get clients;

  /// No description provided for @clientsHint.
  ///
  /// In es, this message translates to:
  /// **'Clientes desarrollados con Tinguar.'**
  String get clientsHint;

  /// No description provided for @blog.
  ///
  /// In es, this message translates to:
  /// **'Blog'**
  String get blog;

  /// No description provided for @blogHint.
  ///
  /// In es, this message translates to:
  /// **'Artículos sobre desarrollo, Flutter, web y más.'**
  String get blogHint;

  /// No description provided for @blogRss.
  ///
  /// In es, this message translates to:
  /// **'RSS del blog'**
  String get blogRss;

  /// No description provided for @blogEmptyFilter.
  ///
  /// In es, this message translates to:
  /// **'No hay artículos en esta categoría.'**
  String get blogEmptyFilter;

  /// No description provided for @home.
  ///
  /// In es, this message translates to:
  /// **'Inicio'**
  String get home;

  /// No description provided for @homeHeroLead.
  ///
  /// In es, this message translates to:
  /// **'Tecnólogo superior en desarrollo de software. Combino desarrollo, soporte IT / helpdesk y sistemas para entregar soluciones que tienen que funcionar en operación real.'**
  String get homeHeroLead;

  /// No description provided for @contact.
  ///
  /// In es, this message translates to:
  /// **'Contacto'**
  String get contact;

  /// No description provided for @contactHint.
  ///
  /// In es, this message translates to:
  /// **'Escríbeme a contacto@albertoguaman.com, por WhatsApp o descarga el CV.'**
  String get contactHint;

  /// No description provided for @contactEmail.
  ///
  /// In es, this message translates to:
  /// **'contacto@albertoguaman.com'**
  String get contactEmail;

  /// No description provided for @cvPreview.
  ///
  /// In es, this message translates to:
  /// **'Vista previa del CV'**
  String get cvPreview;

  /// No description provided for @downloadCv.
  ///
  /// In es, this message translates to:
  /// **'Descargar CV'**
  String get downloadCv;

  /// No description provided for @availabilityOpen.
  ///
  /// In es, this message translates to:
  /// **'Abierto a oportunidades'**
  String get availabilityOpen;

  /// No description provided for @availabilityRole.
  ///
  /// In es, this message translates to:
  /// **'Tecnólogo en software · Desarrollo / Soporte IT'**
  String get availabilityRole;

  /// No description provided for @cvPageTitle.
  ///
  /// In es, this message translates to:
  /// **'CV'**
  String get cvPageTitle;

  /// No description provided for @cvPageHint.
  ///
  /// In es, this message translates to:
  /// **'Vista previa e impresión del currículum.'**
  String get cvPageHint;

  /// No description provided for @printCv.
  ///
  /// In es, this message translates to:
  /// **'Imprimir'**
  String get printCv;

  /// No description provided for @contactFormTitle.
  ///
  /// In es, this message translates to:
  /// **'Formulario de contacto'**
  String get contactFormTitle;

  /// No description provided for @contactFormName.
  ///
  /// In es, this message translates to:
  /// **'Nombre'**
  String get contactFormName;

  /// No description provided for @contactFormEmail.
  ///
  /// In es, this message translates to:
  /// **'Email'**
  String get contactFormEmail;

  /// No description provided for @contactFormTopic.
  ///
  /// In es, this message translates to:
  /// **'Tema'**
  String get contactFormTopic;

  /// No description provided for @contactFormMessage.
  ///
  /// In es, this message translates to:
  /// **'Mensaje'**
  String get contactFormMessage;

  /// No description provided for @contactFormSubmit.
  ///
  /// In es, this message translates to:
  /// **'Enviar'**
  String get contactFormSubmit;

  /// No description provided for @contactFormRequired.
  ///
  /// In es, this message translates to:
  /// **'Completa nombre, email y mensaje.'**
  String get contactFormRequired;

  /// No description provided for @contactTopicGeneral.
  ///
  /// In es, this message translates to:
  /// **'Consulta general'**
  String get contactTopicGeneral;

  /// No description provided for @contactTopicJob.
  ///
  /// In es, this message translates to:
  /// **'Oportunidad laboral'**
  String get contactTopicJob;

  /// No description provided for @contactTopicProject.
  ///
  /// In es, this message translates to:
  /// **'Proyecto / desarrollo'**
  String get contactTopicProject;

  /// No description provided for @themeToggle.
  ///
  /// In es, this message translates to:
  /// **'Tema'**
  String get themeToggle;

  /// No description provided for @skipToContent.
  ///
  /// In es, this message translates to:
  /// **'Saltar al contenido'**
  String get skipToContent;

  /// No description provided for @administratorIt.
  ///
  /// In es, this message translates to:
  /// **'Tecnólogo superior en desarrollo de software'**
  String get administratorIt;

  /// No description provided for @administratorItShort.
  ///
  /// In es, this message translates to:
  /// **'Tecnólogo en software'**
  String get administratorItShort;

  /// No description provided for @seeProject.
  ///
  /// In es, this message translates to:
  /// **'ver proyecto'**
  String get seeProject;

  /// No description provided for @webDeveloperAndDataAnalyst.
  ///
  /// In es, this message translates to:
  /// **'Desarrollador web y analista de datos'**
  String get webDeveloperAndDataAnalyst;

  /// No description provided for @services.
  ///
  /// In es, this message translates to:
  /// **'Servicios de'**
  String get services;

  /// No description provided for @servicesApp.
  ///
  /// In es, this message translates to:
  /// **'Hola Alberto, quiero más información sobre desarrollo de apps:'**
  String get servicesApp;

  /// No description provided for @servicesAppTitle.
  ///
  /// In es, this message translates to:
  /// **'Desarrollo de apps'**
  String get servicesAppTitle;

  /// No description provided for @servicesDevWeb.
  ///
  /// In es, this message translates to:
  /// **'Hola Alberto, quiero más información sobre desarrollo de sitios web:'**
  String get servicesDevWeb;

  /// No description provided for @servicesDevWebTitle.
  ///
  /// In es, this message translates to:
  /// **'Desarrollo de sitios web'**
  String get servicesDevWebTitle;

  /// No description provided for @servicesDisWeb.
  ///
  /// In es, this message translates to:
  /// **'Hola Alberto, quiero más información sobre diseño de sitios web:'**
  String get servicesDisWeb;

  /// No description provided for @servicesDisWebTitle.
  ///
  /// In es, this message translates to:
  /// **'Diseño de sitios web'**
  String get servicesDisWebTitle;

  /// No description provided for @madeWithFlutter.
  ///
  /// In es, this message translates to:
  /// **'Realizado con Flutter'**
  String get madeWithFlutter;

  /// No description provided for @desingFlutter.
  ///
  /// In es, this message translates to:
  /// **'Diseños con Flutter'**
  String get desingFlutter;

  /// No description provided for @resource.
  ///
  /// In es, this message translates to:
  /// **'Recursos de'**
  String get resource;

  /// No description provided for @portfolioStyle.
  ///
  /// In es, this message translates to:
  /// **'Mi portafolio con estilo de'**
  String get portfolioStyle;

  /// No description provided for @professionalWebsite.
  ///
  /// In es, this message translates to:
  /// **'Sitio web Profesional'**
  String get professionalWebsite;

  /// No description provided for @informationAbout.
  ///
  /// In es, this message translates to:
  /// **'Hola Alberto, quiero más información sobre:'**
  String get informationAbout;

  /// No description provided for @meetMe.
  ///
  /// In es, this message translates to:
  /// **'Reúnete conmigo'**
  String get meetMe;

  /// No description provided for @open.
  ///
  /// In es, this message translates to:
  /// **'Abrir'**
  String get open;

  /// No description provided for @googlePlay.
  ///
  /// In es, this message translates to:
  /// **'Google Play'**
  String get googlePlay;

  /// No description provided for @github.
  ///
  /// In es, this message translates to:
  /// **'GitHub'**
  String get github;

  /// No description provided for @original.
  ///
  /// In es, this message translates to:
  /// **'original'**
  String get original;

  /// No description provided for @readMyBlog.
  ///
  /// In es, this message translates to:
  /// **'Lee mi Blog'**
  String get readMyBlog;

  /// No description provided for @view.
  ///
  /// In es, this message translates to:
  /// **'Visualizar'**
  String get view;

  /// No description provided for @descriptionAbout.
  ///
  /// In es, this message translates to:
  /// **'Soy Alberto Guaman. Me muevo entre soporte técnico y desarrollo: tickets, sistemas caídos, apps y sitios que tienen que funcionar en el día a día.\n\nHe dado soporte L1/L2 de informática a sucursales a nivel nacional, coordinado helpdesk, administrado operación comercial y armado productos digitales con Flutter, web y e-commerce.\n\nSi algo se rompe, lo diagnostico; si hay que construir, lo construyo. Ese es el hilo de mi trayectoria.'**
  String get descriptionAbout;

  /// No description provided for @descriptionAboutDevelopment.
  ///
  /// In es, this message translates to:
  /// **'Soy Alberto Guaman, tecnólogo en desarrollo de software. Trabajo entre soporte técnico / IT y la construcción de soluciones digitales.\n\nHe dado soporte L1/L2 de informática a más de 16 sucursales a nivel nacional: hardware, software, tickets y acompañamiento remoto.\n\nEsta cobertura incluye la atención y el acompañamiento tecnológico a más de 200 colaboradores internos. También desarrollo módulos con Java para una plataforma MDM orientada al rastreo y la gestión de equipos empresariales.\n\nMi experiencia combina Java, MDM, Flutter, Dart, Firebase, Git y stack web. Además, trabajo con IA — Cursor, Claude (Anthropic) y modelos predictivos — para escribir, revisar y depurar más rápido, sin soltar el criterio de lo que se entrega.'**
  String get descriptionAboutDevelopment;

  /// No description provided for @aboutProfileDevelopment.
  ///
  /// In es, this message translates to:
  /// **'Desarrollo'**
  String get aboutProfileDevelopment;

  /// No description provided for @aboutProfileAdvisor.
  ///
  /// In es, this message translates to:
  /// **'Asesor'**
  String get aboutProfileAdvisor;

  /// No description provided for @experience.
  ///
  /// In es, this message translates to:
  /// **'Experiencia'**
  String get experience;

  /// No description provided for @project.
  ///
  /// In es, this message translates to:
  /// **'Proyectos'**
  String get project;

  /// No description provided for @caseStudies.
  ///
  /// In es, this message translates to:
  /// **'Casos de estudio'**
  String get caseStudies;

  /// No description provided for @caseStudiesHint.
  ///
  /// In es, this message translates to:
  /// **'Problema, solución y resultados de proyectos reales.'**
  String get caseStudiesHint;

  /// No description provided for @navCaseStudies.
  ///
  /// In es, this message translates to:
  /// **'Casos'**
  String get navCaseStudies;

  /// No description provided for @navTestimonials.
  ///
  /// In es, this message translates to:
  /// **'Reseñas'**
  String get navTestimonials;

  /// No description provided for @caseStudyProblem.
  ///
  /// In es, this message translates to:
  /// **'Problema'**
  String get caseStudyProblem;

  /// No description provided for @caseStudySolution.
  ///
  /// In es, this message translates to:
  /// **'Solución'**
  String get caseStudySolution;

  /// No description provided for @caseStudyResults.
  ///
  /// In es, this message translates to:
  /// **'Resultados'**
  String get caseStudyResults;

  /// No description provided for @caseStudyStack.
  ///
  /// In es, this message translates to:
  /// **'Stack'**
  String get caseStudyStack;

  /// No description provided for @testimonials.
  ///
  /// In es, this message translates to:
  /// **'Recomendaciones'**
  String get testimonials;

  /// No description provided for @testimonialsHint.
  ///
  /// In es, this message translates to:
  /// **'Reseñas de clientes en proyectos con Tinguar.'**
  String get testimonialsHint;

  /// No description provided for @testimonialsGoogleCertified.
  ///
  /// In es, this message translates to:
  /// **'Reseñas certificadas por Google'**
  String get testimonialsGoogleCertified;

  /// No description provided for @exploreMore.
  ///
  /// In es, this message translates to:
  /// **'Explorar'**
  String get exploreMore;

  /// No description provided for @exploreCasesCta.
  ///
  /// In es, this message translates to:
  /// **'Ver casos de estudio'**
  String get exploreCasesCta;

  /// No description provided for @exploreReviewsCta.
  ///
  /// In es, this message translates to:
  /// **'Ver recomendaciones'**
  String get exploreReviewsCta;

  /// No description provided for @publications.
  ///
  /// In es, this message translates to:
  /// **'Publicaciones'**
  String get publications;

  /// No description provided for @content.
  ///
  /// In es, this message translates to:
  /// **'Contenido'**
  String get content;

  /// No description provided for @contentHint.
  ///
  /// In es, this message translates to:
  /// **'Blog, LinkedIn e Instagram'**
  String get contentHint;

  /// No description provided for @contentFilterAll.
  ///
  /// In es, this message translates to:
  /// **'Todo'**
  String get contentFilterAll;

  /// No description provided for @contentFilterBlog.
  ///
  /// In es, this message translates to:
  /// **'Blog'**
  String get contentFilterBlog;

  /// No description provided for @contentFilterLinkedIn.
  ///
  /// In es, this message translates to:
  /// **'LinkedIn'**
  String get contentFilterLinkedIn;

  /// No description provided for @contentFilterInstagram.
  ///
  /// In es, this message translates to:
  /// **'Instagram'**
  String get contentFilterInstagram;

  /// No description provided for @contentReadMore.
  ///
  /// In es, this message translates to:
  /// **'Abrir'**
  String get contentReadMore;

  /// No description provided for @contentSeeAllBlog.
  ///
  /// In es, this message translates to:
  /// **'Ver blog completo'**
  String get contentSeeAllBlog;

  /// No description provided for @contacMe.
  ///
  /// In es, this message translates to:
  /// **'Contáctame'**
  String get contacMe;

  /// No description provided for @aboutMe.
  ///
  /// In es, this message translates to:
  /// **'Sobre mí'**
  String get aboutMe;

  /// No description provided for @helloWordIam.
  ///
  /// In es, this message translates to:
  /// **'¡Hola, Mundo! Yo soy'**
  String get helloWordIam;

  /// No description provided for @freelancer.
  ///
  /// In es, this message translates to:
  /// **'Autónomo  '**
  String get freelancer;

  /// No description provided for @quickLinks.
  ///
  /// In es, this message translates to:
  /// **'Enlaces rápidos'**
  String get quickLinks;

  /// No description provided for @projectsTapToExpand.
  ///
  /// In es, this message translates to:
  /// **'Clic para ver la lista de proyectos'**
  String get projectsTapToExpand;

  /// No description provided for @moreInfo.
  ///
  /// In es, this message translates to:
  /// **'Más información'**
  String get moreInfo;

  /// No description provided for @pageNotFound.
  ///
  /// In es, this message translates to:
  /// **'Página no encontrada'**
  String get pageNotFound;

  /// No description provided for @pageNotFoundHint.
  ///
  /// In es, this message translates to:
  /// **'La ruta que buscas no existe.'**
  String get pageNotFoundHint;

  /// No description provided for @backToHome.
  ///
  /// In es, this message translates to:
  /// **'Volver al inicio'**
  String get backToHome;

  /// No description provided for @portfolio.
  ///
  /// In es, this message translates to:
  /// **'Portafolio'**
  String get portfolio;

  /// No description provided for @languageToggle.
  ///
  /// In es, this message translates to:
  /// **'Idioma'**
  String get languageToggle;

  /// No description provided for @helpdeskManagement.
  ///
  /// In es, this message translates to:
  /// **'- Gestión de helpdesk e incidencias, resolviendo problemas técnicos de manera eficiente.'**
  String get helpdeskManagement;

  /// No description provided for @dataAnalysisAndMaintenance.
  ///
  /// In es, this message translates to:
  /// **'- Análisis de datos y mantenimiento de sitios educativos con Moodle.'**
  String get dataAnalysisAndMaintenance;

  /// No description provided for @processAutomation.
  ///
  /// In es, this message translates to:
  /// **'-Automatización de procesos y mantenimiento preventivo de equipos.'**
  String get processAutomation;

  /// No description provided for @flutterDevelopment.
  ///
  /// In es, this message translates to:
  /// **'- Desarrollo e implementación de software utilizando Flutter.'**
  String get flutterDevelopment;

  /// No description provided for @mobileWebInstructor.
  ///
  /// In es, this message translates to:
  /// **'- Instructor de cursos de aplicaciones móviles y web.'**
  String get mobileWebInstructor;

  /// No description provided for @mobileWebDevelopment.
  ///
  /// In es, this message translates to:
  /// **'- Desarrollo de aplicaciones móviles y web utilizando Flutter.'**
  String get mobileWebDevelopment;

  /// No description provided for @mobileConsulting.
  ///
  /// In es, this message translates to:
  /// **'- Consultoría en el desarrollo de aplicaciones móviles con Flutter.'**
  String get mobileConsulting;

  /// No description provided for @webDevelopment.
  ///
  /// In es, this message translates to:
  /// **'- Desarrollo web con HTML, JavaScript, CSS y Webflow.'**
  String get webDevelopment;

  /// No description provided for @onlineStoreCreation.
  ///
  /// In es, this message translates to:
  /// **'- Creación de tiendas en línea utilizando Odoo, WooCommerce y WordPress.'**
  String get onlineStoreCreation;

  /// No description provided for @mobileWebInstructorRepeat.
  ///
  /// In es, this message translates to:
  /// **'- Instructor de cursos de aplicaciones móviles y web.'**
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
      <String>['es'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'es':
      return AppLocalizationsEs();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
