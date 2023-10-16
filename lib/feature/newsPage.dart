import 'package:flutter/material.dart';
import 'package:pras_flutter/constants.dart';
import 'package:pras_flutter/feature/dontShowAgain.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NewsPage extends StatefulWidget {
  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  String newsContent = "Welcome to News Page";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('News Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              newsContent,
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                savePreferences();
                Navigator.pushNamed(context, '/home');
              },
              child: Text('Skip'),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Transform.scale(
                  scale: 1.2,
                  child: Checkbox(
                    value: dontShowAgain,
                    onChanged: (bool? value) {
                      setState(() {
                        dontShowAgain = value ?? false;
                      });
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        20,
                      ),
                    ),
                    checkColor: Colors.white,
                    activeColor: Color(0xFF0176f9),
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                ),
                Text("Don't Show Again"),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
