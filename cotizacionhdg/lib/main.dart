import 'package:cotizaciones_hdg/src/pages/administrar_cotizaciones/admin_cotizacionesEmpresa.dart';
import 'package:cotizaciones_hdg/src/pages/administrar_cotizaciones/cotizaciones_clientes/cotizaciones_clientes.dart';
import 'package:cotizaciones_hdg/src/pages/administrar_cotizaciones/cotizaciones_clientes/verCotizacion_cliente.dart';
import 'package:cotizaciones_hdg/src/pages/administrar_cotizaciones/ver_cotizaciondetalle.dart';
import 'package:cotizaciones_hdg/src/pages/administrar_usuarios/admin_usuariosEmpresa.dart';
import 'package:cotizaciones_hdg/src/pages/administrar_usuarios/crear_usuario.dart';
import 'package:cotizaciones_hdg/src/pages/administrar_usuarios/ver_detalleUsuario.dart';
import 'package:cotizaciones_hdg/src/pages/bienvenido/adminpage.dart';
import 'package:cotizaciones_hdg/src/pages/bienvenido/menu_clientepage.dart';
import 'package:cotizaciones_hdg/src/pages/bienvenido/cliente.dart';
import 'package:cotizaciones_hdg/src/pages/bienvenido/menuadministrador.dart';
import 'package:cotizaciones_hdg/src/pages/bienvenido/menuvendedor.dart';
import 'package:cotizaciones_hdg/src/pages/bienvenido/vendedorpage.dart';
import 'package:cotizaciones_hdg/src/pages/catalogos/caracteristicas/administrar_caracteristicas.dart';
import 'package:cotizaciones_hdg/src/pages/catalogos/caracteristicas/crear_caracteristicas.dart';
import 'package:cotizaciones_hdg/src/pages/catalogos/caracteristicas/ver_detallecaracteristica.dart';
import 'package:cotizaciones_hdg/src/pages/catalogos/servicios/administrar_servicios.dart';
import 'package:cotizaciones_hdg/src/pages/catalogos/servicios/crear_servicio.dart';
import 'package:cotizaciones_hdg/src/pages/catalogos/servicios/ver_detalleservicio.dart';
import 'package:cotizaciones_hdg/src/pages/catalogos/ver_catalogos.dart';
import 'package:cotizaciones_hdg/src/pages/crear_cotizaciones/descripcion_servicio.dart';
import 'package:cotizaciones_hdg/src/pages/crear_cotizaciones/formulario_cotizacion.dart';
import 'package:cotizaciones_hdg/src/pages/crear_cotizaciones/servicios_cotizaciones.dart';
import 'package:cotizaciones_hdg/src/pages/login/login_page.dart';
import 'package:cotizaciones_hdg/src/pages/roles/roles_page.dart';
import 'package:cotizaciones_hdg/src/styles/estilos.dart';
import 'package:cotizaciones_hdg/src/pages/registro/registro_pg.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, //elimina la etiqueta de debug
      title: 'Cotizaciones HDG',
      initialRoute: 'login',
      routes: {
        'login' : (BuildContext context) => LoginPage(),
        'registro' : (BuildContext context) => RegistroPage(),
        'menuclientepage' : (BuildContext context) => MenuClientePage(),
        'clientepage': (BuildContext context) => ClientePage(),
        'inicioadminpage': (BuildContext context) => InicioAdminPage(),
        'iniciovendedorpage': (BuildContext context) => InicioVendedorPage(),
        'menuadministradorpage' : (BuildContext context) => AdministradorPage(),
        'menuvendedorpage' : (BuildContext context) => VendedorPage(),
        'verCatalogos' : (BuildContext context) => VerCatalogosPage(),
        'adminCaracteristicas': (BuildContext context) => AdministrarCaracteristicasxEmpresa(),
        'verdetalleCaracteristica': (BuildContext context) => VerDetalleCaracteristica(),
        'crearCaracteristica': (BuildContext context) => CrearCaracteristica(),
        'serviciosCotizaciones' : (BuildContext context) => ServiciosCotizacionesPage(),
        'decripcionCotizacion' : (BuildContext context) => DescripcionServicioPage(),
        'formularioCotizacion' : (BuildContext context) => FormularioCotizacionPage(),
        'adminusuariosempresa': (BuildContext context) => AdminUsuariosEmpresa(),
        'crearUsuario': (BuildContext context) => CrearUsuario(),
        'adminserviciosxempresa': (BuildContext context) => AdministrarServicioxEmpresaPage() ,
        'verdetalleServicio': (BuildContext context) => VerDetalleServicioPage(),
        'crearServicio': (BuildContext context) => CrearServicioPage(),
        'verdetalleUsuario': (BuildContext context) => VerDetalleUsuario(),
        'adminCotizaciones': (BuildContext context) => AdminCotizaciones(),
        'verdetalleCotizacion': (BuildContext context) => VerCotizacionDetallePage(),
        'roles': (BuildContext context) => RolesPage(),
        'cotizacionesClientes': (BuildContext context) => CotizacionesClientes(),
        'verCotizacionCliente' : (BuildContext context) => VerCotizacionCliente()
      },
      theme: ThemeData(
          colorScheme: ColorScheme.light(primary: MyColors.primaryColor)
      ),
    );
  }
}


