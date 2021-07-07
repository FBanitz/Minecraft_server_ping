import 'package:http/http.dart';
import 'dart:convert';

class ServerData {
  bool online;
  String ip;
  String port;
  String hostname;
  String version;
  String icon;
  int playerCount;
  int maxPlayers;
  List<String> playerList;
  List<String> info;
  List<String> motd;

  Future<void> pingServer(String ip) async {
    Response response = await get('https://api.mcsrvstat.us/2/$ip');
    if (response.statusCode == 200){
      var debug;
      Motd allmotd;
      Info allinfo;
      Players players;

      Map data = jsonDecode(utf8.decode(response.bodyBytes));
      print(data);
      
      debug = data['debug'] != null ? new Debug.fromJson(data['debug']) : null;
      online = debug != null ? debug.ping : false;

      if (online){
        ip = data['ip'];

        port = data['port'].toString();

        hostname = data['hostname'];

        version = data['version'];

        icon = data['icon'];

        allinfo = data['info'] != null ? new Info.fromJson(data['info']) : null;
        info = allinfo != null ? allinfo.html : null;

        allmotd = data['motd'] != null ? new Motd.fromJson(data['motd']) : null;
        motd = allmotd != null ? allmotd.html : null;


        players = data['players'] != null ? new Players.fromJson(data['players']) : null;
        playerCount = players != null ? players.playerCount : null;
        maxPlayers = players != null ? players.maxPlayers : null;
        playerList = players != null ? players.playerList : null;
        
      }
    }
    else {
      online = false;
    }
  }

}

class Motd {
  List<String> raw;
  List<String> clean;
  List<String> html;

  Motd.fromJson(Map<String, dynamic> json) {
    raw = json['raw'].cast<String>();
    clean = json['clean'].cast<String>();
    html = json['html'].cast<String>();
  }

}

class Debug {
  bool ping;

  Debug.fromJson(Map<String, dynamic> json){
    ping = json['ping'];
  }
}

class Info {
  List<String> raw;
  List<String> clean;
  List<String> html;

  Info.fromJson(Map<String, dynamic> json) {
    raw = json['raw'].cast<String>();
    clean = json['clean'].cast<String>();
    html = json['html'].cast<String>();
  }

}

class Players {
  int playerCount;
  int maxPlayers;
  List<String> playerList;

  Players.fromJson(Map<String, dynamic> json) {
    playerCount = json['online'];
    maxPlayers = json['max'];
    playerList = json['list'] != null ? json['list'].cast<String>() : null;
  }
}