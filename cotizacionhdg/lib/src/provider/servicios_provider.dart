import 'dart:convert';
import 'dart:io';
import 'package:cotizaciones_hdg/src/api/enviroment.dart';
import 'package:flutter/material.dart';
import 'package:cotizaciones_hdg/src/models/response_api.dart';
import 'package:http/http.dart' as http;

import '../styles/my_snackbar.dart';

class ServiciosProvider {
  final _url ="https://cotizaciones-hdg.onrender.com"; //Enviroment.API_COTIZACION;
  final _api = '/api/servicios';
  BuildContext? context;
  Future? init(BuildContext context) {
    this.context = context;
  }
  Future<ResponseApi?> getServicioEmpresa(int codEmpresa) async {
    // print('empresa: $codEmpresa');
    try {
      final urinicio = Uri.parse('$_url$_api/getServicioEmpresa'); //, {'cod_empresa': codEmpresa.toString()});
      final urlBase = urinicio.toString();
      final codEmpresaParam = 'cod_empresa=${codEmpresa.toString()}';
      final fullurl = '$urlBase?$codEmpresaParam';
      final url = Uri.parse(fullurl);
      // print('url completa: $url');
      final headers = {
        'Content-Type': 'application/json',
      };
      final response = await http.get(url, headers: headers);
      if (response.statusCode == 201) {
        final data = json.decode(response.body);
        ResponseApi responseApi = ResponseApi.fromJson(data);
        print('Obteniendo datos servicios$responseApi');
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
  // Future<ResponseApi?> getServicioEmpresa(int codEmpresa) async {
  //   // print('empresa: $codEmpresa');
  //   try {
  //     Uri urinicio = Uri.http(_url, '$_api/getServicioEmpresa'); //, {'cod_empresa': codEmpresa.toString()});
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

  Future<ResponseApi?> getServicioById(int codServicio) async {
    // print('empresa: $codEmpresa');
    try {
      final urinicio = Uri.parse('$_url$_api/getServicioById'); //, {'cod_empresa': codEmpresa.toString()});
      final urlBase = urinicio.toString();
      final codServicioParam = 'id_servicio=${codServicio.toString()}';
      final fullurl = '$urlBase?$codServicioParam';
      final url = Uri.parse(fullurl);
      // print('url completa: $url');
      final headers = {
        'Content-Type': 'application/json',
      };
      final response = await http.get(url, headers: headers);
      if (response.statusCode == 201) {
        final data = json.decode(response.body);
        ResponseApi responseApi = ResponseApi.fromJson(data);
        // print(responseApi);
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
  // Future<ResponseApi?> getServicioById(int codServicio) async {
  //   // print('empresa: $codEmpresa');
  //   try {
  //     Uri urinicio = Uri.http(_url, '$_api/getServicioById'); //, {'cod_empresa': codEmpresa.toString()});
  //     String urlBase = urinicio.toString();
  //     String codServicioParam = 'id_servicio=${codServicio.toString()}';
  //     String fullurl = '$urlBase?$codServicioParam';
  //     Uri url = Uri.parse(fullurl);
  //     // print('url completa: $url');
  //     Map<String, String> headers = {
  //       'Content-type': 'application/json'
  //     };
  //     final res = await http.get(url, headers: headers);
  //     final data = json.decode(res.body);
  //     ResponseApi responseApi = ResponseApi.fromJson(data);
  //     print('RespuestaApi: ${responseApi?.toJson()}');
  //     return responseApi;
  //   } catch (e) {
  //     print('Error: $e');
  //     return null;
  //   }
  // }

  Future<ResponseApi?> editarServicio(int idServicio,int idEmpresa,String nombreServicio, String descripcion,String salidaUbicacion,double precio,double duracion, String imagen,int idcaracteristica) async{
    // print('parámetros: $idServicio, $idEmpresa, $nombreServicio,  $descripcion, $salidaUbicacion, $precio, $duracion,  $imagen, $idcaracteristica');
    try {
      final url = Uri.parse('$_url$_api/editarServicio');
      final bodyParams = json.encode({
        'id_servicio': idServicio.toString(),
        'cod_empresa': idEmpresa.toString(),
        'nombre': nombreServicio.toString(),
        'descripcion': descripcion.toString(),
        'salida_ubicacion': salidaUbicacion.toString(),
        'precio': precio.toString(),
        'duracion': duracion.toString(),
        'id_caracteristica': idcaracteristica.toString(),
        'imagenencabezado': imagen.toString()
      });
      final headers = {
        'Content-Type': 'application/json',
      };
      final response = await http.put(url, headers: headers, body: bodyParams);
      if (response.statusCode == 201) {
        final data = json.decode(response.body);
        ResponseApi responseApi = ResponseApi.fromJson(data);
        print(responseApi);
        return responseApi;
      } else {
        print('Error en la solicitud: ${response.statusCode}');
        MySnackbar.show(context!, 'Error en la solicitud: ${response.statusCode}');
        return null;
      }
    }
    catch(e) {
      print('Error: $e');
      return null;
    }
  }
  // Future<ResponseApi?> editarServicio(int idServicio,int idEmpresa,String nombreServicio, String descripcion,String salidaUbicacion,double precio,double duracion, String imagen,int idcaracteristica) async{
  //   try {
  //     Uri url = Uri.http(_url, '$_api/editarServicio');
  //     String bodyParams = json.encode({
  //       'id_servicio': idServicio.toString(),
  //       'cod_empresa': idEmpresa.toString(),
  //       'nombre': nombreServicio.toString(),
  //       'descripcion': descripcion.toString(),
  //       'salida_ubicacion': salidaUbicacion.toString(),
  //       'precio': precio.toString(),
  //       'duracion': duracion.toString(),
  //       'id_caracteristica': idcaracteristica.toString(),
  //       'imagenencabezado': imagen.toString()
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

  Future<ResponseApi?> eliminarServicio(int idServicio, int idEmpresa) async{
    print('servocop: $idServicio, Empresa: $idEmpresa');
    try {
      final url = Uri.parse('$_url$_api/eliminarServicio');
      final bodyParams = json.encode({
        'id_servicio': idServicio.toString(),
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
        print('Error en la solicitud: ${response.statusCode}');
        return null;
      }
    }
    catch(e) {
      print('Error: $e');
      return null;
    }
  }
  // Future<ResponseApi?> eliminarServicio(int idServicio, int idEmpresa) async{
  //   print('servocop: $idServicio, Empresa: $idEmpresa');
  //   try {
  //     Uri url = Uri.http(_url, '$_api/eliminarServicio');
  //     String bodyParams = json.encode({
  //       'id_servicio': idServicio.toString(),
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

  Future<Stream> crearWithImage(int idEmpresa,String nombreServicio, String descripcion,String salidaUbicacion,double precio,double duracion, String nombreArchivo,
      int idcaracteristica, File image) async{
    try {
      final url = Uri.parse('$_url$_api/crearServicio');
      final request = http.MultipartRequest('POST', url);
      final rutaCompleta = image.path; // Supongamos que esta es la ruta completa al archivo
      final puntoIndex = rutaCompleta.lastIndexOf('.');
      final extension = puntoIndex != -1 ? rutaCompleta.substring(puntoIndex + 1) : '';
      final nombreArchivoExtension = '$nombreArchivo.$extension';
      print(nombreArchivoExtension);

      final parametros = {
        'cod_empresa': idEmpresa.toString(),
        'nombre': nombreServicio.toString(),
        'descripcion': descripcion.toString(),
        'salida_ubicacion': salidaUbicacion.toString(),
        'precio': precio.toString(),
        'duracion': duracion.toString(),
        'id_caracteristica': idcaracteristica.toString(),
        'nombreImagen': nombreArchivoExtension
      };

      if (image != null){
        request.files.add(http.MultipartFile(
            'imagenencabezado',
            http.ByteStream(image.openRead().cast()),
            await image.length(),
            // filename: basename(image.path)
            filename: nombreArchivoExtension
        ));
      }

      request.fields['servicio'] = json.encode(parametros);

      final response = await request.send(); //ENVIAR LA PETICIÓN
      return response.stream.transform(utf8.decoder);
    }
    catch (e){
      print('Error: $e');
      return Future<Stream>.error(e);    }
  }
  // Future<Stream> crearWithImage(int idEmpresa,String nombreServicio, String descripcion,String salidaUbicacion,double precio,double duracion, String nombreArchivo,
  //                             int idcaracteristica, File image) async{
  //   try {
  //     Uri url = Uri.http(_url, '$_api/crearServicio');
  //     final request = http.MultipartRequest('POST', url);
  //     String rutaCompleta = image.path; // Supongamos que esta es la ruta completa al archivo
  //     int puntoIndex = rutaCompleta.lastIndexOf('.');
  //     String extension = puntoIndex != -1 ? rutaCompleta.substring(puntoIndex + 1) : '';
  //     String nombreArchivoExtension = '$nombreArchivo.$extension';
  //     print(nombreArchivoExtension);
  //
  //     Map<String, dynamic> parametros = {
  //       'cod_empresa': idEmpresa.toString(),
  //       'nombre': nombreServicio.toString(),
  //       'descripcion': descripcion.toString(),
  //       'salida_ubicacion': salidaUbicacion.toString(),
  //       'precio': precio.toString(),
  //       'duracion': duracion.toString(),
  //       'id_caracteristica': idcaracteristica.toString(),
  //       'nombreImagen': nombreArchivoExtension
  //     };
  //
  //     if (image != null){
  //       request.files.add(http.MultipartFile(
  //         'imagenencabezado',
  //         http.ByteStream(image.openRead().cast()),
  //         await image.length(),
  //         // filename: basename(image.path)
  //         filename: nombreArchivoExtension
  //       ));
  //     }
  //
  //     request.fields['servicio'] = json.encode(parametros);
  //
  //     final response = await request.send(); //ENVIAR LA PETICIÓN
  //     return response.stream.transform(utf8.decoder);
  //   }
  //   catch (e){
  //     print('Error: $e');
  //     return Future<Stream>.error(e);    }
  // }

  Future<ResponseApi?> CrearServicio(int idEmpresa,String nombreServicio, String descripcion,String salidaUbicacion,double precio,double duracion, String imagen,int idcaracteristica) async{
    try {
      Uri url = Uri.http(_url, '$_api/crearServicio');
      String bodyParams = json.encode({
        'cod_empresa': idEmpresa.toString(),
        'nombre': nombreServicio.toString(),
        'descripcion': descripcion.toString(),
        'salida_ubicacion': salidaUbicacion.toString(),
        'precio': precio.toString(),
        'duracion': duracion.toString(),
        'id_caracteristica': idcaracteristica.toString(),
        'imagenencabezado': imagen.toString()
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


}