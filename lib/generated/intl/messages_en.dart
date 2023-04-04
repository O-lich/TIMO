// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  static String m0(seconds) => "The reminder will be deleted in ${seconds}";

  static String m1(seconds) => "The task will be deleted in ${seconds}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "aboutUs": MessageLookupByLibrary.simpleMessage("About us"),
        "activeReminder": MessageLookupByLibrary.simpleMessage(
            "The active reminder will be displayed below the task as a black item"),
        "add": MessageLookupByLibrary.simpleMessage("add"),
        "addNewList": MessageLookupByLibrary.simpleMessage("add new list"),
        "allFeatures":
            MessageLookupByLibrary.simpleMessage("All features without limits"),
        "and": MessageLookupByLibrary.simpleMessage(" and "),
        "bySubscribing": MessageLookupByLibrary.simpleMessage(
            "By subscribing you accept our"),
        "cancel": MessageLookupByLibrary.simpleMessage("Cancel"),
        "chooseLists": MessageLookupByLibrary.simpleMessage("Lists"),
        "color": MessageLookupByLibrary.simpleMessage("Color"),
        "create": MessageLookupByLibrary.simpleMessage("create"),
        "createNewList":
            MessageLookupByLibrary.simpleMessage("create new list"),
        "delete": MessageLookupByLibrary.simpleMessage("Delete"),
        "deletingReminder": m0,
        "deletingTask": m1,
        "error": MessageLookupByLibrary.simpleMessage("No internet connection"),
        "getPremium": MessageLookupByLibrary.simpleMessage("Get Premium"),
        "goPremium": MessageLookupByLibrary.simpleMessage("Go Premium"),
        "hintTaskText":
            MessageLookupByLibrary.simpleMessage(" Type the task..."),
        "hintText": MessageLookupByLibrary.simpleMessage(" Type new task..."),
        "language": MessageLookupByLibrary.simpleMessage("English"),
        "languageTitle": MessageLookupByLibrary.simpleMessage("Language"),
        "letsDoSmth":
            MessageLookupByLibrary.simpleMessage("Let\'s do something"),
        "lists": MessageLookupByLibrary.simpleMessage("lists"),
        "move": MessageLookupByLibrary.simpleMessage("move"),
        "newList": MessageLookupByLibrary.simpleMessage(" new list"),
        "perMonth": MessageLookupByLibrary.simpleMessage("per month"),
        "perYear": MessageLookupByLibrary.simpleMessage("per year"),
        "premColorsQuotes":
            MessageLookupByLibrary.simpleMessage("New colors and full quotes"),
        "premFuture":
            MessageLookupByLibrary.simpleMessage("New features in future"),
        "premLists": MessageLookupByLibrary.simpleMessage(
            "Different lists and customization"),
        "premTasks": MessageLookupByLibrary.simpleMessage("Unlimited tasks"),
        "privacyPolicy": MessageLookupByLibrary.simpleMessage("Privacy Policy"),
        "privacyPolicyPremium":
            MessageLookupByLibrary.simpleMessage("\nPrivacy policy"),
        "recurringPayment":
            MessageLookupByLibrary.simpleMessage("This is Recurring Payment"),
        "reminder": MessageLookupByLibrary.simpleMessage("Reminder"),
        "rename": MessageLookupByLibrary.simpleMessage("Rename"),
        "reportProblem":
            MessageLookupByLibrary.simpleMessage("Report a problem"),
        "saveReminder": MessageLookupByLibrary.simpleMessage("save reminder"),
        "settings": MessageLookupByLibrary.simpleMessage("Settings"),
        "terms": MessageLookupByLibrary.simpleMessage("Terms"),
        "termsOfUsing": MessageLookupByLibrary.simpleMessage("Terms of Using"),
        "thumbnail": MessageLookupByLibrary.simpleMessage("Thumbnail"),
        "undo": MessageLookupByLibrary.simpleMessage("Undo"),
        "wrongReminder":
            MessageLookupByLibrary.simpleMessage("Wrong reminder time")
      };
}
