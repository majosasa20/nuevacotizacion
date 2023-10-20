import 'dart:convert';
import 'dart:ffi';
import 'package:cotizaciones_hdg/src/api/enviroment.dart';
import 'package:cotizaciones_hdg/src/models/empresas_model.dart';
import 'package:cotizaciones_hdg/src/models/usuario.dart';
import 'package:cotizaciones_hdg/src/styles/shared_pref.dart';
import 'package:flutter/material.dart';
import 'package:cotizaciones_hdg/src/models/response_api.dart';
import 'package:http/http.dart' as http;

class EmpresasProvider {
  String _url = Enviroment.API_COTIZACION;
  String _api = '/api/empresas';
  Usuario? usuario;
  SharedPref _sharedPref = new SharedPref();

  BuildContext? context;
  Future? init(BuildContext context) {
    this.context = context;
  }

  // Future<ResponseApi?> getEmpresaUsuario(int idUsuario) async {
  //   try {
  //     // Construir la URL
  //     Uri url = Uri.http(_url, '$_api/getEmpresaUsuario');
  //     // print('URL DE LA SOLICITUD: $url');
  //     Map<String, String> headers = {
  //       'Content-type': 'application/json'
  //     };
  //     // print(idUsuario);
  //     // Crear un mapa con los parámetros
  //     Map<String, dynamic> params = {
  //       'cod_usuarios': idUsuario,
  //     };
  //
  //     final res = await http.post(url, headers: headers, body: json.encode(params));
  //     final data = json.decode(res.body);
  //     ResponseApi responseApi = ResponseApi.fromJson(data);
  //     return responseApi;
  //   } catch (e) {
  //     print('Error: $e');
  //     return null;
  //   }
  // }

  Future<ResponseApi?> getEmpresaUsuario(int idUsuario) async{
    try {
      Uri url =  Uri.http(_url, '$_api/getEmpresaUsuario');
      // print(idUsuario);
      String bodyParams = json.encode({
        'cod_usuarios': idUsuario
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

  Future<ResponseApi?> getEmpresasCliente() async {
    try {
      Uri url = Uri.http(_url, '$_api/getAll');
      Map<String, String> headers = {
        'Content-type': 'application/json'
      };
      final res = await http.get(url, headers: headers);
      final data = json.decode(res.body);

      // Verificar si 'data' es un mapa o una lista
      if (data is Map<String, dynamic>) {
        // Si 'data' es un mapa, lo devolvemos directamente
        return ResponseApi.fromJson(data);
      } else if (data is List<dynamic>) {
        // Si 'data' es una lista, creamos un mapa que contiene 'data'
        // Esto es para que ResponseApi.fromJson pueda manejarlo como un mapa
        final dataMap = {'data': data};
        return ResponseApi.fromJson(dataMap);
      } else {
        // Manejar cualquier otro tipo de 'data' según tus necesidades
        return null;
      }
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }


// Future<ResponseApi?> getEmpresasCliente() async{
  //   try {
  //     Uri url =  Uri.http(_url, '$_api/getAll');
  //     // print(idUsuario);
  //     // String bodyParams = json.encode({
  //     //   'cod_usuarios': idUsuario
  //     // });
  //     Map<String, String> headers = {
  //       'Content-type': 'application/json'
  //     };
  //     // final res = await http.post(url, headers: headers, body: bodyParams);
  //     final res = await http.get(url, headers: headers);
  //     final data = json.decode(res.body);
  //     ResponseApi responseApi = ResponseApi.fromJson(data);
  //     print('Respuesta: ${responseApi?.toJson()}');
  //     return responseApi;
  //   }
  //   catch(e) {
  //     print('Error: $e');
  //     return null;
  //   }
  // }

}