import 'package:get/get.dart';
import '../models/customer.dart';

class CustomerController extends GetxController {
  var customers = <Customer>[].obs;
  var filteredCustomers = <Customer>[].obs;

  @override
  void onInit() {
    super.onInit();
    for (int i = 0; i < 15; i++) {
      customers.add(Customer(
        name: 'Customer ${i + 1}',
        email: 'customer${i + 1}@example.com',
      ));
    }
    filteredCustomers.assignAll(customers);
  }

  void addCustomer(String name, String email) {
    customers.add(Customer(name: name, email: email));
    searchCustomer(""); // Refresh filter
  }

  void removeCustomer(int index) {
    customers.removeAt(index);
    searchCustomer(""); // Refresh filter
  }

  void searchCustomer(String query) {
    if (query.isEmpty) {
      filteredCustomers.assignAll(customers);
    } else {
      filteredCustomers.assignAll(customers.where((customer) =>
          customer.name.toLowerCase().contains(query.toLowerCase()) ||
          customer.email.toLowerCase().contains(query.toLowerCase())));
    }
  }
}
