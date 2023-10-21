import 'package:cotizaciones_hdg/src/models/caracteristicas_model.dart';
import 'package:cotizaciones_hdg/src/models/medida_model.dart';
import 'package:cotizaciones_hdg/src/models/multimedia_model.dart';
import 'package:cotizaciones_hdg/src/models/tipocombustible_model.dart';
import 'package:cotizaciones_hdg/src/models/ubicaciones_model.dart';
import 'package:cotizaciones_hdg/src/pages/crear_cotizaciones/descripcion_servicio_controller.dart';
import 'package:cotizaciones_hdg/src/styles/estilos.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

class DescripcionServicioPage extends StatefulWidget {
  const DescripcionServicioPage({super.key});

  @override
  State<DescripcionServicioPage> createState() =>
      _DescripcionServicioPageState();
}

class _DescripcionServicioPageState extends State<DescripcionServicioPage> {
  DescripcionServicioController _con = new DescripcionServicioController();

  String? selectedUbicacionOption; // Valor seleccionado por defecto
  String selectedUbicacionText = 'Ubicacion';
  String? selectedCombustibleValue;
  String selectedCombustibleText = 'Tipo Combustible';
  // Lista de controladores para los TextField
  List<TextEditingController> textControllers = [];
  // Lista de valores ingresados en los TextField
  List<String> textFieldValues = [];
  TextEditingController medidaController = TextEditingController();
  final KeyboardVisibilityController _keyboardVisibilityController =
  KeyboardVisibilityController();
  String textFieldValue = '';
  String? medida;
  int? IDcaracteristicaServicio;
  String caracteristicaServicio = '';

