import 'package:flutter/material.dart';
import 'package:pras_flutter/constants.dart';
import 'package:pras_flutter/feature/auth.dart';
import 'package:local_session_timeout/local_session_timeout.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    final sessionConfig = SessionConfig(
        invalidateSessionForAppLostFocus: const Duration(seconds: 0),
        invalidateSessionForUserInactivity: const Duration(seconds: 5));

    sessionConfig.stream.listen((SessionTimeoutState timeoutEvent) {
      // stop listening, as user will already be in auth page
      global_sessionStateStream.add(SessionState.stopListening);
      isLogin = false;
      print("IsLogin False");
      if (timeoutEvent == SessionTimeoutState.userInactivityTimeout) {
        // handle user  inactive timeout
        global_navigator.push(MaterialPageRoute(
          builder: (_) => AuthPage(
              loggedOutReason: "Logged out because of user inactivity"),
        ));
      } else if (timeoutEvent == SessionTimeoutState.appFocusTimeout) {
        // handle user  app lost focus timeout
        global_navigator.push(MaterialPageRoute(
          builder: (_) =>
              AuthPage(loggedOutReason: "Logged out because app lost focus"),
        ));
      }
    });

    return SessionTimeoutManager(
      userActivityDebounceDuration: const Duration(seconds: 1),
      sessionConfig: sessionConfig,
      sessionStateStream: global_sessionStateStream.stream,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        navigatorKey: global_navigatorKey,
        // title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.red,
        ),
        home: AuthPage(),
      ),
    );
  }
}
