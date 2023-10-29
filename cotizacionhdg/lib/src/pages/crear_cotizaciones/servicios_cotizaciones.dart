import 'package:cotizaciones_hdg/src/models/servicios_model.dart';
import 'package:cotizaciones_hdg/src/pages/crear_cotizaciones/servicios_cotizaciones_controller.dart';
import 'package:cotizaciones_hdg/src/styles/estilos.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class ServiciosCotizacionesPage extends StatefulWidget {
  const ServiciosCotizacionesPage({super.key});

  @override
  State<ServiciosCotizacionesPage> createState() =>
      _ServiciosCotizacionesPageState();
}

class _ServiciosCotizacionesPageState extends State<ServiciosCotizacionesPage> {
  late List<Servicio?> servicios;
  ServiciosCotizacionesController _con = new ServiciosCotizacionesController();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      servicios = [];
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
                Positioned(top: -4, bottom: -5, child: _imgFondoNube()),
                Positioned(top: 0, bottom: 0, child: _fondoOpaco()),
                Positioned(
                  top: 70,
                  right: 40,
                  child: _textCerrarSesion(),
                ),
                Positioned(top: 57, right: 2, child: _iconBack()),
                Container(
                  width: double.infinity,
                  margin: EdgeInsets.only(top: 110),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        _textBienvenido(),
                          SizedBox(height: MediaQuery.of(context).size.height * 0.04),
                        Column(
                          children: _con.servicios != null
                              ? [_serviciosEnPares(_con.servicios!)]
                            //     ? _con.servicios!.map<Widget>((Servicio? servicio) {
                            //   return _cardServicios(servicio!);
                            // }).toList()
                           : [
                            _textBienvenido(),
                        SizedBox(height: MediaQuery.of(context).size.height * 0.04),
                        _imagesServicios(),
                      ],
                        )
                      ]
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
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      SizedBox(height: MediaQuery.of(context).size.height * 0.02),
      Text(
        _con.nombre_empresa ?? 'EMPRESA HDG',
        //   'Helicópteros de Guatemala',
          style: TextStyle(
              color: Colors.white, fontSize: 40, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center),
      SizedBox(height: 5),
      Text('SERVICIOS', style: TextStyle(color: Colors.white, fontSize: 20))
    ]);
  }

  //   Widget _cardServicios(Servicio servicios) {
  //   return GestureDetector(
  //     onTap: () {
  //       _con.goToDescripcionServicioPage(servicios.id_servicio, _con.id_empresa, _con.nombre_empresa);
  //     },
  //     child: Container(
  //       height: 140,
  //       width: 189,
  //       margin: EdgeInsets.all(8.0), // Espacio entre cada tarjeta de servicio
  //       decoration: BoxDecoration(
  //         image: DecorationImage(
  //           image: servicios.imagenencabezado != null
  //               ? AssetImage(servicios.imagenencabezado.toString())
  //               : AssetImage('assets/img/hdg.png'),
  //           fit: BoxFit.fill,
  //         ),
  //         boxShadow: [
  //           new BoxShadow(
  //             color: MyColors.primaryColor,
  //             offset: Offset(1, 5),
  //             blurRadius: 10,
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

