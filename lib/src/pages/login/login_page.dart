import 'package:cotizaciones_hdg/src/pages/login/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:cotizaciones_hdg/src/styles/estilos.dart';
import 'package:flutter/scheduler.dart';
import 'package:url_launcher/url_launcher.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  LoginController _con = new LoginController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _con.init(context);

    // SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
    //   _con.init(context);
    // });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: MyColors.primaryColor,
        ),
        width: MediaQuery.of(context).size.width * 1,
        height: double.infinity,
        child: Stack(
          children: [
            Positioned(
                top: -4,
                bottom: -5,
                child: _imgFondoNube()
            ),
            Positioned(
                top: 0,
                bottom: 0,
                child: _fondoOpaco()
            ),
            SingleChildScrollView(
              child: Column(
                children: [
                  _imgCorporacion(),
                  _textFieldEmail(),
                  _textFieldContrasenia(),
                  _buttonLogin(),
                  _textNoTienesCuenta(),
                  SizedBox(height: 20),
                  _textLoginOtros(),
                  SizedBox(height: 12),
                  _buttonGoogle(),
                  _buttonOutlook(),

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _imgCorporacion() {
    return Container(
      margin: EdgeInsets.only(
          top: 120, bottom: MediaQuery.of(context).size.height * 0.08
      ),
      height: 200,
      width: 200,
      decoration: BoxDecoration(
        borderRadius: new BorderRadius.circular(150),
        image: DecorationImage(
          image: AssetImage('assets/img/hdg.png'), fit: BoxFit.cover,
        ),
        boxShadow: [
          new BoxShadow(
            color: MyColors.primaryColor,
            offset: Offset(1, 5),
            blurRadius: 3
          )
        ]
      ),
    );
  }

  Widget _imgFondoNube() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.6,
      child: Image.asset('assets/img/fondoNube.jpg'),
    );
  }

  Widget _fondoOpaco() {
    return Container(
      width: MediaQuery.of(context).size.height * 0.51,
      decoration: BoxDecoration(
        color: MyColors.fondoColorOpacity,
      ),
    );
  }

  Widget _buttonLogin() {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
      child: ElevatedButton(
        onPressed: _con.login,
        // onPressed: _con.goToClientePage,
        // onPressed: _con.goToAdminPage,
        // onPressed: _con.goToVendedorPage,
        child: Text('INGRESAR'),
        style: ElevatedButton.styleFrom(
            backgroundColor: MyColors.secondaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            padding: EdgeInsets.symmetric(vertical: 10)
        ),
      ),
    );
  }

  Widget _textNoTienesCuenta() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          '¿No tienes cuenta?',
          style: TextStyle(color: MyColors.primaryColor),
        ),
        SizedBox(width: 7),
        GestureDetector(
          onTap: _con.goToRegisterPage,
          child: Text(
            'Regístrate',
            style: TextStyle(
                fontWeight: FontWeight.bold, color: MyColors.primaryColor),
          ),
        ),
      ],
    );
  }

  Widget _textLoginOtros() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('O bien, inicia sesión con...', style: TextStyle(color: MyColors.primaryColor)
        ),
      ]);
  }

  Widget _buttonGoogle() {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 100),
      child: ElevatedButton(
        onPressed: () async {String url = "https://www.google.com";},
        child: Text(
            'Inicia sesión con Google',
          style: TextStyle(
              color: MyColors.scondaryOpacityColor
          ),
        ),
        style: ElevatedButton.styleFrom(
            backgroundColor: MyColors.tercerColorOpacity,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            ),
            padding: EdgeInsets.symmetric(vertical: 1)
        ),
      ),
    );
  }

  Widget _buttonOutlook() {
    return Container(
      width: double.infinity,
      // margin: EdgeInsets.symmetric(horizontal: 80, vertical: 1),
      margin: EdgeInsets.only(left: 100, right: 100, top: 0, bottom: 20),
      child: ElevatedButton(
        onPressed: () async {String url = "https://www.outlook.com";},
        child: Text(
            'Inicia sesión con Outlook',
          style: TextStyle(
            color: MyColors.scondaryOpacityColor
          ),
        ),
        style: ElevatedButton.styleFrom(
            backgroundColor: MyColors.tercerColorOpacity,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            padding: EdgeInsets.symmetric(vertical: 1)
        ),
      ),
    );
  }

  Widget _textFieldContrasenia() {
    return Container(
      margin: EdgeInsets.only(left: 50, right: 50, top: 10, bottom: 10),
      decoration: BoxDecoration(
          color: MyColors.primaryOpacityColor,
          borderRadius: BorderRadius.circular(30)
      ),
      child: TextField(
        controller: _con.passwordController,
        obscureText: true,
        decoration: InputDecoration(
            hintText: 'Contraseña',
            border: InputBorder.none,
            contentPadding: EdgeInsets.all(15),
            hintStyle: TextStyle(
                color: Colors.white60
            ),
            prefixIcon: Icon(
                Icons.lock,
                color: Colors.white60
            )
        ),
      ),
    );
  }
  Widget _textFieldEmail() {
    return Container(
      margin: EdgeInsets.only(left: 50, right: 50, top: 20, bottom: 5),
      decoration: BoxDecoration(
          color: MyColors.primaryOpacityColor,
          borderRadius: BorderRadius.circular(30)
      ),
      child: TextField(
        controller: _con.emailController,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
            hintText: 'Correo electrónico',
            border: InputBorder.none,
            contentPadding: EdgeInsets.all(15),
            hintStyle: TextStyle(
                color: Colors.white60
            ),
            prefixIcon: Icon(
                Icons.email,
                color: Colors.white60
            )
        ),
      ),
    );
  }
}
