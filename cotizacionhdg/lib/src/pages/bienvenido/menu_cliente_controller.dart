import 'dart:ffi';
import 'package:cotizaciones_hdg/src/models/empresas_model.dart';
import 'package:cotizaciones_hdg/src/models/response_api.dart';
import 'package:cotizaciones_hdg/src/models/usuario.dart';
import 'package:cotizaciones_hdg/src/provider/empresas_provider.dart';
import 'package:cotizaciones_hdg/src/styles/shared_pref.dart';
import 'package:flutter/material.dart';
import '../../styles/my_snackbar.dart';

class MenuClienteController {
  BuildContext? context;
  Function? refresh;
  Usuario? usuario;
  Empresas? empresas;
  late List<Empresas> empresas2 = [];
  SharedPref _sharedPref = new SharedPref();
  EmpresasProvider empresasProvider = new EmpresasProvider();

  Future? init(BuildContext context, Function refresh) async{
    this.context = context;
    this.refresh = refresh;
    usuario = Usuario.fromJson(await _sharedPref.read('usuario'));
    empresas = Empresas.fromJson(await _sharedPref.read('empresa') ?? {});

    refresh();
  }
  void goToCrearCotizaciones(){
    Navigator.pushNamed(context!, 'clientepage');
  }
  void goToVerCotizacionesCliente(){
    Navigator.pushNamed(context!, 'cotizacionesClientes');
  }

  void logout(){
    _sharedPref.logout(context!);
  }
  // void buscarEmpresas() async{
  //   int? idUsuario = usuario?.idUsuario;
  //   ResponseApi? responseApi = await empresasProvider.getEmpresaUsuario(idUsuario!);
  //   if (responseApi!.success!){
  //     Empresas empresas = Empresas.fromJson(responseApi.data);
  //     _sharedPref.save('empresas', empresas.toJson());
  //     print('EMPRESA ENCONTRADA: ${empresas.toJson()}');
  //   }
  //   else {
  //     MySnackbar.show(context!, responseApi?.message);
  //   }
  // }

  void goToPage(String route){
    Navigator.pushNamedAndRemoveUntil(context!, route, (route) => false);
  }
}
