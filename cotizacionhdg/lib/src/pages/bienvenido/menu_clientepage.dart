import 'package:cotizaciones_hdg/src/pages/bienvenido/menu_cliente_controller.dart';
import 'package:flutter/material.dart';

import '../../styles/estilos.dart';

class MenuClientePage extends StatefulWidget {
  const MenuClientePage({super.key});

  @override
  State<MenuClientePage> createState() => _MenuClientePageState();
}

class _MenuClientePageState extends State<MenuClientePage> {
  MenuClienteController _con = new MenuClienteController();

  void refresh() {
    setState(() {
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
    _con.init(context, refresh);
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('CLIENTE'),
        ),
        body: Container(
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
                Positioned(
                  top: 90,
                  right: 40,
                  child: _textCerrarSesion(),
                ),
                Positioned(
                    top: 77,
                    right: 2,
                    child: _iconBack()
                ),
                Container(
                  width: double.infinity,
                  margin: EdgeInsets.only(top: 110),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        _textBienvenido(),
                        SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                        _buttonCrearCotizacion(),
                        SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                        _buttonCotizaciones(),
                        SizedBox(height: MediaQuery.of(context).size.height * 0.02)
                      ],
                    ),
                  ),
                )
              ],
            )
        )
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

  Widget _textCerrarSesion() {
    return GestureDetector(
      onTap: _con.logout,
      child: Text(
        'SALIR',
        style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 18,
            fontFamily: 'NimbusSans'
        ),
      ),
    );
  }

  Widget _iconBack() {
    return IconButton(
        onPressed: _con.logout,
        icon: Icon(Icons.exit_to_app, color: Colors.white)
    );
  }

  Widget _textBienvenido(){
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: MediaQuery.of(context).size.height * 0.06),
          Text(
              'BIENVENIDO/A',
              style: TextStyle(color: Colors.white, fontSize: 40, fontWeight: FontWeight.bold)
          ), SizedBox(height: 5),
          Text(
            // '"Mariam"',
              _con.usuario?.nombreUsuario ?? "USUARIOs",
              // _con.usuario!.nombreUsuario.toString(),
              style: TextStyle(color: Colors.white, fontSize: 35, fontWeight: FontWeight.bold)
          )
        ]);
  }

  Widget _buttonCrearCotizacion() {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
      child: ElevatedButton(
        // onPressed: _con.login,
        onPressed: _con.goToCrearCotizaciones,
        child: Text('Crear Cotización', style: TextStyle(fontSize: 21)),
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

  Widget _buttonCotizaciones() {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
      child: ElevatedButton(
        // onPressed: _con.login,
        // onPressed: _con.goToClientePage,
        onPressed: _con.goToVerCotizacionesCliente,
        child: Text('Ver Cotizaciones', style: TextStyle(fontSize: 21)),
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

}

