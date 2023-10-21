import 'dart:convert';
import 'package:cotizaciones_hdg/src/models/roles.dart';


Usuario usuarioFromJson(String str) => Usuario.fromJson(json.decode(str));

String usuarioToJson(Usuario data) => json.encode(data.toJson());

class Usuario {
  int? idUsuario;
  String? nombreUsuario;
  String? correoUsuario;
  int? telefonoUsuario;
  String? contrasenia;
  String? estadoUsuario;
  String? sessionToken;
  List<Roles> roles = [];


  Usuario({
    this.idUsuario,
    this.nombreUsuario,
    this.correoUsuario,
    this.telefonoUsuario,
    this.contrasenia,
    this.estadoUsuario,
    this.sessionToken,
    required this.roles
  });

  factory Usuario.fromJson(Map<String, dynamic> json) =>
      Usuario(
          idUsuario: json["id_usuario"],
          nombreUsuario: json["nombre_usuario"],
          correoUsuario: json["correo_usuario"],
          telefonoUsuario: json["telefono_usuario"],
          contrasenia: json["contrasenia"],
          estadoUsuario: json["estado_usuario"],
          sessionToken: json["session_token"],
          roles: json["roles"] is List
              ? (json["roles"] as List<dynamic>)
              .map((x) => Roles.fromJson(x))
              .toList()
              : []
      );

  factory Usuario.fromJson2(Map<String, dynamic> json) {
  var rolesData = json['roles'];
  List<Roles> rolesList = [];
  if (rolesData != null) {
  rolesList = List<Roles>.from(rolesData.map((model) => Roles.fromJson(model)));
  }

  return Usuario(
  idUsuario: json["id_usuario"],
  nombreUsuario: json["nombre_usuario"],
  correoUsuario: json["correo_usuario"],
  telefonoUsuario: json["telefono_usuario"],
  contrasenia: json["contrasenia"],
  estadoUsuario: json["estado_usuario"],
  sessionToken: json["session_token"],
  roles: rolesList,
  );
}

  // get sessionToken => null;

  Map<String, dynamic> toJson() => {
    "id_usuario": idUsuario,
    "nombre_usuario": nombreUsuario,
    "correo_usuario": correoUsuario,
    "telefono_usuario": telefonoUsuario,
    "contrasenia": contrasenia,
    "estado_usuario": estadoUsuario,
    "session_token": sessionToken,
    "roles": roles.map((roles) => roles.toJson()).toList(),
  };
}