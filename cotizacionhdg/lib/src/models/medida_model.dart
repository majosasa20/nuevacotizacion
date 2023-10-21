import 'dart:convert';
Medida medidaFromJson(String str) => Medida.fromJson(json.decode(str));

String medidaFromJsonToJson(Medida data) => json.encode(data.toJson());

class Medida{
  int? idMedida;
  String? descripcionMedida;
  String? abreviatura;

  Medida({
    this.idMedida,
    this.descripcionMedida,
    this.abreviatura,
  });

  factory Medida.fromJson(Map<String, dynamic> json) => Medida(
      idMedida: json["id_medida"], //is int ? json['id_rol'].toString() : json["id_rol"],
      descripcionMedida: json["descripcion_medida"],
      abreviatura: json["abreviatura"]
  );

  Map<String, dynamic> toJson() => {
    "id_medida": idMedida,
    "descripcion_medida": descripcionMedida,
    "abreviatura": abreviatura
  };
}