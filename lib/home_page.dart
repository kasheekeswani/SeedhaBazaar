import 'package:flutter/material.dart';
import 'pages/orders_page.dart';
import 'pages/dashboard/farmer_dashboard.dart';
import 'pages/dashboard/buyer_dashboard.dart';

class HomePage extends StatefulWidget {
  final String userType; // Either 'Farmer' or 'Buyer'

  const HomePage({super.key, required this.userType});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  static const List<Map<String, String>> products = [
    {
      'name': 'Potatoes',
      'price': '₹20/kg',
      'image': 'https://th.bing.com/th/id/R.b0ea390802c97d189c2152e5b1040a40?rik=7ppku4Y9f7fyWw&riu=http%3a%2f%2fwww.photos-public-domain.com%2fwp-content%2fuploads%2f2010%2f11%2fpotatoes.jpg&ehk=ppej%2bTYeB5zO5uvgoQuNWzypg9gESEnsGXkS7OQaYRo%3d&risl=&pid=ImgRaw&r=0',
    },
    {
      'name': 'Rice',
      'price': '₹60/kg',
      'image': 'https://assets-global.website-files.com/64f700835515df24fda55fbd/659cce7edbabbfaa1b2e4445_parboiled.jpg',
    },
    {
      'name': 'Tomatoes',
      'price': '₹25/kg',
      'image': 'https://gardenandhappy.com/wp-content/uploads/2018/10/food-fresh-tomatoes-162830.jpg',
    },
    {
      'name': 'Onions',
      'price': '₹30/kg',
      'image': 'https://th.bing.com/th/id/R.d8c736d7731e57dddbeac3aa5e99ee1d?rik=cV6yIsCR%2fJRPug&riu=http%3a%2f%2fwww.almanac.com%2fsites%2fdefault%2ffiles%2fimage_nodes%2fonions.jpg&ehk=j9c2t0N3TYlDybNtpzOKj2StSAC6Nz3%2bVJD6BbBXxBc%3d&risl=&pid=ImgRaw&r=0',
    },
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget _buildCurrentPage() {
    switch (_selectedIndex) {
      case 0:
        return Column(
          children: [
            _buildSearchBar(),
            Expanded(child: _buildProductGrid(context)),
          ],
        );
      case 1:
        return const OrdersPage();
      case 2:
        return widget.userType == 'Farmer'
            ? const FarmerDashboard()
            : const BuyerDashboard();
      default:
        return const Center(child: Text("Page not found"));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome, ${widget.userType}!'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
      ),
      body: SafeArea(child: _buildCurrentPage()),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_bag), label: 'Orders'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Search products...',
          prefixIcon: const Icon(Icons.search),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }

  Widget _buildProductGrid(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      itemCount: products.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 4,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemBuilder: (context, index) =>
          _buildProductCard(context, products[index]),
    );
  }

  Widget _buildProductCard(BuildContext context, Map<String, String> product) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          '/product_detail',
          arguments: {
            'name': product['name'],
            'price': product['price'],
            'image': product['image'],
            'description': '${product['name']} are fresh and sourced directly from farms.',
          },
        );
      },
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(16)),
              child: Image.network(
                product['image']!,
                height: 120,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) =>
                    const Icon(Icons.broken_image),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                product['name']!,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                product['price']!,
                style: const TextStyle(color: Colors.green),
              ),
            ),
          ],
        ),
      ),
    );
  }
}