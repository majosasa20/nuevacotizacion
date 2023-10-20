import 'dart:convert';
Multimedia multimediaFromJson(String str) => Multimedia.fromJson(json.decode(str));

String multimediaToJson(Multimedia data) => json.encode(data.toJson());

class Multimedia{
  int? codServicio;
  String? multimedia;

  Multimedia({
    this.codServicio,
    this.multimedia
  });

  factory Multimedia.fromJson(Map<String, dynamic> json) => Multimedia(
    codServicio: json["cod_servicio"],
    multimedia: json["archivo_multimedia"]
  );

  Map<String, dynamic> toJson() => {
    "cod_servicio": codServicio,
    "archivo_multimedia": multimedia,
  };

}