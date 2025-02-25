import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'features/dashboard/presentation/pages/dashboard_screen.dart';
import 'features/ai_chat/domain/controllers/chat_controller.dart';
import 'features/automation/domain/controllers/automation_controller.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Dependency Injection
  Get.put(ChatController());
  Get.put(AutomationController());

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'BusinessAI',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.light,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: 'Poppins',
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: Colors.blue[700],
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ),
      darkTheme: ThemeData.dark().copyWith(
        primaryColor: Colors.blue[700],
        scaffoldBackgroundColor: Color(0xFF121212),
        cardColor: Color(0xFF1E1E1E),
      ),
      themeMode: ThemeMode.system,
      home: DashboardScreen(),
    );
  }
}
