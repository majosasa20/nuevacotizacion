
import 'package:cotizaciones_hdg/src/models/medida_model.dart';
import 'package:cotizaciones_hdg/src/pages/catalogos/caracteristicas/crear_caracteristicas_controller.dart';
import 'package:cotizaciones_hdg/src/styles/estilos.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import '../../../models/caracteristicas_model.dart';

class CrearCaracteristica extends StatefulWidget {
  const CrearCaracteristica({super.key});

  @override
  State<CrearCaracteristica> createState() => _CrearCaracteristicaState();
}

class _CrearCaracteristicaState extends State<CrearCaracteristica> {
  CrearCaracteristicaController _con = new CrearCaracteristicaController();
  String? selectedMedidaValue;
  String? selectedMedidaText;

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
                  margin: EdgeInsets.only(top: 110),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        _textBienvenido(),
                        SizedBox(height: MediaQuery.of(context).size.height * 0.04),
                        _textDescripcion(),
                        _textFieldDescripcion(),
                        _textEmpresa(),
                        _textFieldEmpresa(),
                        _textPrecio(),
                        _textFieldPrecio(),
                        _textMedida(),
                        Column(
                          children: _con.medidas != null
                              ? [  _dropdownMedida(_con.medidas),  ]
                              : [],
                        ),
                        SizedBox(height: MediaQuery.of(context).size.height * 0.1),
                        _buttonGuardar(),
                        SizedBox(width: MediaQuery.of(context).size.width * 0.04),
                        _buttonCancelar()
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
    return Column(mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: MediaQuery.of(context).size.height * 0.02),
          Text('CREAR CARACTERÍSTICA',
              style: TextStyle(
                  color: Colors.white, fontSize: 40, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center)
        ]
    );
  }
  Widget _textDescripcion(){
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 5),
      alignment: Alignment.centerLeft,
      child: Text('Nombre Característica',
        style: TextStyle(color: Colors.black45, fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }
  Widget _textEmpresa(){
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 5),
      alignment: Alignment.centerLeft,
      child: Text('Empresa',
        style: TextStyle(color: Colors.black45, fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }
  Widget _textPrecio(){
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 5),
      alignment: Alignment.centerLeft,
      child: Text('Precio',
        style: TextStyle(color: Colors.black45, fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }
  Widget _textMedida(){
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 5),
      alignment: Alignment.centerLeft,
      child: Text('Medida',
        style: TextStyle(color: Colors.black45, fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }
  Widget _textFieldDescripcion() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 5),
      decoration: BoxDecoration(
          color: MyColors.primaryOpacityColor,
          borderRadius: BorderRadius.circular(30)
      ),
      child:
      TextField(
        controller: _con.descripcionController,
        decoration: InputDecoration(
            hintText: 'Característica',
            border: InputBorder.none,
            contentPadding: EdgeInsets.all(15),
            hintStyle: TextStyle(
                color: Colors.white60
            ),
            prefixIcon: Icon(
                Icons.airplanemode_active_rounded,
                color: Colors.white60
            )
        ),
      ),
    );
  }
  Widget _textFieldEmpresa() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 5),
      decoration: BoxDecoration(
          color: MyColors.primaryOpacityColor,
          borderRadius: BorderRadius.circular(30)
      ),
      child: TextField(
        controller: _con.empresaController,
        enabled: false,
        decoration: InputDecoration(
            hintText: 'Empresa',
            border: InputBorder.none,
            contentPadding: EdgeInsets.all(15),
            hintStyle: TextStyle(
                color: Colors.white60
            ),
            prefixIcon: Icon(
                Icons.airplanemode_active_rounded,
                color: Colors.white60
            )
        ),
      ),
    );
  }
  Widget _textFieldPrecio() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 5),
      decoration: BoxDecoration(
          color: MyColors.primaryOpacityColor,
          borderRadius: BorderRadius.circular(30)
      ),
      child: TextField(
        controller: _con.precioController,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
            hintText: 'Precio',
            border: InputBorder.none,
            contentPadding: EdgeInsets.all(15),
            hintStyle: TextStyle(
                color: Colors.white60
            ),
            prefixIcon: Icon(
                Icons.airplanemode_active_rounded,
                color: Colors.white60
            )
        ),
      ),
    );
  }
  Widget _dropdownMedida(List<Medida?> medidas) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
              DropdownButton<String>(
                value: selectedMedidaValue ?? (medidas.isNotEmpty ? medidas[0]?.idMedida.toString() : '1'),
                onChanged: (newValue) {
                  setState(() {
                    selectedMedidaValue = newValue!;
                    selectedMedidaText = _con.medidas
                        .firstWhere((medidas) =>
                    medidas?.idMedida.toString() ==
                        newValue)
                        ?.descripcionMedida ??
                        'MEDIDA';
                  });
                },
                items: _con.medidas
                    .map((Medida? medida) {
                  return DropdownMenuItem<String>(
                    value: medida?.idMedida.toString() ??
                        '1',
                    child: Text(medida?.descripcionMedida ??
                        'Combustible'),
                  );
                }).toList(),
              ),
            ],
    );
  }

  Widget _buttonGuardar() {
    return  ElevatedButton(
      onPressed:() {_mostrarDialogoDeConfirmacion(context);},//  _con.guardarCotizacionServiavia,
      child: Text('GUARDAR'),
      style: ElevatedButton.styleFrom(
        backgroundColor: MyColors.secondaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        padding: EdgeInsets.symmetric(vertical: 10),
        minimumSize: Size(250, 0),
      ),
    );
  }
  Widget _buttonCancelar() {
    return  ElevatedButton(
      onPressed: () {_con.cancelar(_con.id_empresa, _con.nombre_empresa);},
      child: Text('CANCELAR'),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.red[900],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        padding: EdgeInsets.symmetric(vertical: 10),
        minimumSize: Size(250, 0),
      ),
    );
  }

  void _mostrarDialogoDeConfirmacion(BuildContext context) {
    String? medida = selectedMedidaValue;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Crear Característica'),
          backgroundColor: MyColors.fondoColorOpacity,
          content: Text('¿Desea crear la característica ${_con.descripcionController.text} en la empresa ${_con.empresaController.text}?'),
          actions: <Widget>[
            TextButton(
              child: Text('No', style: TextStyle(color: Colors.white),),
              onPressed: () {
                Navigator.of(context).pop(); // Cerrar el diálogo
              },
            ),
            TextButton(
              child: Text('Sí', style: TextStyle(color: Colors.white)),
              onPressed: () {
                Navigator.of(context).pop(); // Cerrar el diálogo
                print(medida);
                _con.guardarCaracteristica(medida);
              },
            ),
          ],
        );
      },
    );
  }
}
