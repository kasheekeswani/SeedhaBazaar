// pages/negotiation_screen.dart
import 'package:flutter/material.dart';
import '../models/negotiation.dart';
import '../models/offer.dart';
import '../widgets/negotiation_widget.dart';

class NegotiationScreen extends StatefulWidget {
  final Negotiation negotiation;
  final String currentUserId;

  const NegotiationScreen({
    super.key,
    required this.negotiation,
    required this.currentUserId,
  });

  @override
  State<NegotiationScreen> createState() => _NegotiationScreenState();
}

class _NegotiationScreenState extends State<NegotiationScreen> {
  late Negotiation _negotiation;

  @override
  void initState() {
    super.initState();
    _negotiation = widget.negotiation;
  }

  void _handleOfferSubmitted(double price) {
    final newOffer = Offer(
      id: UniqueKey().toString(),
      negotiationId: _negotiation.id,
      senderId: widget.currentUserId,
      price: price,
      timestamp: DateTime.now(),
    );

    final updatedOffers = [..._negotiation.offers, newOffer];

    setState(() {
      _negotiation = Negotiation(
        id: _negotiation.id,
        productId: _negotiation.productId,
        buyerId: _negotiation.buyerId,
        farmerId: _negotiation.farmerId,
        offers: updatedOffers,
        status: NegotiationStatus.countered,
      );
    });

    // TODO: Persist the new offer to backend or local storage
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Negotiation'),
      ),
      body: NegotiationWidget(
        negotiation: _negotiation,
        currentUserId: widget.currentUserId,
        onOfferSubmitted: _handleOfferSubmitted,
      ),
    );
  }
}
