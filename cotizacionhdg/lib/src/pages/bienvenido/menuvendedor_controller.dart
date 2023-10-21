import 'package:flutter/material.dart';
import '../../models/empresas_model.dart';
import '../../models/usuario.dart';
import '../../styles/shared_pref.dart';

class MenuVendedorController {
  BuildContext? context;
  Function? refresh;
  SharedPref _sharedPref = new SharedPref();
  Usuario? usuario;
  Empresas? empresas;
  late dynamic id_empresa;// = empresas?.idEmpresa;
  late String? nombre_empresa = '';

  Future? init(BuildContext context, Function refresh) async {
    this.context = context;
    this.refresh = refresh;
    usuario = Usuario.fromJson(await _sharedPref.read('usuario'));
    // empresas = Empresas.fromJson(await _sharedPref.read('empresa') ?? {});
    obtenerDatos();
    // id_empresa = _sharedPref.read('idEmpresa')?.toString() ?? '';
    // nombre_empresa = _sharedPref.read('nombreEmpresa')?.toString() ?? '';
    // nombre_empresa = empresas?.nombreEmpresa;
    // print('nombre de la empresa vendedor$nombre_empresa y id empresa: $id_empresa');
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


  void goToCatalogosPage(){
    // Map<String, dynamic> parametros = {
    //   "idEmpresa": id_empresa,
    //   "nombreEmpresa": nombre_empresa,
    // };
    Navigator.pushNamed(context!, 'verCatalogos',);
  }
  void goToAdminCotizacionesPage() {
    Navigator.pushNamed(context!, 'adminCotizaciones');
  }
  // void goToLoginPage(){
  //   Navigator.pushNamed(context!, 'clientepage');
  // }
  void goToCrearCotizacion() {
    Navigator.pushNamed(context!, 'clientepage');
    refresh!();
  }
  void logout(){
    _sharedPref.logout(context!);
  }
}