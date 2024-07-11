// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_sms/flutter_sms.dart';

class MyForm extends StatefulWidget {
  const MyForm({Key? key}) : super(key: key);

  @override
  _MyFormState createState() => _MyFormState();
}

class _MyFormState extends State<MyForm> {
  final _formKey = GlobalKey<FormState>();
  late String _patientCondition;
  late String _patientname;
  late String _recipient;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,

      child: Scaffold(
         body:ListView(
        children: <Widget>[
          TextFormField(
            decoration: const InputDecoration(labelText: 'Recipient'),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter a valid mobile number';
              }
              return null;
            },
            onSaved: (value) => _recipient = value!,
          ),
          TextFormField(
            decoration: const InputDecoration(labelText: 'patient name'),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter a valid patient name';
              }
              return null;
            },
            onSaved: (value) => _patientname = value!,
          ),
          TextFormField(
            decoration: const InputDecoration(labelText: 'patient condition'),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter a valid patient condition';
              }
              return null;
            },
            onSaved: (value) => _patientCondition = value!,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: ElevatedButton(
              onPressed: () {
                // Validate returns true if the form is valid, otherwise false.
                if (_formKey.currentState!.validate()) {
                  // Save the form
                  _formKey.currentState!.save();
                  // Use the recipient's mobile number to send an SMS
                  String message = 'Patient Name'+_patientname+'Patient condition: ' + _patientCondition;
                  sendSMS(message: message, recipients: [_recipient])
                      .then((response) {
                      print(response);
                  });
                }
              },
              child: const Text('Submit'),
            ),
          ),
        ],
      ),
      ),
    );
  }
}