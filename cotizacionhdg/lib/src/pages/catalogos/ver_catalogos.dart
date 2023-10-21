import 'package:cotizaciones_hdg/src/pages/catalogos/ver_catalogos_controller.dart';
import 'package:cotizaciones_hdg/src/styles/estilos.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class VerCatalogosPage extends StatefulWidget {
  const VerCatalogosPage({super.key});

  @override
  State<VerCatalogosPage> createState() => _VerCatalogosPageState();
}

class _VerCatalogosPageState extends State<VerCatalogosPage> {
  VerCatalogosController _con = new VerCatalogosController();

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
                        _buttonCaracteristicas(),
                        SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                        // if (_con.nombre_empresa == 'SERVIAVIA')
                        // _buttonAeronaves()
                        // else
                        // SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                        _buttonServicios(),
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
              'Ver',
              style: TextStyle(color: Colors.white, fontSize: 35, fontWeight: FontWeight.bold)
          ), SizedBox(height: 5),
          Text(
              'Catálogos',
              style: TextStyle(color: Colors.white, fontSize: 35, fontWeight: FontWeight.bold)
          )
        ]);
  }

  Widget _buttonCaracteristicas() {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
      child: ElevatedButton(
        // onPressed: _con.login,
        onPressed: () {_con.goToCaracteristicasPage();},
        child: Text('Características', style: TextStyle(fontSize: 21)),
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

  Widget _buttonAeronaves() {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
      child: ElevatedButton(
        // onPressed: _con.login,
        // onPressed: _con.goToClientePage,
        onPressed: _con.goToLoginPage,
        child: Text('Aeronaves', style: TextStyle(fontSize: 21)),
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

  Widget _buttonServicios() {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
      child: ElevatedButton(
        // onPressed: _con.login,
        // onPressed: _con.goToClientePage,
        onPressed: () {_con.goToAdministrarServiciosPage();},
        child: Text('Servicios', style: TextStyle(fontSize: 21)),
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
