import 'package:flutter/material.dart';
import 'package:local_session_timeout/local_session_timeout.dart';
import 'package:pras_flutter/constants.dart';

class MyExpandableTextField extends StatefulWidget {
  @override
  _MyExpandableTextFieldState createState() => _MyExpandableTextFieldState();
}

class _MyExpandableTextFieldState extends State<MyExpandableTextField> {
  bool isExpanded = false;
  TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    if (isLogin) {
      print("Insets Bottom: " +
          MediaQuery.of(context).viewInsets.bottom.toString());
      if (MediaQuery.of(context).viewInsets.bottom > 0) {
        // softkeyboard is open
        global_sessionStateStream.add(SessionState.stopListening);
        print("Keyboard Up - Stop Listener");
      } else {
        // keyboard is closed
        global_sessionStateStream.add(SessionState.startListening);
        print("Keyboard Close - Start Listener");
      }
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('Expand Field'),
        actions: [
          IconButton(
            icon: Icon(Icons.home),
            onPressed: () {
              Navigator.pushNamed(context, '/home');
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            height: isExpanded ? null : 40.0, // Set an initial height
            child: TextField(
              controller: textEditingController,
              maxLines: null, // Set to null for unlimited lines
              decoration: InputDecoration(
                hintText: 'Type something...',
                // suffixIcon: isTextOverflow()
                //     ? GestureDetector(
                //         onTap: () {
                //           setState(() {
                //             isExpanded = !isExpanded;
                //           });
                //         },
                //         child: Icon(
                //           isExpanded
                //               ? Icons.expand_less
                //               : Icons.read_more_rounded,
                //         ),
                //       )
                //     : null,
              ),
              keyboardType:
                  TextInputType.numberWithOptions(decimal: true, signed: false),
              onChanged: (value) {
                setState(() {
                  if (!isTextOverflow()) {
                    isExpanded = false;
                  } else {
                    isExpanded = true;
                  }
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  bool isTextOverflow() {
    final textLength = textEditingController.text.length;
    return textLength >
        45; // Adjust this value based on your TextField's initial height
  }
}
