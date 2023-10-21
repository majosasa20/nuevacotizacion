import 'dart:convert';
import 'dart:ffi';
import 'package:cotizaciones_hdg/src/models/usuario.dart';
import 'package:cotizaciones_hdg/src/styles/shared_pref.dart';
import 'package:flutter/material.dart';
import 'package:cotizaciones_hdg/src/models/response_api.dart';
import 'package:cotizaciones_hdg/src/provider/usuarios_provider.dart';
import 'package:cotizaciones_hdg/src/styles/my_snackbar.dart';

class LoginController {
  BuildContext? context; //signo de interrogación para evitar el NULL SAFETY
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();

  UsuariosProvider usuariosProvider = new UsuariosProvider();
  SharedPref _sharedPref = new SharedPref();

  Future? init(BuildContext? context) async{
    this.context = context;
    await usuariosProvider.init(context!);

    Usuario usuario = Usuario.fromJson(await _sharedPref.read('usuario') ?? {});
    // print('Usuario: ${usuario.toJson()}');
    /*
    if (usuario?.sessionToken != null){

      // Navigator.pushNamedAndRemoveUntil(context, 'clientepage', (route) => false);
      // Navigator.pushNamed(context, 'clientepage');
    }
    else{
      Navigator.pushNamedAndRemoveUntil(context, 'login', (route) => false);
    }
    */
  }

  void goToRegisterPage() {
    if (context != null) {
      Navigator.pushNamed(context!, 'registro');
    }else{
      MySnackbar.show(context!, 'No se puede ir al registro');
    }
  }


  // void goToClientePage() {
  //   Navigator.pushNamed(context!, 'clientepage');
  //   String email = emailController.text.trim();
  //   String password = passwordController.text.trim();
  //
  //   print('EMAIL: $email');
  //   print('PASSWORD: $password');
  // }

  // void goToAdminPage() {
  //   Navigator.pushNamed(context!, 'inicioadminpage');
  //   String email = emailController.text.trim();
  //   String password = passwordController.text.trim();
  //
  //   print('EMAIL: $email');
  //   print('PASSWORD: $password');
  // }
  //
  // void goToVendedorPage() {
  //   Navigator.pushNamed(context!, 'iniciovendedorpage');
  //   String email = emailController.text.trim();
  //   String password = passwordController.text.trim();
  //
  //   print('EMAIL: $email');
  //   print('PASSWORD: $password');
  // }

  void login() async{
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    if (email.isEmpty) {
      MySnackbar.show(context!, 'Ingresa un correo');
      return;
    }
    else if (password.isEmpty) {
      MySnackbar.show(context!, 'Ingresa la contraseña');
      return;
    }
    // print('EMAIL: $email');
    // print('PASSWORD: $password');
    ResponseApi? responseApi = await usuariosProvider.login(email, password);
    print('resultado: ${responseApi}');
  //
    if (responseApi != null && responseApi.success!) {
      Usuario usuario = Usuario.fromJson(responseApi.data);
      _sharedPref.save('usuario', usuario.toJson());
      print('USUARIO LOGUEADO: ${usuario.toJson()}');
      if (usuario.roles.length > 1) {
        Navigator.pushNamedAndRemoveUntil(context!, 'roles', (route) => false);
      }
      else {
        // print('LOGIN ROL USUARIO: ${usuario.roles[0].idRol.toString()}');
        if (usuario.roles[0].idRol == 2 || usuario.roles[0].idRol == 3){
          // print('ROL USUARIO: ${usuario.roles[0].idRol}');
          Navigator.pushNamedAndRemoveUntil(context!, 'inicioadminpage', (route) => false);
        }
        else if (usuario.roles[0].idRol == 4 || usuario.roles[0].idRol == 5){
          Navigator.pushNamedAndRemoveUntil(context!, 'iniciovendedorpage', (route) => false);
        }
        else {
          Navigator.pushNamedAndRemoveUntil(context!, 'clientepage', (route) => false);
        }
        // Navigator.pushNamedAndRemoveUntil(context!, 'adminpage', (route) => false);
      }
  //       // Navigator.pushNamed(context!,'clientepage' );
  //     Navigator.pushNamedAndRemoveUntil(context!, 'clientepage', (route) => false);
    }
    else {
      MySnackbar.show(context!, responseApi?.message);
    }
    // print('Respuesta object: ${responseApi}');
    // print('Respuesta: ${responseApi?.toJson()}');
    // MySnackbar.show(context!, responseApi?.message);
  //   // var datos = json.encode(responseApi);
  //   // accesos(datos);

  }

  // void accesos(datos) async{
  //   Int cod_rol = datos.cod_rol;
  //   ResponseApi? responseApi = await usuariosProvider.acceso(cod_rol);
  //   print('Codigo Rol: ${responseApi}');
  // }
}