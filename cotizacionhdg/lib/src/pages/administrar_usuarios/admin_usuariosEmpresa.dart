import 'package:cotizaciones_hdg/src/models/usuario.dart';
import 'package:cotizaciones_hdg/src/styles/estilos.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:cotizaciones_hdg/src/pages/administrar_usuarios/admin_usuariosEmpresaController.dart';

class AdminUsuariosEmpresa extends StatefulWidget {
  const AdminUsuariosEmpresa({super.key});

  @override
  State<AdminUsuariosEmpresa> createState() => _AdminUsuariosEmpresaState();
}

class _AdminUsuariosEmpresaState extends State<AdminUsuariosEmpresa> {
  late List<Usuario?> usuarios;
  AdminUsuariosEmpresaController _con = new AdminUsuariosEmpresaController();

  void refresh() {
    setState(() {
    });
  }

  @override
  void initState() {
    super.initState();
    // SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
    //   usuarios = [];
      _con.init(context, refresh);
    // });
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Admin.> Usuarios ${_con.nombre_empresa}'),
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
                  top: 30,
                  right: 40,
                  child: _textCerrarSesion(),
                ),
                Positioned(
                    top: 17,
                    right: 2,
                    child: _iconBack()
                ),
                Container(
                  width: double.infinity,
                  margin: EdgeInsets.only(top: 70),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        _textBienvenido(),
                        SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                        Column(
                          children: _con.usuarios != null
                              ? [_buttonUsuarios(_con.usuarios)]
                              : [],
                        ),
                        SizedBox(height: MediaQuery.of(context).size.height * 0.03),
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
    print(_con.nombre_empresa);
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
              'USUARIOS',
              style: TextStyle(color: Colors.white, fontSize: 40, fontWeight: FontWeight.bold)
          ), SizedBox(height: 5),
          Text(

              _con.nombre_empresa?.toString() ?? "EMPRESA",
              // _con.usuario!.nombreUsuario.toString(),
              style: TextStyle(color: Colors.white, fontSize: 35, fontWeight: FontWeight.bold)
          )
        ]);
  }

  Widget _buttonUsuarios(List<Usuario?> usuarios) {
    return Column(
      children: usuarios.map((usuario) {
        return Container(
          width: double.infinity,
          margin: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
          child: ElevatedButton(
            onPressed: () {_con.goToDetalleUsuario(usuario?.idUsuario);},
            child: Text('${usuario?.idUsuario} ${usuario?.nombreUsuario ?? 'USUARIO'}',
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
      onTap: () {_con.crearUsuario();},
      child: Text('CREAR USUARIO',
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
