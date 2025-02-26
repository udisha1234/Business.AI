import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CustomerController extends GetxController {
  var customers = <Customer>[].obs;
  var filteredCustomers = <Customer>[].obs;

final String apiUrl = "http://192.168.29.227:5000/api/customers";
  // final String apiUrl = "http://localhost:5000/api/customers";

  @override
  void onInit() {
    super.onInit();
    fetchCustomers(); // Load existing customers on startup
  }

  // 📌 Fetch customers from API
  Future<void> fetchCustomers() async {
    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        customers.assignAll(data.map((json) => Customer.fromJson(json)).toList());
        filteredCustomers.assignAll(customers);
      } else {
        Get.snackbar("Error", "Failed to fetch customers");
      }
    } catch (e) {
      print(e);
      Get.snackbar("Error", "An error occurred while fetching data");
    }
  }

  // ✅ Add customer to API and update UI
  Future<void> addCustomer(String name, String email, String phone) async {
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"name": name, "email": email, "phone": phone}),
      );

      if (response.statusCode == 201) {
        final newCustomer = Customer.fromJson(jsonDecode(response.body));
        customers.add(newCustomer);
        filteredCustomers.assignAll(customers);
        Get.snackbar("Success", "Customer added successfully!");
      } else {
        Get.snackbar("Error", "Failed to add customer");
      }
    } catch (e) {
      print(e);
      Get.snackbar("Error", "An error occurred while adding customer");
    }
    fetchCustomers();
  }

  // 🔍 Search customers
  void searchCustomer(String query) {
    if (query.isEmpty) {
      filteredCustomers.assignAll(customers);
    } else {
      filteredCustomers.assignAll(customers.where((customer) =>
          customer.name.toLowerCase().contains(query.toLowerCase()) ||
          customer.email.toLowerCase().contains(query.toLowerCase())));
    }
  }

  // 🗑️ Remove customer
  Future<void> removeCustomer(String id) async {
    try {
      final response = await http.delete(Uri.parse("$apiUrl/$id"));

      if (response.statusCode == 201) {
        customers.removeWhere((customer) => customer.id == id);
        filteredCustomers.assignAll(customers);
        Get.snackbar("Success", "Customer removed successfully!");
      } else {
        Get.snackbar("Error", "Failed to remove customer");
      }
    } catch (e) {
      Get.snackbar("Error", "An error occurred while removing customer");
    }
  }
}

// ✅ Updated Customer Model with `id`
class Customer {
  final String id;
  final String name;
  final String email;
  final String phone;

  Customer({required this.id, required this.name, required this.email, required this.phone});

  factory Customer.fromJson(Map<String, dynamic> json) {
    return Customer(
      id: json['_id'], // Use MongoDB's `_id`
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
    );
  }
}
