import 'package:flutter/material.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({super.key});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  String selectedMethod = 'UPI';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Payment")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Select Payment Method",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            RadioListTile(
              value: 'UPI',
              groupValue: selectedMethod,
              title: const Text("UPI"),
              onChanged: (value) {
                setState(() {
                  selectedMethod = value!;
                });
              },
            ),
            RadioListTile(
              value: 'Credit/Debit Card',
              groupValue: selectedMethod,
              title: const Text("Credit/Debit Card"),
              onChanged: (value) {
                setState(() {
                  selectedMethod = value!;
                });
              },
            ),
            RadioListTile(
              value: 'Cash on Delivery',
              groupValue: selectedMethod,
              title: const Text("Cash on Delivery"),
              onChanged: (value) {
                setState(() {
                  selectedMethod = value!;
                });
              },
            ),
            const SizedBox(height: 30),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                      title: const Text("Payment Successful"),
                      content: Text("You selected: $selectedMethod\nOrder placed!"),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pushNamedAndRemoveUntil(
                                context, '/home', (route) => false);
                          },
                          child: const Text("OK"),
                        )
                      ],
                    ),
                  );
                },
                child: const Text("Pay Now"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}