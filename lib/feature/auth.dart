import 'package:flutter/material.dart';
import 'package:local_session_timeout/local_session_timeout.dart';
import 'package:pras_flutter/constants.dart';
import 'package:pras_flutter/feature/dontShowAgain.dart';
import 'package:pras_flutter/feature/home.dart';
import 'package:pras_flutter/feature/newsPage.dart';

class AuthPage extends StatelessWidget {
  AuthPage({
    this.loggedOutReason = "",
    super.key,
  });

  late String loggedOutReason;

  Future<void> checkAndNavigate(BuildContext context) async {
    if (await checkShowPage()) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => NewsPage()),
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    }
  }

// Then call checkAndNavigate wherever you need to navigate from

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (loggedOutReason != "")
              Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 15,
                ),
                child: Text(loggedOutReason),
              ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () async {
                // start listening only after user logs in
                global_sessionStateStream.add(SessionState.startListening);
                isLogin = true;
                loggedOutReason = "";
                checkAndNavigate(context);
              },
              child: const Text("Login"),
            ),
          ],
        ),
      ),
    );
  }
}
