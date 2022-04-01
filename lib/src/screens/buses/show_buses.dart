import 'package:flutter/material.dart';
import 'package:terminal_bimodal/src/models/chofer.dart';
import 'package:terminal_bimodal/src/screens/buses/add_buses.dart';
import 'package:terminal_bimodal/src/screens/buses/edit_buses.dart';
import 'package:terminal_bimodal/src/screens/chofers/add_chofer.dart';
import 'package:terminal_bimodal/src/screens/chofers/edit_chofer.dart';
import 'package:terminal_bimodal/src/screens/navigation/nav_bar2.dart';
import 'package:terminal_bimodal/src/components/message_response.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../models/bus.dart';
import '../../models/user.dart';

class ShowBusPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ShowBusPage();
}

List<Bus> buses = [];

class _ShowBusPage extends State<ShowBusPage> {
//--------------------------------- SHOW CHOFERS ---------------------------------//

  late Future<List<Bus>> _listBuses;

  Future<List<Bus>> _getBuses() async {
    Uri url =
        Uri.parse('http://192.168.56.1/terminal_bimodal/public/api/buses');
    final response = await http.get(url);
    List<Bus> data = [];
    if (response.statusCode == 200) {
      String body = utf8.decode(response.bodyBytes);
      final jsonData = jsonDecode(body);
      for (var item in jsonData) {
        print(item["codigo"]);
        data.add(Bus(item["codigo"], item["placa"], item["marca"],
            item["descripcion"], item["estado"]));
      }
      return data;
    } else {
      throw Exception("Falló la conexión");
    }
  }

  @override
  void initState() {
    super.initState();
    _listBuses = _getBuses();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavBar2(),
      appBar: AppBar(
        title: Text("Basic Bus Crud"),
        backgroundColor: Colors.green.shade800,
      ),
      body: FutureBuilder(
        future: _listBuses,
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
                  context, MaterialPageRoute(builder: (_) => RegisterBus()))
              .then((newBus) {
            if (newBus != null) {
              setState(() {
                buses.add(newBus);
                messageResponse(
                    context, newBus.codigo.toString() + " has been saved!");
              });
            }
          });
        },
        tooltip: "Agregar Bus",
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
    List<Widget> buses = [];
    for (var bus in data) {
      buses.add(
        ListTile(
          onTap: () {
            Navigator.push(
                    context, MaterialPageRoute(builder: (_) => EditBus(bus)))
                .then((newBus) {
              if (newBus != null) {
                setState(() {
                  messageResponse(
                      context, newBus.codigo.toString() + " has been updated!");
                });
              }
            });
          },
          onLongPress: () => setState(() {
            // Here will be the deleted method
            this._deleteUser(context, bus);
          }),
          title: Text(bus.placa),
          subtitle: Text(bus.marca),
          leading: CircleAvatar(
            child: Text(bus.codigo.toString()),
          ),
          trailing: Icon(Icons.delete, color: Colors.red),
        ),
      );
    }
    return buses;
  }

//--------------------------------- DELETE USERS ---------------------------------//
  _deleteUser(context, Bus bus) {
    showDialog(
        context: context,
        builder: (dialogContext) => AlertDialog(
              title: Text("Delete User"),
              content: Text("¿Are you sure to delete the user " +
                  bus.codigo.toString() +
                  "?"),
              actions: [
                TextButton(
                  onPressed: () => setState(() {
                    print(bus.codigo.toString());
                    this.delete(bus.codigo.toString());
                    _listBuses = _getBuses();
                    Navigator.pushNamed(dialogContext, "/bus");
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
        "http://192.168.56.1/terminal_bimodal/public/api/buses/delete/" +
            id.toString();
    print(urls);
    Uri url = Uri.parse(urls);
    final response = await http.post(url);
    if (response.statusCode == 200) {
      print("Bus " + id.toString() + " deleted");
    } else {
      throw Exception("Error");
    }
  }
}
