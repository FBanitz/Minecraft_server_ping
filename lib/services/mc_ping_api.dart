import 'package:http/http.dart';
import 'dart:convert';

class ServerData {
  bool online;
  String ip;
  String version;
  List<String> motd;

  Future<void> pingServer(String ip) async {
    Response response = await get('https://api.mcsrvstat.us/2/$ip');
    if (response.statusCode == 200){
      Map data = jsonDecode(utf8.decode(response.bodyBytes));
      print(data);
      var debug;
      Motd allmotd;
      debug = data['debug'] != null ? new Debug.fromJson(data['debug']) : null;
      online = debug != null ? debug.ping : false;
      if (online){
        ip = data['ip'];
        version = data['version'];
        allmotd = data['motd'] != null ? new Motd.fromJson(data['motd']) : null;
        motd = allmotd.html;
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