import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'features/dashboard/presentation/pages/dashboard_screen.dart';
import 'features/ai_chat/domain/controllers/chat_controller.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized(); // Ensures everything is set up before running the app
  Get.put(ChatController()); // ✅ Initialize ChatController globally
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp( // ✅ Use GetMaterialApp for GetX features
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
