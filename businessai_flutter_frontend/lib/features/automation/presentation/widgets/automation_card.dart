import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../domain/controllers/automation_controller.dart';

class AutomationCard extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;
  final Color color;
  final int index;

  AutomationCard({required this.title, required this.description, required this.icon, required this.color, required this.index});

  final AutomationController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(() => Card(
          elevation: 2,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Row(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(color: color.withOpacity(0.2), borderRadius: BorderRadius.circular(10)),
                  child: Icon(icon, color: color, size: 30),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                      SizedBox(height: 4),
                      Text(description, style: TextStyle(fontSize: 12, color: Colors.grey[600])),
                    ],
                  ),
                ),
                Switch(
                  value: controller.isAutomationEnabled[index],
                  onChanged: (value) => controller.toggleAutomation(index, value),
                  activeColor: color,
                ),
              ],
            ),
          ),
        ));
  }
}
