import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:terminal_bimodal/src/models/chofer.dart';
import 'package:terminal_bimodal/src/screens/users/show_user.dart';
import 'package:terminal_bimodal/src/components/text_box.dart';

import '../../connection/api.dart';
import '../../models/user.dart';

class EditChofer extends StatefulWidget {
  final Chofer _chofer;
  EditChofer(this._chofer);

  @override
  State<EditChofer> createState() => _EditChoferState();
}

class _EditChoferState extends State<EditChofer> {
  TextEditingController controllerName = new TextEditingController();
  TextEditingController controllerCarnet = new TextEditingController();
  TextEditingController controllerTelefono = new TextEditingController();
  TextEditingController controllerSexo = new TextEditingController();
  TextEditingController controllerEdad = new TextEditingController();

  _update() async {
    var data = {
      'name': controllerName.text,
      'carnet': controllerCarnet.text,
      'telefono': controllerTelefono.text,
      'sexo': controllerSexo.text,
      'edad': controllerEdad.text,
    };

    var res =
        await CallApi().postData(data, 'update/chofers/' + widget._chofer.id);
    var body = json.decode(res.body);

    if (body['success'] == true) {
      Navigator.pushNamed(context, "/chofer");
      print("Chofer Updated");
    } else {
      print("Error");
    }
  }

  @override
  void initState() {
    Chofer u = widget._chofer;
    controllerName = new TextEditingController(text: u.name);
    controllerCarnet = new TextEditingController(text: u.carnet);
    controllerTelefono = new TextEditingController(text: u.telefono);
    controllerSexo = new TextEditingController(text: u.sexo);
    controllerEdad = new TextEditingController(text: u.edad);
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
                          labelText: "Name:",
                        ),
                        controller: controllerName,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: "Carnet:",
                        ),
                        controller: controllerCarnet,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: "Teléfono:",
                        ),
                        controller: controllerTelefono,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: "Sexo:",
                        ),
                        controller: controllerSexo,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: "Edad:",
                        ),
                        controller: controllerEdad,
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
                          label: Text("Update Chofer"),
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
