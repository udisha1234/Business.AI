class AutomationFeature {
  final String title;
  final String description;
  final String icon;
  final String color;
  bool isActive;

  AutomationFeature({required this.title, required this.description, required this.icon, required this.color, this.isActive = false});

  factory AutomationFeature.fromJson(Map<String, dynamic> json) {
    return AutomationFeature(
      title: json['title'],
      description: json['description'],
      icon: json['icon'],
      color: json['color'],
      isActive: json['isActive'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {'title': title, 'description': description, 'icon': icon, 'color': color, 'isActive': isActive};
  }
}
