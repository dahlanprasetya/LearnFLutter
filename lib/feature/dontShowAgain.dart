import 'package:pras_flutter/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<bool> checkShowPage() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  //prefs.setBool('dontShowPage', false); //for testing, dont forget to disabled
  final bool dontShowPage = prefs.getBool('dontShowPage') ?? false;
  loginCount = prefs.getInt('loginCount') ?? 0;
  loginCount += 1;
  prefs.setInt('loginCount', loginCount);
  if (!dontShowPage) {
    if (loginCount == 1 || loginCount % showAgainAfterLogin == 0) {
      return true;
    }
  }
  return false;
}

void savePreferences() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final bool setDontShowPage = dontShowAgain ?? false;
  prefs.setBool('dontShowPage', setDontShowPage);
}
