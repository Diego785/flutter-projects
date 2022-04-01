import 'dart:io';

import 'package:flutter/material.dart';
import 'package:terminal_bimodal/src/components/image_picker_widget.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool _loading = false;
  File? image;
  String genrer = "Masculino";

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _formKey,
      body: Form(
        child: Stack(
          children: <Widget>[
            ImagePickerWidget(),
            SizedBox(
                child: AppBar(
                  elevation: 0,
                  backgroundColor: Colors.transparent,
                  iconTheme: IconThemeData(color: Colors.white),
                ),
                height: kToolbarHeight + 25),
            Center(
              child: Transform.translate(
                offset: Offset(0, -90),
                child: Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  margin: const EdgeInsets.only(
                      left: 20, right: 20, top: 335, bottom: 10),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 35, vertical: 10),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: "User:",
                          ),
                        ),
                        SizedBox(height: 20),
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: "Password:",
                          ),
                          obscureText: true,
                        ),
                        Row(
                          children: <Widget>[
                            Text(
                              "Género",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey.shade700),
                            ),
                            Expanded(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  RadioListTile(
                                    title: Text(
                                      "Masculino",
                                      style: TextStyle(fontSize: 12),
                                    ),
                                    value: "Masculino",
                                    groupValue: genrer,
                                    onChanged: (genrer) => "Masculino",
                                  ),
                                  RadioListTile(
                                    title: Text(
                                      "Femenino",
                                      style: TextStyle(fontSize: 12),
                                    ),
                                    value: "Femenino",
                                    groupValue: genrer,
                                    onChanged: (genrer) => "Femenino",
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Theme(
                          data: Theme.of(context)
                              .copyWith(accentColor: Colors.white),
                          child: RaisedButton(
                            color: Theme.of(context).primaryColor,
                            textColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            onPressed: () => _home(context),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text("Registrar"),
                                if (_loading)
                                  Container(
                                    height: 20,
                                    width: 20,
                                    margin: EdgeInsets.only(left: 20),
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                    ),
                                  )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _home(BuildContext context) {
    Navigator.of(context).pushNamed("/home");
  }
}
