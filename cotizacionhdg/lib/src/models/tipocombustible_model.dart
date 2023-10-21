import 'dart:convert';

TipoCombustible tipocombustibleFromJson(String str) => TipoCombustible.fromJson(json.decode(str));

String tipocombustibleToJson(TipoCombustible data) => json.encode(data.toJson());

class TipoCombustible{
  int? idCombustible;
  String? marcaCombustible;

  TipoCombustible({
    this.idCombustible,
    this.marcaCombustible
  });

  factory TipoCombustible.fromJson(Map<String, dynamic> json) => TipoCombustible(
      idCombustible: json["id_tipocombustible"],
      marcaCombustible: json["marca_combustible"]
  );

  Map<String, dynamic> toJson() => {
    "id_tipocombustible": idCombustible,
    "marca_combustible": marcaCombustible
  };
}