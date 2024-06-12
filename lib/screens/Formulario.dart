import 'dart:math';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:proyecto_final/screens/Catalogo.dart';
import 'package:proyecto_final/screens/Registro.dart';
import 'package:proyecto_final/screens/Reproduccion.dart';

void main(){
  runApp(Formulario());
}
class Formulario extends StatelessWidget {
  const Formulario({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int indice=0;
  @override
  Widget build(BuildContext context) {
    final List <Widget> screens=[SingleChildScrollView(child: Cuerpo(context)),CatalogoApp(),ReproducionApp()];
    return Scaffold(
      appBar: AppBar(
        title: const Text('Techflix'),
      ),
      body: screens[indice],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: indice,
        onTap: (valor) {
          setState(() {
            indice=valor;
          });
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.local_movies_outlined), label: "Registro"),
          BottomNavigationBarItem(icon: Icon(Icons.list),label: "Catalogo"),
          BottomNavigationBarItem(icon: Icon(Icons.video_camera_back),label: "Reproducir")
        ]
        ),
    );
  }
}

Widget Cuerpo(context){
  return Container(
    padding: EdgeInsets.only(left:40, right: 40),
    child: (
    Column(
      children: <Widget>[
        Text("Registro de peliculas", style: TextStyle(fontSize: 24)),
        nombre(),
        anioPublicacion(),
        duracion(),
        descripcion(),
        url(),
        BtnGuardar(context)
      ],
    )
  )
  );
}

final TextEditingController _nombre=TextEditingController();
Widget nombre(){
  return Container(
    padding: EdgeInsets.only(bottom: 20, top: 50),
    child: TextField(
      controller: _nombre,
      decoration: InputDecoration(
        hintText: "Ingrese el nombre"
      ),
    ),
  );
}

final TextEditingController _anioPublicacion=TextEditingController();
Widget anioPublicacion(){
  return Container(
    padding: EdgeInsets.only(bottom: 20),
    child: TextField(
      controller: _anioPublicacion,
      decoration: InputDecoration(
        hintText: "Ingrese el año de publicación"
      ),
      keyboardType: TextInputType.number,
    ),
  );
}

final TextEditingController _duracion=TextEditingController();
Widget duracion(){
  return Container(
    padding: EdgeInsets.only(bottom: 20),
    child: TextField(
      controller: _duracion,
      decoration: InputDecoration(
        hintText: "Ingrese la duracion"
      ),
      keyboardType: TextInputType.number,
    ),
  );
}

final TextEditingController _descripcion=TextEditingController();
Widget descripcion(){
  return Container(
    padding: EdgeInsets.only(bottom: 20),
    child: TextField(
      controller: _descripcion,
      decoration: InputDecoration(
        hintText: "Ingrese la descripcion"
      ),
    ),
  );
}

final TextEditingController _url=TextEditingController();
Widget url(){
  return Container(
    padding: EdgeInsets.only(bottom: 20),
    child: TextField(
      controller: _url,
      decoration: InputDecoration(
        hintText: "Ingrese la url de la imagen"
      ),
    ),
  );
}



String generarCadenaAleatoria(int longitud) {
  const caracteres = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ';
  Random random = Random();
  return String.fromCharCodes(Iterable.generate(
    longitud,
    (_) => caracteres.codeUnitAt(random.nextInt(caracteres.length)),
  ));
}

Widget BtnGuardar(context){
  return Container(
    padding: EdgeInsets.only(top: 30),
    child: (
      FilledButton(onPressed: (){
        guardar(context);
      }, child: Text("Guardar"))
    ),
  );
}

Future<void> guardar(context) async {
String id=generarCadenaAleatoria(3);
DatabaseReference ref = FirebaseDatabase.instance.ref("peliculas/"+id);
await ref.set({
  "id": id,
  "nombre": _nombre.text,
  "anioPublicacion": _anioPublicacion.text,
  "duracion":_duracion.text,
  "descripcion":_descripcion.text,
  "img":_url.text
});
mostrarAlerta(context);
}

void mostrarAlerta(context){
  showDialog(context: context, builder: (context){
    return AlertDialog(
      title: Text("Registro exitoso"),
      content: Text("La película ha sido registrada con éxito"),
      actions: [
        TextButton(onPressed: (){
          Navigator.pop(context);
        }, child: Text("Cerrar"))
      ],
    );
  });
}

