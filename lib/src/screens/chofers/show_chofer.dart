import 'package:flutter/material.dart';
import 'package:terminal_bimodal/src/models/chofer.dart';
import 'package:terminal_bimodal/src/screens/chofers/add_chofer.dart';
import 'package:terminal_bimodal/src/screens/chofers/add_chofer_bus.dart';
import 'package:terminal_bimodal/src/screens/chofers/edit_chofer.dart';
import 'package:terminal_bimodal/src/screens/navigation/nav_bar2.dart';
import 'package:terminal_bimodal/src/screens/users/add_user.dart';
import 'package:terminal_bimodal/src/screens/users/edit_user.dart';
import 'package:terminal_bimodal/src/components/message_response.dart';
import 'package:terminal_bimodal/src/screens/navigation/nav_bar.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../models/user.dart';

class ShowChoferPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ShowChoferPage();
}

List<Chofer> chofers = [];

class _ShowChoferPage extends State<ShowChoferPage> {
//--------------------------------- SHOW CHOFERS ---------------------------------//

  late Future<List<Chofer>> _listChofers;

  Future<List<Chofer>> _getChofers() async {
    Uri url =
        Uri.parse('http://192.168.56.1/terminal_bimodal/public/api/chofers');
    final response = await http.get(url);
    List<Chofer> data = [];
    if (response.statusCode == 200) {
      String body = utf8.decode(response.bodyBytes);
      final jsonData = jsonDecode(body);
      for (var item in jsonData) {
        print(item["id"]);
        data.add(Chofer(item["id"].toString(), item["name"], item["carnet"],
            item["telefono"], item["sexo"], item["edad"], item["codigoBus"]));
      }
      return data;
    } else {
      throw Exception("Falló la conexión");
    }
  }

  @override
  void initState() {
    super.initState();
    _listChofers = _getChofers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavBar2(),
      appBar: AppBar(
        title: Text("Basic Chofer Crud"),
        backgroundColor: Colors.green.shade800,
      ),
      body: FutureBuilder(
        future: _listChofers,
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
          Navigator.push(
                  context, MaterialPageRoute(builder: (_) => RegisterChofer2()))
              .then((newChofer) {
            if (newChofer != null) {
              setState(() {
                chofers.add(newChofer);
                messageResponse(
                    context, newChofer.id.toString() + " has been saved!");
              });
            }
          });
        },
        tooltip: "Agregar Chófer",
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
    List<Widget> chofers = [];
    for (var chofer in data) {
      chofers.add(
        ListTile(
          onTap: () {
            Navigator.push(context,
                    MaterialPageRoute(builder: (_) => EditChofer(chofer)))
                .then((newChofer) {
              if (newChofer != null) {
                setState(() {
                  messageResponse(
                      context, newChofer.id.toString() + " has been updated!");
                });
              }
            });
          },
          onLongPress: () {
            setState(() {
              // Here will be the deleted method
              this._deleteUser(context, chofer);
            });
          },
          title: Text("Nombre: " + chofer.name),
          subtitle: Text("Bus: " + chofer.codigoBus),
          leading: CircleAvatar(
            child: Text(chofer.id.toString()),
          ),
          trailing: Icon(Icons.delete, color: Colors.red),
        ),
      );
    }
    return chofers;
  }

//--------------------------------- DELETE USERS ---------------------------------//
  _deleteUser(context, Chofer chofer) {
    showDialog(
        context: context,
        builder: (dialogContext) => AlertDialog(
              title: Text("Delete User"),
              content: Text("¿Are you sure to delete the chofer " +
                  chofer.id.toString() +
                  "?"),
              actions: [
                TextButton(
                  onPressed: () {
                    setState(() {
                      print(chofer.id.toString());
                      this.delete(chofer.id.toString());
                      _listChofers = _getChofers();
                      Navigator.pushNamed(dialogContext, "/chofer");
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

  Future delete(id) async {
    String urls =
        "http://192.168.56.1/terminal_bimodal/public/api/chofers/delete/" +
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
