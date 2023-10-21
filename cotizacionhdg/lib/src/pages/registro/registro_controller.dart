import 'dart:ffi';
import 'package:cotizaciones_hdg/src/models/response_api.dart';
import 'package:cotizaciones_hdg/src/models/usuario.dart';
import 'package:cotizaciones_hdg/src/provider/usuarios_provider.dart';
import 'package:cotizaciones_hdg/src/styles/my_snackbar.dart';
import 'package:flutter/material.dart';

class RegistroController {
  BuildContext? context;
  TextEditingController nombreController = new TextEditingController();
  TextEditingController apellidoController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  TextEditingController telefonoController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  // TextEditingController confirmPasswordController = new TextEditingController();

  UsuariosProvider usuariosProvider = new UsuariosProvider();

  Future? init(BuildContext context) {
    this.context = context;
    usuariosProvider.init(context);
  }

  void goToLoginPage() {
    Navigator.pushNamed(context!, 'login');
  }

  void register() async{
    String nombre = nombreController.text;
    String apellido = apellidoController.text;
    String email = emailController.text.trim();
    String telefono = telefonoController.text.trim();
    String password = passwordController.text.trim();
    // String confirmPassword = confirmPasswordController.text.trim();
    if (email.isEmpty || nombre.isEmpty || apellido.isEmpty ||telefono.isEmpty || password.isEmpty) {
      MySnackbar.show(context!, 'Debes ingresar todos los campos');
      return;
    } else {
      if (password.length < 6){
        MySnackbar.show(context!, 'La contraseña debe tener al menos 6 caracteres');
        return;
      } else {
        Usuario usuario = new Usuario(
            nombreUsuario: nombre +' '+ apellido,
            correoUsuario: email,
            telefonoUsuario: int.parse(telefono),
            contrasenia: password,
            estadoUsuario: '1',
            roles: []
        );

        ResponseApi? responseApi = await usuariosProvider.create(usuario);
        MySnackbar.show(context!, responseApi?.message);

        if (responseApi!.success!){
          Future.delayed(Duration(seconds: 3), () {
            Navigator.pushReplacementNamed(context!, 'login');
          });
        }

        print('RESPUESTA: ${responseApi?.toJson()}');
        print(nombre +' '+apellido);
        print(email);
        print(telefono);
        print(password);
      }
    }
    // if (confirmPassword != password) {
    //   MySnackbar.show(context, 'Las contraseñas no coinciden');
    //   return;
    // }
    // print(confirmPassword);
  }
}