import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'contactsList.dart';
import 'dart:convert';

class AddContact extends StatefulWidget {
  @override
  _AddContactState createState() => _AddContactState();
}

class _AddContactState extends State<AddContact> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _phoneNumberController = TextEditingController();

  List<Map<String, String>> _contacts = [];

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
      });
    }
  }

  void _saveContacts() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> contactsJson =
        _contacts.map((contact) => json.encode(contact)).toList();
    await prefs.setStringList('contacts', contactsJson);
  }

  void _addContact() {
    String name = _nameController.text;
    String phoneNumber = _phoneNumberController.text;
    if (name.isNotEmpty && phoneNumber.isNotEmpty) {
      setState(() {
        _contacts.add({
          'name': name,
          'phoneNumber': phoneNumber,
          'createdDate': DateTime.now().toString()
        });
      });
      _saveContacts();
      _nameController.clear();
      _phoneNumberController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Contact'),
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
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Name'),
              style: TextStyle(fontSize: 20),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextField(
              controller: _phoneNumberController,
              decoration: InputDecoration(labelText: 'Phone Number'),
              style: TextStyle(fontSize: 20),
              keyboardType: TextInputType.phone,
            ),
          ),
          ElevatedButton(
            onPressed: () {
              _addContact();
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Success'),
                    content: Text('Contact added successfully.'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop(); // Close the dialog
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ContactsList()),
                          );
                        },
                        child: Text('OK'),
                      ),
                    ],
                  );
                },
              );
            },
            child: Text(
              'Add Contact',
              style: TextStyle(fontSize: 17),
            ),
          ),
        ],
      ),
    );
  }
}
