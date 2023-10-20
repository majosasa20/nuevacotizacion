import 'dart:convert';

EstadosCotizacion estadosFromJson(String str) => EstadosCotizacion.fromJson(json.decode(str));

String estadosToJson(EstadosCotizacion data) => json.encode(data.toJson());

class EstadosCotizacion {
  int? idEstado;
  String? descripcionEstado;

  EstadosCotizacion({
    this.idEstado,
    this.descripcionEstado,
  });

  factory EstadosCotizacion.fromJson(Map<String, dynamic> json) => EstadosCotizacion(
    idEstado: json["id_estado_cotizacion"], //is int ? json['id_Estado'].toString() : json["id_Estado"],
    descripcionEstado: json["descripcion_estado"],
  );

  Map<String, dynamic> toJson() => {
    "id_estado_cotizacion": idEstado,
    "descripcion_estado": descripcionEstado,
  };

  @override
  String toString() {
    return 'Estados{idEstado: $idEstado, descripcionEstado: $descripcionEstado}';
  }

}
