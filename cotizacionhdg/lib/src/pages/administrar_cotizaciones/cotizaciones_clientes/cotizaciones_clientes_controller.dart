import 'package:cotizaciones_hdg/src/models/cotizacion_model.dart';
import 'package:cotizaciones_hdg/src/models/usuario.dart';
import 'package:cotizaciones_hdg/src/provider/cotizaciones_provider.dart';
import 'package:flutter/material.dart';
import '../../../models/response_api.dart';
import '../../../styles/my_snackbar.dart';
import '../../../styles/shared_pref.dart';


class CotizacionesClienteController {
  BuildContext? context;
  Function? refresh;
  late List<Cotizacion?> cotizaciones = [];
  SharedPref _sharedPref = new SharedPref();
  CotizacionesProvider cotizacionesProvider = new CotizacionesProvider();
  Usuario? usuarios;
  // late int? id_empresa = empresas?.idEmpresa;
  // late String? nombre_empresa = '';
  // late int id_usuario;

  Future? init(BuildContext context, Function refresh) async{
    this.context = context;
    this.refresh = refresh;
    usuarios = Usuario.fromJson(await _sharedPref.read('usuario'));
    int? idUsuario = usuarios?.idUsuario;

    if (idUsuario != null) {
      print('usuario código: $idUsuario');
      ResponseApi? responseApi = await cotizacionesProvider.getCotizacionesCliente(idUsuario);
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

  void goToDetalleCotizacion(idCotizacion){
    Navigator.pushNamed(context!, 'verCotizacionCliente', arguments: idCotizacion);
  }

  void logout(){
    _sharedPref.logout(context!);
  }
}