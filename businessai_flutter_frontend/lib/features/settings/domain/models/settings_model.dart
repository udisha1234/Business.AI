import 'package:flutter/material.dart';

class SettingsModel {
  final String title;
  final String description;
  final IconData icon;
  final MaterialColor color;
  final String category;

  SettingsModel(this.title, this.description, this.icon, this.color, this.category);
}
