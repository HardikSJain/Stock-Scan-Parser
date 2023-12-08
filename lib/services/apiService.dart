import 'dart:convert';
import 'package:http/http.dart' as http;

String baseUrl = 'http://coding-assignment.bombayrunning.com';

Future<bool> getBackendStatusAPI() async {
  try {
    var url = Uri.parse('$baseUrl/data.json');
    final response = await http.get(url);
    return true;
  } catch (e) {
    return false;
  }
}
