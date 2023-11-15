import 'package:cotizaciones_hdg/src/pages/bienvenido/menuadministrador_controller.dart';
import 'package:cotizaciones_hdg/src/pages/bienvenido/vendedorpage_controller.dart';
import 'package:cotizaciones_hdg/src/styles/estilos.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import '../../models/empresas_model.dart';

class InicioVendedorPage extends StatefulWidget {
  const InicioVendedorPage({super.key});

  @override
  State<InicioVendedorPage> createState() => _InicioVendedorPageState();
}

class _InicioVendedorPageState extends State<InicioVendedorPage> {
  VendedorPageController _con = new VendedorPageController();
  late List<Empresas?> empresas2;

  void refresh() {
    setState(() {});
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
            width: MediaQuery
                .of(context)
                .size
                .width * 1,
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
                  top: 30,
                  right: 40,
                  child: _textCerrarSesion(),
                ),
                Positioned(
                    top: 17,
                    right: 2,
                    child: _iconExit()
                ),
                Container(
                  width: double.infinity,
                  margin: EdgeInsets.only(top: 70),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        _textBienvenido(),
                        SizedBox(height: MediaQuery
                            .of(context)
                            .size
                            .height * 0.02),
                        _textIngresoSistema(),
                        SizedBox(height: MediaQuery
                            .of(context)
                            .size
                            .height * 0.03),
                        Column(
                          children:
                          _con.empresas != null
                          ? [_cardEmpresa(_con.empresas!)]
                              : [ SizedBox(height: MediaQuery.of(context).size.height * 0.02)],
                        )
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
      height: MediaQuery
          .of(context)
          .size
          .height * 0.6,
      child: Image.asset('assets/img/fondoNube.jpg'),
    );
  }

  Widget _fondoOpaco() {
    return Container(
      width: MediaQuery
          .of(context)
          .size
          .height * 0.51,
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

  Widget _iconExit() {
    return IconButton(
        onPressed: _con.logout,
        icon: Icon(Icons.exit_to_app, color: Colors.white)
    );
  }

  Widget _textBienvenido() {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: MediaQuery
              .of(context)
              .size
              .height * 0.06),
          Text(
              'Vendedor',
              style: TextStyle(color: Colors.white,
                  fontSize: 35,
                  fontWeight: FontWeight.bold)
          ), SizedBox(height: 5),
          Text(
              _con.usuario?.nombreUsuario ?? 'Usuario',
              style: TextStyle(color: Colors.white,
                  fontSize: 35,
                  fontWeight: FontWeight.bold)
          )
        ]);
  }

  Widget _cardEmpresa(Empresas empresas) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
                empresas.nombreEmpresa ?? 'EMPRESA',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.bold)
            ),
          ],
        ),
        GestureDetector(
          onTap: () {
            _con.goToMenuVendedor(empresas.idEmpresa, empresas.nombreEmpresa);
            // _con.goToServiciosCotizaciones(empresas.idEmpresa, empresas.nombreEmpresa);
          },
          child: Container(
            height: 150,
            width: 150,
            decoration: BoxDecoration(
                borderRadius: new BorderRadius.circular(150),
                image: DecorationImage(
                    image: empresas.imagen != null ? AssetImage(
                        empresas.imagen.toString()) : AssetImage(
                        'assets/img/hdg.png'), fit: BoxFit.fill),
                boxShadow: [
                  new BoxShadow(
                      color: MyColors.primaryColor,
                      offset: Offset(1, 5),
                      blurRadius: 10
                  )
                ]
            ),
          ),
        ),
        SizedBox(height: MediaQuery
            .of(context)
            .size
            .height * 0.04),
      ],
    );
  }

  Widget _textIngresoSistema() {
    return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            flex: 1,
            child: Text(
              'Selecciona la empresa en la cual deseas ingresar al sistema...',
              style: TextStyle(color: MyColors.primaryColor, fontSize: 25),
              textAlign: TextAlign.center,
            ),
          )
        ]
    );
  }

}