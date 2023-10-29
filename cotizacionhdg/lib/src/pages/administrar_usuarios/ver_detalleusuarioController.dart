import 'dart:convert';
import 'dart:ffi';
import 'package:cotizaciones_hdg/src/models/roles.dart';
import 'package:cotizaciones_hdg/src/models/usuario.dart';
import 'package:cotizaciones_hdg/src/provider/usuarios_provider.dart';
import 'package:flutter/material.dart';

import '../../models/empresas_model.dart';
import '../../models/response_api.dart';
import '../../provider/roles_provider.dart';
import '../../styles/my_snackbar.dart';
import '../../styles/shared_pref.dart';

class VerDetalleUsuarioController{
  BuildContext? context;
  Function? refresh;
  SharedPref _sharedPref = new SharedPref();
  Empresas? empresas;
  // late int? id_empresa = empresas?.idEmpresa;
  // late String? nombre_empresa = empresas?.nombreEmpresa;
  late int id_empresa;// = empresas?.idEmpresa;
  late String? nombre_empresa = '';
  late List<Roles?> roleslist = [];
  Roles? rol;
  late dynamic idUsuario;
  RolesProvider rolesProvider = new RolesProvider();
  UsuariosProvider usuariosProvider = new UsuariosProvider();
  Usuario? usuarios;

  TextEditingController nombreController = new TextEditingController();
  TextEditingController correoController = new TextEditingController();
  TextEditingController telefonoController = new TextEditingController();
  TextEditingController rolController = new TextEditingController();

  Future? init(BuildContext context, Function refresh) async {
    this.context = context;
    this.refresh = refresh;
    // obtenerDatos();
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
    // empresas = Empresas.fromJson(await _sharedPref.read('empresa') ?? {});
    idUsuario = ModalRoute.of(context)!.settings.arguments;
    print('idusuario: $idUsuario');

    if (idUsuario != null) {
      // print('caracteristica código: $idCaracteristica');
      ResponseApi? responseApi = await usuariosProvider.getUsuariosbyId(idUsuario);
      print('Respuesta: ${responseApi?.toJson()}');

      if (responseApi != null && responseApi.success != null) {
        if (responseApi.success!) {
          usuarios = Usuario.fromJson2(responseApi.data!);
          _sharedPref.save('usuarios', json.encode(usuarios?.toJson()));
          print('abajo se muestra el usuario: ${usuarios?.toJson()}');

          if (usuarios?.roles.isNotEmpty == true) {
            print (usuarios?.roles);
            rol = usuarios?.roles[0];
            print(rol);
          } else { }
        } else {
          MySnackbar.show(context!, responseApi.message ?? 'Mensaje de error predeterminado');
        }
      } else {
        // Manejar el caso en el que responseApi o responseApi.success son nulos
      }
    }
    else {
      MySnackbar.show(context!, 'NO SE ENCUENTRA EL USUARIO');
    }

      nombreController.text = usuarios!.nombreUsuario.toString();
      correoController.text = usuarios!.correoUsuario.toString();
      if (usuarios!.telefonoUsuario != null){
        telefonoController.text = usuarios!.telefonoUsuario.toString();
      }else{ telefonoController.text = ""; }
      if (rol?.descripcionRol == null) {
        rolController.text = "";
      }else{
        rolController.text = rol!.descripcionRol.toString();
      }



    //LLENAR EL DROPDOWN ROLES
    ResponseApi? responseApirol = await rolesProvider.getRolesxEmpresa(id_empresa);
    print('Respuesta roles Todas: ${responseApirol?.toJson()}');
    if (responseApirol != null && responseApirol.success != null) {
      if (responseApirol.success!) {
        List<dynamic> rolesdataList = responseApirol.data;

        if (rolesdataList is List) {
          // Convertir la lista de datos JSON en una lista de objetos
          List<Roles> listaDeRoles = rolesdataList.map((item) {
            if (item is Map<String, dynamic>) {
              return Roles.fromJson(item);
            } else {
              return Roles(); // O algo similar
            }
          }).toList();
          // Guardar la lista de objetos en SharedPreferences
          _sharedPref.save('roles', listaDeRoles.map((rol) => rol?.toJson()).toList());
          // Asignar lista de objetos a la variable "empresas2" en caso de ser necesario
          roleslist = listaDeRoles;
        } else {
        }
      } else {
        MySnackbar.show(context!, responseApirol.message ?? 'Mensaje de error predeterminado');
      }
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

  Future<void> guardarUsuario(idRol) async {
    String? nombre = nombreController.text.trim();
    String? correo = correoController.text;
    String? telefono = telefonoController.text.trim();
    print('nombre: $nombre, correo. $correo, telefono: $telefono');

    if (nombre.isEmpty || correo.isEmpty || telefono.isEmpty || idRol == null) {
      MySnackbar.show(context!, 'Debes ingresar todos los campos');
      return;
    } else {
      if (telefono.length < 8){
        MySnackbar.show(context!, 'Longitud de teléfono incorrecta');
      }else{
        int? id_rol = int.tryParse(idRol);
        if (id_rol != null) {
          int? telefonoFinal = int.tryParse(telefono);
          ResponseApi? responseApinew = await usuariosProvider.editarUsuario(nombre, correo, telefonoFinal, id_rol, id_empresa, usuarios?.idUsuario);
          MySnackbar.show(context!, responseApinew?.message);

          if (responseApinew!.success!) {
            Future.delayed(Duration(seconds: 3), () {
              Map<String, dynamic> parametros = {
                "idEmpresa": id_empresa,
                "nombreEmpresa": nombre_empresa,
              };
              Navigator.pushReplacementNamed(context!, 'adminusuariosempresa', arguments: parametros);
            });
          } else {
            MySnackbar.show(context!, "Error al modificar el usuario.");
          }
        }
      }
    }
  }

  Future<void> eliminarUsuario(id_usuario, id_empresa) async {
    this.refresh = refresh;
    ResponseApi? responseApi = await usuariosProvider.eliminarUsuaio(id_usuario, id_empresa);
    MySnackbar.show(context!, responseApi?.message);
    if (responseApi!.success!){
      Future.delayed(Duration(seconds: 2), () {
        MySnackbar.show(context!, "Usuario Eliminado");
        Map<String, dynamic> parametros = {
          "idEmpresa": id_empresa,
          "nombreEmpresa": nombre_empresa,
        };
        Navigator.pushReplacementNamed(context!, 'adminusuariosempresa', arguments: parametros);
      });
    }else {
      MySnackbar.show(context!, "Error al eliminar Usuario ");
    }
  }

  void cancelar(){
    // Map<String, dynamic> parametros = {
    //   "idEmpresa": id_empresa,
    //   "nombreEmpresa": nombre_empresa,
    // };
    Navigator.pushReplacementNamed(context!, 'adminusuariosempresa');
  }
  void logout(){
    _sharedPref.logout(context!);
  }

}