import 'dart:convert';
import 'package:cotizaciones_hdg/src/models/caracteristicas_model.dart';

import 'multimedia_model.dart';


Servicio servicioFromJson(String str) => Servicio.fromJson(json.decode(str));

String servicioToJson(Servicio data) => json.encode(data.toJson());

class Servicio{
  int? id_servicio;
  String? nombre;
  String? descripcion;
  int? cod_empresa;
  String? nombre_empresa;
  String? duracion;
  String? salida_ubicacion;
  String? imagenencabezado;
  double? precio;
  List<Caracteristicas> caracteristicas = [];
  List<Multimedia> multimedia = [];


  Servicio({
    this.id_servicio,
    this.nombre,
    this.descripcion,
    this.cod_empresa,
    this.duracion,
    this.salida_ubicacion,
    this.imagenencabezado,
    required this.caracteristicas,
    required this.multimedia,
    this.nombre_empresa,
    this.precio
  });

  factory Servicio.fromJson(Map<String, dynamic> json) => Servicio(
    id_servicio: json["id_servicio"],
    nombre: json["nombre"],
    descripcion: json["descripcion"],
    cod_empresa: json["cod_empresa"],
    duracion: json["duracion"],
    nombre_empresa: json["nombre_empresa"],
    salida_ubicacion: json["salida_ubicacion"],
    imagenencabezado: json["imagenencabezado"],
    precio: json["precio"],
    caracteristicas: json["caracteristicas"] is List
        ? (json["caracteristicas"] as List<dynamic>)
        .map((x) => Caracteristicas.fromJson(x))
        .toList()
        : [],
    multimedia: json["multimedia"] is List
        ? (json["multimedia"] as List<dynamic>)
        .map((x) => Multimedia.fromJson(x))
        .toList()
        : [],
  );

  // get sessionToken => null;

  Map<String, dynamic> toJson() => {
    "id_servicio": id_servicio,
    "nombre": nombre,
    "descripcion": descripcion,
    "cod_empresa": cod_empresa,
    "duracion": duracion,
    "salida_ubicacion": salida_ubicacion,
    "imagenencabezado": imagenencabezado,
    "caracteristicas": caracteristicas.map((caracteristica) => caracteristica.toJson()).toList(),
    "multimedia": multimedia.map((multimedia) => multimedia.toJson()).toList(),
    'nombre_empresa': nombre_empresa,
    'precio': precio
  };
}