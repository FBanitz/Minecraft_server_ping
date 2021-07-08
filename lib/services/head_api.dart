import 'package:http/http.dart';
import 'dart:convert';

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