import 'package:flutter/material.dart';
import 'package:pras_flutter/constants.dart';
import 'package:pras_flutter/feature/calculator.dart';
import 'package:pras_flutter/feature/addContact.dart';
import 'package:pras_flutter/feature/confirmationDialog.dart';
import 'package:pras_flutter/feature/contactsList.dart';
import 'package:pras_flutter/feature/expandableField.dart';
import 'package:pras_flutter/constants.dart' as cons;
import 'package:pras_flutter/feature/newsPage.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String testData = "getData";
  late DateTime ctime;

  @override
  void initState() {
    super.initState();
    ctime = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter App Pras'),
      ),
      body: WillPopScope(
        onWillPop: () async {
          DateTime now = DateTime.now();
          if (now.difference(ctime) > Duration(seconds: 2)) {
            //add duration of press gap
            ctime = now;
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(
                    'Press Back Button Again to Exit'))); //scaffold message, you can show Toast message too.
            return false;
          }
          getOutOfApp();
          return false;
        },
        child: Center(
          child: cons.MENU.CURRENT_INDEX == 0
              ? SizedBox(
                  width: double.infinity,
                  height: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (BuildContext context) {
                                  return Calculator();
                                },
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.deepOrange,
                            foregroundColor: Colors.white38,
                          ),
                          child: Text(cons.MENU.CALCULATOR_PAGE)),
                      ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (BuildContext context) {
                                  return AddContact();
                                },
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.deepPurple,
                            foregroundColor: Colors.black38,
                          ),
                          child: Text(cons.MENU.ADD_CONTACT_PAGE)),
                      ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (BuildContext context) {
                                  return ContactsList();
                                },
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white70,
                            foregroundColor: Colors.black38,
                          ),
                          child: Text(cons.MENU.CONTACTS_LIST_PAGE)),
                      ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (BuildContext context) {
                                  return MyExpandableTextField();
                                },
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white70,
                            foregroundColor: Colors.black38,
                          ),
                          child: Text(cons.MENU.EXPANDABLE_FIELD_PAGE)),
                      ElevatedButton(
                          onPressed: () async {
                            bool result = await ConfirmationDialog.show(
                              context: context,
                              isEnabled: true,
                            );

                            if (result) {
                              getOutOfApp();
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            foregroundColor: Colors.black38,
                          ),
                          child: Text("Exit Application")),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => NewsPage()),
                          );
                        },
                        child: Text('Show News'),
                      )
                    ],
                  ),
                )
              : Image.asset('images/alfred-kenneally-dZKhNhzGk7k-unsplash.jpg'),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            label: 'Home',
            icon: Icon(Icons.home),
          ),
          BottomNavigationBarItem(
            label: 'Settings',
            icon: Icon(Icons.settings),
          ),
        ],
        currentIndex: cons.MENU.CURRENT_INDEX,
        onTap: (int index) {
          setState(() {
            cons.MENU.CURRENT_INDEX = index;
          });
        },
      ),
      backgroundColor: Colors.grey,
    );
  }
}
