import 'package:cotizaciones_hdg/src/provider/usuarios_provider.dart';
import 'package:flutter/material.dart';
import '../../models/empresas_model.dart';
import '../../models/response_api.dart';
import '../../models/usuario.dart';
import '../../styles/my_snackbar.dart';
import '../../styles/shared_pref.dart';

class AdminUsuariosEmpresaController {
  BuildContext? context;
  Function? refresh;
  late List<Usuario?> usuarios = [];
  SharedPref _sharedPref = new SharedPref();
  UsuariosProvider usuariosProvider = new UsuariosProvider();
  Empresas? empresas;
  // late int? id_empresa = empresas?.idEmpresa;
  // late String? nombre_empresa = empresas?.nombreEmpresa;
  late int? id_empresa ;// = empresas?.idEmpresa;
  late String? nombre_empresa = '';

  Future? init(BuildContext context, Function refresh) async{
    this.context = context;
    this.refresh = refresh;
    await obtenerDatos();

    // final parametros = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    // id_empresa = parametros["idEmpresa"];
    // nombre_empresa = parametros["nombreEmpresa"];
    // empresas = Empresas.fromJson(await _sharedPref.read('empresa') ?? {});
    // print('empresa usuario: $empresas');

    if (id_empresa != null) {
      print('empresa código: $id_empresa');
      ResponseApi? responseApi = await usuariosProvider.getUsuariosEmpresa(id_empresa!);
      print('Respuesta: ${responseApi?.toJson()}');

      if (responseApi != null && responseApi.success != null) {
        if (responseApi.success!) {
          List<dynamic> usuarioDataList = responseApi.data;

          // Convertir la lista de datos JSON en una lista de objetos Servicio
          List<Usuario> listaDeUsuarios = usuarioDataList.map((item) => Usuario.fromJson(item)).toList();

          // Guardar la lista de objetos Servicio en SharedPreferences
          _sharedPref.save('usuarios', listaDeUsuarios.map((usuario) => usuario.toJson()).toList());

          // Puedes asignar la lista de objetos Servicio a tu variable "usuarios" si lo necesitas
          usuarios = listaDeUsuarios;

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

  void goToCatalogosPage(){
    Navigator.pushNamed(context!, 'verCatalogos');
  }
  void goToDetalleUsuario(idUsuario){
    // print('usuario2: $idUsuario');
    Navigator.pushNamed(context!, 'verdetalleUsuario', arguments: idUsuario);
  }
  void goToLoginPage(){
    Navigator.pushNamed(context!, 'login');
  }
  void crearUsuario(){
    Navigator.pushNamed(context!, 'crearUsuario');
  }

  void logout(){
    _sharedPref.logout(context!);
  }
}