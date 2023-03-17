// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a it locale. All the
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
  String get localeName => 'it';

  static String m0(seconds) => "L\'attività verrà eliminata tra ${seconds}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "aboutUs": MessageLookupByLibrary.simpleMessage("Chi siamo"),
        "activeReminder": MessageLookupByLibrary.simpleMessage(
            "Il promemoria attivo verrà visualizzato sotto l\'attività come un elemento nero"),
        "add": MessageLookupByLibrary.simpleMessage("aggiungere"),
        "addNewList":
            MessageLookupByLibrary.simpleMessage("aggiungere una nuova lista"),
        "and": MessageLookupByLibrary.simpleMessage(" e i "),
        "bySubscribing": MessageLookupByLibrary.simpleMessage(
            "Iscrivendoti accetti la nostra"),
        "chooseLists": MessageLookupByLibrary.simpleMessage("Liste"),
        "color": MessageLookupByLibrary.simpleMessage("Colore"),
        "create": MessageLookupByLibrary.simpleMessage("creare"),
        "createNewList":
            MessageLookupByLibrary.simpleMessage("creare una nuova lista"),
        "delete": MessageLookupByLibrary.simpleMessage("Cancellare"),
        "deletingTask": m0,
        "getPremium": MessageLookupByLibrary.simpleMessage("Prova il premio"),
        "goPremium": MessageLookupByLibrary.simpleMessage("Vai Premium"),
        "hintText":
            MessageLookupByLibrary.simpleMessage(" Digita nuova attività..."),
        "language": MessageLookupByLibrary.simpleMessage("Italiano"),
        "languageTitle": MessageLookupByLibrary.simpleMessage("Lingua"),
        "lists": MessageLookupByLibrary.simpleMessage("liste"),
        "move": MessageLookupByLibrary.simpleMessage("mossa"),
        "newList": MessageLookupByLibrary.simpleMessage(" nuovo elenco"),
        "perMonth": MessageLookupByLibrary.simpleMessage("al mese"),
        "perYear": MessageLookupByLibrary.simpleMessage("all\'anno"),
        "premColorsQuotes": MessageLookupByLibrary.simpleMessage(
            "Nuovi colori e virgolette complete"),
        "premFuture": MessageLookupByLibrary.simpleMessage(
            "Nuove funzionalità in futuro"),
        "premLists": MessageLookupByLibrary.simpleMessage(
            "Diverse liste e personalizzazione"),
        "premTasks":
            MessageLookupByLibrary.simpleMessage("Attività illimitate"),
        "privacyPolicy":
            MessageLookupByLibrary.simpleMessage("Informativa sulla privacy"),
        "privacyPolicyPremium": MessageLookupByLibrary.simpleMessage(
            "\nInformativa sulla privacy "),
        "recurringPayment": MessageLookupByLibrary.simpleMessage(
            "Questo è il pagamento ricorrente"),
        "reminder": MessageLookupByLibrary.simpleMessage("Promemoria"),
        "rename": MessageLookupByLibrary.simpleMessage("Rinominare"),
        "reportProblem":
            MessageLookupByLibrary.simpleMessage("Segnala un problema"),
        "saveReminder":
            MessageLookupByLibrary.simpleMessage("Salva promemoria"),
        "settings": MessageLookupByLibrary.simpleMessage("Configurazione"),
        "terms": MessageLookupByLibrary.simpleMessage("Termini"),
        "termsOfUsing": MessageLookupByLibrary.simpleMessage("Regole d\'uso"),
        "thumbnail": MessageLookupByLibrary.simpleMessage("Miniatura"),
        "undo": MessageLookupByLibrary.simpleMessage("Disfare")
      };
}
