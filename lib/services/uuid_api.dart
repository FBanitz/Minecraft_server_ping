import 'package:flutter/widgets.dart';
import 'package:http/http.dart';
import 'dart:convert';

// This app uses the "Mojang API". Go check it out !
// https://wiki.vg/Mojang_API

class PlayerUuid {

  static Future<String> getId(String playername, {BuildContext context}) async {
    Response response = await get('https://api.mojang.com/users/profiles/minecraft/$playername');
    if (response.statusCode == 200) {
      Map data = jsonDecode(utf8.decode(response.bodyBytes));
      print(data);
      return data['id'];
    } else {
    print("Unable to connect to Mojang servers");
    return "";
    }
  }

}