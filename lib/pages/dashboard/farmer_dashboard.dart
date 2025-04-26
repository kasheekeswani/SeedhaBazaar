import 'package:flutter/material.dart';

class FarmerDashboard extends StatelessWidget {
  const FarmerDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    final Color plum = const Color(0xFF490839);
    final Color orange = const Color(0xFFFF5C00);

    final List<Map<String, dynamic>> products = [
      {'name': 'Chawal', 'price': '₹40/kg', 'quantity': '500kg'},
      {'name': 'Gehu', 'price': '₹35/kg', 'quantity': '750kg'},
      {'name': 'Bajra', 'price': '₹30/kg', 'quantity': '300kg'},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Farmer Dashboard",
          style: TextStyle(fontFamily: 'Poppins'),
        ),
        backgroundColor: plum,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Logout',
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/login');
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Welcome, Ramlal 👋",
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                fontFamily: 'Poppins',
                color: plum,
              ),
            ),
            const SizedBox(height: 20),

            // Stats Overview
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _statCard("Total Products", "3", plum, orange),
                _statCard("Revenue", "₹62,500", plum, orange),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _statCard("Pending Orders", "2", plum, orange),
                _statCard("Verified Docs", "Yes", plum, orange),
              ],
            ),
            const SizedBox(height: 30),

            // Add Product
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: orange,
                foregroundColor: Colors.white,
                textStyle: const TextStyle(fontFamily: 'Poppins'),
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 4,
              ),
              onPressed: () {
                Navigator.pushNamed(context, '/add_product');
              },
              icon: const Icon(Icons.add),
              label: const Text("Add New Product"),
            ),
            const SizedBox(height: 30),

            // Products Section
            Text(
              "Your Products",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                fontFamily: 'Poppins',
                color: plum,
              ),
            ),
            const SizedBox(height: 16),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
                return Card(
                  elevation: 3,
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ListTile(
                    leading: Icon(Icons.agriculture, color: plum),
                    title: Text(
                      product['name'],
                      style: const TextStyle(fontFamily: 'Poppins'),
                    ),
                    subtitle: Text(
                      "${product['price']} | ${product['quantity']}",
                      style: const TextStyle(fontFamily: 'Poppins'),
                    ),
                    trailing: Icon(Icons.edit, color: orange),
                    onTap: () {
                      // TODO: Implement edit functionality
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _statCard(String label, String value, Color plum, Color orange) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
        decoration: BoxDecoration(
          color: plum.withOpacity(0.08),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: plum.withOpacity(0.2)),
        ),
        child: Column(
          children: [
            Text(
              value,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: plum,
                fontFamily: 'Poppins',
              ),
            ),
            const SizedBox(height: 6),
            Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: orange,
                fontFamily: 'Poppins',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
