import 'package:flutter/material.dart';
import 'package:terminal_bimodal/src/screens/users/show_user2.dart';
import 'package:terminal_bimodal/src/components/text_box.dart';

class EditUser extends StatefulWidget {
  final User _user;
  EditUser(this._user);

  @override
  State<EditUser> createState() => _EditUserState();
}

class _EditUserState extends State<EditUser> {
  TextEditingController controllerId = new TextEditingController();
  TextEditingController controllerEmail = new TextEditingController();

  @override
  void initState() {
    User u = widget._user;
    controllerId = new TextEditingController(text: u.id);
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
          TextBox(controllerId, "Id"),
          TextBox(controllerEmail, "Email"),
          Container(
            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: ElevatedButton.icon(
              icon: Icon(Icons.update),
              style: ElevatedButton.styleFrom(
                primary: Colors.green.shade800,
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                textStyle: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                fixedSize: const Size(double.infinity, 60),
              ),
              onPressed: () {
                String id = controllerId.text;
                String email = controllerEmail.text;

                if (id.isNotEmpty && email.isNotEmpty) {
                  Navigator.pop(context, new User(id, email));
                }
              },
              label: Text("Update User"),
            ),
          ),
        ],
      ),
    );
  }
}
