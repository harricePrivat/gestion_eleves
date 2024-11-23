import 'package:http/http.dart' as http;
import 'dart:convert';

class SendData {
  SendData();
  Future<http.Response> goDelete(String url) async {
    return await http.delete(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      //    body: jsonEncode(object));
    );
  }

  Future<http.Response> goGet(String url) async {
    return await http.get(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      // body: jsonEncode(object),
    );
  }

  Future<http.Response> goPost(String url, Object object) async {
    return await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(object),
    );
  }

  // Future<http.Response> goMultipart(String url,)
}
