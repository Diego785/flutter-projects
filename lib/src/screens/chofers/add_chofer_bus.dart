import 'package:flutter/material.dart';
import 'package:terminal_bimodal/src/connection/api.dart';
import 'package:terminal_bimodal/src/components/text_box.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

@immutable
class Bus {
  const Bus({
    required this.codigo,
    required this.placa,
    required this.marca,
    required this.estado,
  });
  final String codigo;
  final String placa;
  final String marca;
  final String estado;

  @override
  String toString() {
    return '$codigo, $placa, $marca, $estado';
  }

  @override
  bool operator ==(Object other) {
    if (other.runtimeType != runtimeType) {
      return false;
    }
    return other is Bus &&
        other.codigo == codigo &&
        other.placa == placa &&
        other.marca == marca &&
        other.estado == estado;
  }

  @override
  int get hashCode => hashValues(codigo, placa, marca, estado);
}

class RegisterChofer2 extends StatefulWidget {
  @override
  State<RegisterChofer2> createState() => _RegisterChofer2();
}

class _RegisterChofer2 extends State<RegisterChofer2> {
  /*static const List<Bus> _busOptions = <Bus>[
    Bus(
      codigo: "9",
      placa: '4443LGH',
      marca: 'Audi',
      estado: 'Buen Estado',
    ),
    Bus(
      codigo: "10",
      placa: '9584KFJ',
      marca: 'Ferrari',
      estado: 'Mantenimiento',
    ),
  ];*/

  static String _displayStringForOption(Bus option) => option.placa;

  late Future<List<Bus>> _listBuses;
  List<Bus> _busOptions = [];
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
        data.add(Bus(
            codigo: item["codigo"].toString(),
            placa: item["placa"],
            marca: item["marca"],
            estado: item["estado"]));
      }
      return data;
    } else {
      throw Exception("Falló la conexión");
    }
  }

  void convert() async {
    _listBuses = _getBuses();
    _busOptions = await _listBuses;
  }

  TextEditingController controllerName = new TextEditingController();
  TextEditingController controllerCarnet = new TextEditingController();
  TextEditingController controllerTelefono = new TextEditingController();
  TextEditingController controllerSexo = new TextEditingController();
  TextEditingController controllerEdad = new TextEditingController();
  TextEditingController controllerCodigoBus = new TextEditingController();
  TextEditingValue textEditingValue = new TextEditingValue();

  _create() async {
    var data = {
      'name': controllerName.text,
      'carnet': controllerCarnet.text,
      'telefono': controllerTelefono.text,
      'sexo': controllerSexo.text,
      'edad': controllerEdad.text,
      'codigoBus': controllerCodigoBus.text
    };

    var res = await CallApi().postData(data, 'create/chofers');
    var body = json.decode(res.body);

    print(data);

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
    controllerCodigoBus = new TextEditingController();
    _listBuses = _getBuses();
    convert();
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
                      Autocomplete<Bus>(
                        displayStringForOption: _displayStringForOption,
                        optionsBuilder: (textEditingValue) {
                          if (textEditingValue.text == '') {
                            return const Iterable<Bus>.empty();
                          }
                          return _busOptions.where((Bus option) {
                            return option
                                .toString()
                                .contains(textEditingValue.text.toLowerCase());
                          });
                        },
                        onSelected: (Bus selection) {
                          debugPrint(
                              'You just selected ${_displayStringForOption(selection)}');
                          controllerCodigoBus.text =
                              selection.codigo.toString();
                        },
                      ),
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
