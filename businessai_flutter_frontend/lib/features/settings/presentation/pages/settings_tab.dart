import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../domain/controllers/settings_controller.dart';
import '../../domain/models/settings_model.dart';

class SettingsTab extends StatelessWidget {
  final SettingsController controller = Get.put(SettingsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Settings")),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }

        return ListView(
          padding: EdgeInsets.all(16),
          children: controller.groupedSettings.entries.map((entry) {
            return _buildSettingsSection(entry.key, entry.value);
          }).toList(),
        );
      }),
    );
  }

  Widget _buildSettingsSection(String title, List<SettingsModel> settings) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 10),
        Card(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
            children: settings.map((setting) {
              return _buildSettingsTile(setting);
            }).toList(),
          ),
        ),
        SizedBox(height: 20),
      ],
    );
  }

  Widget _buildSettingsTile(SettingsModel setting) {
    return ListTile(
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: setting.color[100],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(
          setting.icon,
          color: setting.color[700],
          size: 24,
        ),
      ),
      title: Text(setting.title),
      subtitle: Text(
        setting.description,
        style: TextStyle(
          fontSize: 12,
          color: Colors.grey[600],
        ),
      ),
      trailing: Icon(Icons.chevron_right),
      onTap: () {
        // Add navigation logic here
      },
    );
  }
}
