import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../api/enviroment.dart';
import '../models/response_api.dart';

class EstadosCotizacionProvider{
  String _url = Enviroment.API_COTIZACION;
  String _api = '/api/estadoscotizacioin';

  BuildContext? context;
  Future? init(BuildContext context) {
    this.context = context;
  }

  Future<ResponseApi?> getEstadosCotizacion() async {
    try {
      Uri url = Uri.http(_url, '$_api/getAll');
      Map<String, String> headers = {
        'Content-type': 'application/json'
      };
      final res = await http.get(url, headers: headers);
      final data = json.decode(res.body);

      if (data is Map<String, dynamic>) {
        return ResponseApi.fromJson(data);
      } else if (data is List<dynamic>) {
        final dataMap = {'data': data};
        return ResponseApi.fromJson(dataMap);
      } else {
        return null;
      }
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }

}

