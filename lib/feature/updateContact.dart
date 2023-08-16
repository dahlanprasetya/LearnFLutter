import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'contactsList.dart';
import 'dart:convert';

class UpdateContact extends StatefulWidget {
  final int contactId;
  UpdateContact({required this.contactId});
  @override
  _UpdateContactState createState() =>
      _UpdateContactState(contactId: contactId);
}

class _UpdateContactState extends State<UpdateContact> {
  final int contactId;
  File? avatarImg;
  bool showImageChoices = false;

  _UpdateContactState({required this.contactId});

  TextEditingController _nameController = TextEditingController();
  TextEditingController _phoneNumberController = TextEditingController();

  List<Map<String, String>> _contacts = [];

  @override
  void initState() {
    super.initState();
    _loadContacts();
  }

  Future<void> _loadContacts() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //await prefs.clear(); //--> to delete the previous data
    List<String>? contactsJson = await prefs.getStringList('contacts');
    if (contactsJson != null) {
      setState(() {
        _contacts = contactsJson
            .map((contactJson) =>
                Map<String, String>.from(json.decode(contactJson)))
            .toList();
        _showDataContact();
      });
    }
  }

  void _showDataContact() {
    setState(() {
      _contacts.sort((a, b) => (a['name'] ?? '').compareTo(b['name'] ?? ''));
      _nameController.text = _contacts[contactId]['name'].toString();
      _phoneNumberController.text =
          _contacts[contactId]['phoneNumber'].toString();
      String imagePath = _contacts[contactId]['imagePath'] ?? '';
      if (imagePath.isNotEmpty) {
        avatarImg = File(imagePath); // Convert the path to a File
      }
    });
  }

  void _saveContacts() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> contactsJson =
        _contacts.map((contact) => json.encode(contact)).toList();
    await prefs.setStringList('contacts', contactsJson);
  }

  void _updateContact(BuildContext context, File? imageFile) {
    String name = _nameController.text;
    String phoneNumber = _phoneNumberController.text;
    if (name.isNotEmpty && phoneNumber.isNotEmpty) {
      setState(() {
        _contacts[contactId]['name'] = name;
        _contacts[contactId]['phoneNumber'] = phoneNumber;
        _contacts[contactId]['createdDate'] = DateTime.now().toString();
        if (imageFile != null) {
          _contacts[contactId]['imagePath'] = imageFile.path;
        }
      });
      _saveContacts();
    }
  }

  Future<void> _pickImage(ImageSource source) async {
    final pickedImage = await ImagePicker().pickImage(source: source);

    if (pickedImage != null) {
      setState(() {
        avatarImg = File(pickedImage.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Contact'),
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
          ClipOval(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  showImageChoices = true;
                });
              },
              child: Container(
                  width: 150,
                  height: 150,
                  child: (avatarImg == null
                      ? Icon(
                          Icons.person,
                          size: 150,
                        )
                      : Image.file(avatarImg!))),
            ),
          ),
          if (showImageChoices)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () => _pickImage(ImageSource.camera),
                  child: Text('Take Picture'),
                ),
                ElevatedButton(
                  onPressed: () => _pickImage(ImageSource.gallery),
                  child: Text('Pick from Gallery'),
                ),
              ],
            ),
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
              _updateContact(context, avatarImg);
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Success'),
                    content: Text('Contact updated successfully.'),
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
              'Update Contact',
              style: TextStyle(fontSize: 17),
            ),
          ),
        ],
      ),
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBar(
  //       title: Text('Update Contact'),
  //       actions: [
  //         IconButton(
  //           icon: Icon(Icons.home),
  //           onPressed: () {
  //             Navigator.pushNamed(context, '/');
  //           },
  //         ),
  //       ],
  //     ),
  //     body: Column(
  //       children: [
  //         Padding(
  //           padding: const EdgeInsets.all(15.0),
  //           child: TextField(
  //             controller: _nameController,
  //             decoration: InputDecoration(labelText: 'Name'),
  //             style: TextStyle(fontSize: 20),
  //           ),
  //         ),
  //         Padding(
  //           padding: const EdgeInsets.all(15.0),
  //           child: TextField(
  //             controller: _phoneNumberController,
  //             decoration: InputDecoration(labelText: 'Phone Number'),
  //             style: TextStyle(fontSize: 20),
  //             keyboardType: TextInputType.phone,
  //           ),
  //         ),
  //         ElevatedButton(
  //           onPressed: () {
  //             _updateContact(context);
  //             showDialog(
  //               context: context,
  //               builder: (BuildContext context) {
  //                 return AlertDialog(
  //                   title: Text('Success'),
  //                   content: Text('Contact updated successfully.'),
  //                   actions: [
  //                     TextButton(
  //                       onPressed: () {
  //                         Navigator.of(context).pop(); // Close the dialog
  //                         Navigator.push(
  //                           context,
  //                           MaterialPageRoute(
  //                               builder: (context) => ContactsList()),
  //                         );
  //                       },
  //                       child: Text('OK'),
  //                     ),
  //                   ],
  //                 );
  //               },
  //             );
  //           },
  //           child: Text(
  //             'Update Contact',
  //             style: TextStyle(fontSize: 17),
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }
}
