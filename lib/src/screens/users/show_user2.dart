import 'package:flutter/material.dart';
import 'package:terminal_bimodal/src/screens/navigation/nav_bar2.dart';
import 'package:terminal_bimodal/src/screens/users/add_user2.dart';
import 'package:terminal_bimodal/src/screens/users/edit_user2.dart';
import 'package:terminal_bimodal/src/components/message_response.dart';
import 'package:terminal_bimodal/src/screens/navigation/nav_bar.dart';

class ShowUserPage2 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ShowUserPage2();
}

class User {
  String id = "";
  String email = "";
  String administrativo = "";
  String chofer = "";
  User(id, email) {
    this.id = id.toString();
    this.email = email;
  }
}

class _ShowUserPage2 extends State<ShowUserPage2> {
  List<User> users = [
    User('1', 'diego@gmail.com'),
    User('2', 'david@gmail.com'),
    User('3', 'fernanda@gmail.com'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavBar2(),
      appBar: AppBar(
        title: Text("Basic User Crud"),
        backgroundColor: Colors.green.shade800,
      ),
      body: ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) {
          return ListTile(
            onTap: () {
              Navigator.push(context,
                      MaterialPageRoute(builder: (_) => EditUser(users[index])))
                  .then((newUser) {
                if (newUser != null) {
                  setState(() {
                    users.removeAt(index);
                    users.insert(index, newUser);
                    messageResponse(
                        context, newUser.name + " has been updated!");
                  });
                }
              });
            },
            onLongPress: () {
              // Here will be the deleted method
              removeUser(context, users[index]);
            },
            title: Text(users[index].email),
            leading: CircleAvatar(
              child: Text(users[index].id.toString()),
            ),
            trailing: Icon(Icons.call, color: Colors.red),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
                  context, MaterialPageRoute(builder: (_) => RegisterUser()))
              .then((newUser) {
            if (newUser != null) {
              setState(() {
                users.add(newUser);
                messageResponse(
                    context, newUser.id.toString() + " has been saved!");
              });
            }
          });
        },
        tooltip: "Agregar Usuario",
        child: Icon(Icons.add),
      ),
    );
  }

  removeUser(BuildContext context, User user) {
    showDialog(
        context: context,
        builder: (dialogContext) => AlertDialog(
              title: Text("Delete User"),
              content: Text("¿Are you sure to delete the user " +
                  user.id.toString() +
                  "?"),
              actions: [
                TextButton(
                  onPressed: () {
                    setState(() {
                      this.users.remove(user);
                      Navigator.pop(dialogContext);
                    });
                  },
                  child: Text(
                    "Delete",
                    style: TextStyle(
                      color: Colors.red,
                    ),
                  ),
                ),
                TextButton(
                    onPressed: () {
                      Navigator.pop(dialogContext);
                    },
                    child: Text(
                      "Cancel",
                      style: TextStyle(color: Colors.blue),
                    ))
              ],
            ));
  }
}