  void refresh() {
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      _con.init(context, refresh);
    });
    _keyboardVisibilityController.onChange.listen((bool isVisible) {
      if (isVisible) {
        // El teclado está visible, puedes ajustar la posición de tu contenido aquí
        // Por ejemplo, puedes usar un SingleChildScrollView o un SingleChildScrollView + SingleChildScrollView para envolver tu contenido y hacerlo desplazable cuando aparezca el teclado.
      } else {
        // El teclado se ha ocultado, puedes restaurar la posición de tu contenido aquí
      }
    });
  }

  @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //       body: Container(
  //           width: MediaQuery.of(context).size.width * 1,
  //           height: double.infinity,
  //           child: Stack(
  //             children: [
  //               Positioned(top: -4, bottom: -5, child: _imgFondoNube()),
  //               Positioned(top: 0, bottom: 0, child: _fondoOpaco()),
  //               Positioned(
  //                 top: 90,
  //                 right: 40,
  //                 child: _textCerrarSesion(),
  //               ),
  //               Positioned(top: 77, right: 2, child: _iconBack()),
  //               Container(
  //                 width: double.infinity,
  //                 margin: EdgeInsets.only(top: 110),
  //                 child: SingleChildScrollView(
  //                   child: Column(
  //                     children: [
  //                       _textBienvenido(),
  //                       SizedBox(
  //                           height: MediaQuery.of(context).size.height * 0.04),
  //                       _textDescripcion(),
  //                       // _imagesServicios(),
  //                       Column(
  //                         children: _con.servicios?.multimedia != null
  //                             ? _con.servicios!.multimedia.map((multimedia) {
  //                           return _cardMultimedia(multimedia);
  //                         }).toList()
  //                             : [],
  //                       ),
  //                       SizedBox(
  //                           height: MediaQuery.of(context).size.height * 0.03),
  //                       // _txtCaracteristica(),
  //                       // SizedBox( height: MediaQuery.of(context).size.height * 0.02),
  //                       Column(
  //                         children: _con.servicios?.caracteristicas != null
  //                             ? [
  //                           _cardCaracteristicas(
  //                               _con.servicios!.caracteristicas)
  //                         ]
  //                             : [],
  //                       ),
  //                       SizedBox(
  //                           height: MediaQuery.of(context).size.height * 0.04),
  //                       _btnCotizar(),
  //                       // _inputCaracteristicas(),
  //                       SizedBox(
  //                           height: MediaQuery.of(context).size.height * 0.03)
  //                     ],
  //                   ),
  //                 ),
  //               )
  //             ],
  //           )));
  // }
  Widget build(BuildContext context) {
    return Scaffold(
      body: KeyboardVisibilityBuilder(
        builder: (context, isKeyboardVisible) {
          return Container(
            width: MediaQuery.of(context).size.width * 1,
            height: double.infinity,
            child: Stack(
              children: [
                Positioned(top: -4, bottom: -5, child: _imgFondoNube()),
                Positioned(top: 0, bottom: 0, child: _fondoOpaco()),
                Positioned(
                  top: 90,
                  right: 40,
                  child: _textCerrarSesion(),
                ),
                Positioned(top: 77, right: 2, child: _iconBack()),
                Container(
                  width: double.infinity,
                  margin: EdgeInsets.only(top: 110),
                  child: SingleChildScrollView(
                    // Ajusta el desplazamiento según la visibilidad del teclado
                    padding: EdgeInsets.only(
                      bottom: isKeyboardVisible
                          ? MediaQuery.of(context).viewInsets.bottom
                          : 0,
                    ),
                    child: Column(
                      children: [
                        _textBienvenido(),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.04),
                        _textDescripcion(),
                        Column(
                          children: _con.servicios?.multimedia != null
                              ? _con.servicios!.multimedia.map((multimedia) {
                            return _cardMultimedia(multimedia);
                          }).toList()
                              : [],
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.03),
                        Column(
                          children: _con.servicios?.caracteristicas != null
                              ? [
                            _cardCaracteristicas(
                                _con.servicios!.caracteristicas)
                          ]
                              : [],
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.04),
                        _btnCotizar(),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.03)
                      ],
                    ),
                  ),
                )
              ],
            ),
          );
        },
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
      Text(_con.servicios?.nombre ?? 'SERVICIO',
          style: TextStyle(
              color: Colors.white, fontSize: 50, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center),
      SizedBox(height: 5),
      //   Text('TRASLADO EJECUTIVO',
      //       style: TextStyle(color: Colors.white, fontSize: 20))
    ]);
  }

  Widget _textDescripcion() {
    String descripcion = _con.servicios?.descripcion ?? 'ES UN SERVICIO';
    // Dividir el texto en párrafos usando el punto como separador
    List<String> parrafos = descripcion.split('.');
    // Unir los párrafos con saltos de línea
    String textoFormateado = parrafos.join('\n\n');

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        children: [
          Text(textoFormateado,
              textAlign: TextAlign.justify,
              style: TextStyle(color: Colors.white, fontSize: 25)),
          SizedBox(height: MediaQuery.of(context).size.height * 0.04),
          Text('GALERÍA',
              textAlign: TextAlign.justify,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold))
        ],
      ),
    );
  }

  Widget _numericTextField([TextEditingController? controller]) { //[TextEditingController? controller, String? initialValue]
    return Container(
      width: 60,
      child: TextFormField(
        controller: controller,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(left: 20),
        ),
        style: TextStyle(fontSize: 25),
        onChanged: (newValue) {
          textFieldValue = newValue;
        },
      ),
    );
  }

  // Widget _txtFieldMedida(
  //     String? descripcion, TextEditingController controller, int index) {
  //   return Container(
  //     width: 80,
  //     height: 25,
  //     decoration: BoxDecoration(
  //         color: Colors.white70, borderRadius: BorderRadius.circular(30)),
  //     child: TextField(
  //       controller: controller,
  //       keyboardType: TextInputType.number,
  //       decoration: InputDecoration(
  //         hintText: descripcion ?? 'Medida',
  //         border: InputBorder.none,
  //         contentPadding: EdgeInsets.only(top: -22, left: 10),
  //         hintStyle: TextStyle(color: Colors.grey),
  //       ),
  //       style: TextStyle(fontSize: 14),
  //       onEditingComplete: () {
  //         String newText = controller.text;
  //         if (index >= 0 && index < textFieldValues.length) {
  //           textFieldValues[index] = newText;
  //         }
  //         FocusScope.of(context).unfocus();
  //       },
  //     ),
  //   );
  // }
  //
  // Widget _txtFieldMedidaCombustible(String? descripcion,
  //     [TextEditingController? controller]) {
  //   controller ??= TextEditingController();
  //   return Container(
  //     width: 80,
  //     height: 25,
  //     // margin: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.10),
  //     decoration: BoxDecoration(
  //         color: Colors.white70, borderRadius: BorderRadius.circular(30)),
  //     child: TextField(
  //       controller: controller,
  //       keyboardType: TextInputType.number,
  //       decoration: InputDecoration(
  //         hintText: descripcion ?? 'Medida',
  //         border: InputBorder.none,
  //         contentPadding: EdgeInsets.only(top: -22, left: 10),
  //         hintStyle: TextStyle(color: Colors.grey),
  //         // hintStyle: TextStyle(letterSpacing: 5),
  //       ),
  //       style: TextStyle(fontSize: 14),
  //     ),
  //   );
  // }

  Widget _textMedida(String? abreviatura) {
    return Container(
        margin: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.10),
        child: Text(abreviatura ?? 'Cant.',
            style: TextStyle(color: Colors.white, fontSize: 17)));
  }

  Widget _cardMultimedia(Multimedia multimedia) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        height: MediaQuery.of(context).size.height * 0.3,
        width: MediaQuery.of(context).size.width * 0.9,
        margin: EdgeInsets.all(8.0), // Espacio entre cada tarjeta de servicio
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(multimedia?.multimedia ?? 'assets/img/hdg.png'),
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

  Widget _cardCaracteristicas(List<Caracteristicas?> caracteristicas) {
    return SingleChildScrollView(
      child: Column(
        children: [
          ListView.builder(
            shrinkWrap: true,
            itemCount: caracteristicas.length,
            itemBuilder: (context, index) {
              String? descripcion = caracteristicas[index]?.descripcion;
              IDcaracteristicaServicio = caracteristicas[index]?.idCaracteristica;
              caracteristicaServicio = caracteristicas[index]!.descripcion!;
              List<Medida>? medidas = caracteristicas[index]?.medidas;
              bool mostrarMedida = medidas != null && medidas.isNotEmpty;
              String? abreviatura =
              medidas!.isNotEmpty ? medidas[0].abreviatura : 'Cant.';
              String? descmedida = medidas!.isNotEmpty ? medidas[0].descripcionMedida : 'Cant.';
              medida = descmedida;
              // String? descripcionMedida =
              // medidas!.isNotEmpty ? medidas[0].descripcionMedida : 'Medida';
              // int? idMedida =
              // medidas!.isNotEmpty ? (medidas[0].idMedida as int?) : null;

              if (descripcion == 'Ubicaciones') {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      descripcion ?? 'CARACTERÍSTICAS',
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    DropdownButton<String>(
                      value: selectedUbicacionOption ??
                          _con.ubicaciones[0]?.idUbicacion.toString() ??
                          '1',
                      onChanged: (newValue) {
                        if (newValue != null) {
                          setState(() {
                            selectedUbicacionOption = newValue;
                            // Obtén el texto del elemento seleccionado
                            selectedUbicacionText = _con.ubicaciones
                                .firstWhere((ubicacion) =>
                            ubicacion?.idUbicacion.toString() ==
                                newValue)
                                ?.nombreUbicacion ??
                                'Ubicacion';
                          });
                          _con.buscarCombustible(
                              int.tryParse(selectedUbicacionOption!) ?? 1,
                              refresh);
                        }
                      },
                      items: _con.ubicaciones.map((Ubicaciones? ubicacion) {
                        return DropdownMenuItem<String>(
                          value: ubicacion?.idUbicacion.toString() ?? '1',
                          child:
                          Text(ubicacion?.nombreUbicacion ?? 'Ubicacion'),
                        );
                      }).toList(),
                    ),
                    if (mostrarMedida)
                      Row(
                        children: [
                          SizedBox(
                              width: MediaQuery.of(context).size.width * 0.25),
                          _textMedida(abreviatura),
                          _numericTextField(
                            // descripcionMedida,
                            // controller,
                            // idMedida?.toString() ?? '0'
                          ),

                        ],
                      ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                  ],
                );
              } else if (descripcion == 'Tipo Combustible') {
                // refresh();
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      descripcion ?? 'CARACTERÍSTICAS',
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    if (_con.resultado == false) // Verificar si la lista no está vacía
                      Text(
                        'No hay combustibles disponibles', // O cualquier otro mensaje de tu elección
                        style: TextStyle(
                          color:
                          Colors.red, // O cualquier otro color que desees
                        ),
                      )
                    else
                      Column(
                        children: [
                          DropdownButton<String>(
                            value: selectedCombustibleValue ??
                                _con.tipocombustible[0]?.idCombustible.toString() ??
                                '1',
                            onChanged: (newValue) {
                              setState(() {
                                selectedCombustibleValue = newValue!;
                                selectedCombustibleText = _con.tipocombustible
                                    .firstWhere((combustible) =>
                                combustible?.idCombustible.toString() ==
                                    newValue)
                                    ?.marcaCombustible ??
                                    'Combustible';
                              });
                            },
                            items: _con.tipocombustible
                                .map((TipoCombustible? tipocombustible) {
                              return DropdownMenuItem<String>(
                                value: tipocombustible?.idCombustible.toString() ??
                                    '1',
                                child: Text(tipocombustible?.marcaCombustible ??
                                    'Combustible'),
                              );
                            }).toList(),
                          ),
                          // Coloca el condicional aquí
                          if (mostrarMedida)
                            Row(
                              children: [
                                SizedBox(
                                    width: MediaQuery.of(context).size.width * 0.25),
                                _textMedida(abreviatura),
                                _numericTextField(
                                  // descripcionMedida,
                                  // controller,
                                  // idMedida?.toString() ?? '0'
                                ),
                              ],
                            ),
                        ],
                      ),

                    SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                  ],
                );
              } else {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      descripcion ?? 'CARACTERÍSTICAS',
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                      Column(
                        children: [
                          if (mostrarMedida)
                            Row(
                              children: [
                                SizedBox(
                                    width: MediaQuery.of(context).size.width * 0.25),
                                _textMedida(abreviatura),
                                _numericTextField(
                                  // descripcionMedida,
                                  // controller,
                                  // idMedida?.toString() ?? '0'
                                ),
                              ],
                            ),
                        ],
                      ),

                    SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                  ],
                );
                // if (mostrarMedida) {
                //   TextEditingController controller = TextEditingController(
                //     text: idMedida?.toString() ?? '0',
                //   );
                //   textControllers.add(controller);
                //   widgets.add(
                //     Row(
                //       children: [
                //         SizedBox(
                //             width: MediaQuery.of(context).size.width * 0.25),
                //         _textMedida(abreviatura),
                //         _numericTextField(
                //           // descripcionMedida,
                //           // controller,
                //           // idMedida?.toString() ?? '0'
                //         ),
                //       ],
                //     ),
                //   );
                // }
                // widgets.add(
                //   SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                // );
                //
                // return Column(
                //   crossAxisAlignment: CrossAxisAlignment.center,
                //   children: widgets,
                // );
              }
            },
          ),
        ],
      ),
    );
  }

  void capturarValores() {
    for (int i = 0; i < textControllers.length; i++) {
      String valor = textControllers[i].text;
      textFieldValues[i] = valor;
    }
  }

  // void capturarmedidacomsubtible() {
  //   // Asigna el controlador al TextField creado por _txtFieldMedidaCombustible
  //   Widget textFieldWidget =
  //       _txtFieldMedidaCombustible('Medida', medidaController);
  //   // No es necesario obtener el valor aquí
  // }

  Widget _btnCotizar() {
    return GestureDetector(
      onTap: () {
        capturarValores();
        // capturarmedidacomsubtible();
        String nombreServicio = _con.servicios?.nombre ?? '';
        String codServicio = _con.servicios?.id_servicio.toString() ?? '';
        String codEmpresa = _con.servicios?.cod_empresa.toString() ?? '';
        String nombreEmpresa = _con.nombre_empresa ?? 'empresa';
        // String cantidadMedida = medidaController.text;
        print('empresa manda coti: ${_con.id_empresa}');
        print('$IDcaracteristicaServicio, $caracteristicaServicio');
        // print("codEmpresa:$codEmpresa, nombreServicio:$nombreServicio, cantidadMedida:$textFieldValue,textFieldValues:$textFieldValues, "
        //     "selectedUbicacionOption:$selectedUbicacionOption, selectedUbicacionText:$selectedUbicacionText, selectedCombustibleValue:$selectedCombustibleValue, selectedCombustibleText:$selectedCombustibleText");
        if (_con.id_empresa == 1){
          _con.goToFormularioCotizacionHdgPage(
              codEmpresa,
              nombreEmpresa,
              codServicio,
              nombreServicio,
              textFieldValue,
              medida,
              IDcaracteristicaServicio,
              caracteristicaServicio
          );
        } else if (_con.id_empresa == 2) {
          _con.goToFormularioCotizacionPage(
              codEmpresa,
              nombreEmpresa,
              codServicio,
              nombreServicio,
              textFieldValue,
              medida,
              selectedUbicacionOption,
              selectedUbicacionText,
              selectedCombustibleValue,
              selectedCombustibleText);
        }
        },
      child: Text('COTIZAR',
          textAlign: TextAlign.justify,
          style: TextStyle(
              color: Colors.white,
              fontSize: 30,
              fontWeight: FontWeight.bold,
              decoration: TextDecoration.underline)),
    );
  }

}

