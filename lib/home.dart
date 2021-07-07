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
      body: Container(
        margin: const EdgeInsets.all(13),
        child: Column(
          children: <Widget>[
            serverData != null && serverData.online
                ? Expanded(
                    child: ListView(
                      children: [
                        if (serverData.icon != null)
                          Html(data: '<img src="${serverData.icon}">'),
                        if (serverData.ip != null) Text("ip : ${serverData.ip}"),
                        if (serverData.port != null)
                          Text("port : ${serverData.port}"),
                        if (serverData.hostname != null)
                          Text("hostname : ${serverData.hostname}"),
                        if (serverData.version != null)
                          Text("version : ${serverData.version}"),
                        if (serverData.motd != null) Text("motd : "),
                        if (serverData.motd != null)
                          Container(
                              color: Colors.grey[700],
                              margin: const EdgeInsets.all(13),
                              child: Column(
                                children: [
                                  for (int i = 0; i < serverData.motd.length; i++)
                                    Html(data: serverData.motd[i]),
                                ],
                              )),
                        if (serverData.maxPlayers != null)
                          Text(
                              "Players : ${serverData.playerCount} / ${serverData.maxPlayers}"),
                        serverData.playerList != null &&
                                serverData.maxPlayers != null
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  for (int i = 0;
                                      i < serverData.playerList.length;
                                      i++)
                                    Row(
                                      children: [
                                        if (serverData.playerHead != null)
                                          Html(
                                              data:
                                                  '<img src="${serverData.playerHead[i]}" alt="${serverData.playerList[i]}\'s head">'),
                                        Text(" - ${serverData.playerList[i]}"),
                                      ],
                                    ),
                                  if (serverData.playerList.length > 10)
                                    Text("(+ ${serverData.playerCount - 10})")
                                ],
                              )
                            : serverData.playerCount == 0
                                ? Text("- No player connected")
                                : Text(""),
                        if (serverData.info != null) Text("info : "),
                        if (serverData.info != null)
                          Container(
                              color: Colors.grey[700],
                              margin: const EdgeInsets.all(13),
                              child: Column(
                                children: [
                                  for (int i = 0; i < serverData.info.length; i++)
                                    Html(data: serverData.info[i]),
                                ],
                              ))
                      ],
                    ),
                  )
                : Text("Invalid IP"),
            SizedBox(
              height: 25,
            ),
            TextField(
              decoration: InputDecoration(
                labelText: 'Hostname or Ip',
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(
                    style: BorderStyle.solid,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(
                    style: BorderStyle.solid,
                  ),
                ),
              ),
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
                        isButtonDisabled = false;
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.white,
                      onPrimary: Colors.black,
                    ),
                    icon: Icon(Icons.swap_vert),
                    label: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Text('Ping!'),
                    ),
                  ),
            SizedBox(
              height: 25,
            ),
          ],
        ),
      ),
    );
  }
}
