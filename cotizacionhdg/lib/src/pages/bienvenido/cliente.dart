import 'package:cotizaciones_hdg/src/models/empresas_model.dart';
import 'package:cotizaciones_hdg/src/pages/bienvenido/cliente_controller.dart';
import 'package:cotizaciones_hdg/src/styles/estilos.dart';
import 'package:flutter/material.dart';


class ClientePage extends StatefulWidget {
  const ClientePage({super.key});

  @override
  State<ClientePage> createState() => _ClientePageState();
}

class _ClientePageState extends State<ClientePage> {
  ClienteController _con = new ClienteController();
  // Usuario users = new Usuario();
  late List<Empresas?> empresas2;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
    //   // empresas2 = [];
      _con.init(context, refresh);
    // });
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
                  top: 70,
                  right: 40,
                  child: _textCerrarSesion(),
                ),
                Positioned(
                    top: 57,
                    right: 2,
                    child: _iconBack()
                ),
                Container(
                  width: double.infinity,
                  margin: EdgeInsets.only(top: 60),
                  child: SingleChildScrollView(
                    child: Column(
                        children: [
                          _textBienvenido(),
                          SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                          _textIngresoCotizacion(),
                          SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                          Column(
                            children:
                              _con.empresas != null
                              ? _con.empresas?.idEmpresa == 0
                              ? _con.empresas2 != null
                              ? _con.empresas2!.map<Widget>((Empresas? empresa) {
                                      return _cardEmpresa(empresa!);
                                    }).toList()
                              : [/*_textselectEmpresas(),
                                SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                                _imageHdg(),*/]
                              :[_cardEmpresa(_con.empresas!)]

                              // [_cardEmpresa(_con.empresas!)]
                              //     : [
                              //   Column(
                              //       children:
                              //       _con.empresas2 != null
                              //           ? _con.empresas2!.map<Widget>((Empresas? empresa) {
                              //         return _cardEmpresa(empresa!);
                              //       }).toList()
                              //           : []
                              //   )
                              // ]
                                  : [
                                    _textselectEmpresas(),
                                SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                                _imageHdg(),
                              ],
                          )
                        ]

                        //     ? _con.empresas?.map<Widget>((Empresas empresa) {
                        //   return _cardEmpresa(empresa);
                        // }).toList() : []
                    ),
                    // child: Column(
                    //   children:  [ //_con.usuario != null = _con.usuario!.nombreUsuario{ return _textBienvenido(usuarios.nombreUsuario);}
                    //     // _textBienvenido(users.nombreUsuario as Usuario?),
                    //     _textBienvenido(),
                    //     SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                    //     _textIngresoCotizacion(),
                    //     SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                    //     _textselectEmpresas(),
                    //     SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                    //     _imageHdg(),
                    //   ],
                    // ),
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
        SizedBox(height: MediaQuery.of(context).size.height * 0.06),
        Text(
          'BIENVENIDO/A',
          style: TextStyle(color: Colors.white, fontSize: 40, fontWeight: FontWeight.bold)
        ), SizedBox(height: 5),
        Text(
          // usuarios!.nombreUsuario!.toString(),
          _con.usuario?.nombreUsuario ?? "USUARIO",
          // _con.usuario!.nombreUsuario.toString(),
          style: TextStyle(color: Colors.white, fontSize: 35, fontWeight: FontWeight.bold)
        )
      ]);
  }

  Widget _textIngresoCotizacion(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          flex: 1,
          child: Text(
            'Selecciona la empresa en la cual deseas cotizar el servicio...',
            style: TextStyle(color: MyColors.primaryColor, fontSize: 25), textAlign: TextAlign.center,
          ),
        )
      ]
    );
  }

  Widget _textselectEmpresas() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('HDG', style: TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold)),
        SizedBox(width: MediaQuery.of(context).size.width * 0.20),
        Text('SERVIAVIA', style: TextStyle(color: Colors.white, fontSize:30, fontWeight: FontWeight.bold))
      ],
    );
  }

  Widget _cardEmpresa(Empresas empresas){
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              empresas.nombreEmpresa ?? 'EMPRESA',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold)
            ),
          ],
        ),
        GestureDetector(
          onTap: () {
            _con.goToServiciosCotizaciones(empresas.idEmpresa, empresas.nombreEmpresa);
          },
          child: Container(
            height: 150,
            width: 150,
            decoration: BoxDecoration(
                borderRadius: new BorderRadius.circular(150),
                image: DecorationImage(
                    image: empresas.imagen != null ? AssetImage(empresas.imagen.toString()) : AssetImage('assets/img/hdg.png'), fit: BoxFit.fill),
                boxShadow: [
                  new BoxShadow(
                      color: MyColors.primaryColor,
                      offset: Offset(1, 5),
                      blurRadius: 10
                  )]
            ),
          ),
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.04),
        // Container(
        //   height: 300,
        //   child: FadeInImage(
        //     image: empresas.imagen != null ? AssetImage(empresas.imagen.toString()) : AssetImage('assets/img/hdg.png') as ImageProvider,
        //     fit: BoxFit.contain,
        //     fadeInDuration: Duration(milliseconds: 50),
        //     placeholder: AssetImage('assets/img/hdg.png'),
        //   ),
        // ),
      ],
    );
  }

  Widget _imageHdg() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: _con.goToServiciosPrueba,
          child: Container(
            height: 150,
            width: 150,
            decoration: BoxDecoration(
                borderRadius: new BorderRadius.circular(150),
                image: DecorationImage(
                  image: AssetImage('assets/img/hdgempresa.jpg'), fit: BoxFit.fill),
                boxShadow: [
                  new BoxShadow(
                      color: MyColors.primaryColor,
                      offset: Offset(1, 5),
                      blurRadius: 10
                  )]
            ),
          ),
        ),
        SizedBox(width: MediaQuery.of(context).size.width * 0.10),
        GestureDetector(
          onTap: _con.goToServiciosPrueba,
          child: Container(
            height: 150,
            width: 150,
            decoration: BoxDecoration(
                borderRadius: new BorderRadius.circular(150),
                image: DecorationImage(
                  image: AssetImage('assets/img/serviavia.jpg'), fit: BoxFit.fill),
                boxShadow: [
                  new BoxShadow(
                      color: MyColors.primaryColor,
                      offset: Offset(1, 5),
                      blurRadius: 10
                  )]
            ),
          ),
        )],
    );
  }

  void refresh() {
    setState(() {
    });
  }
}
