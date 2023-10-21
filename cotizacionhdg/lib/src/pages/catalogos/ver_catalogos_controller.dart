import 'package:flutter/material.dart';
import '../../models/empresas_model.dart';
import '../../styles/shared_pref.dart';

class VerCatalogosController {
  BuildContext? context;
  Function? refresh;
  SharedPref _sharedPref = new SharedPref();
  Empresas? empresas;
  // late int? id_empresa = empresas?.idEmpresa;
  // late String? nombre_empresa = empresas?.nombreEmpresa;
  late dynamic id_empresa;// = empresas?.idEmpresa;
  late String? nombre_empresa = '';


  Future? init(BuildContext context, Function refresh) async{
    this.context = context;
    this.refresh = refresh;
    // final parametros = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    // id_empresa = parametros["idEmpresa"];
    // nombre_empresa = parametros["nombreEmpresa"];
    // empresas = Empresas.fromJson(await _sharedPref.read('empresa') ?? {});
    await obtenerDatos();
    print('empresa catalogo: $nombre_empresa');
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
  void goToLoginPage(){
    Navigator.pushNamed(context!, 'login');
  }
  void goToAdministrarServiciosPage(){
    // Map<String, dynamic> parametros = {
    //   "idEmpresa": id_empresa,
    //   "nombreEmpresa": nombre_empresa,
    // };
    Navigator.pushNamed(context!, 'adminserviciosxempresa');
  }

  void goToCaracteristicasPage(){
    // Map<String, dynamic> parametros = {
    //   "idEmpresa": id_empresa,
    //   "nombreEmpresa": nombre_empresa,
    // };
    Navigator.pushNamed(context!, 'adminCaracteristicas');
  }

  void logout(){
    _sharedPref.logout(context!);
  }
}