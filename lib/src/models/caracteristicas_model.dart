import 'dart:convert';
// import 'dart:ffi';
import 'medida_model.dart';

Caracteristicas caracteristicasFromJson(String str) => Caracteristicas.fromJson(json.decode(str));

String caracteristicasToJson(Caracteristicas data) => json.encode(data.toJson());

class Caracteristicas{
  int? idCaracteristica;
  String? descripcion;
  int? codEmpresa;
  double? precio;
  List<Medida> medidas = [];

  Caracteristicas({
    this.idCaracteristica,
    this.descripcion,
    this.codEmpresa,
    this.precio,
    required this.medidas,
  });

  factory Caracteristicas.fromJson(Map<String, dynamic> json) => Caracteristicas(
    idCaracteristica: json["id_caracteristica"], //is int ? json['id_rol'].toString() : json["id_rol"],
    descripcion: json["descripcion"],
    codEmpresa: json["cod_empresa"],
    precio: double.tryParse(json["precio"] ?? "") ?? 0.0,
    medidas: json["medidas"] is List
        ? (json["medidas"] as List<dynamic>)
        .map((x) => Medida.fromJson(x))
        .toList()
        : [],
  );

  Map<String, dynamic> toJson() => {
    "id_caracteristica": idCaracteristica,
    "descripcion": descripcion,
    "cod_empresa": codEmpresa,
    "precio": precio,
    "medidas": medidas.map((medidas) => medidas.toJson()).toList(),
  };
}