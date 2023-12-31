import 'package:cotizaciones_hdg/src/models/roles.dart';
import 'package:cotizaciones_hdg/src/styles/estilos.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'crear_usuarioController.dart';

class CrearUsuario extends StatefulWidget {
  const CrearUsuario({super.key});

  @override
  State<CrearUsuario> createState() => _CrearUsuarioState();
}

class _CrearUsuarioState extends State<CrearUsuario> {
  CrearUsuarioController _con = new CrearUsuarioController();
  String? selectedRolValue;
  String? selectedRolText;

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
        appBar: AppBar(
          title: Text('Usuarios Empresa > Crear Usuario', style: TextStyle(fontSize: 18),),
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
                        // _textNombre(),
                        // _textFieldNombre(),
                        _textCorreo(),
                        _textFieldCorreo(),
                        // _textNumero(),
                        // _textFieldTelefono(),
                        _textRol(),
                        Column(
                          children: _con.roleslist != null
                              ? [  _dropdownRol(_con.roleslist),  ]
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
          Text('CREAR USUARIO',
              style: TextStyle(
                  color: Colors.white, fontSize: 40, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center)
        ]
    );
  }
  // Widget _textNombre(){
  //   return Container(
  //     margin: EdgeInsets.symmetric(horizontal: 50, vertical: 5),
  //     alignment: Alignment.centerLeft,
  //     child: Text('Nombre Completo',
  //       style: TextStyle(color: Colors.black45, fontSize: 20, fontWeight: FontWeight.bold),
  //     ),
  //   );
  // }
  Widget _textCorreo(){
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 5),
      alignment: Alignment.centerLeft,
      child: Text('Correo',
        style: TextStyle(color: Colors.black45, fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }
  // Widget _textNumero(){
  //   return Container(
  //     margin: EdgeInsets.symmetric(horizontal: 50, vertical: 5),
  //     alignment: Alignment.centerLeft,
  //     child: Text('Número',
  //       style: TextStyle(color: Colors.black45, fontSize: 20, fontWeight: FontWeight.bold),
  //     ),
  //   );
  // }
  Widget _textRol(){
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 5),
      alignment: Alignment.centerLeft,
      child: Text('Rol Usuario',
        style: TextStyle(color: Colors.black45, fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }
  // Widget _textFieldNombre() {
  //   return Container(
  //     margin: EdgeInsets.symmetric(horizontal: 50, vertical: 5),
  //     decoration: BoxDecoration(
  //         color: MyColors.primaryOpacityColor,
  //         borderRadius: BorderRadius.circular(30)
  //     ),
  //     child:
  //     TextField(
  //       controller: _con.nombreController,
  //       decoration: InputDecoration(
  //           hintText: 'Nombre Completo',
  //           border: InputBorder.none,
  //           contentPadding: EdgeInsets.all(15),
  //           hintStyle: TextStyle(
  //               color: Colors.white60
  //           ),
  //           prefixIcon: Icon(
  //               Icons.airplanemode_active_rounded,
  //               color: Colors.white60
  //           )
  //       ),
  //     ),
  //   );
  // }
  Widget _textFieldCorreo() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 5),
      decoration: BoxDecoration(
          color: MyColors.primaryOpacityColor,
          borderRadius: BorderRadius.circular(30)
      ),
      child: TextField(
        controller: _con.correoController,
        keyboardType: TextInputType.emailAddress,
        // enabled: false,
        decoration: InputDecoration(
            hintText: 'Correo',
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
  // Widget _textFieldTelefono() {
  //   return Container(
  //     margin: EdgeInsets.symmetric(horizontal: 50, vertical: 5),
  //     decoration: BoxDecoration(
  //         color: MyColors.primaryOpacityColor,
  //         borderRadius: BorderRadius.circular(30)
  //     ),
  //     child: TextField(
  //       controller: _con.telefonoController,
  //       keyboardType: TextInputType.number,
  //       decoration: InputDecoration(
  //           hintText: 'Teléfono',
  //           border: InputBorder.none,
  //           contentPadding: EdgeInsets.all(15),
  //           hintStyle: TextStyle(
  //               color: Colors.white60
  //           ),
  //           prefixIcon: Icon(
  //               Icons.airplanemode_active_rounded,
  //               color: Colors.white60
  //           )
  //       ),
  //     ),
  //   );
  // }
  Widget _dropdownRol(List<Roles?> roles) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        DropdownButton<String>(
          value: selectedRolValue ?? (roles.isNotEmpty ? roles[0]?.idRol.toString() : '1'),
          onChanged: (newValue) {
            setState(() {
              selectedRolValue = newValue!;
              selectedRolText = _con.roleslist
                  .firstWhere((roles) =>
              roles?.idRol.toString() ==
                  newValue)
                  ?.descripcionRol ??
                  'ROL';
            });
          },
          items: _con.roleslist
              .map((Roles? rol) {
            return DropdownMenuItem<String>(
              value: rol?.idRol.toString() ??
                  '1',
              child: Text(rol?.descripcionRol ??
                  'Roles Usuario'),
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
      onPressed: () {_con.cancelar(_con.id_empresa, _con.nombre_empresa);},
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

  void _mostrarDialogoDeConfirmacion(BuildContext context) {
    String? rol = selectedRolValue;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Crear Usuario'),
          backgroundColor: MyColors.fondoColorOpacity,
          content: Text('¿Desea crear el usuario ${_con.nombreController.text} con el rol ${rol}?'),
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
                // _con.guardarUsuario(rol);
                _con.guardarEmpleado(rol);
              },
            ),
          ],
        );
      },
    );
  }
}
