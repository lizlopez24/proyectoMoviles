import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

void main(){
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
        //////////////////////////////////////////
        /// Se asigna la clave y valor a la lista temporal
        //////////////////////////////////////////
        
        tempList.add({"nombre": value['nombre'], "anioPublicacion": value['anioPublicacion'],"img": value['img']});
        
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
        title: Text('Catalogo de Películas'),
      ),
      body: ListView.builder(
        itemCount: movieList.length,
        itemBuilder: (context, index) {
          return Card(
            margin: EdgeInsets.all(10.0),
            child: ListTile(      
            leading: Image.network('${movieList[index]["img"]}'),      
            title: Text('${movieList[index]["nombre"]}'), 
            subtitle:Text('Año de publicación: ${movieList[index]["anioPublicacion"]}'),      
          ));
        },
      ),
    );
  }
}




class CatalogItem extends StatelessWidget {
  final String item;
  final String descripcion;
  final String img;
  final String anioPublicacion;
  CatalogItem({required this.item, required this.descripcion, required this.img, required this.anioPublicacion});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10.0),
      child: ListTile(
        leading: Image.network('$img'),
        title: Text(item),
        subtitle: Text('Año de Publicación $anioPublicacion'),
        trailing: Icon(Icons.arrow_forward),
        onTap: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('$descripcion')),
          );
        },
      ),
    );
  }
}