import 'package:flutter/material.dart';

class LoginSignupPage extends StatelessWidget {
  final String userType;

  const LoginSignupPage({super.key, required this.userType});

  @override
  Widget build(BuildContext context) {
    final Color plum = const Color(0xFF490839);
    final Color orange = const Color(0xFFFF5C00);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Login / Signup",
          style: TextStyle(fontFamily: 'Poppins'),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            if (userType.toLowerCase() == 'farmer') {
              Navigator.pushReplacementNamed(context, '/farmer_dashboard');
            } else {
              Navigator.pushReplacementNamed(context, '/buyer_dashboard');
            }
          },
        ),
        backgroundColor: plum,
        foregroundColor: Colors.white,
        elevation: 2,
      ),
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(24.0),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFFFA7EC), Color(0xFFFCE4EC)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 40),
            const Icon(Icons.local_florist, size: 64, color: Color(0xFFCB1D85)),
            const SizedBox(height: 20),
            const Text(
              "Welcome to SeedhaBazaar",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Color(0xFFCB1D85),
                fontFamily: 'Poppins',
              ),
            ),
            const SizedBox(height: 50),
            _buildAnimatedButton(
              label: "Login as $userType",
              color: orange,
              context: context,
              route: null, // Leads nowhere
            ),
            const SizedBox(height: 16),
            _buildAnimatedButton(
              label:
                  "Login as ${userType.toLowerCase() == 'farmer' ? 'Buyer' : 'Farmer'}",
              color: plum,
              context: context,
              route: null, // Leads nowhere
            ),
            const SizedBox(height: 30),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/credentials');
              },
              child: Text(
                "Don't have an account? Sign up",
                style: TextStyle(
                  fontSize: 14,
                  decoration: TextDecoration.underline,
                  fontFamily: 'Poppins',
                  color: plum,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAnimatedButton({
    required String label,
    required Color color,
    required BuildContext context,
    String? route,
  }) {
    return GestureDetector(
      onTap: () {
        if (route != null) {
          Navigator.pushNamed(context, route);
        }
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 16),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.4),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.white,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
