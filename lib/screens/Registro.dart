import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:proyecto_final/screens/Login.dart';

void main() {
  runApp(RegistroApp());
}

class RegistroApp extends StatelessWidget {
  const RegistroApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Registrarse",
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Registro de Usuario"),
        ),
        body: Cuerpo(context));
  }
}

Widget Cuerpo(context) {
  return Container(
    decoration: BoxDecoration(
        color: Color.fromARGB(255, 14, 16, 65),
      ),
    child: (Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(top:30),
          child: Text("Datos Personales", style: TextStyle(fontSize: 24, color: Colors.white)),
        ),
        Nombre(),
        //Edad(),
        Correo(),
        Password(),
        BotonRegistrar(context)
      ],
    )),
  );
}

final TextEditingController _nombre = TextEditingController();
final TextEditingController _correo = TextEditingController();
final TextEditingController _contrasenia = TextEditingController();
Widget Nombre() {
  return Container(
      padding: const EdgeInsets.all(40),
      child: TextField(
        controller: _nombre,
        decoration: InputDecoration(
            hintText: "Ingrese su nombre",
            fillColor: Colors.white,
            filled: true),
      ));
}

Widget Correo() {
  return Container(
      padding: const EdgeInsets.all(40),
      child: TextField(
        controller: _correo,
        decoration: InputDecoration(
            hintText: "Ingrese su correo electrónico",
            fillColor: Colors.white,
            filled: true),
        keyboardType: TextInputType.emailAddress,
      ));
}

Widget Password() {
  return Column(children: [
    Container(
      padding: EdgeInsets.all(40),
      child: TextField(
        controller: _contrasenia,
        obscureText: true,
        decoration: InputDecoration(
          hintText: 'Ingrese su contraseña',
          fillColor: Colors.white,
          filled: true,
        ),
        keyboardType: TextInputType.visiblePassword,
      ),
    ),
  ]);
}

Widget BotonRegistrar(context) {
  return (FilledButton(
      onPressed: () {
        registro(context);
      },
      child: Text("Registrar")));
}

Future<void> registro(context) async {
  try {
    final credential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(
      email: _correo.text,
      password: _contrasenia.text,
    ).then((user) async {
      await user.user?.updateDisplayName(_nombre.text);
    /*
      String uid=user.user?.uid.toString() ?? generarCadenaAleatoria(10) ;

      DatabaseReference ref =
      FirebaseDatabase.instance.ref("users/"+uid);
      await ref.set({
        "nombre": _nombre.text,
        "edad": _edad.text,
      });
      */
    });

    Navigator.push(context, MaterialPageRoute(builder: (context) => LoginApp()));
  } on FirebaseAuthException catch (e) {
    if (e.code == 'weak-password') {
      print('The password provided is too weak.');
    } else if (e.code == 'email-already-in-use') {
      print('The account already exists for that email.');
    }
  } catch (e) {
    print(e);
  }
}
