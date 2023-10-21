import 'dart:convert';
import 'dart:ffi';
import 'package:cotizaciones_hdg/src/api/enviroment.dart';
import 'package:cotizaciones_hdg/src/models/cotizacion_model.dart';
import 'package:flutter/material.dart';
import 'package:cotizaciones_hdg/src/models/response_api.dart';
import 'package:http/http.dart' as http;

class CotizacionesProvider {
  final _url = Enviroment.API_COTIZACION;
  final _api = '/api/cotizaciones';

  BuildContext? context;
  Future? init(BuildContext context) {
    this.context = context;
  }

  Future<ResponseApi?> crearCotizacion(Cotizacion cotizacion) async{
    print(cotizacion.observaciones);
    try {
      final url = Uri.parse('$_url$_api/crearCotizacion');
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
  // Future<ResponseApi?> crearCotizacion(Cotizacion cotizacion) async{
  //   print(cotizacion.observaciones);
  //   try {
  //     Uri url = Uri.http(_url, '$_api/crearCotizacion');
  //     String bodyParams = json.encode(cotizacion);
  //     Map<String, String> headers = {
  //       'Content-type': 'application/json'
  //     };
  //     final res = await http.post(url, headers: headers, body: bodyParams);
  //     final data = json.decode(res.body);
  //     ResponseApi responseApi = ResponseApi.fromJson(data);
  //     print(responseApi);
  //     return responseApi;
  //   }
  //   catch(e) {
  //     print('Error: $e');
  //     return null;
  //   }
  // }

  Future<ResponseApi?> editarCotizacion(int idEstadoCotizacion,int idCotizacion,int idEmpresa,int idServicio, int idUsuario) async{
    // print(cotizacion);
    try {
      final url = Uri.parse('$_url$_api/actualizarCotizacion');
      final bodyParams = json.encode({
        'cod_estado': idEstadoCotizacion.toString(),
        'id_cotizacion': idCotizacion.toString(),
        'cod_empresa': idEmpresa.toString(),
        'cod_servicio': idServicio.toString(),
        'id_usuario': idUsuario.toString(),
      });
      final headers = {
        'Content-type': 'application/json'
      };
      final response = await http.put(url, headers: headers, body: bodyParams);
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
  // Future<ResponseApi?> editarCotizacion(int idEstadoCotizacion,int idCotizacion,int idEmpresa,int idServicio, int idUsuario) async{
  //   // print(cotizacion);
  //   try {
  //     Uri url = Uri.http(_url, '$_api/actualizarCotizacion');
  //     String bodyParams = json.encode({
  //       'cod_estado': idEstadoCotizacion.toString(),
  //       'id_cotizacion': idCotizacion.toString(),
  //       'cod_empresa': idEmpresa.toString(),
  //       'cod_servicio': idServicio.toString(),
  //       'id_usuario': idUsuario.toString(),
  //     });
  //     Map<String, String> headers = {
  //       'Content-type': 'application/json'
  //     };
  //     final res = await http.put(url, headers: headers, body: bodyParams);
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

  Future<ResponseApi?> getCotizacionesEmpresa(int codEmpresa) async {
    // print('empresa: $codEmpresa');
    try {
      final urinicio = Uri.parse('$_url$_api/getCotizacionesEmpresa');
      final urlBase = urinicio.toString();
      final codEmpresaParam = 'cod_empresa=${codEmpresa.toString()}';
      final fullurl = '$urlBase?$codEmpresaParam';
      final url = Uri.parse(fullurl);
      // print('url completa: $url');
      final headers = {
        'Content-type': 'application/json'
      };
      final response = await http.get(url, headers: headers);
      if (response.statusCode == 201) {
        final data = json.decode(response.body);
        ResponseApi responseApi = ResponseApi.fromJson(data);
        print(responseApi);
        return responseApi;
      } else {
        print('Error en la solicitud: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }
  // Future<ResponseApi?> getCotizacionesEmpresa(int codEmpresa) async {
  //   print('empresa: $codEmpresa');
  //   try {
  //     Uri urinicio = Uri.http(_url, '$_api/getCotizacionesEmpresa');
  //     String urlBase = urinicio.toString();
  //     String codEmpresaParam = 'cod_empresa=${codEmpresa.toString()}';
  //     String fullurl = '$urlBase?$codEmpresaParam';
  //     Uri url = Uri.parse(fullurl);
  //     // print('url completa: $url');
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

  Future<ResponseApi?> getCotizacionesCliente(int codUsuario) async {
    // print('empresa: $codEmpresa');
    try {
      final urinicio = Uri.parse('$_url$_api/getCotizacionesUsuario');
      final urlBase = urinicio.toString();
      final codUsuarioParam = 'cod_usuario=${codUsuario.toString()}';
      final fullurl = '$urlBase?$codUsuarioParam';
      final url = Uri.parse(fullurl);
      // print('url completa: $url');
      final headers = {
        'Content-type': 'application/json'
      };
      final response = await http.get(url, headers: headers);
      if (response.statusCode == 201) {
        final data = json.decode(response.body);
        ResponseApi responseApi = ResponseApi.fromJson(data);
        print(responseApi);
        return responseApi;
      } else {
        print('Error en la solicitud: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }

  Future<ResponseApi?> getCotizacionById(int idCotizacion) async{
    try {
      final urinicio = Uri.parse('$_url$_api/getCotizacionById'); //, {'cod_empresa': codEmpresa.toString()});
      final urlBase = urinicio.toString();
      final idCotizacionParam = 'id_cotizacion=${idCotizacion.toString()}';
      final fullurl = '$urlBase?$idCotizacionParam';
      final url = Uri.parse(fullurl);
      final headers = {
        'Content-type': 'application/json'
      };
      final response = await http.get(url, headers: headers);
      if (response.statusCode == 201) {
        final data = json.decode(response.body);
        ResponseApi responseApi = ResponseApi.fromJson(data);
        print(responseApi);
        return responseApi;
      } else {
        print('Error en la solicitud: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }
  // Future<ResponseApi?> getCotizacionById(int idCotizacion) async{
  //   try {
  //     Uri urinicio = Uri.http(_url, '$_api/getCotizacionById'); //, {'cod_empresa': codEmpresa.toString()});
  //     String urlBase = urinicio.toString();
  //     String idCotizacionParam = 'id_cotizacion=${idCotizacion.toString()}';
  //     String fullurl = '$urlBase?$idCotizacionParam';
  //     Uri url = Uri.parse(fullurl);
  //     Map<String, String> headers = {
  //       'Content-type': 'application/json'
  //     };
  //     final res = await http.get(url, headers: headers);
  //     final data = json.decode(res.body);
  //     ResponseApi responseApi = ResponseApi.fromJson(data);
  //     print('Respuesta: ${responseApi.toJson()}');
  //     return responseApi;
  //   } catch (e) {
  //     print('Error: $e');
  //     return null;
  //   }
  // }

}