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
  String responseIp;
  String responsePort;
  String responseHostname;
  String responseVersion;
  String responseIcon;
  int responsePlayerCount;
  int responseMaxPlayers;
  List<String> responsePlayerList;
  List<String> responsePlayerHead;
  List<String> responseInfo;
  List<String> responseMotd;


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
            responseOnline
                ? Expanded(
                    child: ListView(
                      children: [
                        if (responseIcon != null)
                          Html(data: '<img src="$responseIcon">'),
                        if (responseHostname != null)
                          Text("hostname : $responseHostname"),
                        if (responseIp != null) 
                          Text("ip : $responseIp"),
                        if (responsePort != null)
                          Text("port : $responsePort"),
                        if (responseVersion != null)
                          Text("version : $responseVersion"),
                        if (responseMotd != null) 
                          Text("motd : "),
                        if (responseMotd != null)
                          Container(
                              color: Colors.grey[700],
                              margin: const EdgeInsets.all(13),
                              child: Column(
                                children: [
                                  for (int i = 0; i < responseMotd.length; i++)
                                    Html(data: responseMotd[i]),
                                ],
                              )),
                        if (responseMaxPlayers != null)
                          Text("Players : $responsePlayerCount / $responseMaxPlayers"),
                            responsePlayerList != null && responseMaxPlayers != null
                            ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                for (int i = 0;
                                    i < responsePlayerList.length;
                                    i++)
                                  Row(
                                    children: [
                                      if (responsePlayerHead != null)
                                        Html(data : '<img src="${responsePlayerHead[i]}" alt="$responsePlayerList\'s head">'),
                                      Text(" - ${responsePlayerList[i]}"),
                                    ],
                                  ),
                                if (responsePlayerList.length > 10)
                                  Text("(+ ${responsePlayerCount - 10})")
                              ],
                            )
                            : responsePlayerCount == 0
                            ? Text("- No player connected")
                            : Text(""),
                        if (responseInfo != null) Text("info : "),
                        if (responseInfo != null)
                          Container(
                              color: Colors.grey[700],
                              margin: const EdgeInsets.all(13),
                              child: Column(
                                children: [
                                  for (int i = 0; i < responseInfo.length; i++)
                                    Html(data: responseInfo[i]),
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
                      if (serverData.online) {
                        responseOnline = serverData.online;
                        responseIp = serverData.ip;
                        responsePort = serverData.port;
                        responseHostname = serverData.hostname;
                        responseVersion = serverData.version;
                        responseIcon = serverData.icon;
                        responsePlayerCount = serverData.playerCount;
                        responseMaxPlayers = serverData.maxPlayers;
                        responsePlayerList = serverData.playerList;
                        responsePlayerHead = serverData.playerHead;
                        responseInfo = serverData.info;
                        responseMotd = serverData.motd;
                      }
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
