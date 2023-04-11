// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a de locale. All the
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
  String get localeName => 'de';

  static String m0(seconds) =>
      "Die Erinnerungszeit wird in ${seconds} gelöscht";

  static String m1(seconds) => "Die Aufgabe wird in ${seconds} gelöscht";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "aboutUs": MessageLookupByLibrary.simpleMessage("Über uns"),
        "activeReminder": MessageLookupByLibrary.simpleMessage(
            "Die aktive Erinnerung wird unterhalb der Aufgabe als schwarzes Element angezeigt"),
        "add": MessageLookupByLibrary.simpleMessage("hinzufügen"),
        "addNewList":
            MessageLookupByLibrary.simpleMessage("neue Liste hinzufügen"),
        "allFeatures": MessageLookupByLibrary.simpleMessage(
            "Alle Funktionen\nohne Einschränkungen"),
        "and": MessageLookupByLibrary.simpleMessage(" und "),
        "bySubscribing": MessageLookupByLibrary.simpleMessage(
            "Indem Sie sich anmelden, akzeptieren Sie unsere"),
        "cancel": MessageLookupByLibrary.simpleMessage("Kündigen"),
        "chooseLists": MessageLookupByLibrary.simpleMessage("Listen"),
        "choosePhoto": MessageLookupByLibrary.simpleMessage("Bild auswählen"),
        "color": MessageLookupByLibrary.simpleMessage("Farbe"),
        "create": MessageLookupByLibrary.simpleMessage("erstellen"),
        "createNewList":
            MessageLookupByLibrary.simpleMessage("neue Liste erstellen"),
        "delete": MessageLookupByLibrary.simpleMessage("Löschen"),
        "deleteThumbnail":
            MessageLookupByLibrary.simpleMessage("Vorschaubild löschen"),
        "deletingReminder": m0,
        "deletingTask": m1,
        "error":
            MessageLookupByLibrary.simpleMessage("Keine Internetverbindung"),
        "getPremium": MessageLookupByLibrary.simpleMessage("Hol dir Premium"),
        "goPremium": MessageLookupByLibrary.simpleMessage("Werde Premium"),
        "hintTaskText": MessageLookupByLibrary.simpleMessage(
            " Geben Sie die Aufgabe ein..."),
        "hintText": MessageLookupByLibrary.simpleMessage(
            " Geben Sie neue Aufgabe ein..."),
        "language": MessageLookupByLibrary.simpleMessage("Deutsch"),
        "languageTitle": MessageLookupByLibrary.simpleMessage("Sprache"),
        "letsDoSmth":
            MessageLookupByLibrary.simpleMessage("Erstellen wir eine Aufgabe"),
        "linkAboutUs":
            MessageLookupByLibrary.simpleMessage("https://timodo.app"),
        "linkPrivacyPolicy": MessageLookupByLibrary.simpleMessage(
            "https://timodo.app/policy-de"),
        "linkTermsOfUsing":
            MessageLookupByLibrary.simpleMessage("https://timodo.app/terms-de"),
        "lists": MessageLookupByLibrary.simpleMessage("listen"),
        "move": MessageLookupByLibrary.simpleMessage("Umzug"),
        "newList": MessageLookupByLibrary.simpleMessage(" neue Liste"),
        "okButton": MessageLookupByLibrary.simpleMessage("Ok"),
        "perMonth": MessageLookupByLibrary.simpleMessage("pro monat"),
        "perYear": MessageLookupByLibrary.simpleMessage("per annum"),
        "premColorsQuotes": MessageLookupByLibrary.simpleMessage(
            "Neue Farben und vollständige Anführungszeichen"),
        "premFuture":
            MessageLookupByLibrary.simpleMessage("Neue Features in Zukunft"),
        "premLists": MessageLookupByLibrary.simpleMessage(
            "Verschiedene Listen und Anpassung"),
        "premTasks":
            MessageLookupByLibrary.simpleMessage("Unbegrenzte Aufgaben"),
        "privacyPolicy":
            MessageLookupByLibrary.simpleMessage("Datenschutzbestimmungen"),
        "privacyPolicyPremium":
            MessageLookupByLibrary.simpleMessage("\nDatenschutzrichtlinie"),
        "recurringPayment": MessageLookupByLibrary.simpleMessage(
            "Dies ist eine wiederkehrende Zahlung"),
        "reminder": MessageLookupByLibrary.simpleMessage("Erinnerung"),
        "rename": MessageLookupByLibrary.simpleMessage("Umbenennen"),
        "reportProblem":
            MessageLookupByLibrary.simpleMessage("Ein Problem melden"),
        "save": MessageLookupByLibrary.simpleMessage("Speichern"),
        "saveReminder":
            MessageLookupByLibrary.simpleMessage("Erinnerung speichern"),
        "settings": MessageLookupByLibrary.simpleMessage("Einstellungen"),
        "terms": MessageLookupByLibrary.simpleMessage("Bedingungen"),
        "termsOfUsing":
            MessageLookupByLibrary.simpleMessage("Regeln für die Verwendung"),
        "thumbnail": MessageLookupByLibrary.simpleMessage("Vorschaubild"),
        "undo": MessageLookupByLibrary.simpleMessage("Rückgängig machen"),
        "updateThumbnail":
            MessageLookupByLibrary.simpleMessage("Vorschaubild aktualisieren?"),
        "wrongReminder":
            MessageLookupByLibrary.simpleMessage("Falsche Erinnerungszeit")
      };
}
