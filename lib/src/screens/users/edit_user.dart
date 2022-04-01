import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:terminal_bimodal/src/screens/users/show_user.dart';
import 'package:terminal_bimodal/src/components/text_box.dart';

import '../../connection/api.dart';
import '../../models/user.dart';

class EditUser extends StatefulWidget {
  final User _user;
  EditUser(this._user);

  @override
  State<EditUser> createState() => _EditUserState();
}

class _EditUserState extends State<EditUser> {
  TextEditingController controllerEmail = new TextEditingController();

  _update() async {
    var data = {
      'email': controllerEmail.text,
    };

    var res = await CallApi().postData(data, 'update/' + widget._user.id);
    var body = json.decode(res.body);

    if (body['success'] == true) {
      Navigator.pushNamed(context, "/user");
      print("User Updated");
    } else {
      print("Error");
    }
  }

  @override
  void initState() {
    User u = widget._user;
    controllerEmail = new TextEditingController(text: u.email);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit User"),
        backgroundColor: Colors.green.shade800,
      ),
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
                      Container(
                        margin:
                            EdgeInsets.symmetric(vertical: 50, horizontal: 0),
                        child: ElevatedButton.icon(
                          icon: Icon(Icons.update),
                          style: ElevatedButton.styleFrom(
                            primary: Colors.green.shade800,
                            padding: EdgeInsets.symmetric(
                                horizontal: 90, vertical: 20),
                            textStyle: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                            fixedSize: const Size(double.infinity, 60),
                          ),
                          onPressed: () => setState(() {
                            _update();
                            Navigator.pushNamed(context, "/user");
                          }),
                          label: Text("Update User"),
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
