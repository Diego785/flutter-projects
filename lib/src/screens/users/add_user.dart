import 'package:flutter/material.dart';
import 'package:terminal_bimodal/src/connection/api.dart';
import 'package:terminal_bimodal/src/components/text_box.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

class RegisterUser extends StatefulWidget {
  @override
  State<RegisterUser> createState() => _RegisterUser();
}

class _RegisterUser extends State<RegisterUser> {
  TextEditingController controllerId = new TextEditingController();
  TextEditingController controllerEmail = new TextEditingController();
  TextEditingController controllerPassword = new TextEditingController();

  _create() async {
    var data = {
      'email': controllerEmail.text,
      'password': controllerPassword.text,
    };

    var res = await CallApi().postData(data, 'create');
    var body = json.decode(res.body);

    if (body['success'] == true) {
      Navigator.pushNamed(context, "/user");
      print("User Created");
    } else {
      print("Error");
    }
  }

  @override
  void initState() {
    controllerId = new TextEditingController();
    controllerEmail = new TextEditingController();
    controllerPassword = new TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          AppBar(title: Text("Add User"), backgroundColor: Colors.green[800]),
      body: ListView(
        children: [
          Transform.translate(
            offset: Offset(0, -90),
            child: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 35, vertical: 120),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: "Email:",
                        ),
                        controller: controllerEmail,
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: "Password:",
                        ),
                        obscureText: true,
                        controller: controllerPassword,
                      ),
                      SizedBox(height: 20),
                      Container(
                        margin:
                            EdgeInsets.symmetric(vertical: 50, horizontal: 0),
                        child: ElevatedButton.icon(
                          icon: Icon(Icons.save),
                          style: ElevatedButton.styleFrom(
                            primary: Color.fromRGBO(46, 125, 50, 1),
                            padding: EdgeInsets.symmetric(
                                horizontal: 90, vertical: 20),
                            textStyle: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                            fixedSize: const Size(double.infinity, 60),
                          ),
                          onPressed: () => setState(() {
                            _create();
                            Navigator.pushNamed(context, "/user");
                          }),
                          label: Text("Save User"),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
