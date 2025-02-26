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
                    final customer =
                        customerController.filteredCustomers[index];
                    return ListTile(
                      leading: CircleAvatar(child: Text(customer.name[0])),
                      title: Text(customer.name),
                      subtitle: Text(customer.email),
                      trailing: IconButton(
                        icon: Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          customerController.removeCustomer(
                              customer.id.toString()); // Ensure id is String
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
    final TextEditingController nameController = TextEditingController();
    final TextEditingController emailController = TextEditingController();
    final TextEditingController phoneController = TextEditingController();

    Get.defaultDialog(
      title: "Add Customer",
      content: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                hintText: "Name",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16.0, vertical: 14.0),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                hintText: "Email",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16.0, vertical: 14.0),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 10),
            TextField(
              controller: phoneController,
              decoration: InputDecoration(
                hintText: "Phone",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16.0, vertical: 14.0),
              ),
              keyboardType: TextInputType.phone,
            ),
          ],
        ),
      ),
      // SingleChildScrollView(
      //   child: Column(
      //     children: [
      //       TextField(
      //         controller: nameController,
      //         decoration: InputDecoration(hintText: "Name"),
      //       ),
      //       SizedBox(height: 10),
      //       TextField(
      //         controller: emailController,
      //         decoration: InputDecoration(hintText: "Email"),
      //       ),
      //       SizedBox(height: 10),
      //       TextField(
      //         controller: phoneController,
      //         decoration: InputDecoration(hintText: "Phone"),
      //       ),
      //     ],
      //   ),
      // ),
      confirm: ElevatedButton(
        onPressed: () {
          if (nameController.text.isNotEmpty &&
              emailController.text.isNotEmpty &&
              phoneController.text.isNotEmpty) {
            Get.find<CustomerController>().addCustomer(nameController.text,
                emailController.text, phoneController.text);
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
