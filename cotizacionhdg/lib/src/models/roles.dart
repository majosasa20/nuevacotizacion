import 'dart:convert';

Roles rolesFromJson(String str) => Roles.fromJson(json.decode(str));

String rolesToJson(Roles data) => json.encode(data.toJson());

class Roles {
  int? idRol;
  String? descripcionRol;
  String? estadoRol;
  // int? codEmpresa;
  // List<Empresas> empresas = [];

  Roles({
    this.idRol,
    this.descripcionRol,
    this.estadoRol,
    // this.codEmpresa,
    // required this.empresas
  });

  factory Roles.fromJson(Map<String, dynamic> json) => Roles(
    idRol: json["id_rol"], //is int ? json['id_rol'].toString() : json["id_rol"],
    descripcionRol: json["descripcion_rol"],
    estadoRol: json["estado_rol"],
    // codEmpresa: json["cod_empresa"],
    //   empresas: json["empresas"] is List
    //       ? (json["empresas"] as List<dynamic>)
    //       .map((x) => Empresas.fromJson(x))
    //       .toList()
    //       : [], // Si no es una lista, inicializa como una lista vacía
    //json["empresa"] //== null ? [] : List<Empresas>.from(json['empresa'].map((model)=> Empresas.fromJson(model))) ?? []
  );

  Map<String, dynamic> toJson() => {
    "id_rol": idRol,
    "descripcion_rol": descripcionRol,
    "estado_rol": estadoRol,
    // "cod_empresa": codEmpresa,
    // "empresas": empresas
  };

  @override
  String toString() {
    return 'Roles{idRol: $idRol, descripcionRol: $descripcionRol, estadoRol: $estadoRol}';
  }

}
