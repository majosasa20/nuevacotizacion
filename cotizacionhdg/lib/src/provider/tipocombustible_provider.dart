import 'dart:convert';
import 'package:cotizaciones_hdg/src/api/enviroment.dart';
import 'package:flutter/material.dart';
import 'package:cotizaciones_hdg/src/models/response_api.dart';
import 'package:http/http.dart' as http;

class TipoCombustibleProvider {
  final _url ="https://cotizaciones-hdg.onrender.com"; //Enviroment.API_COTIZACION;
  final _api = '/api/tipocombustible';

  BuildContext? context;
  Future? init(BuildContext context) {
    this.context = context;
  }

  Future<ResponseApi?> getCombustiblebyUbicacion(int idUbicacion) async {
    // print(idUbicacion);
    try {
      final url =  Uri.parse('$_url$_api/getCombustiblebyUbicacion');
      // print(idUsuario);
      final bodyParams = json.encode({
        'cod_ubicacion': idUbicacion
      });
      final headers = {
        'Content-Type': 'application/json',
      };
      final response = await http.post(url, headers: headers, body: bodyParams);
      if (response.statusCode == 201) {
        final data = json.decode(response.body);
        ResponseApi responseApi = ResponseApi.fromJson(data);
        print(responseApi);
        return responseApi;
      } else {
        // Puedes manejar los diferentes códigos de estado aquí
        print('Error en la solicitud: ${response.statusCode}');
        return null;
      }
    }
    catch(e) {
      print('Error: $e');
      return null;
    }
  }
  // Future<ResponseApi?> getCombustiblebyUbicacion(int idUbicacion) async {
  //   // print(idUbicacion);
  //   try {
  //     Uri url =  Uri.http(_url, '$_api/getCombustiblebyUbicacion');
  //     // print(idUsuario);
  //     String bodyParams = json.encode({
  //       'cod_ubicacion': idUbicacion
  //     });
  //     Map<String, String> headers = {
  //       'Content-type': 'application/json'
  //     };
  //     final res = await http.post(url, headers: headers, body: bodyParams);
  //     final data = json.decode(res.body);
  //     ResponseApi responseApi = ResponseApi.fromJson(data);
  //     // print('Respuesta: ${responseApi?.toJson()}');
  //     return responseApi;
  //   }
  //   catch(e) {
  //     print('Error: $e');
  //     return null;
  //   }
  // }


}