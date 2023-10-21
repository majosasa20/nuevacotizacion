import 'dart:convert';
import 'dart:ffi';
import 'package:cotizaciones_hdg/src/api/enviroment.dart';
import 'package:cotizaciones_hdg/src/models/caracteristicas_model.dart';
import 'package:flutter/material.dart';
import 'package:cotizaciones_hdg/src/models/response_api.dart';
import 'package:http/http.dart' as http;

class CaracteristicasProvider {
  String _url = Enviroment.API_COTIZACION;
  String _api = '/api/caracteristicas';

  BuildContext? context;

  Future? init(BuildContext context) {
    this.context = context;
  }

  Future<ResponseApi?> getCaracteristicasEmpresa(int codEmpresa) async {
    // print('empresa: $codEmpresa');
    try {
      Uri urinicio = Uri.http(_url, '$_api/getCaracteristicasEmpresa'); //, {'cod_empresa': codEmpresa.toString()});
      String urlBase = urinicio.toString();
      String codEmpresaParam = 'cod_empresa=${codEmpresa.toString()}';
      String fullurl = '$urlBase?$codEmpresaParam';
      Uri url = Uri.parse(fullurl);
      // print('url completa: $url');
      Map<String, String> headers = {
        'Content-type': 'application/json'
      };
      final res = await http.get(url, headers: headers);
      final data = json.decode(res.body);
      ResponseApi responseApi = ResponseApi.fromJson(data);
      // print('Respuesta: ${responseApi?.toJson()}');
      return responseApi;
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }

  Future<ResponseApi?> getCaracteristicaById(int idCaracteristica) async {
    try {
      Uri urinicio = Uri.http(_url, '$_api/getCaracteristicasByid'); //, {'cod_empresa': codEmpresa.toString()});
      String urlBase = urinicio.toString();
      String idCaracteristicaParam = 'id_caracteristica=${idCaracteristica.toString()}';
      String fullurl = '$urlBase?$idCaracteristicaParam';
      Uri url = Uri.parse(fullurl);
      // print('url completa: $url');
      Map<String, String> headers = {
        'Content-type': 'application/json'
      };
      final res = await http.get(url, headers: headers);
      final data = json.decode(res.body);
      ResponseApi responseApi = ResponseApi.fromJson(data);
      print('Respuesta: ${responseApi?.toJson()}');
      return responseApi;
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }

  Future<ResponseApi?> eliminarCaracteristica(int idCaracteristica, int idEmpresa) async{
    print('caracteristica: $idCaracteristica, Empresa: $idEmpresa');
    try {
      Uri url = Uri.http(_url, '$_api/eliminarCaracteristica');
      String bodyParams = json.encode({
        'id_caracteristica': idCaracteristica.toString(),
        'cod_empresa': idEmpresa.toString(),
      });
      Map<String, String> headers = {
        'Content-type': 'application/json'
      };
      final res = await http.delete(url, headers: headers, body: bodyParams);
      final data = json.decode(res.body);
      ResponseApi responseApi = ResponseApi.fromJson(data);
      return responseApi;
    }
    catch(e) {
      print('Error: $e');
      return null;
    }
  }


  Future<ResponseApi?> crearCaracteristica(String descripcion, int empresa, double? precio, int medida) async{
    print('$descripcion $empresa $precio $medida');
    try {
      Uri url = Uri.http(_url, '$_api/crearCaracteristica');
      String bodyParams = json.encode({
        'descripcion': descripcion.toString(),
        'cod_empresa': empresa.toString(),
        'precio': precio.toString(),
        'medida': medida.toString(),
      });
      Map<String, String> headers = {
        'Content-type': 'application/json'
      };
      final res = await http.post(url, headers: headers, body: bodyParams);
      final data = json.decode(res.body);
      ResponseApi responseApi = ResponseApi.fromJson(data);
      return responseApi;
    }
    catch(e) {
      print('Error: $e');
      return null;
    }
  }

  Future<ResponseApi?> editarCaracteristica(int idCaracteristica,String descripcion, int empresa, double? precio, int medida) async{
    print('$descripcion $empresa $precio $medida');
    try {
      Uri url = Uri.http(_url, '$_api/editarCaracteristica');
      String bodyParams = json.encode({
        'descripcion': descripcion.toString(),
        'cod_empresa': empresa.toString(),
        'precio': precio.toString(),
        'medida': medida.toString(),
        'id_caracteristica': idCaracteristica.toString()
      });
      Map<String, String> headers = {
        'Content-type': 'application/json'
      };
      final res = await http.put(url, headers: headers, body: bodyParams);
      final data = json.decode(res.body);
      ResponseApi responseApi = ResponseApi.fromJson(data);
      return responseApi;
    }
    catch(e) {
      print('Error: $e');
      return null;
    }
  }


}