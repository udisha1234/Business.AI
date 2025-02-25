import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../domain/controllers/customer_controller.dart';

class CustomerTab extends StatelessWidget {
  final CustomerController customerController = Get.put(CustomerController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(16),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search customers...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey.withOpacity(0.1),
                contentPadding: EdgeInsets.symmetric(vertical: 0),
              ),
              onChanged: (value) {
                customerController.searchCustomer(value);
              },
            ),
          ),
          Expanded(
            child: Obx(() => ListView.separated(
                  itemCount: customerController.filteredCustomers.length,
                  separatorBuilder: (context, index) => Divider(height: 1),
                  itemBuilder: (context, index) {
                    final customer = customerController.filteredCustomers[index];
                    return ListTile(
                      leading: CircleAvatar(child: Text(customer.name[0])),
                      title: Text(customer.name),
                      subtitle: Text(customer.email),
                      trailing: IconButton(
                        icon: Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          customerController.removeCustomer(index);
                        },
                      ),
                      onTap: () {},
                    );
                  },
                )),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          _showAddCustomerDialog(context);
        },
        tooltip: 'Add Customer',
      ),
    );
  }

  void _showAddCustomerDialog(BuildContext context) {
    String name = '';
    String email = '';

    Get.defaultDialog(
      title: "Add Customer",
      content: Column(
        children: [
          TextField(
            decoration: InputDecoration(hintText: "Name"),
            onChanged: (value) => name = value,
          ),
          SizedBox(height: 10),
          TextField(
            decoration: InputDecoration(hintText: "Email"),
            onChanged: (value) => email = value,
          ),
        ],
      ),
      confirm: ElevatedButton(
        onPressed: () {
          if (name.isNotEmpty && email.isNotEmpty) {
            Get.find<CustomerController>().addCustomer(name, email);
            Get.back();
          }
        },
        child: Text("Add"),
      ),
      cancel: TextButton(
        onPressed: () => Get.back(),
        child: Text("Cancel"),
      ),
    );
  }
}
