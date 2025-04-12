import 'package:flutter/material.dart';

class FarmerDashboard extends StatelessWidget {
  const FarmerDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Farmer Dashboard"),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/login');
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Welcome, Farmer!",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.pushNamed(context, '/add_product');
              },
              icon: const Icon(Icons.add),
              label: const Text("Add New Product"),
            ),
            const SizedBox(height: 20),
            const Text(
              "Your Products",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: 3, // Replace with actual product list length
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: const Icon(Icons.agriculture),
                    title: Text("Product ${index + 1}"),
                    subtitle: const Text("₹50 per kg"),
                    trailing: const Icon(Icons.edit),
                    onTap: () {
                      // Navigate to edit product page
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}