import 'dart:convert';

Ubicaciones ubicacionesFromJson(String str) => Ubicaciones.fromJson(json.decode(str));

String ubicacionesToJson(Ubicaciones data) => json.encode(data.toJson());

class Ubicaciones{
  int? idUbicacion;
  String? nombreUbicacion;

  Ubicaciones({
    this.idUbicacion,
    this.nombreUbicacion
  });

  factory Ubicaciones.fromJson(Map<String, dynamic> json) => Ubicaciones(
      idUbicacion: json["id_ubicacion"], //is int ? json['id_rol'].toString() : json["id_rol"],
      nombreUbicacion: json["nombre_ubicacion"]
  );

  Map<String, dynamic> toJson() => {
    "id_ubicacion": idUbicacion,
    "nombre_ubicacion": nombreUbicacion
  };
}