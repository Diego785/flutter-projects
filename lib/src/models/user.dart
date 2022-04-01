class User {
  String id = "";
  String name = "";
  String email = "";
  String avatar = "";
  String idAdministrativo = "";
  String idChofer = "";

  User(id, name, email, idAdministrativo, idChofer, avatar) {
    this.id = id;
    this.name = name;
    this.email = email;
    this.idAdministrativo = idAdministrativo;
    this.idChofer = idChofer;
    this.avatar = avatar;
  }
}