// Widget _imagesServicios() {
//   return Column(
//     children: [
//       GestureDetector(
//         onTap: () {},
//         child: Container(
//           height: MediaQuery.of(context).size.height * 0.3,
//           width: MediaQuery.of(context).size.width * 0.9,
//           decoration: BoxDecoration(
//               image: DecorationImage(
//                   image: AssetImage('assets/img/helibiz.jpg'),
//                   fit: BoxFit.fill),
//               boxShadow: [
//                 new BoxShadow(
//                     color: MyColors.primaryColor,
//                     offset: Offset(1, 5),
//                     blurRadius: 10)
//               ]),
//         ),
//       ),
//       SizedBox(height: MediaQuery.of(context).size.height * 0.03),
//       GestureDetector(
//         onTap: () {},
//         child: Container(
//           height: MediaQuery.of(context).size.height * 0.3,
//           width: MediaQuery.of(context).size.width * 0.9,
//           decoration: BoxDecoration(
//               image: DecorationImage(
//                   image: AssetImage('assets/img/hdg.png'), fit: BoxFit.fill),
//               boxShadow: [
//                 new BoxShadow(
//                     color: MyColors.primaryColor,
//                     offset: Offset(1, 5),
//                     blurRadius: 10)
//               ]),
//         ),
//       ),
//       SizedBox(height: MediaQuery.of(context).size.height * 0.07),
//       Text('CARACTERÍSTICAS',
//           textAlign: TextAlign.justify,
//           style: TextStyle(
//               color: Colors.white,
//               fontSize: 30,
//               fontWeight: FontWeight.bold)),
//       SizedBox(height: MediaQuery.of(context).size.height * 0.02),
//     ],
//   );
// }

