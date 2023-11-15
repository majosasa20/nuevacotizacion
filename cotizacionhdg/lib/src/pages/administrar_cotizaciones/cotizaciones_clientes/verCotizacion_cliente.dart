import 'package:cotizaciones_hdg/src/pages/administrar_cotizaciones/cotizaciones_clientes/verCotizacion_cliente_controller.dart';
import 'package:flutter/material.dart';

import '../../../styles/estilos.dart';

class VerCotizacionCliente extends StatefulWidget {
  const VerCotizacionCliente({super.key});

  @override
  State<VerCotizacionCliente> createState() => _VerCotizacionClienteState();
}

class _VerCotizacionClienteState extends State<VerCotizacionCliente> {
  VerCotizacionClienteController _con = new VerCotizacionClienteController();

  void refresh() {
    setState(() {});
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _con.init(context, refresh);
  }

  @override
  Widget build(BuildContext context) {
    // String txtAppBar = '';
    // if (_con.cotizaciones != null) {
    //   txtAppBar =  '${_con.cotizaciones!.nombreUsuario}';
    // } else {
    //   // Lógica para cuando _con.cotizaciones es nulo
    // }
    return Scaffold(
        appBar: AppBar(
          title: Text('Cotizaciones Cliente> Ver Cotización', style: TextStyle(fontSize: 17),),
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
                  margin: EdgeInsets.only(top: 110),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        _textBienvenido(),
                        SizedBox(height: MediaQuery.of(context).size.height * 0.04),
                        _textServicio(),
                        _textFieldServicio(),
                        _textCliente(),
                        _textFieldCliente(),
                        _textCorreo(),
                        _textFieldCorreo(),
                        _textNumero(),
                        _textFieldTelefono(),
                        _textDestino(),
                        _textFieldDestino(),
                        _textCaracteristica(),
                        _textFieldCaracteristica(),
                        _textFechaServicio(),
                        _textFieldFechaServicio(),
                        _textFechaOrden(),
                        _textFieldFechaSolicitud(),
                        _textEstado(),
                        _textFieldEstado(),
                        _textObservaciones(),
                        _textFieldFObservaciones(),
                        _botones(),
                        SizedBox(height: MediaQuery.of(context).size.height * 0.1),
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
          if (_con.cotizaciones?.nombre_empresa == 'SERVIAVIA')
            Text('ORDEN COMPRA #${_con.idCotizacion ?? 'Cliente'}',
                style: TextStyle(
                    color: Colors.white, fontSize: 40, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center)
          else
            Text('COTIZACIÓN #${_con.idCotizacion ?? 'Cliente'}',
                style: TextStyle(
                    color: Colors.white, fontSize: 40, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center)
        ]
    );
  }
  Widget _textServicio(){
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 5),
      alignment: Alignment.centerLeft,
      child: Text('Servicio',
        style: TextStyle(color: Colors.black45, fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }
  Widget _textCliente(){
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 5),
      alignment: Alignment.centerLeft,
      child: Text('Nombre Cliente',
        style: TextStyle(color: Colors.black45, fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }
  Widget _textCorreo(){
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 5),
      alignment: Alignment.centerLeft,
      child: Text('Correo Cliente',
        style: TextStyle(color: Colors.black45, fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }
  Widget _textNumero(){
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 5),
      alignment: Alignment.centerLeft,
      child: Text('Teléfono Cliente',
        style: TextStyle(color: Colors.black45, fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }
  Widget _textEstado(){
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 5),
      alignment: Alignment.centerLeft,
      child: Text('Estado Orden',
        style: TextStyle(color: Colors.black45, fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }
  Widget _textDestino(){
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 5),
      alignment: Alignment.centerLeft,
      child: Text('Destino Orden',
        style: TextStyle(color: Colors.black45, fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }
  Widget _textCaracteristica(){
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 5),
      alignment: Alignment.centerLeft,
      child: Text('Detalle Orden',
        style: TextStyle(color: Colors.black45, fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }
  Widget _textObservaciones(){
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 5),
      alignment: Alignment.centerLeft,
      child: Text('Observaciones',
        style: TextStyle(color: Colors.black45, fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }
  Widget _textFechaServicio(){
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 5),
      alignment: Alignment.centerLeft,
      child: Text('Fecha Servicio Orden',
        style: TextStyle(color: Colors.black45, fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }
  Widget _textFechaOrden(){
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 5),
      alignment: Alignment.centerLeft,
      child: Text('Fecha Genera Solicitud',
        style: TextStyle(color: Colors.black45, fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }
  Widget _textFieldServicio() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 5),
      decoration: BoxDecoration(
          color: MyColors.primaryOpacityColor,
          borderRadius: BorderRadius.circular(30)
      ),
      child:
      TextField(
        controller: _con.servicioController,
        enabled: false,
        decoration: InputDecoration(
          hintText: 'Servicio',
          border: InputBorder.none,
          contentPadding: EdgeInsets.all(15),
          hintStyle: TextStyle(
              color: Colors.white60
          ),
          // prefixIcon: Icon(
          //     Icons.airplanemode_active_rounded,
          //     color: Colors.white60
          // )
        ),
      ),
    );
  }
  Widget _textFieldCliente() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 5),
      decoration: BoxDecoration(
          color: MyColors.primaryOpacityColor,
          borderRadius: BorderRadius.circular(30)
      ),
      child:
      TextField(
        controller: _con.clienteController,
        enabled: false,
        decoration: InputDecoration(
          hintText: 'Cliente',
          border: InputBorder.none,
          contentPadding: EdgeInsets.all(15),
          hintStyle: TextStyle(
              color: Colors.white60
          ),
          // prefixIcon: Icon(
          //     Icons.airplanemode_active_rounded,
          //     color: Colors.white60
          // )
        ),
      ),
    );
  }
  Widget _textFieldCorreo() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 5),
      decoration: BoxDecoration(
          color: MyColors.primaryOpacityColor,
          borderRadius: BorderRadius.circular(30)
      ),
      child: TextField(
        controller: _con.correoclienteController,
        enabled: false,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          hintText: 'Correo cliente',
          border: InputBorder.none,
          contentPadding: EdgeInsets.all(15),
          hintStyle: TextStyle(
              color: Colors.white60
          ),
          // prefixIcon: Icon(
          //    Icons.airplanemode_active_rounded,
          //     color: Colors.white60
          // )
        ),
      ),
    );
  }
  Widget _textFieldTelefono() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 5),
      decoration: BoxDecoration(
          color: MyColors.primaryOpacityColor,
          borderRadius: BorderRadius.circular(30)
      ),
      child: TextField(
        controller: _con.telefonoclienteController,
        enabled: false,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          hintText: 'Teléfono Cliente',
          border: InputBorder.none,
          contentPadding: EdgeInsets.all(15),
          hintStyle: TextStyle(
              color: Colors.white60
          ),
          // prefixIcon: Icon(
          //     Icons.airplanemode_active_rounded,
          //     color: Colors.white60
          // )
        ),
      ),
    );
  }
  Widget _textFieldEstado() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 5),
      decoration: BoxDecoration(
          color: MyColors.primaryOpacityColor,
          borderRadius: BorderRadius.circular(30)
      ),
      child: TextField(
        controller: _con.estadoCotizacionController,
        enabled: false,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          hintText: 'Teléfono Cliente',
          border: InputBorder.none,
          contentPadding: EdgeInsets.all(15),
          hintStyle: TextStyle(
              color: Colors.white60
          ),
          // prefixIcon: Icon(
          //     Icons.airplanemode_active_rounded,
          //     color: Colors.white60
          // )
        ),
      ),
    );
  }

  Widget _textFieldDestino() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 5),
      decoration: BoxDecoration(
          color: MyColors.primaryOpacityColor,
          borderRadius: BorderRadius.circular(30)
      ),
      child: TextField(
        controller: _con.destinoController,
        enabled: false,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          hintText: 'Destino Servicio',
          border: InputBorder.none,
          contentPadding: EdgeInsets.all(15),
          hintStyle: TextStyle(
              color: Colors.white60
          ),
          // prefixIcon: Icon(
          //     Icons.airplanemode_active_rounded,
          //     color: Colors.white60
          // )
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
        enabled: false,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          hintText: 'Detalle Servicio',
          border: InputBorder.none,
          contentPadding: EdgeInsets.all(15),
          hintStyle: TextStyle(
              color: Colors.white60
          ),
          // prefixIcon: Icon(
          //     Icons.airplanemode_active_rounded,
          //     color: Colors.white60
          // )
        ),
      ),
    );
  }
  Widget _textFieldFechaServicio() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 5),
      decoration: BoxDecoration(
          color: MyColors.primaryOpacityColor,
          borderRadius: BorderRadius.circular(30)
      ),
      child: TextField(
        controller: _con.fechaServicioController,
        enabled: false,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          hintText: 'Fecha Servicio',
          border: InputBorder.none,
          contentPadding: EdgeInsets.all(15),
          hintStyle: TextStyle(
              color: Colors.white60
          ),
          // prefixIcon: Icon(
          //     Icons.airplanemode_active_rounded,
          //     color: Colors.white60
          // )
        ),
      ),
    );
  }
  Widget _textFieldFechaSolicitud() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 5),
      decoration: BoxDecoration(
          color: MyColors.primaryOpacityColor,
          borderRadius: BorderRadius.circular(30)
      ),
      child: TextField(
        controller: _con.fechaSolicitudController,
        enabled: false,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          hintText: 'Fecha Solicitud',
          border: InputBorder.none,
          contentPadding: EdgeInsets.all(15),
          hintStyle: TextStyle(
              color: Colors.white60
          ),
          // prefixIcon: Icon(
          //     Icons.airplanemode_active_rounded,
          //     color: Colors.white60
          // )
        ),
      ),
    );
  }
  Widget _textFieldFObservacionesNO() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 5),
      decoration: BoxDecoration(
          color: MyColors.primaryOpacityColor,
          borderRadius: BorderRadius.circular(30)
      ),
      child: TextField(
        controller: _con.observacionesController,
        enabled: false,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          hintText: 'Observaciones',
          border: InputBorder.none,
          contentPadding: EdgeInsets.all(15),
          hintStyle: TextStyle(
              color: Colors.white60
          ),
        ),
      ),
    );
  }
  Widget _textFieldFObservaciones() {
    return Container(
      height: 200,
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 5),
      decoration: BoxDecoration(
          color: MyColors.primaryOpacityColor,
          borderRadius: BorderRadius.circular(30)
      ),
      child: SingleChildScrollView(
        child: TextField(
          controller: _con.observacionesController,
          enabled: false,
          maxLines: null,
          decoration: InputDecoration(
            hintText: 'Observaciones',
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

  Widget _buttonRegresar() {
    return  ElevatedButton(
      onPressed: () {_con.cancelar();},
      child: Text('REGRESAR'),
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

  Widget _botones() {
    return Container(
      width: double.infinity,
      alignment: Alignment.center,
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
      child: Column(
        children: [
          SizedBox(height: MediaQuery.of(context).size.height * 0.04),
          _buttonRegresar(),
              ],
      ),
    );
  }

}
