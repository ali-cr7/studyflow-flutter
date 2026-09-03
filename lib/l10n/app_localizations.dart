import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';

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
    Locale('ar'),
    Locale('en'),
  ];

  /// No description provided for @languageEnglish.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get languageEnglish;

  /// No description provided for @languageArabic.
  ///
  /// In en, this message translates to:
  /// **'العربية'**
  String get languageArabic;

  /// No description provided for @settingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settingsTitle;

  /// No description provided for @profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// No description provided for @name.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get name;

  /// No description provided for @grade.
  ///
  /// In en, this message translates to:
  /// **'Grade'**
  String get grade;

  /// No description provided for @appearance.
  ///
  /// In en, this message translates to:
  /// **'Appearance'**
  String get appearance;

  /// No description provided for @light.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get light;

  /// No description provided for @dark.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get dark;

  /// No description provided for @system.
  ///
  /// In en, this message translates to:
  /// **'System'**
  String get system;

  /// No description provided for @focusSettings.
  ///
  /// In en, this message translates to:
  /// **'Focus settings'**
  String get focusSettings;

  /// No description provided for @notifications.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notifications;

  /// No description provided for @notificationsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Reminders for study blocks'**
  String get notificationsSubtitle;

  /// No description provided for @soundEffects.
  ///
  /// In en, this message translates to:
  /// **'Sound effects'**
  String get soundEffects;

  /// No description provided for @soundEffectsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Session alerts and sound cues'**
  String get soundEffectsSubtitle;

  /// No description provided for @focusSound.
  ///
  /// In en, this message translates to:
  /// **'Focus sound'**
  String get focusSound;

  /// No description provided for @sessionDefaults.
  ///
  /// In en, this message translates to:
  /// **'Session defaults'**
  String get sessionDefaults;

  /// No description provided for @breakDefaults.
  ///
  /// In en, this message translates to:
  /// **'Break defaults'**
  String get breakDefaults;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @about.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get about;

  /// No description provided for @version.
  ///
  /// In en, this message translates to:
  /// **'Version'**
  String get version;

  /// No description provided for @dailyPlan.
  ///
  /// In en, this message translates to:
  /// **'Daily Plan'**
  String get dailyPlan;

  /// No description provided for @subjects.
  ///
  /// In en, this message translates to:
  /// **'Subjects'**
  String get subjects;

  /// No description provided for @statistics.
  ///
  /// In en, this message translates to:
  /// **'Statistics'**
  String get statistics;

  /// No description provided for @history.
  ///
  /// In en, this message translates to:
  /// **'History'**
  String get history;

  /// No description provided for @achievements.
  ///
  /// In en, this message translates to:
  /// **'Achievements'**
  String get achievements;

  /// No description provided for @askTeacher.
  ///
  /// In en, this message translates to:
  /// **'Ask Teacher'**
  String get askTeacher;

  /// No description provided for @noSound.
  ///
  /// In en, this message translates to:
  /// **'No sound'**
  String get noSound;

  /// No description provided for @rain.
  ///
  /// In en, this message translates to:
  /// **'Rain'**
  String get rain;

  /// No description provided for @ocean.
  ///
  /// In en, this message translates to:
  /// **'Ocean'**
  String get ocean;

  /// No description provided for @forest.
  ///
  /// In en, this message translates to:
  /// **'Forest'**
  String get forest;

  /// No description provided for @cafe.
  ///
  /// In en, this message translates to:
  /// **'Cafe'**
  String get cafe;

  /// No description provided for @min.
  ///
  /// In en, this message translates to:
  /// **'min'**
  String get min;

  /// No description provided for @study.
  ///
  /// In en, this message translates to:
  /// **'Study'**
  String get study;

  /// No description provided for @breakTime.
  ///
  /// In en, this message translates to:
  /// **'Break'**
  String get breakTime;

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

  /// No description provided for @resume.
  ///
  /// In en, this message translates to:
  /// **'Resume'**
  String get resume;

  /// No description provided for @stop.
  ///
  /// In en, this message translates to:
  /// **'Stop'**
  String get stop;

  /// No description provided for @reset.
  ///
  /// In en, this message translates to:
  /// **'Reset'**
  String get reset;

  /// No description provided for @addSubject.
  ///
  /// In en, this message translates to:
  /// **'Add Subject'**
  String get addSubject;

  /// No description provided for @subjectName.
  ///
  /// In en, this message translates to:
  /// **'Subject name'**
  String get subjectName;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @edit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get edit;

  /// No description provided for @totalStudyTime.
  ///
  /// In en, this message translates to:
  /// **'Total'**
  String get totalStudyTime;

  /// No description provided for @totalSessions.
  ///
  /// In en, this message translates to:
  /// **'Total sessions'**
  String get totalSessions;

  /// No description provided for @streak.
  ///
  /// In en, this message translates to:
  /// **'Streak'**
  String get streak;

  /// No description provided for @days.
  ///
  /// In en, this message translates to:
  /// **'days'**
  String get days;

  /// No description provided for @hours.
  ///
  /// In en, this message translates to:
  /// **'hours'**
  String get hours;

  /// No description provided for @minutes.
  ///
  /// In en, this message translates to:
  /// **'minutes'**
  String get minutes;

  /// No description provided for @noHistory.
  ///
  /// In en, this message translates to:
  /// **'No history yet'**
  String get noHistory;

  /// No description provided for @noSubjects.
  ///
  /// In en, this message translates to:
  /// **'No subjects yet'**
  String get noSubjects;

  /// No description provided for @addYourFirstSubject.
  ///
  /// In en, this message translates to:
  /// **'Add your first subject to get started'**
  String get addYourFirstSubject;

  /// No description provided for @noAchievements.
  ///
  /// In en, this message translates to:
  /// **'No achievements yet'**
  String get noAchievements;

  /// No description provided for @keepStudying.
  ///
  /// In en, this message translates to:
  /// **'Keep studying to unlock achievements'**
  String get keepStudying;

  /// No description provided for @question.
  ///
  /// In en, this message translates to:
  /// **'Question'**
  String get question;

  /// No description provided for @typeYourQuestion.
  ///
  /// In en, this message translates to:
  /// **'Type your question...'**
  String get typeYourQuestion;

  /// No description provided for @send.
  ///
  /// In en, this message translates to:
  /// **'Send'**
  String get send;

  /// No description provided for @onboardingWelcome.
  ///
  /// In en, this message translates to:
  /// **'Welcome to StudyRise'**
  String get onboardingWelcome;

  /// No description provided for @onboardingDescription.
  ///
  /// In en, this message translates to:
  /// **'Your personal study companion'**
  String get onboardingDescription;

  /// No description provided for @getStarted.
  ///
  /// In en, this message translates to:
  /// **'Get Started'**
  String get getStarted;

  /// No description provided for @records.
  ///
  /// In en, this message translates to:
  /// **'Records'**
  String get records;

  /// No description provided for @drawer.
  ///
  /// In en, this message translates to:
  /// **'Drawer'**
  String get drawer;

  /// No description provided for @studySession.
  ///
  /// In en, this message translates to:
  /// **'Study session'**
  String get studySession;

  /// No description provided for @error.
  ///
  /// In en, this message translates to:
  /// **'Error: {message}'**
  String error(Object message);

  /// No description provided for @breakTimeLabel.
  ///
  /// In en, this message translates to:
  /// **'Break time'**
  String get breakTimeLabel;

  /// No description provided for @paused.
  ///
  /// In en, this message translates to:
  /// **'Paused'**
  String get paused;

  /// No description provided for @focusBlock.
  ///
  /// In en, this message translates to:
  /// **'Focus block'**
  String get focusBlock;

  /// No description provided for @allSet.
  ///
  /// In en, this message translates to:
  /// **'All set'**
  String get allSet;

  /// No description provided for @finish.
  ///
  /// In en, this message translates to:
  /// **'Finish'**
  String get finish;

  /// No description provided for @nextSession.
  ///
  /// In en, this message translates to:
  /// **'Next session'**
  String get nextSession;

  /// No description provided for @backToPlan.
  ///
  /// In en, this message translates to:
  /// **'Back to plan'**
  String get backToPlan;

  /// No description provided for @unmuteSound.
  ///
  /// In en, this message translates to:
  /// **'Unmute sound'**
  String get unmuteSound;

  /// No description provided for @muteSound.
  ///
  /// In en, this message translates to:
  /// **'Mute sound'**
  String get muteSound;

  /// No description provided for @breakEndsSoon.
  ///
  /// In en, this message translates to:
  /// **'Break ends soon'**
  String get breakEndsSoon;

  /// No description provided for @readyWhenYouAre.
  ///
  /// In en, this message translates to:
  /// **'Ready when you are'**
  String get readyWhenYouAre;

  /// No description provided for @completed.
  ///
  /// In en, this message translates to:
  /// **'completed'**
  String get completed;

  /// No description provided for @sessionComplete.
  ///
  /// In en, this message translates to:
  /// **'Session complete'**
  String get sessionComplete;

  /// No description provided for @soundMuted.
  ///
  /// In en, this message translates to:
  /// **'Sound muted'**
  String get soundMuted;

  /// No description provided for @ambientSoundPlaying.
  ///
  /// In en, this message translates to:
  /// **'Ambient sound playing'**
  String get ambientSoundPlaying;

  /// No description provided for @dashboardTitle.
  ///
  /// In en, this message translates to:
  /// **'Dashboard'**
  String get dashboardTitle;

  /// No description provided for @noSubjectsAdded.
  ///
  /// In en, this message translates to:
  /// **'No subjects added yet'**
  String get noSubjectsAdded;

  /// No description provided for @addSubjectHint.
  ///
  /// In en, this message translates to:
  /// **'Tap + to add a subject'**
  String get addSubjectHint;

  /// No description provided for @todayGoal.
  ///
  /// In en, this message translates to:
  /// **'Today\'s goal'**
  String get todayGoal;

  /// No description provided for @goalReached.
  ///
  /// In en, this message translates to:
  /// **'Goal reached!'**
  String get goalReached;

  /// No description provided for @remaining.
  ///
  /// In en, this message translates to:
  /// **'Remaining'**
  String get remaining;

  /// No description provided for @quickActions.
  ///
  /// In en, this message translates to:
  /// **'Quick actions'**
  String get quickActions;

  /// No description provided for @startSession.
  ///
  /// In en, this message translates to:
  /// **'Start session'**
  String get startSession;

  /// No description provided for @viewStatistics.
  ///
  /// In en, this message translates to:
  /// **'View statistics'**
  String get viewStatistics;

  /// No description provided for @viewHistory.
  ///
  /// In en, this message translates to:
  /// **'View history'**
  String get viewHistory;

  /// No description provided for @subjectsPageTitle.
  ///
  /// In en, this message translates to:
  /// **'Subjects'**
  String get subjectsPageTitle;

  /// No description provided for @addNewSubject.
  ///
  /// In en, this message translates to:
  /// **'Add new subject'**
  String get addNewSubject;

  /// No description provided for @enterSubjectName.
  ///
  /// In en, this message translates to:
  /// **'Enter subject name'**
  String get enterSubjectName;

  /// No description provided for @subjectAlreadyExists.
  ///
  /// In en, this message translates to:
  /// **'Subject already exists'**
  String get subjectAlreadyExists;

  /// No description provided for @statisticsPageTitle.
  ///
  /// In en, this message translates to:
  /// **'Statistics'**
  String get statisticsPageTitle;

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

  /// No description provided for @allTime.
  ///
  /// In en, this message translates to:
  /// **'All time'**
  String get allTime;

  /// No description provided for @studyTime.
  ///
  /// In en, this message translates to:
  /// **'Study time'**
  String get studyTime;

  /// No description provided for @sessions.
  ///
  /// In en, this message translates to:
  /// **'Sessions'**
  String get sessions;

  /// No description provided for @averagePerDay.
  ///
  /// In en, this message translates to:
  /// **'Average per day'**
  String get averagePerDay;

  /// No description provided for @bestDay.
  ///
  /// In en, this message translates to:
  /// **'Best day'**
  String get bestDay;

  /// No description provided for @historyPageTitle.
  ///
  /// In en, this message translates to:
  /// **'History'**
  String get historyPageTitle;

  /// No description provided for @noSessions.
  ///
  /// In en, this message translates to:
  /// **'No sessions yet'**
  String get noSessions;

  /// No description provided for @sessionsCount.
  ///
  /// In en, this message translates to:
  /// **'{count} sessions'**
  String sessionsCount(Object count);

  /// No description provided for @achievementsPageTitle.
  ///
  /// In en, this message translates to:
  /// **'Achievements'**
  String get achievementsPageTitle;

  /// No description provided for @locked.
  ///
  /// In en, this message translates to:
  /// **'Locked'**
  String get locked;

  /// No description provided for @unlocked.
  ///
  /// In en, this message translates to:
  /// **'Unlocked'**
  String get unlocked;

  /// No description provided for @activationTitle.
  ///
  /// In en, this message translates to:
  /// **'Activation'**
  String get activationTitle;

  /// No description provided for @enterCode.
  ///
  /// In en, this message translates to:
  /// **'Enter activation code'**
  String get enterCode;

  /// No description provided for @activate.
  ///
  /// In en, this message translates to:
  /// **'Activate'**
  String get activate;

  /// No description provided for @invalidCode.
  ///
  /// In en, this message translates to:
  /// **'Invalid code'**
  String get invalidCode;

  /// No description provided for @activationSuccess.
  ///
  /// In en, this message translates to:
  /// **'Activation successful!'**
  String get activationSuccess;

  /// No description provided for @askTeacherTitle.
  ///
  /// In en, this message translates to:
  /// **'Ask Teacher'**
  String get askTeacherTitle;

  /// No description provided for @typeQuestion.
  ///
  /// In en, this message translates to:
  /// **'Type your question'**
  String get typeQuestion;

  /// No description provided for @noAnswerYet.
  ///
  /// In en, this message translates to:
  /// **'No answer yet'**
  String get noAnswerYet;

  /// No description provided for @onboardingTitle.
  ///
  /// In en, this message translates to:
  /// **'Welcome'**
  String get onboardingTitle;

  /// No description provided for @onboardingSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Your study journey starts here'**
  String get onboardingSubtitle;

  /// No description provided for @next.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get next;

  /// No description provided for @skip.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get skip;

  /// No description provided for @done.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get done;

  /// No description provided for @backupTitle.
  ///
  /// In en, this message translates to:
  /// **'Backup'**
  String get backupTitle;

  /// No description provided for @createBackup.
  ///
  /// In en, this message translates to:
  /// **'Create backup'**
  String get createBackup;

  /// No description provided for @restoreBackup.
  ///
  /// In en, this message translates to:
  /// **'Restore backup'**
  String get restoreBackup;

  /// No description provided for @backupCreated.
  ///
  /// In en, this message translates to:
  /// **'Backup created successfully'**
  String get backupCreated;

  /// No description provided for @backupRestored.
  ///
  /// In en, this message translates to:
  /// **'Backup restored successfully'**
  String get backupRestored;

  /// No description provided for @aboutTitle.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get aboutTitle;

  /// No description provided for @aboutDescription.
  ///
  /// In en, this message translates to:
  /// **'A study planner app designed for students'**
  String get aboutDescription;

  /// No description provided for @versionLabel.
  ///
  /// In en, this message translates to:
  /// **'Version {version}'**
  String versionLabel(Object version);

  /// No description provided for @errorOccurred.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong.'**
  String get errorOccurred;

  /// No description provided for @noProfileFound.
  ///
  /// In en, this message translates to:
  /// **'No profile found.'**
  String get noProfileFound;

  /// No description provided for @appName.
  ///
  /// In en, this message translates to:
  /// **'Study Planner'**
  String get appName;

  /// No description provided for @appTagline.
  ///
  /// In en, this message translates to:
  /// **'Study smarter. Stay consistent.'**
  String get appTagline;

  /// No description provided for @recordsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Your best study achievements'**
  String get recordsSubtitle;

  /// No description provided for @historySubtitle.
  ///
  /// In en, this message translates to:
  /// **'Review your study sessions'**
  String get historySubtitle;

  /// No description provided for @askTeacherSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Need help? Contact your teacher'**
  String get askTeacherSubtitle;

  /// No description provided for @aboutSubtitle.
  ///
  /// In en, this message translates to:
  /// **'About Study Planner'**
  String get aboutSubtitle;

  /// No description provided for @aboutLongDescription.
  ///
  /// In en, this message translates to:
  /// **'A simple study companion designed to help students organize their time, stay consistent, and achieve their goals.'**
  String get aboutLongDescription;

  /// No description provided for @createdBy.
  ///
  /// In en, this message translates to:
  /// **'Created by Ali Al Ali'**
  String get createdBy;

  /// No description provided for @developerRole.
  ///
  /// In en, this message translates to:
  /// **'Software Engineer • Flutter Developer'**
  String get developerRole;

  /// No description provided for @connectWithMe.
  ///
  /// In en, this message translates to:
  /// **'Connect with me'**
  String get connectWithMe;

  /// No description provided for @close.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get close;

  /// No description provided for @versionWithNumber.
  ///
  /// In en, this message translates to:
  /// **'Version {version}'**
  String versionWithNumber(Object version);

  /// No description provided for @onboardingAppName.
  ///
  /// In en, this message translates to:
  /// **'StudyFlow'**
  String get onboardingAppName;

  /// No description provided for @onboardingTagline.
  ///
  /// In en, this message translates to:
  /// **'Plan smarter. Study consistently. Achieve more.'**
  String get onboardingTagline;

  /// No description provided for @onboardingWelcomeMessage.
  ///
  /// In en, this message translates to:
  /// **'Welcome to StudyFlow — your personal study coach for staying on track. We\'ll ask a few questions to tailor your experience.'**
  String get onboardingWelcomeMessage;

  /// No description provided for @onboardingGetStartedMessage.
  ///
  /// In en, this message translates to:
  /// **'Get started and build a study plan that fits your day.'**
  String get onboardingGetStartedMessage;

  /// No description provided for @askTheTeacher.
  ///
  /// In en, this message translates to:
  /// **'Ask the Teacher'**
  String get askTheTeacher;

  /// No description provided for @whatsAppOpened.
  ///
  /// In en, this message translates to:
  /// **'WhatsApp opened successfully.'**
  String get whatsAppOpened;

  /// No description provided for @needHelp.
  ///
  /// In en, this message translates to:
  /// **'Need help?'**
  String get needHelp;

  /// No description provided for @askTeacherHeaderSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Ask your teacher about anything you are struggling with.'**
  String get askTeacherHeaderSubtitle;

  /// No description provided for @student.
  ///
  /// In en, this message translates to:
  /// **'Student'**
  String get student;

  /// No description provided for @subject.
  ///
  /// In en, this message translates to:
  /// **'Subject'**
  String get subject;

  /// No description provided for @selectSubject.
  ///
  /// In en, this message translates to:
  /// **'Select a subject'**
  String get selectSubject;

  /// No description provided for @yourQuestion.
  ///
  /// In en, this message translates to:
  /// **'Your question'**
  String get yourQuestion;

  /// No description provided for @describeStruggle.
  ///
  /// In en, this message translates to:
  /// **'Describe what you are struggling with...'**
  String get describeStruggle;

  /// No description provided for @messageSentViaWhatsApp.
  ///
  /// In en, this message translates to:
  /// **'Your message will be sent through WhatsApp.'**
  String get messageSentViaWhatsApp;

  /// No description provided for @openingWhatsApp.
  ///
  /// In en, this message translates to:
  /// **'Opening WhatsApp...'**
  String get openingWhatsApp;

  /// No description provided for @sendViaWhatsApp.
  ///
  /// In en, this message translates to:
  /// **'Send via WhatsApp'**
  String get sendViaWhatsApp;

  /// No description provided for @dailyPlanTitle.
  ///
  /// In en, this message translates to:
  /// **'Daily plan'**
  String get dailyPlanTitle;

  /// No description provided for @todaysSchedule.
  ///
  /// In en, this message translates to:
  /// **'Today\'s schedule'**
  String get todaysSchedule;

  /// No description provided for @loadingYourPlan.
  ///
  /// In en, this message translates to:
  /// **'Loading your plan...'**
  String get loadingYourPlan;

  /// No description provided for @deleteSubjectConfirm.
  ///
  /// In en, this message translates to:
  /// **'Delete subject?'**
  String get deleteSubjectConfirm;

  /// No description provided for @removeSubjectConfirm.
  ///
  /// In en, this message translates to:
  /// **'Remove {name} from your subject list?'**
  String removeSubjectConfirm(Object name);

  /// No description provided for @yourSubjects.
  ///
  /// In en, this message translates to:
  /// **'Your subjects'**
  String get yourSubjects;

  /// No description provided for @unableToLoadStatistics.
  ///
  /// In en, this message translates to:
  /// **'Unable to load statistics'**
  String get unableToLoadStatistics;

  /// No description provided for @statisticsLoadError.
  ///
  /// In en, this message translates to:
  /// **'Your study data could not be loaded right now.'**
  String get statisticsLoadError;

  /// No description provided for @startFirstStreak.
  ///
  /// In en, this message translates to:
  /// **'Start your first study streak'**
  String get startFirstStreak;

  /// No description provided for @completeSessionToUnlock.
  ///
  /// In en, this message translates to:
  /// **'Complete a study session to unlock your progress dashboard.'**
  String get completeSessionToUnlock;

  /// No description provided for @yourProgress.
  ///
  /// In en, this message translates to:
  /// **'Your Progress'**
  String get yourProgress;

  /// No description provided for @sessionsCompleted.
  ///
  /// In en, this message translates to:
  /// **'{count} sessions completed'**
  String sessionsCompleted(Object count);

  /// No description provided for @studyTimeMetric.
  ///
  /// In en, this message translates to:
  /// **'Study Time'**
  String get studyTimeMetric;

  /// No description provided for @completedSessionsMetric.
  ///
  /// In en, this message translates to:
  /// **'{count} completed sessions'**
  String completedSessionsMetric(Object count);

  /// No description provided for @sessionsMetric.
  ///
  /// In en, this message translates to:
  /// **'Sessions'**
  String get sessionsMetric;

  /// No description provided for @planCompletion.
  ///
  /// In en, this message translates to:
  /// **'Plan Completion'**
  String get planCompletion;

  /// No description provided for @plannedVsCompleted.
  ///
  /// In en, this message translates to:
  /// **'{completed} of {planned}'**
  String plannedVsCompleted(Object completed, Object planned);

  /// No description provided for @currentStreak.
  ///
  /// In en, this message translates to:
  /// **'Current Streak'**
  String get currentStreak;

  /// No description provided for @activeStreak.
  ///
  /// In en, this message translates to:
  /// **'active streak'**
  String get activeStreak;

  /// No description provided for @studyActivity.
  ///
  /// In en, this message translates to:
  /// **'Study Activity'**
  String get studyActivity;

  /// No description provided for @studyBySubject.
  ///
  /// In en, this message translates to:
  /// **'Study by Subject'**
  String get studyBySubject;

  /// No description provided for @plannedVsCompletedHeader.
  ///
  /// In en, this message translates to:
  /// **'Planned vs Completed'**
  String get plannedVsCompletedHeader;

  /// No description provided for @consistency.
  ///
  /// In en, this message translates to:
  /// **'Consistency'**
  String get consistency;

  /// No description provided for @insights.
  ///
  /// In en, this message translates to:
  /// **'Insights'**
  String get insights;

  /// No description provided for @bestRecords.
  ///
  /// In en, this message translates to:
  /// **'Best Records'**
  String get bestRecords;

  /// No description provided for @recentAchievements.
  ///
  /// In en, this message translates to:
  /// **'Recent Achievements'**
  String get recentAchievements;

  /// No description provided for @studyDays.
  ///
  /// In en, this message translates to:
  /// **'Study days'**
  String get studyDays;

  /// No description provided for @activeDays.
  ///
  /// In en, this message translates to:
  /// **'Active days'**
  String get activeDays;

  /// No description provided for @noStudyHistory.
  ///
  /// In en, this message translates to:
  /// **'No study history'**
  String get noStudyHistory;

  /// No description provided for @noStudyHistoryMessage.
  ///
  /// In en, this message translates to:
  /// **'You have no completed study sessions for this month yet.'**
  String get noStudyHistoryMessage;

  /// No description provided for @yourAchievements.
  ///
  /// In en, this message translates to:
  /// **'Your achievements'**
  String get yourAchievements;

  /// No description provided for @achievementsUnlocked.
  ///
  /// In en, this message translates to:
  /// **'{unlockedCount} of {totalCount} unlocked'**
  String achievementsUnlocked(Object totalCount, Object unlockedCount);

  /// No description provided for @keepStudyingToUnlockMore.
  ///
  /// In en, this message translates to:
  /// **'Keep studying to unlock more!'**
  String get keepStudyingToUnlockMore;

  /// No description provided for @goodMorning.
  ///
  /// In en, this message translates to:
  /// **'Good morning, {name}'**
  String goodMorning(Object name);

  /// No description provided for @goodAfternoon.
  ///
  /// In en, this message translates to:
  /// **'Good afternoon, {name}'**
  String goodAfternoon(Object name);

  /// No description provided for @goodEvening.
  ///
  /// In en, this message translates to:
  /// **'Good evening, {name}'**
  String goodEvening(Object name);

  /// No description provided for @readyToReachGoals.
  ///
  /// In en, this message translates to:
  /// **'Ready to reach your study goals today?'**
  String get readyToReachGoals;

  /// No description provided for @studyPlanSummary.
  ///
  /// In en, this message translates to:
  /// **'Study plan summary'**
  String get studyPlanSummary;

  /// No description provided for @dailyGoal.
  ///
  /// In en, this message translates to:
  /// **'Daily goal'**
  String get dailyGoal;

  /// No description provided for @sessionLength.
  ///
  /// In en, this message translates to:
  /// **'Session length'**
  String get sessionLength;

  /// No description provided for @breakDuration.
  ///
  /// In en, this message translates to:
  /// **'Break duration'**
  String get breakDuration;

  /// No description provided for @todaysFocus.
  ///
  /// In en, this message translates to:
  /// **'Today\'s focus'**
  String get todaysFocus;

  /// No description provided for @focusForMinutes.
  ///
  /// In en, this message translates to:
  /// **'Focus for {breakMinutes} minutes, then take {studyMinutes} minutes to recharge.'**
  String focusForMinutes(Object breakMinutes, Object studyMinutes);

  /// No description provided for @subjectDistributionTitle.
  ///
  /// In en, this message translates to:
  /// **'Subject Distribution'**
  String get subjectDistributionTitle;

  /// No description provided for @subjectDistributionEmpty.
  ///
  /// In en, this message translates to:
  /// **'No subject data for this period'**
  String get subjectDistributionEmpty;

  /// No description provided for @otherSubjects.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get otherSubjects;

  /// No description provided for @streakDays.
  ///
  /// In en, this message translates to:
  /// **'{count}-day streak'**
  String streakDays(Object count);

  /// No description provided for @noRecordsYet.
  ///
  /// In en, this message translates to:
  /// **'No records yet'**
  String get noRecordsYet;

  /// No description provided for @keepStudyingForRecords.
  ///
  /// In en, this message translates to:
  /// **'Keep studying to unlock your best streaks and milestones.'**
  String get keepStudyingForRecords;

  /// No description provided for @average.
  ///
  /// In en, this message translates to:
  /// **'Average {duration}'**
  String average(Object duration);

  /// No description provided for @goal.
  ///
  /// In en, this message translates to:
  /// **'Goal {duration}'**
  String goal(Object duration);

  /// No description provided for @goalLabel.
  ///
  /// In en, this message translates to:
  /// **'Goal'**
  String get goalLabel;

  /// No description provided for @noSubjectDataYet.
  ///
  /// In en, this message translates to:
  /// **'No subject data yet'**
  String get noSubjectDataYet;

  /// No description provided for @completeSessionsForBreakdown.
  ///
  /// In en, this message translates to:
  /// **'Complete sessions to see your breakdown by subject.'**
  String get completeSessionsForBreakdown;

  /// No description provided for @percent.
  ///
  /// In en, this message translates to:
  /// **'{value}%'**
  String percent(Object value);

  /// No description provided for @activeDaysCount.
  ///
  /// In en, this message translates to:
  /// **'{count} active days'**
  String activeDaysCount(Object count);

  /// No description provided for @longestStreak.
  ///
  /// In en, this message translates to:
  /// **'Longest streak {count}'**
  String longestStreak(Object count);

  /// No description provided for @periodToday.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get periodToday;

  /// No description provided for @periodWeek.
  ///
  /// In en, this message translates to:
  /// **'Week'**
  String get periodWeek;

  /// No description provided for @periodMonth.
  ///
  /// In en, this message translates to:
  /// **'Month'**
  String get periodMonth;

  /// No description provided for @periodYear.
  ///
  /// In en, this message translates to:
  /// **'Year'**
  String get periodYear;

  /// No description provided for @periodAllTime.
  ///
  /// In en, this message translates to:
  /// **'All Time'**
  String get periodAllTime;

  /// No description provided for @noInsightsYet.
  ///
  /// In en, this message translates to:
  /// **'No insights yet'**
  String get noInsightsYet;

  /// No description provided for @buildConsistentRhythm.
  ///
  /// In en, this message translates to:
  /// **'Build a consistent study rhythm to unlock personalized insights.'**
  String get buildConsistentRhythm;

  /// No description provided for @noAchievementsYetStats.
  ///
  /// In en, this message translates to:
  /// **'No achievements yet'**
  String get noAchievementsYetStats;

  /// No description provided for @completeSessionsForAchievements.
  ///
  /// In en, this message translates to:
  /// **'Complete study sessions and reach your goals to unlock milestones.'**
  String get completeSessionsForAchievements;

  /// No description provided for @couldNotLoadStatistics.
  ///
  /// In en, this message translates to:
  /// **'Could not load your statistics.'**
  String get couldNotLoadStatistics;

  /// No description provided for @completedFormat.
  ///
  /// In en, this message translates to:
  /// **'{duration} completed'**
  String completedFormat(Object duration);

  /// No description provided for @plannedFormat.
  ///
  /// In en, this message translates to:
  /// **'Planned {duration}'**
  String plannedFormat(Object duration);

  /// No description provided for @completedLabel.
  ///
  /// In en, this message translates to:
  /// **'Completed {duration}'**
  String completedLabel(Object duration);

  /// No description provided for @mostStudiedSubject.
  ///
  /// In en, this message translates to:
  /// **'{subject} is your most studied subject {period}.'**
  String mostStudiedSubject(Object period, Object subject);

  /// No description provided for @planCompletionInsight.
  ///
  /// In en, this message translates to:
  /// **'You completed {percent}% of your planned study time.'**
  String planCompletionInsight(Object percent);

  /// No description provided for @currentStreakInsight.
  ///
  /// In en, this message translates to:
  /// **'Your current streak is {count} days.'**
  String currentStreakInsight(Object count);

  /// No description provided for @longestStreakInsight.
  ///
  /// In en, this message translates to:
  /// **'Your longest streak is {count} days.'**
  String longestStreakInsight(Object count);

  /// No description provided for @periodLabelToday.
  ///
  /// In en, this message translates to:
  /// **'today'**
  String get periodLabelToday;

  /// No description provided for @periodLabelWeek.
  ///
  /// In en, this message translates to:
  /// **'this week'**
  String get periodLabelWeek;

  /// No description provided for @periodLabelMonth.
  ///
  /// In en, this message translates to:
  /// **'this month'**
  String get periodLabelMonth;

  /// No description provided for @periodLabelYear.
  ///
  /// In en, this message translates to:
  /// **'this year'**
  String get periodLabelYear;

  /// No description provided for @periodLabelAllTime.
  ///
  /// In en, this message translates to:
  /// **'overall'**
  String get periodLabelAllTime;

  /// No description provided for @longestStreakRecord.
  ///
  /// In en, this message translates to:
  /// **'Longest streak'**
  String get longestStreakRecord;

  /// No description provided for @mostProductiveDay.
  ///
  /// In en, this message translates to:
  /// **'Most productive day'**
  String get mostProductiveDay;

  /// No description provided for @mostStudiedSubjectRecord.
  ///
  /// In en, this message translates to:
  /// **'Most studied subject'**
  String get mostStudiedSubjectRecord;

  /// No description provided for @longestSession.
  ///
  /// In en, this message translates to:
  /// **'Longest session'**
  String get longestSession;

  /// No description provided for @noStudySessionsRecorded.
  ///
  /// In en, this message translates to:
  /// **'No study sessions recorded yet for this period.'**
  String get noStudySessionsRecorded;

  /// No description provided for @na.
  ///
  /// In en, this message translates to:
  /// **'N/A'**
  String get na;
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
      <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
