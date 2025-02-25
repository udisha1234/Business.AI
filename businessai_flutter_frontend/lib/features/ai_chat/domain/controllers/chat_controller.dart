import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';

class ChatController extends GetxController {
  var messages = <Map<String, String>>[].obs; // Stores messages
  var isLoading = false.obs;
  TextEditingController textController = TextEditingController();

  Future<void> sendMessage() async {
    String userMessage = textController.text.trim();
    if (userMessage.isEmpty) return;

    messages.add({"role": "user", "text": userMessage});
    textController.clear();
    isLoading.value = true;

    try {
      var response = await http.post(
        Uri.parse('http://192.168.29.227:5000/chat'), // Update to your IP if needed
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"message": userMessage}),
      );
      print(response);
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        messages.add({"role": "ai", "text": data['reply'] ?? "No response"});
      } else {
        messages.add({"role": "error", "text": "Error: Unable to get response."});
      }
    } catch (e) {
      messages.add({"role": "error", "text": "Error: ${e.toString()}"});
    } finally {
      isLoading.value = false;
    }
  }
}
