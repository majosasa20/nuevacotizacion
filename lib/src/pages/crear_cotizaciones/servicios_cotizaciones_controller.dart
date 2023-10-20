import 'package:cotizaciones_hdg/src/models/response_api.dart';
import 'package:cotizaciones_hdg/src/models/servicios_model.dart';
import 'package:cotizaciones_hdg/src/provider/servicios_provider.dart';
import 'package:flutter/material.dart';
import 'package:cotizaciones_hdg/src/styles/shared_pref.dart';
import '../../models/empresas_model.dart';
import '../../styles/my_snackbar.dart';

class ServiciosCotizacionesController {
  BuildContext? context;
  Function? refresh;
  late List<Servicio?> servicios = [];
  ServiciosProvider serviciosProvider = new ServiciosProvider();
  SharedPref _sharedPref = new SharedPref();
  Empresas? empresas;
  late int? id_empresa ;
  late String? nombre_empresa = '';

  Future? init(BuildContext context, Function refresh) async {
    this.context = context;
    this.refresh = refresh;
    empresas = Empresas.fromJson(await _sharedPref.read('empresa') ?? {});
    final parametros = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    id_empresa = parametros["idEmpresa"];
    nombre_empresa = parametros["nombreEmpresa"];
    print('empresa servicios cotizacion $id_empresa $nombre_empresa');
    // id_empresa = ModalRoute.of(context!)!.settings.arguments;

    if (id_empresa != null) {
      print('empresa código: $id_empresa');
      ResponseApi? responseApi = await serviciosProvider.getServicioEmpresa(id_empresa!);
      print('Respuesta: ${responseApi?.toJson()}');

      if (responseApi != null && responseApi.success != null) {
        if (responseApi.success!) {
          List<dynamic> servicioDataList = responseApi.data;

          // Convertir la lista de datos JSON en una lista de objetos Servicio
          List<Servicio> listaDeServicios = servicioDataList.map((item) => Servicio.fromJson(item)).toList();

          // Guardar la lista de objetos Servicio en SharedPreferences
          _sharedPref.save('servicios', listaDeServicios.map((servicio) => servicio.toJson()).toList());

          // Puedes asignar la lista de objetos Servicio a tu variable "servicios" si lo necesitas
          servicios = listaDeServicios;

          // print('abajo se muestran los servicios: ${servicios.map((servicio) => servicio.toJson()).toList()}');
        } else {
          MySnackbar.show(context!, responseApi.message ?? 'Mensaje de error predeterminado');
        }
      } else {
      }
    } else {
      MySnackbar.show(context!, 'NO SE ENCUENTRAN LOS SERVICIOS');
    }
    refresh();
  }
  void goToLoginPage(){
    Navigator.pushNamed(context!, 'login');
  }
  void goToDescripcionServicioPage(idServicio, codEmpresa, nombreEmpresa){
    Map<String, dynamic> parametros = {
      "id_servicio": idServicio,
      "cod_Empresa": codEmpresa,
      "nombre_empresa": nombreEmpresa
    };
    Navigator.pushNamed(context!, 'decripcionCotizacion', arguments: parametros);
  }
  void goToDescripcionServicioPagePRUEBA(){
    Navigator.pushNamed(context!, 'decripcionCotizacion');

  }

  void logout(){
    _sharedPref.logout(context!);
  }
}

  // Future? init(BuildContext context) async{
  //   this.context = context;
  //   id_empresa = ModalRoute.of(context!)!.settings.arguments;
  //
  //   if (id_empresa != null){
  //     print('empresa código: $id_empresa');
  //     ResponseApi? responseApi = await serviciosProvider.getServicioEmpresa(id_empresa);
  //     print('Respuesta: ${responseApi?.toJson()}');
  //
  //     if (responseApi != null && responseApi.success != null) {
  //       if (responseApi.success!) {
  //         // servicios = Servicio.fromJson(responseApi.data!);
  //         List<dynamic> servicioDataList = responseApi.data;
  //         List<Map<String, dynamic>> listaDeServiciosJson = servicios.map((servicio) => servicio.toJson()).toList();
  //
  //         // Ahora tienes una lista de objetos Servicio
  //         // Puedes hacer lo que necesites con esta lista, como asignarla a tu variable "servicios"
  //         servicios = listaDeServicios;
  //         _sharedPref.save('servicios', servicios?.toJson());
  //         // print('abajo se muestran los servicios: ${servicios?.toJson()}');
  //         // print('EMPRESA USUARIO: ${empresas.toJson()}');
  //       } else {
  //         MySnackbar.show(context!, responseApi.message ?? 'Mensaje de error predeterminado');
  //       }
  //     } else {
  //     }
  //   } else {
  //     MySnackbar.show(context!, 'NO SE ENCUENTRAN LOS SERVICIOS');
  //   }
  // }
