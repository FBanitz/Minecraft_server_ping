import 'package:http/http.dart';
import 'dart:convert';

// This app uses the "Mojang API". Go check it out !
// https://wiki.vg/Mojang_API

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