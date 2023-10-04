import 'dart:async';

import 'package:flutter/material.dart';
import 'package:local_session_timeout/local_session_timeout.dart';
import 'package:pras_flutter/feature/calculator.dart';
import 'package:pras_flutter/feature/addContact.dart';
import 'package:pras_flutter/feature/contactsList.dart';
import 'package:pras_flutter/feature/expandableField.dart';
import 'package:pras_flutter/constants.dart' as cons;

class HomePage extends StatefulWidget {

  const HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String testData = "getData";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter App Pras'),
      ),
      body: Center(
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
                  ],
                ),
              )
            : Image.asset('images/alfred-kenneally-dZKhNhzGk7k-unsplash.jpg'),
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
