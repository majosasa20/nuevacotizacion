import 'dart:convert';
import 'package:cotizaciones_hdg/src/api/enviroment.dart';
import 'package:flutter/material.dart';
import 'package:cotizaciones_hdg/src/models/response_api.dart';
import 'package:http/http.dart' as http;

class UbicacionesProvider {
  final _url = Enviroment.API_COTIZACION;
  final _api = '/api/ubicaciones';

  BuildContext? context;
  Future? init(BuildContext context) {
    this.context = context;
  }

  Future<ResponseApi?> getUbicaciones() async{
    try {
      final url =  Uri.parse('$_url$_api/getAll');
      final headers = {
        'Content-Type': 'application/json',
      };
      final response = await http.get(url, headers: headers);
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
  // Future<ResponseApi?> getUbicaciones() async{
  //   try {
  //     Uri url =  Uri.http(_url, '$_api/getAll');
  //     Map<String, String> headers = {
  //       'Content-type': 'application/json'
  //     };
  //     final res = await http.get(url, headers: headers);
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