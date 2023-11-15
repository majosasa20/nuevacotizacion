import 'package:cotizaciones_hdg/src/pages/crear_cotizaciones/formulario_cotizacion_controller.dart';
import 'package:cotizaciones_hdg/src/styles/estilos.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
// import 'package:date_picker_widget/date_picker_widget.dart';
import 'package:intl/intl.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';



class FormularioCotizacionPage extends StatefulWidget {
  const FormularioCotizacionPage({super.key});

  @override
  State<FormularioCotizacionPage> createState() => _FormularioCotizacionPageState();
}

class _FormularioCotizacionPageState extends State<FormularioCotizacionPage> {
  FormularioCotizacionController _con = new FormularioCotizacionController();
  // final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  // final DateFormat _dateFormat = DateFormat('dd/MM/yyyy');
  final DateTime currentDate = DateTime.now(); // Obtén la fecha actual
  TimeOfDay? _selectedTime;
  // bool isSubmitButtonEnabled = false;

  void refresh() {
    setState(() {
    });
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
    String txtAppBar = '';
    if (_con.nombre_empresa != null && _con.nombre_empresa.isNotEmpty) {
      if (_con.nombre_empresa == 'SERVIAVIA') {
        txtAppBar = 'Enviar Orden';
      } else if (_con.nombre_empresa == 'Helicópteros de Guatemala') {
        txtAppBar = 'Enviar Cotización';
      } else {txtAppBar = ''; }
    }
    // refresh();
    return Scaffold(
        appBar: AppBar(
          //${_con.nombreServicio ?? "Sin Servicio"}
          title: Text('Servicio ${_con.nombreServicio ?? "Sin Servicio"}> ${txtAppBar}', style: TextStyle(fontSize: 17),),
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
                  margin: EdgeInsets.only(top: 60),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        _textBienvenido(),
                        SizedBox(height: MediaQuery.of(context).size.height * 0.04),
                        _textFieldSservicio(),
                        _textFieldName(),
                        _textFieldTelefono(),
                        _textFieldEmail(),
                        _textFieldDestino(),
                        _textFieldFechaSalida(context),
                        _textFieldHoraSalida(context),
                        _textFieldCaracteristicas(),
                        _textFieldObservaciones(),
                        _buttonGuardar()
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
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      SizedBox(height: MediaQuery.of(context).size.height * 0.02),
      if (_con.nombre_empresa == 'SERVIAVIA')
        Text('ORDEN DE COMPRA',
        style: TextStyle(
        color: Colors.white, fontSize: 40, fontWeight: FontWeight.bold),
        textAlign: TextAlign.center)
      else
        Text('COTIZAR SERVICIO',
            style: TextStyle(
                color: Colors.white, fontSize: 40, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center),
    ]);
  }

  Widget _textFieldSservicio() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 5),
      decoration: BoxDecoration(
          color: MyColors.primaryOpacityColor,
          borderRadius: BorderRadius.circular(30)
      ),
      child: TextField(
        controller: _con.servicioController,
        // keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
            hintText: 'Servicio',
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

  Widget _textFieldName() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 5),
      decoration: BoxDecoration(
          color: MyColors.primaryOpacityColor,
          borderRadius: BorderRadius.circular(30)
      ),
      child: TextField(
        controller: _con.nombreUsuarioController,
        decoration: InputDecoration(
            hintText: 'Nombre Completo',
            border: InputBorder.none,
            contentPadding: EdgeInsets.all(15),
            hintStyle: TextStyle(
                color: Colors.white60
            ),
            prefixIcon: Icon(
                Icons.person,
                color: Colors.white60
            )
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
        controller: _con.telefonoUsuarioController,
        keyboardType: TextInputType.phone,
        decoration: InputDecoration(
            hintText: 'Teléfono',
            border: InputBorder.none,
            contentPadding: EdgeInsets.all(15),
            hintStyle: TextStyle(
                color: Colors.white60
            ),
            prefixIcon: Icon(
                Icons.phone,
                color: Colors.white60
            )
        ),
      ),
    );
  }

  Widget _textFieldEmail() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 5),
      decoration: BoxDecoration(
          color: MyColors.primaryOpacityColor,
          borderRadius: BorderRadius.circular(30)
      ),
      child: TextField(
        controller: _con.correoUsuarioController,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
            hintText: 'Email',
            border: InputBorder.none,
            contentPadding: EdgeInsets.all(15),
            hintStyle: TextStyle(
                color: Colors.white60
            ),
            prefixIcon: Icon(
                Icons.email,
                color: Colors.white60
            )
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
        controller: _con.destinoServicioController,
        // obscureText: true,
        decoration: InputDecoration(
            hintText: 'Destino',
            border: InputBorder.none,
            contentPadding: EdgeInsets.all(15),
            hintStyle: TextStyle(
                color: Colors.white60
            ),
            prefixIcon: Icon(
                Icons.location_on,
                color: Colors.white60
            )
        ),
      ),
    );
  }

  Widget _textFieldFechaSalida(BuildContext context) {
    final TextEditingController _dateController = TextEditingController();
    final DateFormat _dateFormat = DateFormat('dd/MM/yyyy');
    String? errorMessage;

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 5),
      decoration: BoxDecoration(
        color: MyColors.primaryOpacityColor,
        borderRadius: BorderRadius.circular(30),
      ),
      child: DateTimePicker(
        type: DateTimePickerType.date,
        controller: _con.fechaSalidaController,
        dateMask: 'dd/MM/yyyy',
        firstDate: currentDate, // Establece la fecha mínima como la fecha actual
        lastDate: DateTime(2101),
        icon: Icon(Icons.date_range_outlined, color: Colors.white60),
        decoration: InputDecoration(
          hintText: 'Fecha Salida',
          border: InputBorder.none,
          contentPadding: EdgeInsets.all(15),
          hintStyle: TextStyle(color: Colors.white60),
          prefixIcon: Icon(
            Icons.date_range_outlined,
            color: Colors.white60,
          ),
        ),
        onChanged: (val) {
          // DateTime selectedDate = _dateFormat.parse(val);
          // if (selectedDate.isBefore(currentDate)) {
          //   errorMessage = 'No puede seleccionar una fecha anterior';
          //   _dateController.clear();
          // } else {
          //   errorMessage = null;
          //   // updateSubmitButtonState();
          // }
        },
        validator: (val) {
          // Si deseas mostrar un mensaje de error, puedes hacerlo aquí.
          // Puedes usar el valor de errorText que estableciste en onChanged.
          return null; // Devuelve null si no hay error, o un mensaje de error si es necesario.
        },
        onSaved: (val) {
          // Aquí puedes guardar la fecha si es necesario
        },
      ),
    );
  }

  Widget _textFieldHoraSalida(BuildContext context) {
    final TextEditingController _timeController = TextEditingController();
    String? errorMessage;
    final DateTime currentDate = DateTime.now();
    final TimeOfDay currentTime = TimeOfDay.now();

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 5),
      decoration: BoxDecoration(
        color: MyColors.primaryOpacityColor,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: InkWell(
                  onTap: () {
                    _selectTime(context);
                  },
                  child: Padding(
                    padding: EdgeInsets.all(15),
                    child: Row(
                      children: [
                        Icon(
                          Icons.access_time,
                          color: Colors.white60,
                        ),
                        SizedBox(width: 10),
                        Text(
                          _selectedTime != null
                              ? _selectedTime!.format(context)
                              : 'Seleccionar hora',
                          style: TextStyle(),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          if (errorMessage != null)
            Text(
              errorMessage!,
              style: TextStyle(color: Colors.red),
            ),
        ],
      ),
    );
  }
  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime ?? TimeOfDay.now(),
    );
    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
        final formattedHour = _selectedTime!.hour.toString().padLeft(2, '0');
        final formattedMinute = _selectedTime!.minute.toString().padLeft(2, '0');
        final formattedTime = '$formattedHour:$formattedMinute';
        _con.horaSalidaController.text = formattedTime;
      });
    }
  }


  Widget _textFieldCaracteristicas() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 5),
      decoration: BoxDecoration(
          color: MyColors.primaryOpacityColor,
          borderRadius: BorderRadius.circular(30)
      ),
      child: TextField(
        controller: _con.caracteristicasController,
        readOnly: true,
        // obscureText: true,
        decoration: InputDecoration(
          hintText: 'Características',
          border: InputBorder.none,
          contentPadding: EdgeInsets.all(15),
          hintStyle: TextStyle(
              color: Colors.white60
          ),
          // prefixIcon: Icon(
          //     Icons.lock_outline,
          //     color: Colors.white60
          // )
        ),
      ),
    );
  }

  Widget _textFieldObservaciones() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 5),
      decoration: BoxDecoration(
          color: MyColors.primaryOpacityColor,
          borderRadius: BorderRadius.circular(30)
      ),
      child: TextField(
        controller: _con.observacionesController,
        // obscureText: true,
        decoration: InputDecoration(
          hintText: 'Observaciones',
          border: InputBorder.none,
          contentPadding: EdgeInsets.all(15),
          hintStyle: TextStyle(
              color: Colors.white60
          ),
          prefixIcon: Icon(
              Icons.remove_red_eye_sharp,
              color: Colors.white60
          )
        ),
      ),
    );
  }


  Widget _buttonGuardar() {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
      child: ElevatedButton(
        onPressed: _con.guardarCotizacionServiavia,
        child: Text('ENVIAR'),
        style: ElevatedButton.styleFrom(
            backgroundColor: MyColors.secondaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            padding: EdgeInsets.symmetric(vertical: 10)
        ),
      ),
    );
  }

  // void updateSubmitButtonState() {
  //   if (_dateController.text.isNotEmpty && _timeController.text.isNotEmpty) {
  //     final DateTime selectedDate = _dateFormat.parse(_dateController.text);
  //     final DateTime selectedDateTime = DateTime(
  //       selectedDate.year,
  //       selectedDate.month,
  //       selectedDate.day,
  //       _selectedTime!.hour,
  //       _selectedTime!.minute,
  //     );
  //     final DateTime minimumTime = currentDate.add(Duration(hours: 3));
  //
  //     if (selectedDateTime.isAfter(minimumTime)) {
  //       setState(() {
  //         isSubmitButtonEnabled = true;
  //       });
  //       return;
  //     }
  //   }
  //   setState(() {
  //     isSubmitButtonEnabled = false;
  //   });
  // }


// Future<void> _selectTime(BuildContext context) async {
  //   final TimeOfDay? picked = await showTimePicker(
  //     context: context,
  //     initialTime: _selectedTime ?? TimeOfDay.now(),
  //   );
  //
  //   if (picked != null && picked != _selectedTime) {
  //     _selectedTime = picked;
  //     final formattedTime =
  //         '${_selectedTime!.hour}:${_selectedTime!.minute.toString().padLeft(2, '0')}';
  //     _timeController.text = formattedTime;
  //   }
  // }


}
