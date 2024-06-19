import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:proyecto_final/screens/Catalogo.dart';
import 'package:proyecto_final/screens/Formulario.dart';

void main(){
  runApp(LoginApp());
}
class LoginApp extends StatelessWidget {
  const LoginApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home(),);
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
        title: const Text("Iniciar Sesión"),
      ),
      body: SingleChildScrollView(child: Cuerpo(context)),
    );
  }
}
Widget Cuerpo(context){
  return Container(
    height: MediaQuery.of(context).size.height,
    decoration: BoxDecoration(
        color: Color.fromARGB(255, 14, 16, 65),
      ),
    child: (
      Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(top: 30),
            child: Image.network('https://cdn-icons-png.freepik.com/512/10892/10892514.png', scale: 3,),
          ),
          Correo(),
          Password(),
          BotonLogin(context)
        ],
      )
    ),
  );
}

final TextEditingController _correo=TextEditingController();
Widget Correo(){
  return Container(
    padding: const EdgeInsets.all(40),
    child: TextField(
      controller: _correo,
      decoration: InputDecoration(
        hintText: "Ingrese su correo electrónico",
        fillColor: Colors.white,
        filled: true
      ),
      keyboardType: TextInputType.emailAddress,
    )
  );
}

final TextEditingController _contrasenia=TextEditingController();
Widget Password(){
  return Column(
    children: [
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
    ]
  );
}

Widget BotonLogin(context){
  return(
    FilledButton(onPressed: (){
      login(context);
      //Navigator.push(context, MaterialPageRoute(builder: (context)=>Formulario()));
    }, child: Text("Iniciar Sesión"))
  );
}

Future<void> login(context) async {
  try {
  final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
    email: _correo.text,
    password: _contrasenia.text
  );
  Navigator.push(context, MaterialPageRoute(builder: (context)=>Formulario()));
} on FirebaseAuthException catch (e) {
  if (e.code == 'invalid-credential') {
    mostrarAlertaMail(context);
  } else if (e.code == 'wrong-password') {
  }
}
}

void mostrarAlertaMail(context){
  showDialog(context: context, builder: (context){
    return AlertDialog(
      title: Text("Error al iniciar sesión"),
      content: Text("El correo o contraseña son incorrectos"),
      actions: [
        TextButton(onPressed: (){
          Navigator.pop(context);
        }, child: Text("Aceptar"))
      ],
    );
  });
}