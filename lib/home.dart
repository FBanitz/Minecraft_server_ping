import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  const Home({ Key? key }) : super(key: key);
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var url = Uri.parse('https://api.mcsrvstat.us/2/mc.luston.fr');
  Future<String> _getData() async {
    final response  = await http.get(url);
    if (response.statusCode==200) {
      return response.body;
    } else {
      throw Exception("Erreur impossible de récupérer les données");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Minecraft Server ping"),
        centerTitle: true,
      ),
      body: Center(
        child: FutureBuilder(
          future: _getData(),
          builder: (context, snapshot){
            if (snapshot.hasData) {
              return Text(snapshot.data.toString());
            } else if (snapshot.hasError) {
              return Text("Erreur de chargement");
            } else {
              return CircularProgressIndicator();
            }
          }
          ),
      ),
    );
  }
}
