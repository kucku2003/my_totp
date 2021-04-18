import 'package:flutter/material.dart';
import 'package:my_totp/main.dart';
import 'package:base32/base32.dart';
import 'package:provider/provider.dart';
import 'app-model.dart';
import 'otp-model.dart';

class SetupPage extends StatefulWidget {
  SetupPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _SetupPageState createState() => _SetupPageState();
}

class _SetupPageState extends State<SetupPage> {

  String _name = "";
  String _key = "";

  @override
  Widget build(BuildContext context) {
    return Consumer<AppModel>(
      builder: (context, appModel, child) => Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Column(
          children: [
            TextFormField(
              autovalidateMode: AutovalidateMode.disabled,
              decoration: const InputDecoration(
                icon: Icon(Icons.person),
                hintText: 'Enter description of the new account',
                labelText: 'Account name (*)',
              ),
              onChanged: (String value) {
                this._name = value;
              },
            ),
            TextFormField(
              autovalidateMode: AutovalidateMode.always,
              decoration: const InputDecoration(
                icon: Icon(Icons.lock),
                hintText: 'Enter secret key',
                labelText: 'Key (*)',
              ),
              onChanged: (String value) {
                this._key = value;
              },
              validator: (String value) {
                try {
                  base32.decode(value);
                } on FormatException catch (_) {
                  return 'Invalid key format';
                }
                return null;
              },
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  label: Text('Add new account'),
                  icon: Icon(Icons.save),
                  onPressed: () => {
                    appModel.addOTP(this._name, this._key),
                    Navigator.pop(context)
                  },
                ),
              )
            )
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => {
            Navigator.pop(context)
          },
          child: Icon(Icons.arrow_back),
        ), // This trailing comma makes auto-formatting nicer for build methods.
      )
    );
  }
}

