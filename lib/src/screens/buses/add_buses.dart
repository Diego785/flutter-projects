import 'package:flutter/material.dart';
import 'package:terminal_bimodal/src/connection/api.dart';
import 'package:terminal_bimodal/src/components/text_box.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

class RegisterBus extends StatefulWidget {
  @override
  State<RegisterBus> createState() => _RegisterBus();
}

class _RegisterBus extends State<RegisterBus> {
  TextEditingController controllerPlaca = new TextEditingController();
  TextEditingController controllerMarca = new TextEditingController();
  TextEditingController controllerDescripcion = new TextEditingController();
  TextEditingController controllerEstado = new TextEditingController();

  _create() async {
    var data = {
      'placa': controllerPlaca.text,
      'marca': controllerMarca.text,
      'descripcion': controllerDescripcion.text,
      'estado': controllerEstado.text,
    };

    var res = await CallApi().postData(data, 'create/buses');
    var body = json.decode(res.body);

    if (body['success'] == true) {
      Navigator.pushNamed(context, "/bus");
      print("Bus Created");
    } else {
      print("Error");
    }
  }

  @override
  void initState() {
    controllerPlaca = new TextEditingController();
    controllerMarca = new TextEditingController();
    controllerDescripcion = new TextEditingController();
    controllerEstado = new TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          AppBar(title: Text("Add Bus"), backgroundColor: Colors.green[800]),
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
                          labelText: "Placa:",
                        ),
                        controller: controllerPlaca,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: "Marca:",
                        ),
                        controller: controllerMarca,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: "Descripción:",
                        ),
                        controller: controllerDescripcion,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: "Estado:",
                        ),
                        controller: controllerEstado,
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
                            Navigator.pushNamed(context, "/bus");
                          }),
                          label: Text("Save Bus"),
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
