import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ChatController extends GetxController {
  var messages = <Map<String, String>>[].obs;
  var isLoading = false.obs;
  TextEditingController textController = TextEditingController();

  final String apiUrl = "http://192.168.29.227:5000/api/chat"; // Replace with your actual backend URL

  void sendMessage() async {
    String messageText = textController.text.trim();
    if (messageText.isEmpty) return;

    messages.add({"role": "user", "text": messageText});
    textController.clear();
    isLoading.value = true;

    try {
      var response = await http.post(
        Uri.parse(apiUrl),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"message": messageText}),
      );

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        messages.add({"role": "bot", "text": data["reply"] ?? "No response from AI"});
      } else {
        messages.add({"role": "bot", "text": "Error: ${response.statusCode}"});
      }
    } catch (e) {
      messages.add({"role": "bot", "text": "Failed to connect to AI server"});
    } finally {
      isLoading.value = false;
    }
  }
}
