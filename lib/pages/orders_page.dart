import 'package:flutter/material.dart';

class OrdersPage extends StatelessWidget {
  const OrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> orders = [
      {
        'product': 'Potatoes',
        'date': '10 April 2025',
        'status': 'Delivered',
      },
      {
        'product': 'Tomatoes',
        'date': '8 April 2025',
        'status': 'Shipped',
      },
      {
        'product': 'Rice',
        'date': '5 April 2025',
        'status': 'Processing',
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Orders'),
        backgroundColor: const Color(0xFF490839), // Plum
        foregroundColor: Colors.white,
      ),
      backgroundColor: const Color(0xFFFFA7EC).withOpacity(0.1), // light Candy tone
      body: ListView.builder(
        itemCount: orders.length,
        itemBuilder: (context, index) {
          final order = orders[index];

          Color statusColor;
          switch (order['status']) {
            case 'Delivered':
              statusColor = const Color(0xFFCB1D85); // Pink
              break;
            case 'Shipped':
              statusColor = const Color(0xFFF94500); // Carrot
              break;
            default:
              statusColor = Colors.grey.shade700;
          }

          return Card(
            color: Colors.white,
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              leading: const Icon(Icons.shopping_cart, color: Color(0xFF490839)),
              title: Text(
                order['product']!,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Color(0xFF490839), // Plum
                ),
              ),
              subtitle: Text(
                'Ordered on: ${order['date']}',
                style: const TextStyle(
                  color: Colors.black54,
                ),
              ),
              trailing: Text(
                order['status']!,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: statusColor,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
