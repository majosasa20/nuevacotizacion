import 'package:cotizaciones_hdg/src/models/cotizacion_model.dart';
import 'package:cotizaciones_hdg/src/provider/cotizaciones_provider.dart';
import 'package:flutter/material.dart';

import '../../models/empresas_model.dart';
import '../../models/response_api.dart';
import '../../styles/my_snackbar.dart';
import '../../styles/shared_pref.dart';

class AdminCotizacionesController {
  BuildContext? context;
  Function? refresh;
  late List<Cotizacion?> cotizaciones = [];
  SharedPref _sharedPref = new SharedPref();
  CotizacionesProvider cotizacionesProvider = new CotizacionesProvider();
  Empresas? empresas;
  // late int? id_empresa = empresas?.idEmpresa;
  // late String? nombre_empresa = '';
  late int id_empresa;// = empresas?.idEmpresa;
  late String? nombre_empresa = '';

  Future? init(BuildContext context, Function refresh) async{
    this.context = context;
    this.refresh = refresh;
    // empresas = Empresas.fromJson(await _sharedPref.read('empresa') ?? {});
    // nombre_empresa = empresas?.nombreEmpresa;
    // obtenerDatos();
    final nombreEmpresaValue = await _sharedPref.read('nombreEmpresa');
    final idEmpresaValue = await _sharedPref.read('idEmpresa');

    if (nombreEmpresaValue != null) {
      nombre_empresa = nombreEmpresaValue.toString();
      print('Nombre de la empresa catalogos $nombre_empresa');
    }

    if (idEmpresaValue != null) {
      id_empresa = int.parse(idEmpresaValue.toString());
      print('ID de la empresa catalogos $id_empresa');
    }
    // print('empresa cotizaciones: ${nombre_empresa}');

    if (id_empresa != null) {
      print('empresa código: $id_empresa');
      ResponseApi? responseApi = await cotizacionesProvider.getCotizacionesEmpresa(id_empresa!);
      print('Respuesta: ${responseApi?.toJson()}');

      if (responseApi != null && responseApi.success != null) {
        if (responseApi.success!) {
          List<dynamic> cotizacionDataList = responseApi.data;

          // Convertir la lista de datos JSON en una lista de objetos Servicio
          List<Cotizacion> listaDeCotizaciones = cotizacionDataList.map((item) => Cotizacion.fromJson(item)).toList();

          // Guardar la lista de objetos Servicio en SharedPreferences
          _sharedPref.save('cotizaciones', listaDeCotizaciones.map((cotizacion) => cotizacion.toJson()).toList());

          // Puedes asignar la lista de objetos Servicio a tu variable "usuarios" si lo necesitas
          cotizaciones = listaDeCotizaciones;

        } else {
          MySnackbar.show(context!, responseApi.message ?? 'Mensaje de error predeterminado');
        }
      } else {
      }
    } else {
      MySnackbar.show(context!, 'NO SE ENCUENTRAN LAS COTIZACIONES');
    }
    refresh();
  }
  Future<void> obtenerDatos() async {
    final nombreEmpresaValue = await _sharedPref.read('nombreEmpresa');
    final idEmpresaValue = await _sharedPref.read('idEmpresa');

    if (nombreEmpresaValue != null) {
      nombre_empresa = nombreEmpresaValue.toString();
      print('Nombre de la empresa catalogos $nombre_empresa');
    }

    if (idEmpresaValue != null) {
      id_empresa = int.parse(idEmpresaValue.toString());
      print('ID de la empresa catalogos $id_empresa');
    }
  }

  void goToDetalleCotizacion(idCotizacion){
    Navigator.pushNamed(context!, 'verdetalleCotizacion', arguments: idCotizacion);
  }

  void logout(){
    _sharedPref.logout(context!);
  }
}