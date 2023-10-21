import 'package:cotizaciones_hdg/src/pages/administrar_cotizaciones/cotizaciones_clientes/cotizaciones_clientes_controller.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../models/cotizacion_model.dart';
import '../../../styles/estilos.dart';

class CotizacionesClientes extends StatefulWidget {
  const CotizacionesClientes({super.key});

  @override
  State<CotizacionesClientes> createState() => _CotizacionesClientesState();
}

class _CotizacionesClientesState extends State<CotizacionesClientes> {
  CotizacionesClienteController _con = new CotizacionesClienteController();
  late List<Cotizacion?> cotizaciones;
  final DateFormat dateFormat = DateFormat('dd-MM-yyyy');

  void refresh() {
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _con.init(context, refresh);
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
                Positioned(top: -4, bottom: -5, child: _imgFondoNube()),
                Positioned(top: 0, bottom: 0, child: _fondoOpaco()),
                Positioned(
                  top: 50,
                  right: 40,
                  child: _textCerrarSesion(),
                ),
                Positioned(top: 37, right: 2, child: _iconBack()),
                Container(
                  width: double.infinity,
                  margin: EdgeInsets.only(top: 80),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        _textBienvenido(),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.05),
                        Column(
                          children: _con.cotizaciones != null
                              ? [_buttonCotizaciones(_con.cotizaciones)]
                              : [
                                SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                                _textSinCotizaciones()
                                ],
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.1),
                      ],
                    ),
                  ),
                )
              ],
            )));
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
            fontFamily: 'NimbusSans'),
      ),
    );
  }

  Widget _iconBack() {
    return IconButton(
        onPressed: _con.logout,
        icon: Icon(Icons.exit_to_app, color: Colors.white));
  }

  Widget _textBienvenido() {
    print(_con.usuarios?.nombreUsuario);
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Text('COTIZACIONES de',
          style: TextStyle(
              color: Colors.white, fontSize: 40, fontWeight: FontWeight.bold)),
      SizedBox(height: 5),
      Text(_con.usuarios?.nombreUsuario ?? "USUARIO",
          style: TextStyle(
              color: Colors.white, fontSize: 35, fontWeight: FontWeight.bold))
    ]);
  }
  Widget _textSinCotizaciones() {
    // print(_con.usuarios?.nombreUsuario);
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Text('No hay cotización de este usuario',
          style: TextStyle(
              color: Colors.redAccent, fontSize: 35, fontWeight: FontWeight.bold))
    ]);
  }

  Widget _buttonCotizaciones(List<Cotizacion?> cotizaciones) {
    return Column(
      children: cotizaciones.map((cotizacion) {
        String fechaFormateada = dateFormat.format(cotizacion?.fechaservicio ?? DateTime.now());
        return Container(
          width: double.infinity,
          margin: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
          child: ElevatedButton(
            onPressed: () {
              _con.goToDetalleCotizacion(cotizacion?.id_cotizacion);
            },
            child: Column(
              children: [
                Text(
                  '${cotizacion?.id_cotizacion} ${cotizacion?.nombreServicio ?? 'SERVICIO'}',
                  style: TextStyle(fontSize: 21),
                ),
                Text(
                  '${cotizacion?.nombreUsuario ?? 'USUARIO'} $fechaFormateada',
                  style: TextStyle(fontSize: 18),
                ),
              ],
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
}
