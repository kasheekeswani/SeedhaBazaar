import 'package:flutter/material.dart';
import 'home_page.dart';
import 'pages/login_signup_page.dart';
import 'pages/credentials_page.dart';
import 'pages/product_detail_page.dart';
import 'pages/checkout_page.dart';
import 'pages/payment_page.dart';
import 'pages/dashboard/farmer_dashboard.dart';
import 'pages/dashboard/buyer_dashboard.dart';
import 'pages/orders_page.dart';
import 'pages/negotiation_screen.dart';
import 'pages/meeting_page.dart';

import 'models/negotiation.dart';

Map<String, WidgetBuilder> appRoutes = {
  // 🔐 Auth Screens
  '/login': (context) => const LoginSignupPage(userType: 'farmer'),
  '/credentials': (context) => const CredentialsPage(),

  // 🏠 Home Page
  '/home_page': (context) => const HomePage(userType: 'Farmer'),

  // 🛒 Product Detail (with arguments)
  '/product_detail': (context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final priceString = args['price'].toString();
    final parsedPrice = double.tryParse(
      priceString.replaceAll(RegExp(r'[^\d.]'), ''),
    ) ?? 0.0;

    return ProductDetailPage(
      productName: args['name'],
      productImage: args['image'],
      price: parsedPrice,
      description: args['description'],
    );
  },

  // 🧾 Negotiation Page (with arguments)
  '/negotiate': (context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    final negotiation = Negotiation(
      id: 'neg-${DateTime.now().millisecondsSinceEpoch}',
      productId: 'product-001', // Replace this with actual product ID if available
      buyerId: 'user-001', // Replace this with actual buyer ID from auth
      farmerId: 'farmer-001', // Replace this with actual farmer ID
      offers: [],
      status: NegotiationStatus.pending,
    );

    return NegotiationScreen(
      negotiation: negotiation,
      currentUserId: 'user-001', // Replace with actual logged-in user ID
    );
  },

  // 💳 Checkout & Payment
  '/checkout': (context) => const CheckoutPage(),
  '/payment': (context) => const PaymentPage(),

  // 📦 Orders Page
  '/orders': (context) => const OrdersPage(),

  '/meeting': (context) => const MeetingPage(),

  // 👤 Dashboards
  '/farmer_dashboard': (context) => const FarmerDashboard(),
  '/buyer_dashboard': (context) => const BuyerDashboard(),
};
