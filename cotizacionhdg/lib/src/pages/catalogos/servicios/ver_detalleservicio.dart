import 'package:cotizaciones_hdg/src/models/caracteristicas_model.dart';
import 'package:cotizaciones_hdg/src/pages/catalogos/servicios/ver_detalleservicio_controller.dart';
import 'package:flutter/material.dart';

import '../../../styles/estilos.dart';

class VerDetalleServicioPage extends StatefulWidget {
  const VerDetalleServicioPage({super.key});

  @override
  State<VerDetalleServicioPage> createState() => _VerDetalleServicioPageState();
}

class _VerDetalleServicioPageState extends State<VerDetalleServicioPage> {
  VerDetalleServicioController _con = new VerDetalleServicioController();

  bool bhabilitar = false;
  String? selectedCaracteristicaValue;
  String? selectedCaracteristicaText;

  void refresh() {
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _con.init(context, refresh);
  }

  @override
  Widget build(BuildContext context) {
    String txtAppBar = '';
    if (bhabilitar == false){
      txtAppBar = 'Servicios> Ver Servicio';
    } else {
      txtAppBar = 'Servicios> Editar Servicio';
    }
    return Scaffold(
        appBar: AppBar(
          title: Text('${txtAppBar}', style: TextStyle(fontSize: 19),),
        ),
        body: Container(
            width: MediaQuery.of(context).size.width * 1,
            height: double.infinity,
            child: Stack(
              children: [
                Positioned(top: -4, bottom: -5, child: _imgFondoNube()),
                Positioned(top: 0, bottom: 0, child: _fondoOpaco()),
                Positioned(
                  top: 30,
                  right: 40,
                  child: _textCerrarSesion(),
                ),
                Positioned(top: 17, right: 2, child: _iconBack()),
                Container(
                  width: double.infinity,
                  margin: EdgeInsets.only(top: 60),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        _textBienvenido(),
                        SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                        _textNombre(),
                        _textFieldNombre(),
                        _textSalidaUbicacion(),
                        _textFieldSalidaUbicacion(),
                        _textImagen(),
                        _textFieldImagen(),
                        _textDuracion(),
                        _textFieldDuracion(),
                        _textEmpresa(),
                        _textFieldEmpresa(),
                        _textPrecio(),
                        _textFieldPrecio(),
                        _textDescripcion(),
                        _textFieldDescripcion(),
                        _textCaracteristica(),
                        if (bhabilitar == false)
                          _textFieldCaracteristica()
                        else
                          Column(
                            children: _con.caracteristicastlist != null
                                ? [  _dropdownCaracteristica(_con.caracteristicastlist),  ]
                                : [],
                          ),
                        SizedBox(height: MediaQuery.of(context).size.height * 0.002),
                        _botones()
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
          if (bhabilitar == false)
            Text('VER SERVICIO',
                style: TextStyle(
                    color: Colors.white, fontSize: 40, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center)
          else
            Text('EDITAR SERVICIO',
                style: TextStyle(
                    color: Colors.white, fontSize: 40, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center)
        ]
    );
  }
  Widget _textNombre(){
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 5),
      alignment: Alignment.centerLeft,
      child: Text('Nombre Servicio',
        style: TextStyle(color: Colors.black45, fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }
  Widget _textDescripcion(){
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 5),
      alignment: Alignment.centerLeft,
      child: Text('Descripción',
        style: TextStyle(color: Colors.black45, fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }
  Widget _textCaracteristica(){
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 5),
      alignment: Alignment.centerLeft,
      child: Text('Característica',
        style: TextStyle(color: Colors.black45, fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }
  Widget _textSalidaUbicacion(){
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 5),
      alignment: Alignment.centerLeft,
      child: Text('Salida Ubicación',
        style: TextStyle(color: Colors.black45, fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }
  Widget _textPrecio(){
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 5),
      alignment: Alignment.centerLeft,
      child: Text('Precio Servicio',
        style: TextStyle(color: Colors.black45, fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }
  Widget _textImagen(){
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 5),
      alignment: Alignment.centerLeft,
      child: Text('Imagen Encabezado',
        style: TextStyle(color: Colors.black45, fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }
  Widget _textDuracion(){
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 5),
      alignment: Alignment.centerLeft,
      child: Text('Duración Servicio en Horas',
        style: TextStyle(color: Colors.black45, fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }
  Widget _textEmpresa(){
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 5),
      alignment: Alignment.centerLeft,
      child: Text('Empresa Servicio',
        style: TextStyle(color: Colors.black45, fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }
  Widget _textFieldNombre() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 5),
      decoration: BoxDecoration(
          color: MyColors.primaryOpacityColor,
          borderRadius: BorderRadius.circular(30)
      ),
      child:
      TextField(
        controller: _con.nombreservicioController,
        enabled: bhabilitar,
        decoration: InputDecoration(
            hintText: 'Nombre Servicio',
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
  Widget _textFieldDescripcion() {
    return Container(
      height: 200,
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 5),
      decoration: BoxDecoration(
          color: MyColors.primaryOpacityColor,
          borderRadius: BorderRadius.circular(30)
      ),
      child: SingleChildScrollView(
        child: TextField(
          controller: _con.descricionController,
          enabled: bhabilitar,
          maxLines: null,
          decoration: InputDecoration(
              hintText: 'Descripcion Servicio',
              border: InputBorder.none,
              contentPadding: EdgeInsets.all(15),
              hintStyle: TextStyle(
                  color: Colors.white60
              ),
          ),
        ),
      ),
    );
  }
  Widget _textFieldCaracteristica() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 5),
      decoration: BoxDecoration(
          color: MyColors.primaryOpacityColor,
          borderRadius: BorderRadius.circular(30)
      ),
      child: TextField(
        controller: _con.caracteristicaController,
        enabled: bhabilitar,
        decoration: InputDecoration(
            hintText: 'Característica Servicio',
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
  Widget _textFieldSalidaUbicacion() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 5),
      decoration: BoxDecoration(
          color: MyColors.primaryOpacityColor,
          borderRadius: BorderRadius.circular(30)
      ),
      child: TextField(
        controller: _con.salidaUbicacionController,
        enabled: bhabilitar,
        decoration: InputDecoration(
            hintText: 'Salida Ubicación',
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
        enabled: bhabilitar,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
            hintText: 'Precio Servicio',
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
  Widget _textFieldDuracion() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 5),
      decoration: BoxDecoration(
          color: MyColors.primaryOpacityColor,
          borderRadius: BorderRadius.circular(30)
      ),
      child: TextField(
        controller: _con.duracionController,
        enabled: bhabilitar,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
            hintText: 'Duracion Servicio en Horas',
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
  Widget _textFieldImagen() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 5),
      decoration: BoxDecoration(
          color: MyColors.primaryOpacityColor,
          borderRadius: BorderRadius.circular(30)
      ),
      child: TextField(
        controller: _con.imagenEncabezadoController,
        enabled: bhabilitar,
        decoration: InputDecoration(
            hintText: 'Imagen Servicio',
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
        enabled: bhabilitar,
        decoration: InputDecoration(
            hintText: 'Empresa Servicio',
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

  Widget _dropdownCaracteristica(List<Caracteristicas?> caracteristicas) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        DropdownButton<String>(
          value: selectedCaracteristicaValue ?? (caracteristicas.isNotEmpty ? caracteristicas[0]?.idCaracteristica.toString() : '1'),
          onChanged: (newValue) {
            setState(() {
              selectedCaracteristicaValue = newValue!;
              selectedCaracteristicaText = _con.caracteristicastlist
                  .firstWhere((caracteristicas) =>
              caracteristicas?.idCaracteristica.toString() ==
                  newValue)
                  ?.descripcion ??
                  'ROL';
            });
          },
          items: _con.caracteristicastlist
              .map((Caracteristicas? caracteristica) {
            return DropdownMenuItem<String>(
              value: caracteristica?.idCaracteristica.toString() ??
                  '1',
              child: Text(caracteristica?.descripcion ??
                  'caracteristica servicio'),
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
        minimumSize: Size(MediaQuery.of(context).size.height * 0.28, 0),
      ),
    );
  }
  Widget _buttonCancelar() {
    return  ElevatedButton(
      onPressed: () {_con.cancelar();},
      child: Text('CANCELAR'),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.red[900],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        padding: EdgeInsets.symmetric(vertical: 10),
        minimumSize: Size(MediaQuery.of(context).size.height * 0.28, 0),
      ),
    );
  }

  Widget _buttonBorrar() {
    return ElevatedButton(
      onPressed: () {_mostrarDialogoDeBorrar(context);},// _con.eliminarCaracteristica(_con.idCaracteristica);
      child: Text('BORRAR'),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.red[900],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        padding: EdgeInsets.symmetric(vertical: 10),
        minimumSize: Size(MediaQuery.of(context).size.height * 0.16, 0),
      ),
    );
  }

  Widget _botones() {
    return Container(
      width: double.infinity,
      alignment: Alignment.center,
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
      child: Column(
        children: [
          if (bhabilitar == false)
            Row( // Envolver los botones en un Row
              children: [
                _buttonEditar(),
                SizedBox(width: MediaQuery.of(context).size.width * 0.04),
                _buttonBorrar(),
              ],
            )
          else
            Column(
              children: [
                _buttonGuardar(),
                // SizedBox(height: MediaQuery.of(context).size.height * 0.04),
                _buttonCancelar(),
              ],
            )
        ],
      ),
    );
  }


  Widget _buttonEditar() {
    return ElevatedButton(
      onPressed: () {bhabilitar = true; refresh();},// _con.guardarCotizacionServiavia()
      child: Text('EDITAR'),
      style: ElevatedButton.styleFrom(
        backgroundColor: MyColors.secondaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        padding: EdgeInsets.symmetric(vertical: 10),
        minimumSize: Size(MediaQuery.of(context).size.height * 0.16, 0),
      ),
    );
  }

  void _mostrarDialogoDeConfirmacion(BuildContext context) {
    int? caracteristica = int.parse(selectedCaracteristicaValue!);
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Editar Servicio'),
          backgroundColor: MyColors.fondoColorOpacity,
          content: Text('¿Desea editar el servicio ${_con.nombreservicioController.text}?'),
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
                // print(rol);
                _con.guardarServicio(caracteristica);
              },
            ),
          ],
        );
      },
    );
  }

  void _mostrarDialogoDeBorrar(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Eliminar Servicio'),
          backgroundColor: MyColors.fondoColorOpacity,
          content: Text('¿Desea eliminar el servicio: ${_con.nombreservicioController.text}?'),
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
                _con.eliminarServicio(_con.servicios?.id_servicio, _con.id_empresa);
              },
            ),
          ],
        );
      },
    );
  }

}
