// lib/models/offer.dart
class Offer {
  final String id;
  final String negotiationId;
  final String senderId;
  final double price;
  final DateTime timestamp;

  Offer({
    required this.id,
    required this.negotiationId,
    required this.senderId,
    required this.price,
    required this.timestamp,
  });
}
