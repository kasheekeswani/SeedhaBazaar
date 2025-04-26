import 'package:flutter/material.dart';
import '../models/negotiation.dart';


class NegotiationWidget extends StatefulWidget {
  final Negotiation negotiation;
  final String currentUserId;
  final Function(double) onOfferSubmitted;

  const NegotiationWidget({
    super.key,
    required this.negotiation,
    required this.currentUserId,
    required this.onOfferSubmitted,
  });

  @override
  State<NegotiationWidget> createState() => _NegotiationWidgetState();
}

class _NegotiationWidgetState extends State<NegotiationWidget> {
  final TextEditingController _offerController = TextEditingController();

  @override
  void dispose() {
    _offerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: widget.negotiation.offers.length,
            itemBuilder: (context, index) {
              final offer = widget.negotiation.offers[index];
              final isCurrentUser = offer.senderId == widget.currentUserId;

              return Align(
                alignment:
                    isCurrentUser ? Alignment.centerRight : Alignment.centerLeft,
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: isCurrentUser
                        ? Colors.orange.shade100
                        : Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: isCurrentUser
                        ? CrossAxisAlignment.end
                        : CrossAxisAlignment.start,
                    children: [
                      Text(
                        '₹${offer.price.toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${isCurrentUser ? "You" : "Other"} - ${offer.timestamp.toLocal().toString().split('.').first}',
                        style: const TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        const Divider(height: 1),
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _offerController,
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  decoration: const InputDecoration(
                    labelText: 'Enter your offer',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              ElevatedButton(
                onPressed: () {
                  final price = double.tryParse(_offerController.text.trim());
                  if (price != null && price > 0) {
                    widget.onOfferSubmitted(price);
                    _offerController.clear();
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Enter a valid price')),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                ),
                child: const Text('Submit'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
