import 'package:flutter/material.dart';
import 'package:terminal_bimodal/src/screens/users/show_user2.dart';
import 'package:terminal_bimodal/src/components/text_box.dart';

class RegisterUser extends StatefulWidget {
  @override
  State<RegisterUser> createState() => _RegisterUser();
}

class _RegisterUser extends State<RegisterUser> {
  TextEditingController controllerId = new TextEditingController();
  TextEditingController controllerEmail = new TextEditingController();

  @override
  void initState() {
    controllerId = new TextEditingController();
    controllerEmail = new TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          AppBar(title: Text("Add User"), backgroundColor: Colors.green[800]),
      body: ListView(
        children: [
          TextBox(controllerId, "Email"),
          TextBox(controllerEmail, "Email"),
          Container(
            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: ElevatedButton.icon(
              icon: Icon(Icons.save),
              style: ElevatedButton.styleFrom(
                primary: Colors.green.shade800,
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                textStyle: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                fixedSize: const Size(double.infinity, 60),
              ),
              onPressed: () {
                String id = controllerEmail.text;
                String email = controllerEmail.text;

                if (id.isNotEmpty && email.isNotEmpty) {
                  Navigator.pop(context, new User(id, email));
                }
              },
              label: Text("Save User"),
            ),
          ),
        ],
      ),
    );
  }
}
