import 'dart:convert';
import 'dart:ffi';
import 'package:cotizaciones_hdg/src/api/enviroment.dart';
import 'package:cotizaciones_hdg/src/models/usuario.dart';
import 'package:flutter/material.dart';
import 'package:cotizaciones_hdg/src/models/response_api.dart';
import 'package:http/http.dart' as http;

class UsuariosProvider {
  String _url = Enviroment.API_COTIZACION;
  String _api = '/api/usuarios';

  BuildContext? context;
  Future? init(BuildContext context) {
    this.context = context;
  }
  Future<ResponseApi?> create(Usuario usuario) async{
    try {
      Uri url = Uri.http(_url, '$_api/create');
      String bodyParams = json.encode(usuario);
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

  Future<ResponseApi?> login(String email, String password) async{
    try {
      Uri url =  Uri.http(_url, '$_api/login');
      String bodyParams = json.encode({
        'correo_usuario': email,
        'contrasenia': password
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

  Future<ResponseApi?> acceso(Int cod_usuarios) async{
    try {
      Uri url =  Uri.http(_url, '$_api/login');
      String bodyParams = json.encode({
        'cod_usuarios': cod_usuarios
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

  Future<ResponseApi?> getUsuariosEmpresa(int codEmpresa) async {
    print('empresa: $codEmpresa');
    try {
      Uri urinicio = Uri.http(_url, '$_api/UsuarioEmpresa');
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

  Future<ResponseApi?> agregarUsuario(String nombre, String correo, int? telefono, int rol, int? empresa) async{
    try {
      Uri url = Uri.http(_url, '$_api/agregar');
      String bodyParams = json.encode({
        'nombre_usuario': nombre.toString(),
        'cod_empresa': empresa.toString(),
        'correo_usuario': correo.toString(),
        'telefono_usuario': telefono.toString(),
        'cod_rol': rol.toString()
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

  Future<ResponseApi?> getUsuariosbyId(int idUsuario) async{
    // print('usuario: $idUsuario');
    try {
      Uri urinicio = Uri.http(_url, '$_api/UsuarioId'); //, {'cod_empresa': codEmpresa.toString()});
      String urlBase = urinicio.toString();
      String idUsuarioParam = 'id_usuario=${idUsuario.toString()}';
      String fullurl = '$urlBase?$idUsuarioParam';
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

  Future<ResponseApi?> editarUsuario(String nombre, String correo, int? telefono, int rol, int? empresa, int? idUsuario) async{
    try {
      Uri url = Uri.http(_url, '$_api/actualizaUsuario');
      String bodyParams = json.encode({
        'nombre_usuario': nombre.toString(),
        'cod_empresa': empresa.toString(),
        'correo_usuario': correo.toString(),
        'telefono_usuario': telefono.toString(),
        'cod_rol': rol.toString(),
        'id_usuario': idUsuario.toString()
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

  Future<ResponseApi?> eliminarUsuaio(int idUsuario, int idEmpresa) async{
    print('usuario: $idUsuario, Empresa: $idEmpresa');
    try {
      Uri url = Uri.http(_url, '$_api/eliminarUsuario');
      String bodyParams = json.encode({
        'id_usuario': idUsuario.toString(),
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

}