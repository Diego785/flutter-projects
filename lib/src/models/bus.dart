class Bus {
  String codigo = "";
  String placa = "";
  String marca = "";
  String? descripcion = "";
  String estado = "";

  Bus(codigo, placa, marca, descripcion, estado) {
    this.codigo = codigo.toString();
    this.placa = placa;
    this.marca = marca;
    this.descripcion = descripcion;
    this.estado = estado;
  }
}
