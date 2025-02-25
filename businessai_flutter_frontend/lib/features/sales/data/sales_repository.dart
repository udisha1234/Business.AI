import '../domain/models/sales_data.dart';

class SalesRepository {
  Future<List<SalesData>> getSalesData() async {
    await Future.delayed(Duration(seconds: 2)); // Simulating API call
    return [
      SalesData(product: "Product 1", growth: 12.5, revenue: 1500),
      SalesData(product: "Product 2", growth: 9.2, revenue: 1200),
      SalesData(product: "Product 3", growth: 7.8, revenue: 980),
    ];
  }
}
