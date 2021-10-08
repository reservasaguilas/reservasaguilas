import 'package:flutter/material.dart';
import 'package:reservasaguilas/pages/reservas.dart';
import 'prereserva.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    void _showSnack()=> ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Container(child: Text('Developed by Secotaro Maximiliano'), alignment: Alignment.center, height: 20,),
        duration: Duration(seconds: 5),
      )
    );
    final ancho = MediaQuery.of(context).size.width;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: _showSnack,
        child: Icon(Icons.info_outline,),
        backgroundColor: Colors.white,
        elevation: 2,
        mini: true,
      ),
      backgroundColor: Color.fromRGBO(255, 229, 217, 1),
      appBar: AppBar(
        title: Text('Aguilas de Piedra', style: TextStyle(color: Colors.white, shadows: [Shadow(blurRadius: 5.0, color: Colors.black54)]),),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                SizedBox(height: ancho*0.2,),
                ClipRRect(
                  borderRadius: BorderRadius.circular(1000),
                  child: Container(child: Image.asset('/Users/maximilianosecotaro/desarrollos/aguilas/assets/logo.jpeg',), width: ancho*0.8, height: ancho*0.8,)
                ),
                SizedBox(height: ancho*0.40,),
                SizedBox(
                  width: ancho*0.8,
                  child: RaisedButton(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('Pre-Reserva', style: TextStyle(fontSize: 20, color: Colors.white, shadows: [Shadow(blurRadius: 5.0, color: Colors.black54)]),),
                      ), 
                      onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => PreReservas()));
                      }, 
                      color: Color.fromRGBO(72, 202, 228, 1),
                      elevation: 3,
                  ),
                ),
                SizedBox(height: ancho*0.02,),
                SizedBox(
                  width: ancho*0.8,
                  child: RaisedButton(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('Reserva', style: TextStyle(fontSize: 20, color: Colors.white, shadows: [Shadow(blurRadius: 5.0, color: Colors.black54)]),),
                      ), 
                      onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => Reservas()));
                      }, 
                      color: Color.fromRGBO(72, 202, 228, 1),
                      elevation: 3,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
//Color.fromRGBO(254, 197, 187, 1)