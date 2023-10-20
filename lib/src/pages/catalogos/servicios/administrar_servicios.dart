import 'package:cotizaciones_hdg/src/pages/administrar_usuarios/admin_usuariosEmpresaController.dart';
import 'package:cotizaciones_hdg/src/pages/catalogos/servicios/administrar_servicios_controller.dart';
import 'package:cotizaciones_hdg/src/styles/estilos.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import '../../../models/servicios_model.dart';

class AdministrarServicioxEmpresaPage extends StatefulWidget {
  const AdministrarServicioxEmpresaPage({super.key});

  @override
  State<AdministrarServicioxEmpresaPage> createState() => _AdministrarServicioxEmpresaPageState();
}

class _AdministrarServicioxEmpresaPageState extends State<AdministrarServicioxEmpresaPage> {
  late List<Servicio?> servicios;
  AdministrarServiciosxEmpresaController _con = new AdministrarServiciosxEmpresaController();

  void refresh() {
    setState(() {
    });
  }

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      servicios = [];
      _con.init(context, refresh);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('ADMINISTRADOR'),
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
                  top: 50,
                  right: 40,
                  child: _textCerrarSesion(),
                ),
                Positioned(
                    top: 37,
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
                        Column(
                          children: _con.servicios != null
                              ? [_buttonServicios(_con.servicios!)]
                              : [],
                        ),
                        SizedBox(height: MediaQuery.of(context).size.height * 0.1),
                        _buttonCrear()
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
          Text(
              'SERVICIOS',
              style: TextStyle(color: Colors.white, fontSize: 40, fontWeight: FontWeight.bold)
          ), SizedBox(height: 5),
          Text(
              _con.nombre_empresa?.toString() ?? "EMPRESA",
              // _con.usuario!.nombreUsuario.toString(),
              style: TextStyle(color: Colors.white, fontSize: 35, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
          )
        ]);
  }

  Widget _buttonServicios(List<Servicio?> servicios) {
    return Column(
      children: servicios.map((servicio) {
        return Container(
          width: double.infinity,
          margin: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
          child: ElevatedButton(
            onPressed: () { _con.goToDetalleServicio(servicio?.id_servicio);},
            child: Text('${servicio?.nombre ?? 'SERVICIO'}',
              style: TextStyle(fontSize: 21),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: MyColors.secondaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              padding: EdgeInsets.symmetric(vertical: 10),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buttonCrear() { //_con.crearCaracteristica(_con.id_empresa, _con.nombre_empresa);
    return GestureDetector(
      onTap: () {_con.crearServicios();},
      child: Text('CREAR SERVICIO',
          textAlign: TextAlign.justify,
          style: TextStyle(
              color: Colors.indigo[900],
              fontSize: 25,
              fontWeight: FontWeight.bold,
              decoration: TextDecoration.underline)
      ),

    );
  }

}
