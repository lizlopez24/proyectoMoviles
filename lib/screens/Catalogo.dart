import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:proyecto_final/screens/Reproduccion.dart';

void main() {
  runApp(CatalogoApp());
}

class CatalogoApp extends StatelessWidget {
  const CatalogoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Catálogo de Productos",
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Map<dynamic, dynamic>> movieList = [];
  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() {
    DatabaseReference productoRef = FirebaseDatabase.instance.ref('peliculas');
    productoRef.onValue.listen((DatabaseEvent event) {
      final data = event.snapshot.value;
      updateProductList(data);
    });
  }

  void updateProductList(dynamic data) {
    if (data != null) {
      List<Map<dynamic, dynamic>> tempList = [];
      data.forEach((key, value) {
        tempList.add({
          "nombre": value['nombre'],
          "anioPublicacion": value['anioPublicacion'],
          "img": value['img'],
          "url": value['url']
        });
      });

      setState(() {
        movieList = tempList;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Películas disponibles', style: TextStyle(color: Colors.white),),
        backgroundColor: Color.fromARGB(255, 168, 91, 204),
      ),
      body: SingleChildScrollView(
        child: Container(
        height: MediaQuery.of(context).size.height,
    decoration: BoxDecoration(
        color: Color.fromARGB(255, 14, 16, 65),
      ),
        child: ListView.builder(
          itemCount: movieList.length,
          itemBuilder: (context, index) {
            return Card(
                margin: EdgeInsets.all(10.0),
                child: ListTile(
                  leading: Image.network('${movieList[index]["img"]}'),
                  title: Text('${movieList[index]["nombre"]}'),
                  subtitle: Text(
                      'Año de publicación: ${movieList[index]["anioPublicacion"]}'),
                  trailing: Icon(Icons.arrow_forward),
                  onTap: () {
                    String data = '${movieList[index]["url"]}';
                    String nombre='${movieList[index]["nombre"]}';
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ReproducionApp(data: data, nombre: nombre,)));
                  },
                ));
          },
        ),
      ),
    )
    );
  }
}
