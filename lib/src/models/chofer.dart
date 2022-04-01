class Chofer {
  String id = "";
  String name = "";
  String carnet = "";
  String telefono = "";
  String sexo = "";
  String edad = "";
  String? codigoBus = "";

  Chofer(id, name, carnet, telefono, sexo, edad, codigoBus) {
    this.id = id;
    this.name = name;
    this.carnet = carnet;
    this.telefono = telefono;
    this.sexo = sexo;
    this.edad = edad.toString();
    this.codigoBus = codigoBus.toString();
  }
}
