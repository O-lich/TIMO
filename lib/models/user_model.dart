import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserModel {
  int locale;
  String userID;
  bool isClosePanelTapped;

  UserModel({String? userID, int? locale, bool? isClosePanelTapped})
      : userID = userID ?? 'testUser',
        locale = locale ?? -1,
        isClosePanelTapped = isClosePanelTapped ?? false;

  factory UserModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return UserModel(
        locale: data?['locale'],
        userID: data?['userID'],
        isClosePanelTapped: data?['isClosePanelTapped']);
  }

  Map<String, dynamic> toFirestore() {
    return {
      "locale": locale,
      "userID": userID,
    "isClosePanelTapped": isClosePanelTapped,
    };
  }

  static Future<UserModel> getUserModel() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userID = prefs.getString('userID');
    int? locale = prefs.getInt('locale');
    bool? isClosePanelTapped = prefs.getBool('isClosePanelTapped');
    if (userID == null) {
      userID = UniqueKey().toString();
      await prefs.setString('userID', userID);
    }
    return UserModel(userID: userID, locale: locale, isClosePanelTapped: isClosePanelTapped);
  }
}
