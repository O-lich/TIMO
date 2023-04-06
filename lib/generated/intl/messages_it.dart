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

  static String m0(seconds) => "Il promemoria verrà eliminata tra ${seconds}";

  static String m1(seconds) => "L\'attività verrà eliminata tra ${seconds}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "aboutUs": MessageLookupByLibrary.simpleMessage("Chi siamo"),
        "activeReminder": MessageLookupByLibrary.simpleMessage(
            "Il promemoria attivo verrà visualizzato sotto l\'attività come un elemento nero"),
        "add": MessageLookupByLibrary.simpleMessage("aggiungere"),
        "addNewList":
            MessageLookupByLibrary.simpleMessage("aggiungere una nuova lista"),
        "allFeatures": MessageLookupByLibrary.simpleMessage(
            "Tutte le funzioni senza limiti"),
        "and": MessageLookupByLibrary.simpleMessage(" e i "),
        "bySubscribing": MessageLookupByLibrary.simpleMessage(
            "Iscrivendoti accetti la nostra"),
        "cancel": MessageLookupByLibrary.simpleMessage("Annullare"),
        "chooseLists": MessageLookupByLibrary.simpleMessage("Liste"),
        "choosePhoto":
            MessageLookupByLibrary.simpleMessage("Scegliere la foto"),
        "color": MessageLookupByLibrary.simpleMessage("Colore"),
        "create": MessageLookupByLibrary.simpleMessage("creare"),
        "createNewList":
            MessageLookupByLibrary.simpleMessage("creare una nuova lista"),
        "delete": MessageLookupByLibrary.simpleMessage("Cancellare"),
        "deleteThumbnail":
            MessageLookupByLibrary.simpleMessage("Eliminare la copertura"),
        "deletingReminder": m0,
        "deletingTask": m1,
        "error": MessageLookupByLibrary.simpleMessage(
            "Nessuna connessione internet"),
        "getPremium": MessageLookupByLibrary.simpleMessage("Diventa premium"),
        "goPremium": MessageLookupByLibrary.simpleMessage("Vai Premium"),
        "hintTaskText":
            MessageLookupByLibrary.simpleMessage("Digita l\'attività..."),
        "hintText":
            MessageLookupByLibrary.simpleMessage(" Digita nuova attività..."),
        "language": MessageLookupByLibrary.simpleMessage("Italiano"),
        "languageTitle": MessageLookupByLibrary.simpleMessage("Lingua"),
        "letsDoSmth":
            MessageLookupByLibrary.simpleMessage("Creiamo una attività"),
        "lists": MessageLookupByLibrary.simpleMessage("liste"),
        "move": MessageLookupByLibrary.simpleMessage("mossa"),
        "newList": MessageLookupByLibrary.simpleMessage(" nuova lista"),
        "okButton": MessageLookupByLibrary.simpleMessage("Ok"),
        "perMonth": MessageLookupByLibrary.simpleMessage("al mese"),
        "perYear": MessageLookupByLibrary.simpleMessage("all\'anno"),
        "premColorsQuotes": MessageLookupByLibrary.simpleMessage(
            "Nuovi colori e virgolette complete"),
        "premFuture": MessageLookupByLibrary.simpleMessage(
            "Nuove funzionalità in futuro"),
        "premLists": MessageLookupByLibrary.simpleMessage(
            "Diverse liste personalizzabile"),
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
            MessageLookupByLibrary.simpleMessage("Salvare promemoria"),
        "settings": MessageLookupByLibrary.simpleMessage("Configurazione"),
        "terms": MessageLookupByLibrary.simpleMessage("Termini"),
        "termsOfUsing": MessageLookupByLibrary.simpleMessage("Regole d\'uso"),
        "thumbnail": MessageLookupByLibrary.simpleMessage("Copertura"),
        "undo": MessageLookupByLibrary.simpleMessage("Disfare"),
        "updateThumbnail":
            MessageLookupByLibrary.simpleMessage("Aggiornare la copertura?"),
        "wrongReminder":
            MessageLookupByLibrary.simpleMessage("Orario di promemoria errato")
      };
}
