import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:flutter/services.dart';
import 'dart:async';
import 'package:printing/printing.dart';

class VerPdfReserva extends StatelessWidget {

  const VerPdfReserva({
    Key? key,
    this.titular,
    this.dni,
    this.fechaIngreso,
    this.fechaSalida,
    this.horaIngreso,
    this.horaEgreso,
    this.pax,
    this.firma,
    this.observacion,
    this.valorNoche,
    this.total,
    this.adelanto
  }) : super(key: key);

  final titular;
  final dni;
  final fechaIngreso;
  final horaIngreso;
  final fechaSalida;
  final horaEgreso;
  final valorNoche;
  final pax;
  final observacion;
  final firma;
  final total;
  final adelanto;

  @override
  
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reserva', style: TextStyle(color: Colors.white, shadows: [Shadow(blurRadius: 5.0, color: Colors.black54)]),),
      ),
      body: PdfPreview(
        build: (format) => generatePDF(titular, dni, adelanto, fechaIngreso, horaIngreso, fechaSalida, horaEgreso, valorNoche, pax, observacion, firma, total),
        canChangeOrientation: false,
        canChangePageFormat: false,
        pdfFileName: '$titular.pdf',
        scrollViewDecoration: BoxDecoration(color:  Color.fromRGBO(255, 229, 217, 1)),
      ),
    );
  }
}


