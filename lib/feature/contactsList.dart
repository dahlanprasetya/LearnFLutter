import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'updateContact.dart';
import 'dart:convert';
import 'dart:io';

class ContactsList extends StatefulWidget {
  @override
  _ContactsListState createState() => _ContactsListState();
}

class _ContactsListState extends State<ContactsList> {
  List<Map<String, String>> _contacts = [];
  File? avatarImg;

  @override
  void initState() {
    super.initState();
    _loadContacts();
  }

  void _loadContacts() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //await prefs.clear(); //--> to delete the previous data
    List<String>? contactsJson = prefs.getStringList('contacts');
    if (contactsJson != null) {
      setState(() {
        _contacts = contactsJson
            .map((contactJson) =>
                Map<String, String>.from(json.decode(contactJson)))
            .toList();
        _contacts.sort((a, b) => (a['name'] ?? '').compareTo(b['name'] ?? ''));
      });
    }
  }

  void _saveContacts() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> contactsJson =
        _contacts.map((contact) => json.encode(contact)).toList();
    await prefs.setStringList('contacts', contactsJson);
  }

  void _deleteContact(int index) async {
    setState(() {
      _contacts.removeAt(index);
    });
    _saveContacts();
  }

  Future _setImageValue(int index) async {
    setState(() {
      String imagePath = _contacts[index]['imagePath'] ?? '';
      if (imagePath.isNotEmpty) {
        avatarImg = File(imagePath);
      } // Convert the path to a File
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contacts List'),
        actions: [
          IconButton(
            icon: Icon(Icons.home),
            onPressed: () {
              Navigator.pushNamed(context, '/');
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.all(15),
              child: Text(
                "List of Contacts:",
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                textAlign: TextAlign.left,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _contacts.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: () {},
                    child: Container(
                      width: 50,
                      height: 50,
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      alignment: Alignment.center,
                      child: _contacts[index]['imagePath'] != null
                          ? ClipOval(
                              child: Image.file(
                                File(_contacts[index]['imagePath'].toString()),
                                width: 60,
                                height: 60,
                                fit: BoxFit.cover,
                              ),
                            )
                          : CircleAvatar(
                              backgroundImage:
                                  AssetImage('images/icons8-kiwi-100.png'),
                            ),
                    ),
                  ),
                  trailing: PopupMenuButton<String>(
                    icon: const Icon(Icons.more_vert),
                    itemBuilder: (BuildContext context) {
                      return <PopupMenuEntry<String>>[
                        PopupMenuItem<String>(
                          value: 'update',
                          child: Container(
                            // Wrap the child with a container
                            width: 40, // Customize the width
                            child: const Center(
                                child: Text('Update',
                                    style: TextStyle(fontSize: 12))),
                          ),
                        ),
                        PopupMenuItem<String>(
                          value: 'delete',
                          child: Container(
                            // Wrap the child with a container
                            width: 35, // Customize the width
                            child: const Center(
                                child: Text('Delete',
                                    style: TextStyle(fontSize: 12))),
                          ),
                        ),
                      ];
                    },
                    onSelected: (String value) {
                      if (value == 'update') {
                        // Handle update action
                        //_updateContact(index);
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (BuildContext context) {
                              return UpdateContact(
                                contactId: index,
                              );
                            },
                          ),
                        );
                      } else if (value == 'delete') {
                        // Handle delete action
                        _deleteContact(index);
                      }
                    },
                  ),
                  title: Text(_contacts[index]['name'] ?? ''),
                  subtitle: Text(_contacts[index]['phoneNumber'] != null
                      ? _contacts[index]['phoneNumber'].toString() +
                          ' \nLast Update: ' +
                          _contacts[index]['createdDate'].toString()
                      : ''),
                  isThreeLine: true,
                  dense: true,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
