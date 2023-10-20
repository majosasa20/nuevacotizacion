import 'dart:convert';
import 'package:cotizaciones_hdg/src/api/enviroment.dart';
import 'package:flutter/material.dart';
import 'package:cotizaciones_hdg/src/models/response_api.dart';
import 'package:http/http.dart' as http;

class TipoCombustibleProvider {
  String _url = Enviroment.API_COTIZACION;
  String _api = '/api/tipocombustible';

  BuildContext? context;
  Future? init(BuildContext context) {
    this.context = context;
  }


  // Future<ResponseApi?> getCombustiblebyUbicacion(int idUbicacion) async{
  //   print(idUbicacion);
  //   try {
  //     Uri urinicio = Uri.http(_url, '$_api/getCombustiblebyUbicacion');
  //     String urlBase = urinicio.toString();
  //     String codUbicacionParam = 'cod_ubicacion=${idUbicacion.toString()}';
  //     String fullurl = '$urlBase?$codUbicacionParam';
  //     Uri url = Uri.parse(fullurl);
  //     print('url completa: $url');
  //     Map<String, String> headers = {
  //       'Content-type': 'application/json'
  //     };
  //     final res = await http.get(url, headers: headers);
  //     final data = json.decode(res.body);
  //     ResponseApi responseApi = ResponseApi.fromJson(data);
  //     // print('Respuesta: ${responseApi?.toJson()}');
  //     return responseApi;
  //   } catch (e) {
  //     print('Error: $e');
  //     return null;
  //   }
  // }

  Future<ResponseApi?> getCombustiblebyUbicacion(int idUbicacion) async {
    // print(idUbicacion);
    try {
      Uri url =  Uri.http(_url, '$_api/getCombustiblebyUbicacion');
      // print(idUsuario);
      String bodyParams = json.encode({
        'cod_ubicacion': idUbicacion
      });
      Map<String, String> headers = {
        'Content-type': 'application/json'
      };
      final res = await http.post(url, headers: headers, body: bodyParams);
      final data = json.decode(res.body);
      ResponseApi responseApi = ResponseApi.fromJson(data);
      // print('Respuesta: ${responseApi?.toJson()}');
      return responseApi;
    }
    catch(e) {
      print('Error: $e');
      return null;
    }
  }


}