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
  List<String> playerHead;
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
        playerHead = players != null ? players.playerHead : null;
        
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

  Motd.fromJson(Map<String, dynamic> data) {
    raw = data['raw'].cast<String>();
    clean = data['clean'].cast<String>();
    html = data['html'].cast<String>();
  }

}

class Debug {
  bool ping;

  Debug.fromJson(Map<String, dynamic> data){
    ping = data['ping'];
  }
}

class Info {
  List<String> raw;
  List<String> clean;
  List<String> html;

  Info.fromJson(Map<String, dynamic> data) {
    raw = data['raw'].cast<String>();
    clean = data['clean'].cast<String>();
    html = data['html'].cast<String>();
  }

}

class Players {
  int playerCount;
  int maxPlayers;
  List<String> playerList;
  List<String> playerUuid;
  List<String> playerHead;

  Players.fromJson(Map<String, dynamic> data) {
    var uuid = new Uuid();
    var head = new PlayerHead();
    playerCount = data['online'];
    maxPlayers = data['max'];
    playerList = data['list'] != null ? data['list'].cast<String>() : null;
    if (playerUuid != null)
    playerUuid.clear();
    if (playerList != null)
    for (int i = 0; i < playerList.length; i++){
      uuid.getId(playerList[i]);
      if (uuid.id != null)
      playerUuid.add(uuid.id);
    }
    if (playerUuid != null)
    for (int i = 0; i < playerUuid.length; i++){
      head.getHead(playerUuid[i]);
      playerHead.add(head.img);
    }
  }
}

class Uuid {
  String id;

  Future<void> getId(String playername) async {
    Response response = await get('https://api.mojang.com/users/profiles/minecraft/$playername');
    if (response.statusCode == 200) {
      Map data = jsonDecode(utf8.decode(response.bodyBytes));
      print(data);
      id = data['id'];
    } else 
    print("unable to connect to Mojang servers");
  }
}

class PlayerHead {
  String img;

  Future<void> getHead(String uuid) async {
    Response response = await get('https://crafatar.com/renders/head/$uuid');
    if (response.statusCode == 200) {
      String data = jsonDecode(utf8.decode(response.bodyBytes));
      print(data);
      img = data;
    }else 
    print("unable to connect to craftar servers");
  }
}