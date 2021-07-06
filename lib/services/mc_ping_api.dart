import 'package:http/http.dart';
import 'dart:convert';

class ServerData {
  bool online;
  String ip;
  String version;
  Motd motd;

  Future<void> pingServer(String ip) async {
    Response response = await get('https://api.mcsrvstat.us/2/$ip');
    Map data = jsonDecode(utf8.decode(response.bodyBytes));
    print(data);

    online = data['online'];
    ip = data['ip'];
    version = data['version'];
    motd = data['motd'] != null ? new Motd.fromJson(data['motd']) : null;
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