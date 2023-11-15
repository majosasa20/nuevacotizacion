import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:cotizaciones_hdg/src/models/response_api.dart';
import 'package:http/http.dart' as http;

import '../models/cotizacion_model.dart';
import '../styles/my_snackbar.dart';

class EnviarCorreoProvider {
  final _url = "https://cotizaciones-hdg.onrender.com"; //Enviroment.API_COTIZACION;
  final _api = '/api/enviarCorreos';

  BuildContext? context;

  Future? init(BuildContext context) {
    this.context = context;
  }

  Future<ResponseApi?> postCorreoCrearCotizacion(Cotizacion cotizacion) async {
    try {
      final url = Uri.parse('$_url$_api/CotizacionCreada');
      final bodyParams = json.encode(cotizacion);
      final headers = {
        'Content-type': 'application/json'
      };
      final response = await http.post(url, headers: headers, body: bodyParams);
      if (response.statusCode == 201) {
        final data = json.decode(response.body);
        ResponseApi responseApi = ResponseApi.fromJson(data);
        print(responseApi);
        return responseApi;
      } else {
        print('Error en la solicitud: ${response.statusCode}');
        return null;
      }
    }
    catch(e) {
      print('Error: $e');
      return null;
    }
  }
}