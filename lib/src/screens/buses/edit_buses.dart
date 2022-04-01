import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:terminal_bimodal/src/models/bus.dart';
import 'package:terminal_bimodal/src/models/chofer.dart';
import 'package:terminal_bimodal/src/screens/users/show_user.dart';
import 'package:terminal_bimodal/src/components/text_box.dart';

import '../../connection/api.dart';
import '../../models/user.dart';

class EditBus extends StatefulWidget {
  final Bus _bus;
  EditBus(this._bus);

  @override
  State<EditBus> createState() => _EditBusState();
}

class _EditBusState extends State<EditBus> {
  TextEditingController controllerPlaca = new TextEditingController();
  TextEditingController controllerMarca = new TextEditingController();
  TextEditingController controllerDescripcion = new TextEditingController();
  TextEditingController controllerEstado = new TextEditingController();

  _update() async {
    var data = {
      'placa': controllerPlaca.text,
      'marca': controllerMarca.text,
      'descripcion': controllerDescripcion.text,
      'estado': controllerEstado.text,
    };

    var res =
        await CallApi().postData(data, 'update/buses/' + widget._bus.codigo);
    var body = json.decode(res.body);

    if (body['success'] == true) {
      Navigator.pushNamed(context, "/bus");
      print("Bus Updated");
    } else {
      print("Error");
    }
  }

  @override
  void initState() {
    Bus u = widget._bus;
    controllerPlaca = new TextEditingController(text: u.placa);
    controllerMarca = new TextEditingController(text: u.marca);
    controllerDescripcion = new TextEditingController(text: u.descripcion);
    controllerEstado = new TextEditingController(text: u.estado);
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
                            Navigator.pushNamed(context, "/bus");
                          }),
                          label: Text("Update Bus"),
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
