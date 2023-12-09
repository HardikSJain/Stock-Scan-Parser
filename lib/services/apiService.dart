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

Future<List<Map<String, dynamic>>> getStockScan() async {
  try {
    var url = Uri.parse('$baseUrl/data.json');
    final response = await http.get(url);

    // Explicitly cast the decoded JSON to List<Map<String, dynamic>>
    List<Map<String, dynamic>> stockScan =
        (jsonDecode(response.body) as List).cast<Map<String, dynamic>>();

    // print(response.body);
    // print(stockScan);
    return stockScan;
  } catch (e) {
    print(e.toString());
    return [];
  }
}
