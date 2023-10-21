import 'package:cotizaciones_hdg/src/models/servicios_model.dart';
import 'package:cotizaciones_hdg/src/models/tipocombustible_model.dart';
import 'package:cotizaciones_hdg/src/models/ubicaciones_model.dart';
import 'package:cotizaciones_hdg/src/provider/tipocombustible_provider.dart';
import 'package:cotizaciones_hdg/src/provider/ubicaciones_provider.dart';
import 'package:flutter/material.dart';

import '../../models/empresas_model.dart';
import '../../models/response_api.dart';
import '../../provider/servicios_provider.dart';
import '../../styles/my_snackbar.dart';
import '../../styles/shared_pref.dart';

class DescripcionServicioController {
  BuildContext? context;
  Function? refresh;
  Servicio? servicios;
  // Ubicaciones? ubicaciones;
  late List<Ubicaciones> ubicaciones = [];
  late List<TipoCombustible> tipocombustible = [];
  ServiciosProvider serviciosProvider = new ServiciosProvider();
  UbicacionesProvider ubicacionesProvider = new UbicacionesProvider();
  TipoCombustibleProvider tipoCombustibleProvider = new TipoCombustibleProvider();
  bool resultado = false;

  SharedPref _sharedPref = new SharedPref();
  dynamic idServicio; //Recibe el argumento del id de la empresa seleccionada
  Empresas? empresas;
  late int? id_empresa;
  late String? nombre_empresa = '';


  Future? init(BuildContext context, Function refresh) async {
    this.context = context;
    this.refresh = refresh;
    // idServicio = ModalRoute.of(context)!.settings.arguments;
    final parametros = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    idServicio = parametros["id_servicio"];
    id_empresa= parametros["cod_Empresa"];
    nombre_empresa = parametros["nombre_empresa"];
    empresas = Empresas.fromJson(await _sharedPref.read('empresa') ?? {});
    if (idServicio == null) {
      idServicio = ModalRoute.of(context)!.settings.arguments;
    }
    print(idServicio);

    if (idServicio != null) {
      print('servicio código: $idServicio');
      ResponseApi? responseApi = await serviciosProvider.getServicioById(idServicio);
      print('Respuesta: ${responseApi?.toJson()}');

      if (responseApi != null && responseApi.success != null) {
        if (responseApi.success!) {
          servicios = Servicio.fromJson(responseApi.data!);
          _sharedPref.save('servicios: ', servicios?.toJson());
          print('abajo se muestra el servicio: ${servicios?.toJson()}');
          // print('EMPRESA USUARIO: ${empresas.toJson()}');
        } else {
          MySnackbar.show(context!, responseApi.message ?? 'Mensaje de error predeterminado');
        }
      } else {
        // Manejar el caso en el que responseApi o responseApi.success son nulos
      }
    } else {
      MySnackbar.show(context!, 'NO SE ENCUENTRA EL SERVICIO');
    }
    refresh();

    if (servicios?.cod_empresa == 2) {

      ResponseApi? responseApiUbi = await ubicacionesProvider.getUbicaciones();
      print('Respuesta Ubicaciones Todas: ${responseApiUbi?.toJson()}');
      if (responseApiUbi != null && responseApiUbi.success != null) {
        if (responseApiUbi.success!) {
          List<dynamic> ubicacionesDataList = responseApiUbi.data;

          if (ubicacionesDataList is List) {
            // Convertir la lista de datos JSON en una lista de objetos
            List<Ubicaciones> listaDeUbicaciones = ubicacionesDataList.map((item) {
              if (item is Map<String, dynamic>) {
                return Ubicaciones.fromJson(item);
              } else {
                return Ubicaciones(); // O algo similar
              }
            }).toList();
            // Guardar la lista de objetos en SharedPreferences
            _sharedPref.save('empresas', listaDeUbicaciones.map((ubicacion) => ubicacion?.toJson()).toList());
            // Asignar lista de objetos a la variable "empresas2" en caso de ser necesario
            ubicaciones = listaDeUbicaciones;
          } else {
          }
        } else {
          MySnackbar.show(context!, responseApiUbi.message ?? 'Mensaje de error predeterminado');
        }
      }
    }
    refresh();
  }

  Future<void> buscarCombustible(idCombustible, Function refresh) async {
    this.refresh = refresh;
    refresh();
    ResponseApi? responseApiCom = await tipoCombustibleProvider.getCombustiblebyUbicacion(idCombustible);
    print('Respuesta Combustible: ${responseApiCom?.toJson()}');
    if (responseApiCom != null && responseApiCom.success != null) {
      if (responseApiCom.success!) {
        List<dynamic> combustibleDataList = responseApiCom.data;

        if (combustibleDataList is List) {
          // Convertir la lista de datos JSON en una lista de objetos
          List<TipoCombustible> listaDeCombustible = combustibleDataList.map((item) {
            if (item is Map<String, dynamic>) {
              return TipoCombustible.fromJson(item);
            } else {
              return TipoCombustible(); // O algo similar
            }
          }).toList();
          // Guardar la lista de objetos en SharedPreferences
          _sharedPref.save('tipocombustible', listaDeCombustible.map((tipocombustibles) => tipocombustibles?.toJson()).toList());
          // Asignar lista de objetos a la variable "empresas2" en caso de ser necesario
          tipocombustible = listaDeCombustible;
          resultado = true;
        } else {
        }
      } else {
        MySnackbar.show(context!, responseApiCom.message ?? 'Mensaje de error predeterminado');
        resultado = false;
      }
    }
    refresh();
    print(resultado);
  }

  void goToLoginPage(){
    Navigator.pushNamed(context!, 'login');
  }

  void goToFormularioCotizacionPage(
      String codEmpresa,
      String nombreEmpresa,
      String codServicio,
      String nombreServicio,
      dynamic cantidadMedida,
      dynamic medida,
      dynamic idUbicacion,
      dynamic ubicacion,
      dynamic idCombustible,
      dynamic combustible
      ) {
    Map<String, dynamic> parametros = {
      "codEmpresa": codEmpresa,
      "nombreEmpresa": nombreEmpresa,
      "codServicio": codServicio,
      "nombreServicio": nombreServicio,
      "cantidadMedida": cantidadMedida,
      "medida": medida,
      "idUbicacion": idUbicacion,
      "ubicacion": ubicacion,
      "idCombustible": idCombustible,
      "combustible": combustible
    };
    // print(parametros);
    Navigator.pushNamed(context!, 'formularioCotizacion', arguments: parametros);
  }

  void goToFormularioCotizacionHdgPage(
      String codEmpresa,
      String nombreEmpresa,
      String codServicio,
      String nombreServicio,
      dynamic cantidadMedida,
      dynamic medida,
      dynamic idCaracteristica,
      dynamic caracteristica,
      ) {
    Map<String, dynamic> parametros = {
      "codEmpresa": codEmpresa,
      "nombreEmpresa": nombreEmpresa,
      "codServicio": codServicio,
      "nombreServicio": nombreServicio,
      "cantidadMedida": cantidadMedida,
      "medida": medida,
      "idCaracteristica": idCaracteristica,
      "Caracteristica": caracteristica,
    };
    // print(parametros);
    Navigator.pushNamed(context!, 'formularioCotizacion', arguments: parametros);
  }

  void logout(){
    _sharedPref.logout(context!);
  }
}