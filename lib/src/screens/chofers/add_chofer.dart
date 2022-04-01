import 'package:flutter/material.dart';
import 'package:terminal_bimodal/src/connection/api.dart';
import 'package:terminal_bimodal/src/components/text_box.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

class RegisterChofer extends StatefulWidget {
  @override
  State<RegisterChofer> createState() => _RegisterChofer();
}

class _RegisterChofer extends State<RegisterChofer> {
  TextEditingController controllerName = new TextEditingController();
  TextEditingController controllerCarnet = new TextEditingController();
  TextEditingController controllerTelefono = new TextEditingController();
  TextEditingController controllerSexo = new TextEditingController();
  TextEditingController controllerEdad = new TextEditingController();

  _create() async {
    var data = {
      'name': controllerName.text,
      'carnet': controllerCarnet.text,
      'telefono': controllerTelefono.text,
      'sexo': controllerSexo.text,
      'edad': controllerEdad.text,
    };

    var res = await CallApi().postData(data, 'create/chofers');
    var body = json.decode(res.body);

    if (body['success'] == true) {
      Navigator.pushNamed(context, "/chofer");
      print("Chofer Created");
    } else {
      print("Error");
    }
  }

  @override
  void initState() {
    controllerName = new TextEditingController();
    controllerCarnet = new TextEditingController();
    controllerTelefono = new TextEditingController();
    controllerSexo = new TextEditingController();
    controllerEdad = new TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          AppBar(title: Text("Add Chofer"), backgroundColor: Colors.green[800]),
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
                        keyboardType: TextInputType.number,
                        controller: controllerEdad,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: "Código de Bus:",
                        ),
                        controller: controllerSexo,
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
                            Navigator.pushNamed(context, "/chofer");
                          }),
                          label: Text("Save Chófer"),
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
