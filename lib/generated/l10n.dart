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

  /// `English`
  String get language {
    return Intl.message(
      'English',
      name: 'language',
      desc: 'current language',
      args: [],
    );
  }

  /// `lists`
  String get lists {
    return Intl.message(
      'lists',
      name: 'lists',
      desc: 'lists title',
      args: [],
    );
  }

  /// `Lists`
  String get chooseLists {
    return Intl.message(
      'Lists',
      name: 'chooseLists',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get settings {
    return Intl.message(
      'Settings',
      name: 'settings',
      desc: 'settings title',
      args: [],
    );
  }

  /// `About us`
  String get aboutUs {
    return Intl.message(
      'About us',
      name: 'aboutUs',
      desc: 'about us',
      args: [],
    );
  }

  /// `Language`
  String get languageTitle {
    return Intl.message(
      'Language',
      name: 'languageTitle',
      desc: 'language title',
      args: [],
    );
  }

  /// `Report a problem`
  String get reportProblem {
    return Intl.message(
      'Report a problem',
      name: 'reportProblem',
      desc: 'Report a problem',
      args: [],
    );
  }

  /// `Terms of Using`
  String get termsOfUsing {
    return Intl.message(
      'Terms of Using',
      name: 'termsOfUsing',
      desc: 'Terms of Using',
      args: [],
    );
  }

  /// `Privacy Policy`
  String get privacyPolicy {
    return Intl.message(
      'Privacy Policy',
      name: 'privacyPolicy',
      desc: 'privacy policy',
      args: [],
    );
  }

  /// `Get Premium`
  String get getPremium {
    return Intl.message(
      'Get Premium',
      name: 'getPremium',
      desc: 'premium offer',
      args: [],
    );
  }

  /// `per month`
  String get perMonth {
    return Intl.message(
      'per month',
      name: 'perMonth',
      desc: 'per month',
      args: [],
    );
  }

  /// `per year`
  String get perYear {
    return Intl.message(
      'per year',
      name: 'perYear',
      desc: 'per month',
      args: [],
    );
  }

  /// `Delete`
  String get delete {
    return Intl.message(
      'Delete',
      name: 'delete',
      desc: 'delete button',
      args: [],
    );
  }

  /// `Rename`
  String get rename {
    return Intl.message(
      'Rename',
      name: 'rename',
      desc: 'rename button',
      args: [],
    );
  }

  /// `Thumbnail`
  String get thumbnail {
    return Intl.message(
      'Thumbnail',
      name: 'thumbnail',
      desc: 'thumbnail button',
      args: [],
    );
  }

  /// `Reminder`
  String get reminder {
    return Intl.message(
      'Reminder',
      name: 'reminder',
      desc: 'Reminder',
      args: [],
    );
  }

  /// `The active reminder will be displayed below the task as a black item`
  String get activeReminder {
    return Intl.message(
      'The active reminder will be displayed below the task as a black item',
      name: 'activeReminder',
      desc: 'active reminder info',
      args: [],
    );
  }

  /// `save reminder`
  String get saveReminder {
    return Intl.message(
      'save reminder',
      name: 'saveReminder',
      desc: 'save reminder button',
      args: [],
    );
  }

  /// `Color`
  String get color {
    return Intl.message(
      'Color',
      name: 'color',
      desc: 'color',
      args: [],
    );
  }

  /// `add`
  String get add {
    return Intl.message(
      'add',
      name: 'add',
      desc: 'add button',
      args: [],
    );
  }

  /// `move`
  String get move {
    return Intl.message(
      'move',
      name: 'move',
      desc: 'move button',
      args: [],
    );
  }

  /// `add new list`
  String get addNewList {
    return Intl.message(
      'add new list',
      name: 'addNewList',
      desc: 'add new list button',
      args: [],
    );
  }

  /// `create new list`
  String get createNewList {
    return Intl.message(
      'create new list',
      name: 'createNewList',
      desc: 'create new list button',
      args: [],
    );
  }

  /// ` new list`
  String get newList {
    return Intl.message(
      ' new list',
      name: 'newList',
      desc: 'new list',
      args: [],
    );
  }

  /// `create`
  String get create {
    return Intl.message(
      'create',
      name: 'create',
      desc: 'create button',
      args: [],
    );
  }

  /// ` Type new task...`
  String get hintText {
    return Intl.message(
      ' Type new task...',
      name: 'hintText',
      desc: 'hint text  Type new task...',
      args: [],
    );
  }

  /// `Undo`
  String get undo {
    return Intl.message(
      'Undo',
      name: 'undo',
      desc: 'undo button',
      args: [],
    );
  }

  /// `The task will be deleted in {seconds}`
  String deletingTask(int seconds) {
    return Intl.message(
      'The task will be deleted in $seconds',
      name: 'deletingTask',
      desc: 'Delete task in some seconds',
      args: [seconds],
    );
  }

  /// `This is Recurring Payment`
  String get recurringPayment {
    return Intl.message(
      'This is Recurring Payment',
      name: 'recurringPayment',
      desc: 'This is Recurring Payment',
      args: [],
    );
  }

  /// `Go Premium`
  String get goPremium {
    return Intl.message(
      'Go Premium',
      name: 'goPremium',
      desc: 'Go Premium',
      args: [],
    );
  }

  /// `By subscribing you accept our`
  String get bySubscribing {
    return Intl.message(
      'By subscribing you accept our',
      name: 'bySubscribing',
      desc: 'By subscribing you accept our',
      args: [],
    );
  }

  /// `Terms`
  String get terms {
    return Intl.message(
      'Terms',
      name: 'terms',
      desc: 'Terms',
      args: [],
    );
  }

  /// `\nPrivacy policy`
  String get privacyPolicyPremium {
    return Intl.message(
      '\nPrivacy policy',
      name: 'privacyPolicyPremium',
      desc: 'Privacy policy',
      args: [],
    );
  }

  /// ` and `
  String get and {
    return Intl.message(
      ' and ',
      name: 'and',
      desc: 'and',
      args: [],
    );
  }

  /// `Unlimited tasks`
  String get premTasks {
    return Intl.message(
      'Unlimited tasks',
      name: 'premTasks',
      desc: 'Unlimited tasks',
      args: [],
    );
  }

  /// `New colors and full quotes`
  String get premColorsQuotes {
    return Intl.message(
      'New colors and full quotes',
      name: 'premColorsQuotes',
      desc: 'New colors and full quotes',
      args: [],
    );
  }

  /// `Different lists and customization`
  String get premLists {
    return Intl.message(
      'Different lists and customization',
      name: 'premLists',
      desc: 'Different lists and customization',
      args: [],
    );
  }

  /// `New features in future`
  String get premFuture {
    return Intl.message(
      'New features in future',
      name: 'premFuture',
      desc: 'New features in future',
      args: [],
    );
  }

  /// `All features without limits`
  String get allFeatures {
    return Intl.message(
      'All features without limits',
      name: 'allFeatures',
      desc: 'All features',
      args: [],
    );
  }

  /// ` Type the task...`
  String get hintTaskText {
    return Intl.message(
      ' Type the task...',
      name: 'hintTaskText',
      desc: 'hint text Type the task...',
      args: [],
    );
  }

  /// `Let's do something`
  String get letsDoSmth {
    return Intl.message(
      'Let\'s do something',
      name: 'letsDoSmth',
      desc: 'initial text',
      args: [],
    );
  }

  /// `Wrong reminder time`
  String get wrongReminder {
    return Intl.message(
      'Wrong reminder time',
      name: 'wrongReminder',
      desc: 'wrong reminder message',
      args: [],
    );
  }

  /// `The reminder will be deleted in {seconds}`
  String deletingReminder(int seconds) {
    return Intl.message(
      'The reminder will be deleted in $seconds',
      name: 'deletingReminder',
      desc: 'Delete task in some seconds',
      args: [seconds],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message(
      'Cancel',
      name: 'cancel',
      desc: 'cancel button',
      args: [],
    );
  }

  /// `No internet connection`
  String get error {
    return Intl.message(
      'No internet connection',
      name: 'error',
      desc: 'No internet connection',
      args: [],
    );
  }

  /// `Update thumbnail?`
  String get updateThumbnail {
    return Intl.message(
      'Update thumbnail?',
      name: 'updateThumbnail',
      desc: 'update thumbnail',
      args: [],
    );
  }

  /// `Delete thumbnail`
  String get deleteThumbnail {
    return Intl.message(
      'Delete thumbnail',
      name: 'deleteThumbnail',
      desc: 'Delete thumbnail button',
      args: [],
    );
  }

  /// `Choose photo`
  String get choosePhoto {
    return Intl.message(
      'Choose photo',
      name: 'choosePhoto',
      desc: 'Delete thumbnail button',
      args: [],
    );
  }

  /// `Ok`
  String get okButton {
    return Intl.message(
      'Ok',
      name: 'okButton',
      desc: 'Ok button',
      args: [],
    );
  }

  /// `https://timodo.app`
  String get linkAboutUs {
    return Intl.message(
      'https://timodo.app',
      name: 'linkAboutUs',
      desc: 'link about us settings',
      args: [],
    );
  }

  /// `https://timodo.app/terms-eng`
  String get linkTermsOfUsing {
    return Intl.message(
      'https://timodo.app/terms-eng',
      name: 'linkTermsOfUsing',
      desc: 'link about us settings',
      args: [],
    );
  }

  /// `https://timodo.app/policy-eng`
  String get linkPrivacyPolicy {
    return Intl.message(
      'https://timodo.app/policy-eng',
      name: 'linkPrivacyPolicy',
      desc: 'link about us settings',
      args: [],
    );
  }

  /// `Save`
  String get save {
    return Intl.message(
      'Save',
      name: 'save',
      desc: 'Save button',
      args: [],
    );
  }

  /// `back`
  String get back {
    return Intl.message(
      'back',
      name: 'back',
      desc: 'Back button',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'de'),
      Locale.fromSubtags(languageCode: 'es'),
      Locale.fromSubtags(languageCode: 'it'),
      Locale.fromSubtags(languageCode: 'ru'),
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
