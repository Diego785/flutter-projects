class User {
  String id = "";
  String name = "";
  String email = "";
  String avatar = "";
  String idAdministrativo = "";
  String idChofer = "";

  User(id, name, email, idAdministrativo, idChofer, avatar) {
    this.id;
    this.name;
    this.email;
    this.idAdministrativo;
    this.idChofer;
    this.avatar;
  }

  User.fromJson(Map<String, dynamic> json)
      : id = json['id'].toString(),
        name = json['name'],
        email = json['email'],
        idAdministrativo = json['idAdministrativo'].toString(),
        idChofer = json['idChofer'].toString(),
        avatar = json['avatar'];
}
