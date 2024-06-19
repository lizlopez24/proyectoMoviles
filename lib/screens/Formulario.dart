import 'dart:math';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:proyecto_final/screens/Catalogo.dart';
import 'package:proyecto_final/screens/Registro.dart';

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
    final List <Widget> screens=[SingleChildScrollView(child: Cuerpo(context)), CatalogoApp()];
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
          BottomNavigationBarItem(icon: Icon(Icons.list),label: "Catalogo")
        ]
        ),
    );
  }
}

Widget Cuerpo(context){
  return Container(
    height: MediaQuery.of(context).size.height,
    decoration: BoxDecoration(
        color: Color.fromARGB(255, 14, 16, 65),
      ),
    padding: EdgeInsets.only(left:40, right: 40),
    child: (
    Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(top: 40),
          child: Text("Registro de peliculas", style: TextStyle(fontSize: 24, color: Colors.white))),
        nombre(),
        anioPublicacion(),
        duracion(),
        descripcion(),
        url(),
        urlPelicula(),
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
        hintText: "Ingrese el nombre",
         fillColor: Colors.white,
            filled: true
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
        hintText: "Ingrese el año de publicación",
         fillColor: Colors.white,
            filled: true
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
        hintText: "Ingrese la duracion",
         fillColor: Colors.white,
            filled: true
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
        hintText: "Ingrese la descripcion",
         fillColor: Colors.white,
            filled: true
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
        hintText: "Ingrese la url de la imagen",
         fillColor: Colors.white,
            filled: true
      ),
    ),
  );
}

final TextEditingController _urlPelicula=TextEditingController();
Widget urlPelicula(){
  return Container(
    padding: EdgeInsets.only(bottom: 20),
    child: TextField(
      controller: _urlPelicula,
      decoration: InputDecoration(
        hintText: "Ingrese la url de la pelicula en el storage",
         fillColor: Colors.white,
            filled: true
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
        mostrarAlerta(context);
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
  "img":_url.text,
  "url":_urlPelicula.text
});
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

