import '../sources/automation_local_db.dart';
import '../sources/automation_api.dart';

class AutomationRepository {
  final AutomationApi api = AutomationApi();
  final AutomationLocalDb localDb = AutomationLocalDb();

  Future<List<Map<String, dynamic>>> fetchAutomationFeatures() async {
    try {
      return await api.fetchAutomationFeatures();
    } catch (e) {
      return localDb.getAutomationFeatures();
    }
  }

  void saveAutomationFeature(Map<String, dynamic> data) {
    localDb.saveAutomationFeature(data);
  }
}
