import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../api/enviroment.dart';
import '../models/response_api.dart';

class EstadosCotizacionProvider{
  final _url = Enviroment.API_COTIZACION;
  final _api = '/api/estadoscotizacioin';
  BuildContext? context;
  Future? init(BuildContext context) {
    this.context = context;
    return null;
  }

  Future<ResponseApi?> getEstadosCotizacion() async {
    try {
      final url = Uri.parse('$_url$_api/getAll');
      final headers = {
        'Content-type': 'application/json'
      };
      final response = await http.get(url, headers: headers);
      if (response.statusCode == 201) {
        final data = json.decode(response.body);
        ResponseApi responseApi = ResponseApi.fromJson(data);
        print(responseApi);
        return responseApi;
        if (data is Map<String, dynamic>) {
          return ResponseApi.fromJson(data);
        } else if (data is List<dynamic>) {
          final dataMap = {'data': data};
          return ResponseApi.fromJson(dataMap);
        } else {
          return null;
        }
      } else {
        print('Error en la solicitud: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }
  // Future<ResponseApi?> getEstadosCotizacion() async {
  //   try {
  //     Uri url = Uri.http(_url, '$_api/getAll');
  //     Map<String, String> headers = {
  //       'Content-type': 'application/json'
  //     };
  //     final res = await http.get(url, headers: headers);
  //     final data = json.decode(res.body);
  //
  //     if (data is Map<String, dynamic>) {
  //       return ResponseApi.fromJson(data);
  //     } else if (data is List<dynamic>) {
  //       final dataMap = {'data': data};
  //       return ResponseApi.fromJson(dataMap);
  //     } else {
  //       return null;
  //     }
  //   } catch (e) {
  //     print('Error: $e');
  //     return null;
  //   }
  // }

}

