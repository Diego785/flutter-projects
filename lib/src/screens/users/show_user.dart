import 'package:flutter/material.dart';
import 'package:terminal_bimodal/src/screens/navigation/nav_bar2.dart';
import 'package:terminal_bimodal/src/screens/users/add_user.dart';
import 'package:terminal_bimodal/src/screens/users/edit_user.dart';
import 'package:terminal_bimodal/src/components/message_response.dart';
import 'package:terminal_bimodal/src/screens/navigation/nav_bar.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:getwidget/getwidget.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../models/user.dart';

class ShowUserPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ShowUserPage();
}

List<User> users = [];

class _ShowUserPage extends State<ShowUserPage> {
//--------------------------------- SHOW USERS ---------------------------------//
  bool _isLoading = false;
  late Future<List<User>> _listUsers;

  Future<List<User>> _getUsers() async {
    Uri url =
        Uri.parse('http://192.168.56.1/terminal_bimodal/public/api/users');
    final response = await http.get(url);
    List<User> data = [];
    if (response.statusCode == 200) {
      String body = utf8.decode(response.bodyBytes);
      final jsonData = jsonDecode(body);
      for (var item in jsonData) {
        print(item["idChofer"]);
        data.add(User(
            item["id"].toString(),
            item["name"],
            item["email"],
            item["idAdministrativo"].toString(),
            item["idChofer"].toString(),
            item["avatar"]));
      }
      return data;
    } else {
      throw Exception("Falló la conexión");
    }
  }

  @override
  void initState() {
    super.initState();
    _listUsers = _getUsers();
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? LoadingPage()
        : Scaffold(
            drawer: NavBar2(),
            appBar: AppBar(
              title: Text("Basic User Crud"),
              backgroundColor: Colors.green.shade800,
            ),
            body: FutureBuilder(
              future: _listUsers,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return RefreshIndicator(
                    onRefresh: _refresh,
                    child: ListView(
                      children: _list(context, snapshot.data),
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Text("Error");
                }
                return Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                Navigator.push(context,
                        MaterialPageRoute(builder: (_) => RegisterUser()))
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

  Future<void> _refresh() {
    return Future.delayed(
      Duration(seconds: 5),
    );
  }

  List<Widget> _list(context, data) {
    List<Widget> users = [];
    for (var usr in data) {
      users.add(
        ListTile(
          onTap: () {
            Navigator.push(
                    context, MaterialPageRoute(builder: (_) => EditUser(usr)))
                .then((newUser) {
              if (newUser != null) {
                setState(() {
                  messageResponse(
                      context, newUser.id.toString() + " has been updated!");
                });
              }
            });
          },
          onLongPress: () => setState(() {
            // Here will be the deleted method
            setState(() => _isLoading = true);
            this._deleteUser(context, usr);
            setState(() => _isLoading = false);
          }),
          title: Text(usr.name),
          subtitle: Text(usr.email),
          leading: CircleAvatar(
            child: Text(usr.id.toString()),
          ),
          trailing: Icon(Icons.delete, color: Colors.red),
        ),
      );
    }
    return users;
  }

//--------------------------------- DELETE USERS ---------------------------------//
  _deleteUser(context, User user) {
    showDialog(
        context: context,
        builder: (dialogContext) => AlertDialog(
              title: Text("Delete User"),
              content: Text("¿Are you sure to delete the user " +
                  user.id.toString() +
                  "?"),
              actions: [
                TextButton(
                  onPressed: () => setState(() {
                    print(user.id.toString());
                    this.delete(user.id.toString());
                    _listUsers = _getUsers();
                    Navigator.pushNamed(dialogContext, "/user");
                  }),
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

  Future delete(id) async {
    String urls =
        "http://192.168.56.1/terminal_bimodal/public/api/users/delete/" +
            id.toString();
    print(urls);
    Uri url = Uri.parse(urls);
    final response = await http.post(url);
    if (response.statusCode == 200) {
      print("User " + id.toString() + " deleted");
    } else {
      throw Exception("Error");
    }
  }
}

class LoadingPage extends StatelessWidget {
  const LoadingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green.shade700,
      body: Center(
        child: SpinKitCircle(
          size: 140,
          duration: const Duration(seconds: 2),
          color: Colors.white,
        ),
      ),
    );
  }
}