Future<Uint8List> generatePDF(titular, dni, adelanto, fechaIngreso, horaIngreso, fechaSalida, horaEgreso, valorNoche, pax, observacion, firma, total) async {

  final doc = pw.Document(title: 'Reserva', author: 'Aguilas de Piedra');

  final profileImage = pw.MemoryImage(
    (await rootBundle.load('/Users/maximilianosecotaro/desarrollos/aguilas/assets/logo.jpeg')).buffer.asUint8List(),
  );

  final formatIngreso = new DateFormat('dd-MM-yyyy').format(fechaIngreso);
  final formatSalida = new DateFormat('dd-MM-yyyy').format(fechaSalida);

  final formatterDNI = new NumberFormat("#,###", "es_ES");
  var dniInt = int.parse(dni);
  assert(dniInt is int);
  final dniFormateado = formatterDNI.format(dniInt);

  final formatterNoche = new NumberFormat("#,###", "es_ES"); 
  var nocheInt = int.parse(valorNoche);
  assert(nocheInt is int);
  var nocheFormateado = formatterNoche.format(nocheInt);
  
  final formatterAdelanto = new NumberFormat("#,###", "es_ES");
  var adelantoInt = int.parse(adelanto);
  assert(adelantoInt is int);
  final adelantoFormateado = formatterAdelanto.format(adelantoInt);

  doc.addPage(
    pw.MultiPage(
      pageFormat: PdfPageFormat.a4,
      margin: pw.EdgeInsets.all(60),
      build: (pw.Context context) => [
        pw.Partitions(
          children: [
            pw.Partition(
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: <pw.Widget>[
                  pw.Text('Reserva', style: pw.Theme.of(context).defaultTextStyle.copyWith(fontWeight: pw.FontWeight.bold, fontSize: 20, color: PdfColor.fromInt(0xff283593))),
                  pw.Padding(padding: const pw.EdgeInsets.only(top: 45)),
                  pw.Container(
                    alignment: pw.Alignment.center,
                    padding: const pw.EdgeInsets.only(left: 30, bottom: 20),
                    child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.center,
                      mainAxisAlignment: pw.MainAxisAlignment.center,
                      children: <pw.Widget>[
                        pw.Text('$titular', style: pw.Theme.of(context).defaultTextStyle.copyWith(fontWeight: pw.FontWeight.bold, fontSize: 13, fontStyle: pw.FontStyle.italic)),
                        pw.Text('DNI: $dniFormateado', style: pw.Theme.of(context).defaultTextStyle.copyWith(fontWeight: pw.FontWeight.bold, fontSize: 13, fontStyle: pw.FontStyle.italic)),
                      ]
                    ),
                  ),
                ],
              ),
            ),
            pw.Partition(
              child: pw.Column(
                children: [
                  pw.Container(
                    child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.center,
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: <pw.Widget>[
                        pw.ClipOval(
                          child: pw.Container(
                            width: 150,
                            height: 150,
                            child: pw.Image(profileImage), //poner imagen de aguilas png
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ), 
          ],
        ),
        pw.Padding(
          padding: const pw.EdgeInsets.all(15),
          child:pw.Container(
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: <pw.Widget>[
                pw.Padding(
                  padding: const pw.EdgeInsets.all(1),
                  child: pw.Text('- Ingreso: a las $horaIngreso hs del $formatIngreso', style: pw.Theme.of(context).defaultTextStyle.copyWith(fontStyle: pw.FontStyle.italic)),
                ),
                pw.Padding(
                  padding: const pw.EdgeInsets.all(1),
                  child: pw.Text('- Salida: a las $horaEgreso hs del $formatSalida', style: pw.Theme.of(context).defaultTextStyle.copyWith(fontStyle: pw.FontStyle.italic)),
                ),
                pw.Padding(
                  padding: const pw.EdgeInsets.all(1),
                  child: pw.Text('- Valor noche: \$ $nocheFormateado', style: pw.Theme.of(context).defaultTextStyle.copyWith(fontStyle: pw.FontStyle.italic)),
                ),
                pw.Padding(
                  padding: const pw.EdgeInsets.all(1),
                  child: pw.Text('- Total noches: $total', style: pw.Theme.of(context).defaultTextStyle.copyWith(fontStyle: pw.FontStyle.italic)),
                ),
                pw.Padding(
                  padding: const pw.EdgeInsets.all(1),
                  child: pw.Text('- Pax: $pax', style: pw.Theme.of(context).defaultTextStyle.copyWith(fontStyle: pw.FontStyle.italic)),
                ),
                pw.Padding(
                  padding: const pw.EdgeInsets.all(1),
                  child: pw.Text('- Depósito realizado: \$ $adelantoFormateado', style: pw.Theme.of(context).defaultTextStyle.copyWith(fontStyle: pw.FontStyle.italic)),
                ),
                pw.Padding(
                  padding: const pw.EdgeInsets.all(1),
                  child: pw.Text(observacion != ''? '- Observación: $observacion': '- Observación: ninguna', style: pw.Theme.of(context).defaultTextStyle.copyWith(fontStyle: pw.FontStyle.italic)),
                ),
              ],
            ),
        ),),
        pw.Text('Teléfonos a tener en cuenta:', style: pw.Theme.of(context).defaultTextStyle.copyWith(fontStyle: pw.FontStyle.italic)),
        pw.Padding(
          padding: const pw.EdgeInsets.all(15),
          child:pw.Container(
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: <pw.Widget>[
                pw.Padding(
                  padding: const pw.EdgeInsets.all(1),
                  child: pw.Text('- Tel. Oficina: 0261- 439 03 13 (Ariel, administración)', style: pw.Theme.of(context).defaultTextStyle.copyWith(fontStyle: pw.FontStyle.italic)),
                ),
                pw.Padding(
                  padding: const pw.EdgeInsets.all(1),
                  child: pw.Text('- Cel: 0261- 153 68 58 85 (Ariel)', style: pw.Theme.of(context).defaultTextStyle.copyWith(fontStyle: pw.FontStyle.italic)),
                ),
                pw.Padding(
                  padding: const pw.EdgeInsets.all(1),
                  child: pw.Text('- Cel: 0260- 154 00 45 79 (Hernán)', style: pw.Theme.of(context).defaultTextStyle.copyWith(fontStyle: pw.FontStyle.italic)),
                ),
                pw.Padding(
                  padding: const pw.EdgeInsets.all(1),
                  child: pw.Text('- Cel: 0261- 156 17 55 62 (Mailén)', style: pw.Theme.of(context).defaultTextStyle.copyWith(fontStyle: pw.FontStyle.italic)),
                ),
                pw.Padding(
                  padding: const pw.EdgeInsets.all(1),
                  child: pw.Text('- Ante cualquier duda insista con los teléfonos dados.', style: pw.Theme.of(context).defaultTextStyle.copyWith(fontStyle: pw.FontStyle.italic)),
                ),
              ],
            ),
        ),),
        pw.Text('Cualquier consulta no dudes en llamarnos. Saludos', style: pw.Theme.of(context).defaultTextStyle.copyWith(fontStyle: pw.FontStyle.italic)),
        pw.Padding(padding: const pw.EdgeInsets.only(top: 20)),
        pw.Container(
          alignment: pw.Alignment.center,
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.center,
            mainAxisAlignment: pw.MainAxisAlignment.center,
            children: <pw.Widget>[
              pw.Text(firma, style: pw.Theme.of(context).defaultTextStyle.copyWith(fontStyle: pw.FontStyle.italic, color: PdfColor.fromInt(0xff283593))),
              pw.Text('Administración', style: pw.Theme.of(context).defaultTextStyle.copyWith(fontStyle: pw.FontStyle.italic, color: PdfColor.fromInt(0xff283593))),
              pw.Text('Oficina (Lunes a Viernes de 8:30 a 17 hs)', style: pw.Theme.of(context).defaultTextStyle.copyWith(fontStyle: pw.FontStyle.italic, color: PdfColor.fromInt(0xff283593))),
              pw.Text('Tel: 0261- 439 0313', style: pw.Theme.of(context).defaultTextStyle.copyWith(fontStyle: pw.FontStyle.italic, color: PdfColor.fromInt(0xff283593))),],
          ),
        ),
        pw.Padding(padding: const pw.EdgeInsets.only(top: 30)),
        pw.Text('A tener en cuenta:', style: pw.Theme.of(context).defaultTextStyle.copyWith(fontStyle: pw.FontStyle.italic)),
        pw.Padding(padding: const pw.EdgeInsets.only(top: 10)),
        pw.Text('En caso de un eventual inconveniente no pudiera llegar, se ruega avisarnos a los teléfonos dados, para:', style: pw.Theme.of(context).defaultTextStyle.copyWith(fontStyle: pw.FontStyle.italic)),
        pw.Padding(
          padding: const pw.EdgeInsets.all(15),
          child:pw.Container(
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: <pw.Widget>[
                pw.Padding(
                  padding: const pw.EdgeInsets.all(1),
                  child: pw.Text('- Poder trasladar a otra fecha dentro de los 30 días siguientes a la reserva. De no llegar a un acuerdo se perderá la seña de la cabaña.', style: pw.Theme.of(context).defaultTextStyle.copyWith(fontStyle: pw.FontStyle.italic)),
                ),
              ],
            ),
          ),
        ),
        pw.Text('Si por algún motivo no llegara en dicha fecha pautada sin avisar, perderá la seña y reserva realizada por dicha cabaña.', style: pw.Theme.of(context).defaultTextStyle.copyWith(fontStyle: pw.FontStyle.italic)),
        pw.Padding(padding: const pw.EdgeInsets.only(top: 10)),
        pw.Text('El ingreso al complejo es hasta las 20 hs., después de dicha hora convenir con Hernán.', style: pw.Theme.of(context).defaultTextStyle.copyWith(fontStyle: pw.FontStyle.italic)),
      ],
    ),
  );
  return doc.save();
}
