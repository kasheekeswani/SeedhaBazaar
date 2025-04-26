import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({super.key});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  late Razorpay _razorpay;
  String selectedMethod = 'UPI';

  final Color plum = const Color(0xFF490839);
  final Color orange = const Color(0xFFFF5C00);

  @override
  void initState() {
    super.initState();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  void dispose() {
    _razorpay.clear();
    super.dispose();
  }

  void _startPayment() {
    var options = {
      'key': 'rzp_test_1DP5mmOlF5G5ag', // replace with your Razorpay API key
      'amount': 50000, // in paise = ₹500.00
      'name': 'SeedhaBazaar',
      'description': 'Order Payment',
      'prefill': {
        'contact': '9876543210',
        'email': 'test@example.com',
      },
      'external': {
        'wallets': ['paytm']
      }
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint('Error: $e');
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    _showDialog("Payment Successful", "Payment ID: ${response.paymentId}\nPayment is completed!");
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    _showDialog("Payment Failed", response.message ?? "Something went wrong.");
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    _showDialog("External Wallet Selected", response.walletName ?? "");
  }

  void _showDialog(String title, String message) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        title: Text(title, style: const TextStyle(fontFamily: 'Poppins')),
        content: Text(message, style: const TextStyle(fontFamily: 'Poppins')),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
            },
            child: Text("OK", style: TextStyle(color: orange, fontFamily: 'Poppins')),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Payment", style: TextStyle(fontFamily: 'Poppins')),
        backgroundColor: plum,
        foregroundColor: Colors.white,
        elevation: 2,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Select Payment Method",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                fontFamily: 'Poppins',
                color: plum,
              ),
            ),
            const SizedBox(height: 20),
            _buildPaymentOption("UPI"),
            _buildPaymentOption("Credit/Debit Card"),
            _buildPaymentOption("Cash on Delivery"),
            const SizedBox(height: 40),
            Center(
              child: GestureDetector(
                onTap: _startPayment,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 14),
                  decoration: BoxDecoration(
                    color: orange,
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                        color: orange.withOpacity(0.4),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: const Text(
                    "Pay Now",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Poppins',
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentOption(String method) {
    return RadioListTile<String>(
      value: method,
      groupValue: selectedMethod,
      onChanged: (value) => setState(() => selectedMethod = value!),
      activeColor: orange,
      title: Text(method, style: const TextStyle(fontFamily: 'Poppins')),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    );
  }
}
