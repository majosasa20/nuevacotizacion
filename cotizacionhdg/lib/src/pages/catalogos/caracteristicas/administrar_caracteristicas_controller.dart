import 'package:cotizaciones_hdg/src/models/caracteristicas_model.dart';
import 'package:flutter/material.dart';

import '../../../models/empresas_model.dart';
import '../../../models/response_api.dart';
import '../../../provider/caracteristicas_provider.dart';
import '../../../styles/my_snackbar.dart';
import '../../../styles/shared_pref.dart';

class AdministrarCaracteristicasxEmpresaController{
  BuildContext? context;
  Function? refresh;
  SharedPref _sharedPref = new SharedPref();
  CaracteristicasProvider caracteristicasProvider = new CaracteristicasProvider();
  Empresas? empresas;
  // late int? id_empresa = empresas?.idEmpresa;
  // late String? nombre_empresa = empresas?.nombreEmpresa;
  late List<Caracteristicas?> caracteristicas = [];
  late int id_empresa;// = empresas?.idEmpresa;
  late String? nombre_empresa = '';

  Future? init(BuildContext context, Function refresh) async {
    this.context = context;
    this.refresh = refresh;
    obtenerDatos();
    // empresas = Empresas.fromJson(await _sharedPref.read('empresa') ?? {});
    // print('caracteristicas empresa: $nombre_empresa');
    // final parametros = ModalRoute
    //     .of(context)!
    //     .settings
    //     .arguments as Map<String, dynamic>;
    // id_empresa = parametros["idEmpresa"];
    // nombre_empresa = parametros["nombreEmpresa"];

    if (id_empresa != null) {
      // print('empresa código: $id_empresa');
      ResponseApi? responseApi = await caracteristicasProvider.getCaracteristicasEmpresa(id_empresa!);
      print('Respuesta: ${responseApi?.toJson()}');

      if (responseApi != null && responseApi.success != null) {
        if (responseApi.success!) {
          List<dynamic> caracteristicasDataList = responseApi.data;

          // Convertir la lista de datos JSON en una lista de objetos Servicio
          List<Caracteristicas> listaDeCaracteristicas = caracteristicasDataList.map((item) => Caracteristicas.fromJson(item)).toList();

          // Guardar la lista de objetos Servicio en SharedPreferences
          _sharedPref.save('caracteristicas', listaDeCaracteristicas.map((caracteristica) => caracteristica.toJson()).toList());

          // Puedes asignar la lista de objetos Servicio a tu variable "usuarios" si lo necesitas
          caracteristicas = listaDeCaracteristicas;

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

  void goToDetalleCaracteristica( id_caracteristica){
    // Map<String, dynamic> parametros = {
    //   "idEmpresa": id_empresa,
    //   "nombreEmpresa": nombre_empresa,
    //   "idCaracteristica": id_caracteristica
    // };
    Navigator.pushNamed(context!, 'verdetalleCaracteristica', arguments: id_caracteristica);
  }

  void crearCaracteristica(){
    // Map<String, dynamic> parametros = {
    //   "idEmpresa": id_empresa,
    //   "nombreEmpresa": nombre_empresa
    // };
    Navigator.pushNamed(context!, 'crearCaracteristica');
  }

  void logout(){
    _sharedPref.logout(context!);
  }

}