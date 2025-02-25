import 'package:get/get.dart';
import '../models/settings_model.dart';
import 'package:flutter/material.dart';

class SettingsController extends GetxController {
  var isLoading = true.obs;
  var settings = <SettingsModel>[].obs;
  var groupedSettings = <String, List<SettingsModel>>{}.obs;

  @override
  void onInit() {
    super.onInit();
    fetchSettings();
  }

  void fetchSettings() async {
    await Future.delayed(Duration(seconds: 1)); // Simulating network delay

    settings.value = [
      SettingsModel("Profile Information", "Manage your personal details", Icons.person, Colors.blue, "Account"),
      SettingsModel("Business Details", "Update your company information", Icons.business, Colors.orange, "Account"),
      SettingsModel("Subscription Plan", "Manage your BusinessAI subscription", Icons.card_membership, Colors.purple, "Account"),
      
      SettingsModel("Appearance", "Light, dark, or system theme", Icons.palette, Colors.indigo, "Preferences"),
      SettingsModel("Notifications", "Manage app notifications", Icons.notifications, Colors.red, "Preferences"),
      SettingsModel("Language", "Change app language", Icons.language, Colors.green, "Preferences"),
      
      SettingsModel("Payment Gateways", "Connect payment processors", Icons.payment, Colors.amber, "Integrations"),
      SettingsModel("Twilio Integration", "Configure AI call system", Icons.phone, Colors.blue, "Integrations"),
      SettingsModel("Email Service", "Connect email provider", Icons.email, Colors.teal, "Integrations"),
      
      SettingsModel("Password", "Change your password", Icons.lock, Colors.red, "Security"),
      SettingsModel("Two-Factor Authentication", "Add extra security layer", Icons.security, Colors.green, "Security"),
      SettingsModel("API Keys", "Manage integration keys", Icons.key, Colors.purple, "Security"),
      
      SettingsModel("Help Center", "View documentation and guides", Icons.help, Colors.blue, "Support"),
      SettingsModel("Contact Support", "Get help from our team", Icons.support_agent, Colors.orange, "Support"),
      SettingsModel("About", "App version and information", Icons.info, Colors.grey, "Support"),
    ];

    // Grouping settings dynamically
    var grouped = <String, List<SettingsModel>>{};
    for (var setting in settings) {
      if (!grouped.containsKey(setting.category)) {
        grouped[setting.category] = [];
      }
      grouped[setting.category]!.add(setting);
    }

    groupedSettings.value = grouped;
    isLoading.value = false;
  }
}