// Widget _inputCaracteristicas() {
//   return Column(
//     children: [
//       Text('CARACTERÍSTICAS',
//           textAlign: TextAlign.justify,
//           style: TextStyle(
//               color: Colors.white,
//               fontSize: 30,
//               fontWeight: FontWeight.bold)),
//       Row(
//         children: [
//           SizedBox(width: MediaQuery.of(context).size.width * 0.10),
//           Text('Desayuno',
//               style: TextStyle(
//                   color: MyColors.primaryColor,
//                   fontSize: 20,
//                   fontWeight: FontWeight.bold)),
//           SizedBox(width: MediaQuery.of(context).size.width * 0.34),
//           Text('Tour',
//               style: TextStyle(
//                   color: MyColors.primaryColor,
//                   fontSize: 20,
//                   fontWeight: FontWeight.bold))
//         ],
//       ),
//       SizedBox(height: MediaQuery.of(context).size.height * 0.005),
//       Row(
//         children: [
//           _textCantidad(),
//           _textField(),
//           SizedBox(width: MediaQuery.of(context).size.width * 0.20),
//           _textCantidad(),
//           _textField()
//         ],
//       ),
//       SizedBox(height: MediaQuery.of(context).size.height * 0.02),
//       Row(
//         children: [
//           SizedBox(width: MediaQuery.of(context).size.width * 0.10),
//           Text('Almuerzo',
//               style: TextStyle(
//                   color: MyColors.primaryColor,
//                   fontSize: 20,
//                   fontWeight: FontWeight.bold)),
//           SizedBox(width: MediaQuery.of(context).size.width * 0.34),
//           Text('Cena',
//               style: TextStyle(
//                   color: MyColors.primaryColor,
//                   fontSize: 20,
//                   fontWeight: FontWeight.bold))
//         ],
//       ),
//       SizedBox(height: MediaQuery.of(context).size.height * 0.005),
//       Row(
//         children: [
//           _textCantidad(),
//           _textField(),
//           SizedBox(width: MediaQuery.of(context).size.width * 0.20),
//           _textCantidad(),
//           _textField(),
//         ],
//       ),
//       SizedBox(height: MediaQuery.of(context).size.height * 0.02),
//       Row(
//         children: [
//           SizedBox(width: MediaQuery.of(context).size.width * 0.10),
//           Text('Hospedaje',
//               style: TextStyle(
//                   color: MyColors.primaryColor,
//                   fontSize: 20,
//                   fontWeight: FontWeight.bold)),
//           SizedBox(width: MediaQuery.of(context).size.width * 0.32),
//           Text('Piscina',
//               style: TextStyle(
//                   color: MyColors.primaryColor,
//                   fontSize: 20,
//                   fontWeight: FontWeight.bold))
//         ],
//       ),
//       SizedBox(height: MediaQuery.of(context).size.height * 0.005),
//       Row(
//         children: [
//           _textCantidad(),
//           _textField(),
//           SizedBox(width: MediaQuery.of(context).size.width * 0.20),
//           _textCantidad(),
//           // _textField(),
//         ],
//       ),
//       SizedBox(height: MediaQuery.of(context).size.height * 0.07),
//       GestureDetector(
//         onTap: () {
//           _con.goToFormularioCotizacionPage(_con.servicios?.nombre);
//         },
//         child: Text('COTIZAR',
//             textAlign: TextAlign.justify,
//             style: TextStyle(
//                 color: Colors.white,
//                 fontSize: 30,
//                 fontWeight: FontWeight.bold,
//                 decoration: TextDecoration.underline)),
//       ),
//       SizedBox(height: MediaQuery.of(context).size.height * 0.02),
//     ],
//   );
// }

// Widget _txtCaracteristica() {
//   return Column(
//     children: [
//       Text('CARACTERÍSTICAS',
//           textAlign: TextAlign.justify,
//           style: TextStyle(
//               color: Colors.white,
//               fontSize: 30,
//               fontWeight: FontWeight.bold)),
//     ],
//   );
// }
// Widget _caracteristicasenPares(List<Caracteristicas?> caracteristicas) {
//   List<Widget> rows = [];
//   for (int i = 0; i < caracteristicas.length; i += 2) {
//     // Crear una fila con dos tarjetas de servicio
//     List<Widget> rowChildren = [];
//     if (i < caracteristicas.length) {
//       rowChildren.add(_cardCaracteristicas(caracteristicas[i]!));
//     }
//     if (i + 1 < caracteristicas.length) {
//       rowChildren.add(_cardCaracteristicas(caracteristicas[i + 1]!));
//     }
//     rows.add(Row(
//       children: rowChildren,
//     ));
//   }
//   return Column(
//     children: rows,
//   );
// }