// En tu widget que muestra las tarjetas de servicios en pares

  Widget _cardServicios(Servicio servicios) {
    return GestureDetector(
      onTap: () {
        _con.goToDescripcionServicioPage(servicios.id_servicio, _con.id_empresa, _con.nombre_empresa);
      },
      child: Container(
        height: 140,
        width: 189,
        margin: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: servicios.imagenencabezado != null
                ? Image.network(servicios.imagenencabezado.toString()).image
                : AssetImage('assets/img/hdg.png'),
            fit: BoxFit.fill,
          ),
          boxShadow: [
            BoxShadow(
              color: MyColors.primaryColor,
              offset: Offset(1, 5),
              blurRadius: 10,
            ),
          ],
        ),
      ),
    );
  }

  Widget _serviciosEnPares(List<Servicio?> servicios) {
    List<Widget> rows = [];
    for (int i = 0; i < servicios.length; i += 2) {
      // Crear una fila con dos tarjetas de servicio
      List<Widget> rowChildren = [];
      if (i < servicios.length) {
        rowChildren.add(_cardServicios(servicios[i]!));
      }
      if (i + 1 < servicios.length) {
        rowChildren.add(_cardServicios(servicios[i + 1]!));
      }
      rows.add(Row(
        children: rowChildren,
      ));
    }

    return Column(
      children: rows,
    );
  }

  Widget _imagesServicios() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: _con.goToDescripcionServicioPagePRUEBA,
              child: Container(
                height: 100,
                width: 150,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/img/helibiz.jpg'),
                        fit: BoxFit.fill),
                    boxShadow: [
                      new BoxShadow(
                          color: MyColors.primaryColor,
                          offset: Offset(1, 5),
                          blurRadius: 10)
                    ]),
              ),
            ),
            SizedBox(width: MediaQuery.of(context).size.width * 0.10),
            GestureDetector(
              onTap: _con.goToLoginPage,
              child: Container(
                height: 100,
                width: 150,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/img/helibiz.jpg'),
                        fit: BoxFit.fill),
                    boxShadow: [
                      new BoxShadow(
                          color: MyColors.primaryColor,
                          offset: Offset(1, 5),
                          blurRadius: 10)
                    ]),
              ),
            )
          ],
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.02),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: _con.goToLoginPage,
              child: Container(
                height: 100,
                width: 150,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/img/helibiz.jpg'),
                        fit: BoxFit.fill),
                    boxShadow: [
                      new BoxShadow(
                          color: MyColors.primaryColor,
                          offset: Offset(1, 5),
                          blurRadius: 10)
                    ]),
              ),
            ),
            SizedBox(width: MediaQuery.of(context).size.width * 0.10),
            GestureDetector(
              onTap: _con.goToLoginPage,
              child: Container(
                height: 100,
                width: 150,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/img/helibiz.jpg'),
                        fit: BoxFit.fill),
                    boxShadow: [
                      new BoxShadow(
                          color: MyColors.primaryColor,
                          offset: Offset(1, 5),
                          blurRadius: 10)
                    ]),
              ),
            )
          ],
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.02),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: _con.goToLoginPage,
              child: Container(
                height: 100,
                width: 150,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/img/helibiz.jpg'),
                        fit: BoxFit.fill),
                    boxShadow: [
                      new BoxShadow(
                          color: MyColors.primaryColor,
                          offset: Offset(1, 5),
                          blurRadius: 10)
                    ]),
              ),
            ),
            SizedBox(width: MediaQuery.of(context).size.width * 0.10),
            GestureDetector(
              onTap: _con.goToLoginPage,
              child: Container(
                height: 100,
                width: 150,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/img/helibiz.jpg'),
                        fit: BoxFit.fill),
                    boxShadow: [
                      new BoxShadow(
                          color: MyColors.primaryColor,
                          offset: Offset(1, 5),
                          blurRadius: 10)
                    ]),
              ),
            )
          ],
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.02),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: _con.goToLoginPage,
              child: Container(
                height: 100,
                width: 150,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/img/helibiz.jpg'),
                        fit: BoxFit.fill),
                    boxShadow: [
                      new BoxShadow(
                          color: MyColors.primaryColor,
                          offset: Offset(1, 5),
                          blurRadius: 10)
                    ]),
              ),
            ),
            SizedBox(width: MediaQuery.of(context).size.width * 0.10),
            GestureDetector(
              onTap: _con.goToLoginPage,
              child: Container(
                height: 100,
                width: 150,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/img/helibiz.jpg'),
                        fit: BoxFit.fill),
                    boxShadow: [
                      new BoxShadow(
                          color: MyColors.primaryColor,
                          offset: Offset(1, 5),
                          blurRadius: 10)
                    ]),
              ),
            )
          ],
        ),
      ],
    );
  }

  void refresh() {
    setState(() {
    });
  }
}

// Widget _cardServicios(Servicio servicios) {
//   return Column(
//     children: [
//       Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           GestureDetector(
//             onTap: () {_con.goToDescripcionServicioPage(servicios.id_servicio);},
//             child: Container(
//               height: 200,
//               width: 250,
//               decoration: BoxDecoration(
//                   image: DecorationImage(
//                       image: servicios.imagenencabezado != null
//                           ? AssetImage(servicios.imagenencabezado.toString())
//                           : AssetImage('assets/img/hdg.png'), fit: BoxFit.fill),
//                   boxShadow: [
//                     new BoxShadow(
//                         color: MyColors.primaryColor,
//                         offset: Offset(1, 5),
//                         blurRadius: 10)
//                   ]),
//             ),
//
//           ),
//           SizedBox(width: MediaQuery.of(context).size.width * 0.10),
//         ],
//       ),
//       SizedBox(height: MediaQuery.of(context).size.height * 0.02),
//     ],
//   );
// }
