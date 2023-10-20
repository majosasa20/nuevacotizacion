import 'package:cotizaciones_hdg/src/models/cotizacion_model.dart';
import 'package:cotizaciones_hdg/src/models/response_api.dart';
import 'package:cotizaciones_hdg/src/provider/cotizaciones_provider.dart';
import 'package:flutter/material.dart';
import '../../models/usuario.dart';
import '../../styles/my_snackbar.dart';
import '../../styles/shared_pref.dart';

class FormularioCotizacionController {
  BuildContext? context; //signo de interrogación para evitar el NULL SAFETY
  Usuario? usuario;
  SharedPref _sharedPref = new SharedPref();
  Function? refresh;
  //declarando variables para parámetros recibidos
  late dynamic nombreServicio;
  late dynamic codEmpresa;
  late dynamic cantidadMedida;
  late dynamic medida;
  late dynamic textFieldValues;
  late dynamic idUbicacion;
  late dynamic ubicacion;
  late dynamic idCombustible;
  late dynamic combustible;
  late dynamic nombre_empresa = '';
  late dynamic codServicio;
  late dynamic idCaracteristica;
  late dynamic caracteristica;
  CotizacionesProvider cotizacionesProvider = new CotizacionesProvider();

  TextEditingController servicioController = new TextEditingController();
  TextEditingController nombreUsuarioController = new TextEditingController();
  TextEditingController telefonoUsuarioController = new TextEditingController();
  TextEditingController correoUsuarioController = new TextEditingController();
  TextEditingController destinoServicioController = new TextEditingController();
  TextEditingController fechaSalidaController = new TextEditingController();
  TextEditingController horaSalidaController = new TextEditingController();
  TextEditingController caracteristicasController = new TextEditingController();
  TextEditingController observacionesController = new TextEditingController();

  Future? init(BuildContext context, Function refresh) async{
    this.context = context;
    this.refresh = refresh;
    usuario = Usuario.fromJson(await _sharedPref.read('usuario'));
    //parámetros del servicio
    final parametros = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    nombre_empresa = parametros["nombreEmpresa"];
    codEmpresa= parametros["codEmpresa"];
    codServicio = parametros["codServicio"];
    nombreServicio= parametros["nombreServicio"];
    cantidadMedida= parametros["cantidadMedida"];
    medida = parametros["medida"];
    textFieldValues= parametros["textFieldValues"];
    idUbicacion= parametros["idUbicacion"];
    ubicacion= parametros["ubicacion"];
    idCombustible= parametros["idCombustible"];
    combustible= parametros["combustible"];
    if (nombreServicio == 'COMBUSTIBLE') {
      idCaracteristica = int.parse(idCombustible);
    } else {idCaracteristica=parametros["idCaracteristica"];}
    caracteristica=parametros["Caracteristica"];
print("${parametros}");
    //llena los textfield
    servicioController.text = nombreServicio;
    destinoServicioController.text = ubicacion ?? '';
    nombreUsuarioController.text = usuario!.nombreUsuario.toString();
    telefonoUsuarioController.text = usuario!.telefonoUsuario.toString() ?? '';
    correoUsuarioController.text = usuario!.correoUsuario.toString() ?? ' ';
    if (nombreServicio == 'COMBUSTIBLE') {
      caracteristicasController.text ="$cantidadMedida $medida Combustible $combustible";
    }else{
      caracteristicasController.text = "$cantidadMedida $caracteristica";
    }
  }

  void goToLoginPage() {
    Navigator.pushNamed(context!, 'login');
  }

  Future<void> guardarCotizacionServiavia() async {
    String servicio = servicioController.text.trim();
    String nombre = nombreUsuarioController.text;
    String telefono = telefonoUsuarioController.text.trim();
    String email = correoUsuarioController.text.trim();
    String destino = destinoServicioController.text;
    String fechaSalida = fechaSalidaController.text;
    String horaSalida = horaSalidaController.text;
    String caracteristicas = caracteristicasController.text;
    String observaciones = observacionesController.text;
    // print(observacionesController.text);

    if (servicio.isEmpty || nombre.isEmpty || telefono.isEmpty ||email.isEmpty || destino.isEmpty || fechaSalida.isEmpty || horaSalida.isEmpty || caracteristicas.isEmpty) {
      MySnackbar.show(context!, 'Debes ingresar todos los campos');
      return;
    } else {
      // Obtén la fecha y hora actual
      DateTime now = DateTime.now();
      // print("ahora $now");
      // Parsea la fecha y hora ingresadas por el usuario
      DateTime fechaSalidaDateTime = DateTime.parse("$fechaSalida $horaSalida");
      // print(fechaSalidaDateTime);
      // Calcula la diferencia en horas entre la fecha y hora actual y la fecha de salida
      Duration diferencia = fechaSalidaDateTime.difference(now);
      // print(diferencia);
      if (diferencia.inHours < 3) {
        MySnackbar.show(context!, 'La fecha y hora de salida debe ser al menos 3 horas después de la fecha y hora actual.');
        return;
      }else{
        // print("$servicio,$nombre,$telefono,$email,$destino,$fechaSalida,$horaSalida,$caracteristicas");
        print('fecha salida: $fechaSalidaDateTime');

        Cotizacion cotizacion = new Cotizacion(
            cod_empresa: int.parse(codEmpresa),
            destino: destino,
            observaciones:observaciones,
            id_usuario:usuario?.idUsuario,
            cod_servicio:int.parse(codServicio),
            cod_aeronave:null,
            caracteristica:idCaracteristica,
            cantidad:int.parse(cantidadMedida),
            precio:0,
            fechaservicio: fechaSalidaDateTime
        );
        // print("datos enviado: ${cotizacion.observaciones}");

        ResponseApi? responseApi = await cotizacionesProvider.crearCotizacion(cotizacion);
        if (responseApi != null && responseApi is ResponseApi) {
          MySnackbar.show(context!, responseApi.message);
          if (responseApi.success!){
            Future.delayed(Duration(seconds: 3), () {
              Navigator.pushReplacementNamed(context!, 'clientepage');
            });
          }else{
            MySnackbar.show(context!, "Error al crear la cotización.");
          }
        }

        print('RESPUESTA: ${responseApi?.toJson()}');
      }
    }
  }

  void mensajeErrores(String mensaje){
    MySnackbar.show(context!, mensaje);
  }

  void logout(){
    _sharedPref.logout(context!);
  }

}