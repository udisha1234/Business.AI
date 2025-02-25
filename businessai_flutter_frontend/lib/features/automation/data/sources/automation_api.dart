import 'dart:convert';
import 'package:http/http.dart' as http;

class AutomationApi {
  Future<List<Map<String, dynamic>>> fetchAutomationFeatures() async {
    final response = await http.get(Uri.parse('https://api.example.com/automation'));

    if (response.statusCode == 200) {
      List<dynamic> jsonData = jsonDecode(response.body);
      return jsonData.cast<Map<String, dynamic>>();
    } else {
      throw Exception('Failed to fetch automation data');
    }
  }
}
