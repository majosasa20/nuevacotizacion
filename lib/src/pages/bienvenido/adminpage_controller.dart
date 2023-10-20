import 'package:flutter/material.dart';
import '../../models/empresas_model.dart';
import '../../models/response_api.dart';
import '../../models/usuario.dart';
import '../../provider/empresas_provider.dart';
import '../../styles/my_snackbar.dart';
import '../../styles/shared_pref.dart';

class AdministradorPageController{
  BuildContext? context;
  Function? refresh;
  Usuario? usuario;
  Empresas? empresas;
  SharedPref _sharedPref = new SharedPref();
  EmpresasProvider empresasProvider = new EmpresasProvider();

  Future? init(BuildContext context, Function refresh) async{
    this.context = context;
    this.refresh = refresh;
    usuario = Usuario.fromJson(await _sharedPref.read('usuario'));
    empresas = Empresas.fromJson(await _sharedPref.read('empresa') ?? {});
    int? idUsuario = usuario?.idUsuario;

    if (idUsuario != null) {
      print('ROL DEL USUARIO CLIENTE: $idUsuario');
      ResponseApi? responseApi = await empresasProvider.getEmpresaUsuario(idUsuario);
      // print('Respuesta object: ${responseApi}');
      print('Respuesta: ${responseApi?.toJson()}');
      if (responseApi != null && responseApi.success != null) {
        if (responseApi.success!) {
          empresas = Empresas.fromJson(responseApi.data!);
          _sharedPref.save('empresas', empresas?.toJson());
          print('abajo se muestra la empresa: ${empresas?.toJson()}');
          // print('EMPRESA USUARIO: ${empresas.toJson()}');
        } else {
          MySnackbar.show(context!, responseApi.message ?? 'Mensaje de error predeterminado');
        }
      } else { // Manejar el caso en el que responseApi o responseApi.success son nulos
      }

    } else {
      MySnackbar.show(context!, 'NO SE ENCUENTRA USUARIO');
    }
    refresh();
  }

  void goToMenuAdmin(idempresa,nombreempresa){
    _sharedPref.save('idEmpresa', idempresa);
    _sharedPref.save('nombreEmpresa', nombreempresa);
    // _sharedPref.save('empresa', empresas?.toJson());
    Map<String, dynamic> parametros = {
      "idEmpresa": idempresa,
      "nombreEmpresa": nombreempresa,
    };
    Navigator.pushNamed(context!, 'menuadministradorpage',  arguments: parametros);
  }

  void logout(){
    _sharedPref.logout(context!);
  }
}