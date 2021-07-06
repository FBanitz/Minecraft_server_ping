import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'services/mc_ping_api.dart';

import 'package:flutter/material.dart';



class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  ServerData serverData;
  bool isButtonDisabled = false;
  String data = "";
  String ip = "";

  changeIp(value){
    setState(() {
      ip = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Minecraft Server ping"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: <Widget>[
                  SizedBox(
                    height: 25,
                  ),
                  Text(data),
                  SizedBox(
                    height: 25,
                  ),
                  TextField(
                    onChanged: changeIp,
                  ),
            isButtonDisabled
              ? SpinKitWave(
                  color: Colors.grey,
                  size: 20.0,
                )
              : ElevatedButton.icon(
                  onPressed: () async {
                    setState(() {
                      isButtonDisabled = true;
                    });
                    serverData = ServerData();
                    await serverData.pingServer(ip);
                    setState(() {
                      data = "ip : ${serverData.ip} version : ${serverData.version} motd : ${serverData.motd.clean[0]}";
                      isButtonDisabled = false;
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.white,
                    onPrimary: Colors.black,
                  ),
                  icon: Icon(Icons.refresh),
                  label: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text('Ping!'),
                  ),
                )
        ],),
      ),
    );
  }
}
