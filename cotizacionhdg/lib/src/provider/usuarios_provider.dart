import 'dart:convert';
// import 'dart:js_interop';
import 'package:cotizaciones_hdg/src/api/enviroment.dart';
import 'package:cotizaciones_hdg/src/models/usuario.dart';
import 'package:flutter/material.dart';
import 'package:cotizaciones_hdg/src/models/response_api.dart';
import 'package:http/http.dart' as http;

import '../styles/my_snackbar.dart';

class UsuariosProvider {
  final _url ="https://cotizaciones-hdg.onrender.com"; //Enviroment.API_COTIZACION;
  final _api = '/api/usuarios';
  // String _host = Enviroment.headerHost;
  // String _key = Enviroment.headerKey;

  BuildContext? context;
  Future? init(BuildContext context) {
    this.context = context;
  }
  // Future<ResponseApi?> create(Usuario usuario) async{
  //   try {
  //     Uri url = Uri.http(_url, '$_api/create');
  //     final bodyParams = json.encode(usuario);
  //     Map<String, String> headers = {
  //       'Content-type': 'application/json'
  //     };
  //     final res = await http.post(url, headers: headers, body: bodyParams);
  //     final data = json.decode(res.body);
  //     ResponseApi responseApi = ResponseApi.fromJson(data);
  //     return responseApi;
  //   }
  //   catch(e) {
  //     print('Error: $e');
  //     return null;
  //   }
  // }
  Future<ResponseApi?> create(Usuario usuario) async{
    try {
      final url = Uri.parse('$_url$_api/create');
      final bodyParams = json.encode(usuario);

      final headers = {
        'Content-Type': 'application/json',
      };
      final response = await http.post(url, headers: headers, body: bodyParams);
      print(response);
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

  // Future<ResponseApi?> login(String email, String password) async{
  //   try {
  //     Uri url =  Uri.http(_url, '$_api/login');
  //     final bodyParams = json.encode({
  //       'correo_usuario': email,
  //       'contrasenia': password
  //     });
  //     Map<String, String> headers = {
  //       'Content-type': 'application/json'
  //     };
  //     final res = await http.post(url, headers: headers, body: bodyParams);
  //     final data = json.decode(res.body);
  //     ResponseApi responseApi = ResponseApi.fromJson(data);
  //     return responseApi;
  //   }
  //   catch(e) {
  //     print('Error: $e');
  //     return null;
  //   }
  // }
  Future<ResponseApi?> login(String email, String password) async {
    try {
      final url = Uri.parse('$_url$_api/login'); // Combinar URL y ruta

      final bodyParams = {
        'correo_usuario': email,
        'contrasenia': password,
      };
      // MySnackbar.show(context!, email + password);
      final headers = {
        'Content-Type': 'application/json',
      };
      final response = await http.post(url, headers: headers, body: json.encode(bodyParams));
      MySnackbar.show(context!, "${response}");
      if (response.statusCode == 201) {
        final data = json.decode(response.body);
        ResponseApi responseApi = ResponseApi.fromJson(data);
        print(responseApi);
        // MySnackbar.show(context!, response == true ? "peticion correcta" : "peticion erronea");
        return responseApi;
      } else {
        // Puedes manejar los diferentes códigos de estado aquí
        print('Error en la solicitud: ${response.statusCode}');
        MySnackbar.show(context!, 'Error en la solicitud: ${response.statusCode}');

        return null;
      }
    } catch (e) {
      print('Error: $e');
      MySnackbar.show(context!, 'Error: ${e}');
      return null;
    }
  }

  // Future<ResponseApi?> login(String email, String password) async{
  //   try {
  //     fetch('$_url$_api/login', {
  //       method: 'POST',
  //       body: JSON.stringify({
  //         'correo_usuario': email,
  //         'contrasenia': password
  //       }),
  //       headers: {
  //         'Content-type': 'application/json; charset=UTF-8'
  //       },
  //     })
  //         .then((response) => response.json())
  //         .then((json) => print(json));
  //   }
  //   catch(e) {
  //     print('Error: $e');
  //     return null;
  //   }
  // }

  // Future<ResponseApi?> acceso(Int cod_usuarios) async{
  //   try {
  //     Uri url =  Uri.http(_url, '$_api/login');
  //     final bodyParams = json.encode({
  //       'cod_usuarios': cod_usuarios
  //     });
  //     Map<String, String> headers = {
  //       'Content-type': 'application/json'
  //     };
  //     final res = await http.post(url, headers: headers, body: bodyParams);
  //     final data = json.decode(res.body);
  //     ResponseApi responseApi = ResponseApi.fromJson(data);
  //     return responseApi;
  //   }
  //   catch(e) {
  //     print('Error: $e');
  //     return null;
  //   }
  // }

  // Future<ResponseApi?> getUsuariosEmpresa(int codEmpresa) async {
  //   print('empresa: $codEmpresa');
  //   try {
  //     Uri urinicio = Uri.http(_url, '$_api/UsuarioEmpresa');
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
  Future<ResponseApi?> getUsuariosEmpresa(int codEmpresa) async {
    print('empresa: $codEmpresa');
    try {
      final urinicio = Uri.parse('$_url$_api/UsuarioEmpresa');
      final urlBase = urinicio.toString();
      final codEmpresaParam = 'cod_empresa=${codEmpresa.toString()}';
      final fullurl = '$urlBase?$codEmpresaParam';
      final url = Uri.parse(fullurl);

      final headers = {
        'Content-Type': 'application/json',
      };
      final response = await http.get(url, headers: headers);
      if (response.statusCode == 201) {
        final data = json.decode(response.body);
        ResponseApi responseApi = ResponseApi.fromJson(data);
        print('Respuesta: ${responseApi?.toJson()}');
        return responseApi;
      } else {
        // Puedes manejar los diferentes códigos de estado aquí
        print('Error en la solicitud: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }

  // Future<ResponseApi?> agregarUsuario(String nombre, String correo, int? telefono, int rol, int? empresa) async{
  //   try {
  //     Uri url = Uri.http(_url, '$_api/agregar');
  //     final bodyParams = json.encode({
  //       'nombre_usuario': nombre.toString(),
  //       'cod_empresa': empresa.toString(),
  //       'correo_usuario': correo.toString(),
  //       'telefono_usuario': telefono.toString(),
  //       'cod_rol': rol.toString()
  //     });
  //     Map<String, String> headers = {
  //       'Content-type': 'application/json'
  //     };
  //     final res = await http.post(url, headers: headers, body: bodyParams);
  //     final data = json.decode(res.body);
  //     ResponseApi responseApi = ResponseApi.fromJson(data);
  //     return responseApi;
  //   }
  //   catch(e) {
  //     print('Error: $e');
  //     return null;
  //   }
  // }
  Future<ResponseApi?> agregarUsuario(String nombre, String correo, int? telefono, int rol, int? empresa) async{
    try {
      final url = Uri.parse('$_url$_api/agregar');

      final bodyParams = json.encode({
        'nombre_usuario': nombre.toString(),
        'cod_empresa': empresa.toString(),
        'correo_usuario': correo.toString(),
        'telefono_usuario': telefono.toString(),
        'cod_rol': rol.toString()
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
  Future<ResponseApi?> agregarEmpleado(String correo, int rol, int? empresa) async{
    try {
      final url = Uri.parse('$_url$_api/agregarEmpleado');

      final bodyParams = json.encode({
        'cod_empresa': empresa.toString(),
        'correo_usuario': correo.toString(),
        'cod_rol': rol.toString()
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


  // Future<ResponseApi?> getUsuariosbyId(int idUsuario) async{
  //   // print('usuario: $idUsuario');
  //   try {
  //     Uri urinicio = Uri.http(_url, '$_api/UsuarioId'); //, {'cod_empresa': codEmpresa.toString()});
  //     String urlBase = urinicio.toString();
  //     String idUsuarioParam = 'id_usuario=${idUsuario.toString()}';
  //     String fullurl = '$urlBase?$idUsuarioParam';
  //     Uri url = Uri.parse(fullurl);
  //     // print('url completa: $url');
  //     Map<String, String> headers = {
  //       'Content-type': 'application/json'
  //     };
  //     final res = await http.get(url, headers: headers);
  //     final data = json.decode(res.body);
  //     ResponseApi responseApi = ResponseApi.fromJson(data);
  //     print('Respuesta: ${responseApi?.toJson()}');
  //     return responseApi;
  //   } catch (e) {
  //     print('Error: $e');
  //     return null;
  //   }
  // }
  Future<ResponseApi?> getUsuariosbyId(int idUsuario) async{
    // print('usuario: $idUsuario');
    try {
      final urinicio = Uri.parse('$_url$_api/UsuarioId');
      final urlBase = urinicio.toString();
      final idUsuarioParam = 'id_usuario=${idUsuario.toString()}';
      final fullurl = '$urlBase?$idUsuarioParam';
      final url = Uri.parse(fullurl);
      // print('url completa: $url');
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
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }

  // Future<ResponseApi?> editarUsuario(String nombre, String correo, int? telefono, int rol, int? empresa, int? idUsuario) async{
  //   try {
  //     Uri url = Uri.http(_url, '$_api/actualizaUsuario');
  //     final bodyParams = json.encode({
  //       'nombre_usuario': nombre.toString(),
  //       'cod_empresa': empresa.toString(),
  //       'correo_usuario': correo.toString(),
  //       'telefono_usuario': telefono.toString(),
  //       'cod_rol': rol.toString(),
  //       'id_usuario': idUsuario.toString()
  //     });
  //     Map<String, String> headers = {
  //       'Content-type': 'application/json'
  //     };
  //     final res = await http.put(url, headers: headers, body: bodyParams);
  //     final data = json.decode(res.body);
  //     ResponseApi responseApi = ResponseApi.fromJson(data);
  //     return responseApi;
  //   }
  //   catch(e) {
  //     print('Error: $e');
  //     return null;
  //   }
  // }
  Future<ResponseApi?> editarUsuario(String nombre, String correo, int? telefono, int rol, int? empresa, int? idUsuario) async{
    try {
      final url = Uri.parse('$_url$_api/actualizaUsuario');
      final bodyParams = json.encode({
        'nombre_usuario': nombre.toString(),
        'cod_empresa': empresa.toString(),
        'correo_usuario': correo.toString(),
        'telefono_usuario': telefono.toString(),
        'cod_rol': rol.toString(),
        'id_usuario': idUsuario.toString()
      });
      final headers = {
        'Content-Type': 'application/json',
      };
      final response = await http.put(url, headers: headers, body: json.encode(bodyParams));

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

  // Future<ResponseApi?> eliminarUsuaio(int idUsuario, int idEmpresa) async{
  //   print('usuario: $idUsuario, Empresa: $idEmpresa');
  //   try {
  //     Uri url = Uri.http(_url, '$_api/eliminarUsuario');
  //     final bodyParams = json.encode({
  //       'id_usuario': idUsuario.toString(),
  //       'cod_empresa': idEmpresa.toString(),
  //     });
  //     Map<String, String> headers = {
  //       'Content-type': 'application/json'
  //     };
  //     final res = await http.delete(url, headers: headers, body: bodyParams);
  //     final data = json.decode(res.body);
  //     ResponseApi responseApi = ResponseApi.fromJson(data);
  //     return responseApi;
  //   }
  //   catch(e) {
  //     print('Error: $e');
  //     return null;
  //   }
  // }
  Future<ResponseApi?> eliminarUsuaio(int idUsuario, int idEmpresa) async{
    print('usuario: $idUsuario, Empresa: $idEmpresa');
    try {
      final url = Uri.parse('$_url$_api/eliminarUsuario');
      final bodyParams = json.encode({
        'id_usuario': idUsuario.toString(),
        'cod_empresa': idEmpresa.toString(),
      });
      final headers = {
        'Content-type': 'application/json'
      };
      final response = await http.delete(url, headers: headers, body: bodyParams);
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

}