
import 'package:cotizaciones_hdg/src/models/empresas_model.dart';
import 'package:cotizaciones_hdg/src/models/response_api.dart';
import 'package:cotizaciones_hdg/src/models/usuario.dart';
import 'package:cotizaciones_hdg/src/provider/empresas_provider.dart';
import 'package:cotizaciones_hdg/src/styles/shared_pref.dart';
import 'package:flutter/material.dart';
import '../../styles/my_snackbar.dart';

class ClienteController {
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
      //MANDANDO A LLAMAR A TODAS LAS EMPRESAS PARA EL CLIENTE
      ResponseApi? responseApi2 = await empresasProvider.getEmpresasCliente();
      print('Respuesta Empresas Todas: ${responseApi2?.toJson()}');
      if (responseApi2 != null && responseApi2.success != null) {
        if (responseApi2.success!) {
          List<dynamic> empresaDataList = responseApi2.data;

          // Asegúrate de que empresaDataList sea realmente una lista
          if (empresaDataList is List) {
            // Convertir la lista de datos JSON en una lista de objetos
            List<Empresas> listaDeEmpresas = empresaDataList.map((item) {
              if (item is Map<String, dynamic>) {
                return Empresas.fromJson(item);
              } else {
                // Puedes manejar el caso en que los datos no sean un mapa válido.
                // Puedes devolver un valor por defecto o lanzar una excepción según tus necesidades.
                return Empresas(); // O algo similar
              }
            }).toList();
            // Guardar la lista de objetos en SharedPreferences
            _sharedPref.save('empresas', listaDeEmpresas.map((empresa) => empresa?.toJson()).toList());
            // Asignar lista de objetos a la variable "empresas2" en caso de ser necesario
            empresas2 = listaDeEmpresas;
          } else {
            // Manejar el caso en que empresaDataList no sea una lista
            // Puedes devolver un valor por defecto o lanzar una excepción según tus necesidades.
          }
        } else {
          MySnackbar.show(context!, responseApi2.message ?? 'Mensaje de error predeterminado');
        }
      }

    } else {
        MySnackbar.show(context!, 'NO SE ENCUENTRA USUARIO');
    }
    refresh();
  }

  void goToServiciosCotizaciones(idEmpresa, nombreEmpresa){
    // Navigator.pushNamed(context!, 'serviciosCotizaciones', arguments: id_empresa);
    print('correo usuario: ${usuario?.correoUsuario} empresa: ${idEmpresa} ${nombreEmpresa}');
    // print('$idEmpresa $nombreEmpresa');
    Map<String, dynamic> parametros = {
      "idEmpresa": idEmpresa,
      "nombreEmpresa": nombreEmpresa,
    };
    Navigator.pushNamed(context!, 'serviciosCotizaciones', arguments: parametros);
  }
  void goToServiciosPrueba(){
    Navigator.pushNamed(context!, 'serviciosCotizaciones');
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
