import 'dart:convert';


Empresas empresasFromJson(String str) => Empresas.fromJson(json.decode(str));

String empresasToJson(Empresas data) => json.encode(data.toJson());

class Empresas {
  int? idEmpresa;
  String? nombreEmpresa;
  String? estadoEmpresa;
  String? imagen;


  Empresas({
    this.idEmpresa,
    this.nombreEmpresa,
    this.estadoEmpresa,
    this.imagen,
  });

  factory Empresas.fromJson(Map<String, dynamic> json) => Empresas(
    idEmpresa: json['id_empresa'], //json["id_rol"] is int ? json['id_rol'].toString() : ,
    nombreEmpresa: json["nombre_empresa"],
    estadoEmpresa: json["estado_empresa"],
    imagen: json["imagen"],
  );

  // factory Empresas.fromJson(dynamic json) {
  //   if (json is Map<String, dynamic>) {
  //     // Si json es un mapa, extraemos los valores como se haría normalmente
  //     return Empresas(
  //       idEmpresa: json['nombre'],
  //       nombreEmpresa: json['direccion'],
  //       estadoEmpresa: json["estado_empresa"],
  //       imagen: json["imagen"],
  //     );
  //   } else if (json is List<dynamic>) {
  //     // Si json es una lista, usamos el constructor fromList
  //     return Empresas.fromList(json);
  //   } else {
  //     return Empresas(
  //       idEmpresa: 0,
  //       nombreEmpresa: '',
  //       estadoEmpresa: '',
  //       imagen: '',
  //     );
  //   }
  // }
  //
  // // Constructor para crear una instancia de Empresas desde una lista
  // factory Empresas.fromList(List<dynamic> jsonList) {
  //   if (jsonList.length >= 2) {
  //     return Empresas(
  //         idEmpresa: jsonList[0],
  //         nombreEmpresa: jsonList[1],
  //         estadoEmpresa: jsonList[2],
  //         imagen: jsonList[3]
  //     );
  //   } else {
  //     return Empresas(
  //       idEmpresa: 0,
  //       nombreEmpresa: '',
  //       estadoEmpresa: '',
  //       imagen: '',
  //     );
  //   }
  // }

  Map<String, dynamic> toJson() => {
    "id_empresa": idEmpresa,
    "nombre_empresa": nombreEmpresa,
    "estado_empresa": estadoEmpresa,
    "imagen": imagen,
  };

}
