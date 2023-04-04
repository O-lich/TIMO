// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a ru locale. All the
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
  String get localeName => 'ru';

  static String m0(seconds) => "Напоминание будет удалено через ${seconds}";

  static String m1(seconds) => "Задача будет удалена через ${seconds}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "aboutUs": MessageLookupByLibrary.simpleMessage("О нас"),
        "activeReminder": MessageLookupByLibrary.simpleMessage(
            "Активное напоминание будет отображаться под задачей в виде черного элемента."),
        "add": MessageLookupByLibrary.simpleMessage("добавить"),
        "addNewList":
            MessageLookupByLibrary.simpleMessage("добавить новый список"),
        "allFeatures": MessageLookupByLibrary.simpleMessage(
            "Все функции\nбез ограничений"),
        "and": MessageLookupByLibrary.simpleMessage(" и "),
        "bySubscribing": MessageLookupByLibrary.simpleMessage(
            "Подписываясь, вы принимаете наши"),
        "cancel": MessageLookupByLibrary.simpleMessage("Отмена"),
        "chooseLists": MessageLookupByLibrary.simpleMessage("Списки"),
        "color": MessageLookupByLibrary.simpleMessage("Цвет"),
        "create": MessageLookupByLibrary.simpleMessage("создать"),
        "createNewList":
            MessageLookupByLibrary.simpleMessage("создать новый список"),
        "delete": MessageLookupByLibrary.simpleMessage("Удалить"),
        "deletingReminder": m0,
        "deletingTask": m1,
        "error":
            MessageLookupByLibrary.simpleMessage("Нет соединения с интернетом"),
        "getPremium": MessageLookupByLibrary.simpleMessage("Попробуй премиум"),
        "goPremium": MessageLookupByLibrary.simpleMessage("Перейти на Премиум"),
        "hintTaskText":
            MessageLookupByLibrary.simpleMessage(" Введите задачу..."),
        "hintText":
            MessageLookupByLibrary.simpleMessage(" Введите новую задачу..."),
        "language": MessageLookupByLibrary.simpleMessage("Русский"),
        "languageTitle": MessageLookupByLibrary.simpleMessage("Язык"),
        "letsDoSmth":
            MessageLookupByLibrary.simpleMessage("Давай создадим задачу"),
        "lists": MessageLookupByLibrary.simpleMessage("списки"),
        "move": MessageLookupByLibrary.simpleMessage("переместить"),
        "newList": MessageLookupByLibrary.simpleMessage(" новый список"),
        "perMonth": MessageLookupByLibrary.simpleMessage("в месяц"),
        "perYear": MessageLookupByLibrary.simpleMessage("в год"),
        "premColorsQuotes": MessageLookupByLibrary.simpleMessage(
            "Новые цвета и цитаты целиком"),
        "premFuture":
            MessageLookupByLibrary.simpleMessage("Новые функции в будущем"),
        "premLists": MessageLookupByLibrary.simpleMessage(
            "Разные списки и кастомизации"),
        "premTasks": MessageLookupByLibrary.simpleMessage(
            "Неограниченное количество задач"),
        "privacyPolicy":
            MessageLookupByLibrary.simpleMessage("Политика конфиденциальности"),
        "privacyPolicyPremium": MessageLookupByLibrary.simpleMessage(
            "\nПолитику конфиденциальности"),
        "recurringPayment":
            MessageLookupByLibrary.simpleMessage("Это регулярный платеж"),
        "reminder": MessageLookupByLibrary.simpleMessage("Напоминание"),
        "rename": MessageLookupByLibrary.simpleMessage("Переименовать"),
        "reportProblem":
            MessageLookupByLibrary.simpleMessage("Сообщить о проблеме"),
        "saveReminder":
            MessageLookupByLibrary.simpleMessage("Установить напоминание"),
        "settings": MessageLookupByLibrary.simpleMessage("Настройки"),
        "terms": MessageLookupByLibrary.simpleMessage("Условия"),
        "termsOfUsing":
            MessageLookupByLibrary.simpleMessage("Правила использования"),
        "thumbnail": MessageLookupByLibrary.simpleMessage("Обложка"),
        "undo": MessageLookupByLibrary.simpleMessage("Отменить"),
        "wrongReminder":
            MessageLookupByLibrary.simpleMessage("Неверное время напоминания")
      };
}
