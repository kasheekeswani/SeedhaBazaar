// lib/models/negotiation.dart
import 'offer.dart'; // Make sure this is correctly relative to your file structure

class Negotiation {
  final String id;
  final String productId;
  final String buyerId;
  final String farmerId;
  final List<Offer> offers;
  final NegotiationStatus status;

  Negotiation({
    required this.id,
    required this.productId,
    required this.buyerId,
    required this.farmerId,
    required this.offers,
    required this.status,
  });
}

enum NegotiationStatus { pending, accepted, rejected, countered }
