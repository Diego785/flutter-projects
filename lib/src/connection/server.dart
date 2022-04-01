import 'package:flutter/material.dart';
import 'package:terminal_bimodal/src/screens/users/show_user.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:getwidget/getwidget.dart';

import '../models/user.dart';

class Connection extends StatefulWidget {
  @override
  _ConnectionState createState() => _ConnectionState();
}

class _ConnectionState extends State<Connection> {
  late Future<List<User>> _listUsers;

  //--------------------------- SHOW USERS ---------------------------------//
  Future<List<User>> _getUsers() async {
    Uri url =
        Uri.parse('http://192.168.56.1/terminal_bimodal/public/api/users');
    final response = await http.get(url);
    List<User> data = [];
    if (response.statusCode == 200) {
      String body = utf8.decode(response.bodyBytes);
      final jsonData = jsonDecode(body);
      for (var item in jsonData) {
        data.add(User(item["id"], item["name"], item["email"],
            item["administrativo"], item["chofer"], item["avatar"]));
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

  /*List<User> users = [
    User("1", "Diego", "diego2412@gmail.com", "7529345"),
  ];*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Users List"),
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
    );
  }

  List<Widget> _list(context, data) {
    List<Widget> users = [];
    for (var usr in data) {
      users.add(
        GFListTile(
          titleText: usr.id,
          subTitleText: usr.email,
          icon: Icon(Icons.delete),
          onTap: () {
            this._deleteUser(context, usr);
          },
        ),
      );
    }
    return users;
  }

  //--------------------------- DELETE USERS ---------------------------------//

  _deleteUser(context, User user) {
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              title: Text("Delete User"),
              content: Text("Are you sure?"),
              actions: [
                FlatButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("Cancel")),
                FlatButton(
                    onPressed: () => setState(() {
                          print(user.id);
                          this.delete(context, user.id);
                          _listUsers = _getUsers();
                          Navigator.pushNamed(context, "/");
                        }),
                    child: Text(
                      "Delete",
                      style: TextStyle(color: Colors.red),
                    )),
              ],
            ));
  }

  Future delete(context, id) async {
    String urls =
        "http://192.168.56.1/terminal_bimodal/public/api/users/delete/" + id;
    print(urls);
    print(id);
    Uri url = Uri.parse(urls);
    final response = await http.post(url);
    if (response.statusCode == 200) {
      print("User " + id + "deleted");
    } else {
      throw Exception("Error");
    }
  }

  Future<void> _refresh() {
    return Future.delayed(
      Duration(seconds: 5),
    );
  }

//--------------------------- ADD USERS ---------------------------------//

}
