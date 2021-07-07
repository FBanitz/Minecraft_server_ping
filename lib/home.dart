import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'services/mc_ping_api.dart';

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  ServerData serverData;
  bool isButtonDisabled = false;
  String data = "";
  String ip = "";
  bool responseOnline = false;
  String responseIp = "";
  String responseVersion = "";

  changeIp(value) {
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
      body: Column(
        children: <Widget>[
          SizedBox(
            height: 25,
          ),
          responseOnline
              ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("ip : $responseIp"),
                  Text("version : $responseVersion"),
                  Text("motd : "),
                  for (int i=0; i < serverData.motd.length; i++ )
                    Html(data: serverData.motd[i]),
                ],
              )
              : Text("Ip non valide"),
          SizedBox(
            height: 25,
          ),
          TextField(
            
            onChanged: changeIp,
          ),
          SizedBox(
            height: 25,
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
                      if (serverData.online){
                        responseIp = serverData.ip;
                        responseVersion = serverData.version;
                        responseOnline = serverData.online;
                      }
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
        ],
      ),
    );
  }
}
