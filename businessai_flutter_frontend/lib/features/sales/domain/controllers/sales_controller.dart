import 'package:get/get.dart';
import '../models/sales_data.dart';
import '../../data/sales_repository.dart';

class SalesController extends GetxController {
  var salesData = <SalesData>[].obs;
  final SalesRepository repository;

  SalesController(this.repository);

  @override
  void onInit() {
    super.onInit();
    fetchSalesData();
  }

  void fetchSalesData() async {
    salesData.value = await repository.getSalesData();
  }
}
