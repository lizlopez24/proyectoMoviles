import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:proyecto_final/screens/Login.dart';
import 'package:proyecto_final/screens/Registro.dart';
import 'package:firebase_core/firebase_core.dart';
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
await Firebase.initializeApp();

  runApp(const Bienvenida());
}

class Bienvenida extends StatelessWidget {
  const Bienvenida({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Techflix",
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
        title: const Text("Techflix"),
      ),
      body: Cuerpo(context)
    );
  }
}

Widget Cuerpo(context){
  return Container(
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 14, 16, 65),
        image: DecorationImage(
          image: NetworkImage('https://canalc.com.ar/wp-content/uploads/2022/08/cultura.jpg')
          )
      ),
      child:(
      Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
        Container(
          padding: EdgeInsets.only(bottom: 290),
          child: Inicio(),
          ),
          Row(
            children: [
              Container(
                padding: EdgeInsets.only(left: 55,top: 70),
                child: BotonRegistro(context)
              ),
              Container(
                padding: EdgeInsets.only(left: 55, top: 70),
                child: BotonLogin(context)
              ),
            ],
          ),
      ],)
      ),
  );
}

Widget Inicio(){
  return Container(
      padding: EdgeInsets.all(40),
      child: Text("Bienvenido a tu aplicacion favorita de streaming", style: TextStyle(fontSize: 30, fontFamily: 'Georgia', fontStyle: FontStyle.italic, fontWeight: FontWeight.bold, color: Colors.white)),
  );
}

Widget BotonRegistro(context){
  return(
    FilledButton(onPressed: (){
      Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => RegistroApp()),
          );
    }, child: Text("Registrarse"))
  );
}

Widget BotonLogin(context){
  return(
    FilledButton(onPressed: (){
      Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => LoginApp()),
          );
    }, child: Text("Iniciar Sesión"))
  );
}