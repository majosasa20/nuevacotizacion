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

class CrearUsuarioController{
  BuildContext? context;
  Function? refresh;
  SharedPref _sharedPref = new SharedPref();
  Empresas? empresas;
  late int id_empresa;// = empresas?.idEmpresa;
  late String? nombre_empresa = '';
  // late int? id_empresa = empresas?.idEmpresa;
  // late String? nombre_empresa = empresas?.nombreEmpresa;
  late List<Roles?> roleslist = [];
  RolesProvider rolesProvider = new RolesProvider();
  UsuariosProvider usuariosProvider = new UsuariosProvider();
  Usuario? usuarios;

  bool resultado = false;

  TextEditingController nombreController = new TextEditingController();
  TextEditingController correoController = new TextEditingController();
  TextEditingController telefonoController = new TextEditingController();

  Future? init(BuildContext context, Function refresh) async {
    this.context = context;
    this.refresh = refresh;
    obtenerDatos();
    // empresas = Empresas.fromJson(await _sharedPref.read('empresa') ?? {});

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
          ResponseApi? responseApinew = await usuariosProvider.agregarUsuario(nombre, correo, telefonoFinal, id_rol, id_empresa);
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
            MySnackbar.show(context!, "Error al crear el usuario.");
          }
        }
      }
      }
    }

    void cancelar(id_empresa, nombre_empresa){
      Map<String, dynamic> parametros = {
        "idEmpresa": id_empresa,
        "nombreEmpresa": nombre_empresa,
      };
      Navigator.pushReplacementNamed(context!, 'adminCaracteristicas', arguments: parametros);
    }
    void logout(){
      _sharedPref.logout(context!);
    }

  }