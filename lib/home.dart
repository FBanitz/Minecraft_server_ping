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

  //parametters from Api
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

  void getData() async {
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
            showData(),
            SizedBox(
              height: 25,
            ),
            input(),
            SizedBox(
              height: 25,
            ),
            button(),
            SizedBox(
              height: 25,
            ),
          ],
        ),
      ),
    );
  }

  Widget showData() {
    return Container(
      child: 
      responseOnline
        ? Expanded(
            child: ListView(
              children: [
                showIcon(),
                showHostname(),
                showIp(),
                showPort(),
                showVersion(),
                showMotd(),
                showPlayers(),
                showInfo(),
              ],
            ),
          )
        : Text("Can't resolve hostname / IP"),
    );
  }

  Widget showIcon() {
    if (responseIcon != null) 
      return Html(data: '<img src="$responseIcon">');
    return SizedBox.shrink();
  }

  Widget showHostname() {
    if (responseHostname != null) 
      return Text("hostname : $responseHostname");
    return SizedBox.shrink();
  }

  Widget showIp() {
    if (responseIp != null) 
      return Text("ip : $responseIp");
    return SizedBox.shrink();
  }

  Widget showPort() {
    if (responsePort != null) 
      return Text("port : $responsePort");
    return SizedBox.shrink();
  }

  Widget showVersion() {
    if (responseVersion != null) 
      return Text("version : $responseVersion");
    return SizedBox.shrink();
  }

  Widget showMotd() {
    if (responseMotd != null)
      return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("motd : "),
          Container(
            color: Colors.grey[700],
            margin: const EdgeInsets.all(13),
            child: Column(
              children: [
                for (int i = 0; i < responseMotd.length; i++)
                  Html(data: responseMotd[i]),
              ],
            )
          ),
        ],
      );
    return SizedBox.shrink();
  }

  Widget showPlayers() {
    if (responseMaxPlayers != null)
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Players : $responsePlayerCount / $responseMaxPlayers"),
        if(responsePlayerList != null && responseMaxPlayers != null)
          showPlayerList(),
      ],
    );
    return SizedBox.shrink();
  }

  Widget showPlayerList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (int i = 0; i < responsePlayerList.length; i++)
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
    );
  }

  Widget showInfo(){
    if (responseInfo != null) 
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("info : "),
        Container(
          color: Colors.grey[700],
          margin: const EdgeInsets.all(13),
          child: Column(
            children: [
              for (int i = 0; i < responseInfo.length; i++)
                Html(data: responseInfo[i]),
            ],
          ),
        ),
      ],
    );
    return SizedBox.shrink();
  }

  Widget input() {
    return TextField(
      decoration: InputDecoration(
        labelText: 'Hostname or IP',
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
    );
  }

  Widget button() {
    if (isButtonDisabled)
      return SpinKitWave(
        color: Colors.grey,
        size: 20.0,
      );
    return ElevatedButton.icon(
      onPressed: getData,
      style: ElevatedButton.styleFrom(
        primary: Colors.white,
        onPrimary: Colors.black,
      ),
      icon: Icon(Icons.swap_vert),
      label: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Text('Ping!'),
      ),
    );
  }
}