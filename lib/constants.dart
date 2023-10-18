import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:local_session_timeout/local_session_timeout.dart';
import 'package:move_to_background/move_to_background.dart';

final global_navigatorKey = GlobalKey<NavigatorState>();
NavigatorState get global_navigator => global_navigatorKey.currentState!;
final global_sessionStateStream = StreamController<SessionState>();

late bool isLogin = false;
late int loginCount = 0;
final int showAgainAfterLogin = 10;
bool? dontShowAgain = false;
late bool checkConflict = false;
late bool addConflict = true;

class MENU {
  // add a private constructor to prevent this class being instantiated
  // e.g. invoke `MENU()` accidentally
  MENU._();
  static const String CALCULATOR_PAGE = 'Calculator';
  static const String ADD_CONTACT_PAGE = 'Add Contact';
  static const String CONTACTS_LIST_PAGE = 'Contacts List';
  static const String EXPANDABLE_FIELD_PAGE = 'Expandable TextField';
  static const String OTHER_PAGE = 'Calculator Test';
  static int CURRENT_INDEX = 0;
}

class CALCULATOR {
  CALCULATOR._();
  static String OUTPUT = "0";
  static String CURRENT_NUMBER = "";
  static double NUM_1 = 0;
  static double NUM_2 = 0;
  static String OPERAND = "";
}

Future<void> popApp({bool? animated}) async {
  await SystemChannels.platform
      .invokeMethod<void>('SystemNavigator.pop', animated);
}

late DateTime currentBackPressTime;
Future<bool> onWillPop() {
  DateTime now = DateTime.now();
  if (now.difference(currentBackPressTime) > Duration(seconds: 2)) {
    currentBackPressTime = now;
    SnackBar(content: Text('Tap back again to leave'));
    Fluttertoast.showToast(msg: "Tap back again to leave");
    return Future.value(false);
  }
  return Future.value(false);
}

void getOutOfApp() {
  if (Platform.isAndroid) {
    popApp();
  } else if (Platform.isIOS) {
    MoveToBackground.moveTaskToBack();
  }
}

late String globalValue = "";
late String testNewBranchFeatures = "wow";
late String testNewBranchFeatures2 = "wow212";
