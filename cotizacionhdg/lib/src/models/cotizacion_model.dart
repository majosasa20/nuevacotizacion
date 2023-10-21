import 'dart:convert';

import 'package:intl/intl.dart';

Cotizacion cotizacionFromJson(String str) => Cotizacion.fromJson(json.decode(str));

String cotizacionToJson(Cotizacion data) => json.encode(data.toJson());

class Cotizacion {
  int? id_cotizacion;
  int? cod_empresa;
  String? nombre_empresa;
  String? destino;
  String? observaciones;
  int? id_usuario;
  int? cod_servicio;
  int? cod_aeronave;
  int? caracteristica;
  String? descripcionCaracteristica;
  int? cantidad;
  double? precio;
  DateTime? fechaservicio;
  DateTime? fechacotizacion;
  String? nombreServicio;
  String? nombreUsuario;
  String? correoUsuario;
  int? telefonoUsuario;
  String? descripcionestado;

  Cotizacion(
      {this.id_cotizacion,
        this.cod_empresa,
        this.nombre_empresa,
      this.destino,
      this.observaciones,
      this.id_usuario,
      this.cod_servicio,
      this.cod_aeronave,
      this.caracteristica,
      this.cantidad,
      this.precio,
      this.fechaservicio,
      this.fechacotizacion,
      this.nombreServicio,
      this.nombreUsuario,
      this.correoUsuario,
      this.telefonoUsuario,
      this.descripcionestado,
      this.descripcionCaracteristica,
      }
      );

  factory Cotizacion.fromJson(Map<String, dynamic> json) => Cotizacion(
      id_cotizacion: json["id_cotizacion"],
      cod_empresa: json["cod_empresa"],
      nombre_empresa: json["nombre_empresa"],
      destino: json["destino"],
      observaciones: json["observaciones"],
      id_usuario: json["id_usuario"],
      cod_servicio: json["cod_servicio"],
      cod_aeronave: json["cod_aeronave"],
      caracteristica: json["caracteristica"],
      cantidad: json["cantidad"],
      precio: double.tryParse(json["precio"] ?? "") ?? 0.0,
      fechaservicio: DateFormat('yyyy-MM-dd HH:mm').parse(json["fecha_servicio"]),
      fechacotizacion: DateFormat('yyyy-MM-dd HH:mm').parse(json["fecha_cotizacion"]),
      nombreServicio: json["servicio"],
      nombreUsuario: json["nombre_usuario"],
      correoUsuario: json["correo_usuario"],
      telefonoUsuario: json["telefono_usuario"],
      descripcionestado: json["descripcion_estado"],
      descripcionCaracteristica: json["descripcion_caracteristica"]
  );

  // get sessionToken => null;

  Map<String, dynamic> toJson() {
    return {
      'id_cotizacion': id_cotizacion,
      'cod_empresa': cod_empresa,
      "nombre_empresa": nombre_empresa,
      'destino': destino,
      'observaciones': observaciones,
      'id_usuario': id_usuario,
      'cod_servicio': cod_servicio,
      'cod_aeronave': cod_aeronave,
      'caracteristica': caracteristica,
      'cantidad': cantidad,
      'precio': precio,
      'fecha_servicio': fechaservicio?.toIso8601String(),
      'fecha_cotizacion': fechacotizacion?.toIso8601String(),
      'servicio': nombreServicio,
      'nombre_usuario': nombreUsuario,
      'correo_usuario': correoUsuario,
      'telefono_usuario': telefonoUsuario,
      'descripcion_estado': descripcionestado,
      'descripcion_caracteristica': descripcionCaracteristica
    };
  }

}
