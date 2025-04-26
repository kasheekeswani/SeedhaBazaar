import 'package:flutter/material.dart';

class BuyerDashboard extends StatelessWidget {
  const BuyerDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    final Color plum = const Color(0xFF490839);
    final Color orange = const Color(0xFFFF5C00);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Buyer Dashboard",
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
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Welcome, Buyer!",
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                fontFamily: 'Poppins',
                color: plum,
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: orange,
                foregroundColor: Colors.white,
                textStyle: const TextStyle(fontFamily: 'Poppins'),
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 4,
              ),
              onPressed: () {
                Navigator.pushNamed(context, '/home');
              },
              icon: const Icon(Icons.shopping_cart),
              label: const Text("Shop Products"),
            ),
            const SizedBox(height: 40),
            Text(
              "Your Orders",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                fontFamily: 'Poppins',
                color: plum,
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: 3, // Replace with dynamic order data
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 3,
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ListTile(
                      leading: Icon(Icons.receipt_long, color: plum),
                      title: Text(
                        "Order #${index + 1001}",
                        style: const TextStyle(fontFamily: 'Poppins'),
                      ),
                      subtitle: const Text(
                        "Status: Delivered",
                        style: TextStyle(fontFamily: 'Poppins'),
                      ),
                      trailing: Icon(Icons.arrow_forward_ios, color: orange),
                      onTap: () {
                        // TODO: Link to order details
                      },
                    ),
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
