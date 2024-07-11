// ignore_for_file: deprecated_member_use, library_private_types_in_public_api, depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:url_launcher/url_launcher.dart';

class CallScreen extends StatefulWidget {
  const CallScreen({Key? key}) : super(key: key);

  @override
  _CallScreenState createState() => _CallScreenState();
}

class _CallScreenState extends State<CallScreen> {
  TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: ListView(
        children: <Widget>[
          TextFormField(
            keyboardType: TextInputType.phone,
            controller: textEditingController,
            onSaved: (phoneNumber) {
              textEditingController.text = phoneNumber!;
            },
          ),
          ElevatedButton(
            child: const Text("launchPhoneURL"),
            onPressed: () {
              _launchPhoneURL(textEditingController.text);
            },
          ),
          ElevatedButton(
            child: const Text("callNumber"),
            onPressed: () {
              _callNumber(textEditingController.text);
            },
          )
        ],
      ),
    );
  }
}

_callNumber(String phoneNumber) async {
  String number = phoneNumber;
  await FlutterPhoneDirectCaller.callNumber(number);
}

_launchPhoneURL(String phoneNumber) async {
  String url = 'tel:$phoneNumber';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
