import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class AutomationLocalDb {
  Future<List<Map<String, dynamic>>> getAutomationFeatures() async {
    final prefs = await SharedPreferences.getInstance();
    String? jsonData = prefs.getString('automation_features');
    if (jsonData != null) {
      return List<Map<String, dynamic>>.from(jsonDecode(jsonData));
    }
    return [];
  }

  void saveAutomationFeature(Map<String, dynamic> data) async {
    final prefs = await SharedPreferences.getInstance();
    List<Map<String, dynamic>> existingData = await getAutomationFeatures();
    existingData.add(data);
    prefs.setString('automation_features', jsonEncode(existingData));
  }
}
