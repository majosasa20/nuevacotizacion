import 'package:cotizaciones_hdg/src/models/usuario.dart';
import 'package:flutter/material.dart';
import '../../models/empresas_model.dart';
import '../../styles/shared_pref.dart';

class MenuAdministradorController {
  BuildContext? context;
  Function? refresh;
  Usuario? usuario;
  SharedPref _sharedPref = new SharedPref();
  Empresas? empresas;
  // late int? id_empresa = empresas?.idEmpresa;
  // late String? nombre_empresa = empresas?.nombreEmpresa;
  late int id_empresa;// = empresas?.idEmpresa;
  late String? nombre_empresa = '';

  Future? init(BuildContext context, Function refresh) async {
    this.context = context;
    this.refresh = refresh;
    //OBTENER EL USUARIO DE SESIÓN
    usuario = Usuario.fromJson(await _sharedPref.read('usuario'));
    obtenerDatos();
    // empresas = Empresas.fromJson(await _sharedPref.read('empresa') ?? {});
    print('empresa: $nombre_empresa');
    // final parametros = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    // id_empresa = parametros["idEmpresa"];
    // nombre_empresa = parametros["nombreEmpresa"];

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
  // void goToCotizacionPage() {
  //   Navigator.pushNamed(context!, 'adminpage');
  // }

  void goToCatalogosPage(){
    // Map<String, dynamic> parametros = {
    //   "idEmpresa": id_empresa,
    //   "nombreEmpresa": nombre_empresa,
    // };
    Navigator.pushNamed(context!, 'verCatalogos');
  }
  // void goToAdminCotizacionesPage() {
  //   Navigator.pushNamed(context!, 'adminpage');
  // }
  void goToUsuariosPage(){
    // Map<String, dynamic> parametros = {
    //   "idEmpresa": id_empresa,
    //   "nombreEmpresa": nombre_empresa,
    // };
    Navigator.pushNamed(context!, 'adminusuariosempresa');
  }
  void goToAdminCotizacionesPage(){
    Navigator.pushNamed(context!, 'adminCotizaciones');
  }
  void goToCrearCotizacion() {
    Navigator.pushNamed(context!, 'clientepage'); //, arguments: usuario?.idUsuario
    refresh!();
  }
  void logout(){
    _sharedPref.logout(context!);
  }
}