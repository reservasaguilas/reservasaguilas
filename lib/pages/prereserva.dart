import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:reservasaguilas/pages/pdfPreReserva.dart';

class PreReservas extends StatefulWidget {

  @override
  _ReservasState createState() => _ReservasState();
}

class _ReservasState extends State<PreReservas> {
  @override

  String titular = '';
  String dni = '';
  var fechaIngreso;
  String horaIngreso = '13:00';
  var fechaSalida;
  String horaEgreso = '10:30';
  String valorNoche = '';
  String pax = '';
  String observacion = '';
  int total = 1;

  Object valueChoise = 'Mailén Aguilá';
  List listItem = [
    'Mailén Aguilá',
    'Ariel Vega',
  ];


  Object ques = 'Estimada';
  List listTrato = [
    'Estimada',
    'Estimado',
  ];

  Widget build(BuildContext context) {

    final ancho = MediaQuery.of(context).size.width;

    var fecha1;

    if(fechaIngreso != null){
      final formatIngreso = new DateFormat('dd-MM-yyyy').format(fechaIngreso);
      fecha1 = formatIngreso;
    }

    var fecha2;

    if(fechaSalida != null){
      final formatSalida = new DateFormat('dd-MM-yyyy').format(fechaSalida);
      fecha2 = formatSalida;
    }

    return Scaffold(
      backgroundColor: Color.fromRGBO(255, 229, 217, 1),
      appBar: AppBar(
        title: Text('Pre-Reserva', style: TextStyle(color: Colors.white, shadows: [Shadow(blurRadius: 5.0, color: Colors.black54)]),),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text('Titular: '),
                  SizedBox(width: 5,),
                  Expanded(
                    child: TextField(
                      onChanged: (text){titular = text;},
                      textCapitalization: TextCapitalization.words,
                    ),
                  ),
                ],
              ),
              Row(children: [
                Text('Trato:'), 
                SizedBox(width: 10.0,),
                DropdownButton(
                  value: ques,
                  onChanged: (value) => setState(() => ques = value!),
                  items: listTrato.map((valueItem){
                    return DropdownMenuItem(
                      value: valueItem,
                      child: Text(valueItem),
                    );
                  }).toList(),
                ),
              ],),
              Row(
                children: [
                  Text('DNI: '),
                  SizedBox(width: 5,),
                  Expanded(
                    child: TextField(
                      onChanged: (text){dni = text;},
                      keyboardType: TextInputType.number,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.only(top: 5.0),
                child: Row(
                  children: [
                    Text('Fecha de Ingreso: '),
                    SizedBox(width: 5,),
                    RaisedButton(
                      color: Color.fromRGBO(72, 202, 228, 1),
                      child: Text(fechaIngreso != null? '$fecha1': 'Seleccionar', style: TextStyle(color: Colors.white, shadows: [Shadow(blurRadius: 5.0, color: Colors.black54)]),),
                      onPressed: (){showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime.now(), lastDate: DateTime(2099))
                      .then((date) => setState((){fechaIngreso = date;}))
                      ;}
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5.0),
                child: Row(
                  children: [
                    Text('Fecha de Salida: '),
                    SizedBox(width: 14,),
                    RaisedButton(
                      color: Color.fromRGBO(72, 202, 228, 1),
                      child: Text(fechaSalida != null? '$fecha2': 'Seleccionar', style: TextStyle(color: Colors.white, shadows: [Shadow(blurRadius: 5.0, color: Colors.black54)]),),
                      onPressed: (){showDatePicker(context: context, initialDate: fechaIngreso, firstDate: DateTime.now(), lastDate: DateTime(2099),)
                      .then((date) => setState((){fechaSalida = date;}))
                      ;}
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Text('Valor noche: '),
                  SizedBox(width: 5,),
                  Expanded(
                    child: TextField(
                      onChanged: (text){valorNoche = text;},
                      keyboardType: TextInputType.number,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Text('Pax: '),
                  SizedBox(width: 5,),
                  Expanded(
                    child: TextField(
                      onChanged: (text){pax = text;},
                      keyboardType: TextInputType.number,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Text('Observación: '),
                  SizedBox(width: 5,),
                  Expanded(
                    child: TextField(
                      onChanged: (text){observacion = text;},
                    ),
                  ),
                ],
              ),
              Row(children: [
                Text('Firma:'), 
                SizedBox(width: 10.0,),
                DropdownButton(
                  value: valueChoise,
                  onChanged: (value) => setState(() => valueChoise = value!),
                  items: listItem.map((valueItem){
                    return DropdownMenuItem(
                      value: valueItem,
                      child: Text(valueItem),
                    );
                  }).toList(),
                ),
              ],),
              SizedBox(height: 40,),
              Center(
                child: SizedBox(
                  width: ancho*0.8,
                  child: RaisedButton(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('Generar PDF', style: TextStyle(fontSize: 20, color: Colors.white, shadows: [Shadow(blurRadius: 5.0, color: Colors.black54)]),),
                      ), 
                      onPressed: (){
                        total = fechaSalida.difference(fechaIngreso).inDays;
                        Navigator.push(context, MaterialPageRoute(builder: (context) => VerPdf(trato: ques, dni: dni, observacion: observacion, pax: pax, fechaIngreso: fechaIngreso, fechaSalida: fechaSalida, firma: valueChoise, horaEgreso: horaEgreso, horaIngreso: horaIngreso, valorNoche: valorNoche, titular: titular, total: total,)));
                      }, 
                      color: Color.fromRGBO(72, 202, 228, 1),
                      elevation: 3,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}