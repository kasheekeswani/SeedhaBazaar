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
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
      ),
      body: ListView.builder(
        itemCount: orders.length,
        itemBuilder: (context, index) {
          final order = orders[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            child: ListTile(
              leading: const Icon(Icons.shopping_cart),
              title: Text(order['product']!),
              subtitle: Text('Ordered on: ${order['date']}'),
              trailing: Text(
                order['status']!,
                style: TextStyle(
                  color: order['status'] == 'Delivered'
                      ? Colors.green
                      : order['status'] == 'Shipped'
                          ? Colors.orange
                          : Colors.red,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}