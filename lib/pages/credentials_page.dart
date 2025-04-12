import 'package:flutter/material.dart';

class CredentialsPage extends StatefulWidget {
  const CredentialsPage({super.key});

  @override
  State<CredentialsPage> createState() => _CredentialsPageState();
}

class _CredentialsPageState extends State<CredentialsPage> {
  final _formKey = GlobalKey<FormState>();
  String name = '';
  String phone = '';
  String role = 'Farmer'; // default

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Enter Your Details")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Name'),
                onSaved: (value) => name = value ?? '',
                validator: (value) =>
                    value == null || value.isEmpty ? 'Enter name' : null,
              ),
              const SizedBox(height: 10),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Phone Number'),
                keyboardType: TextInputType.phone,
                onSaved: (value) => phone = value ?? '',
                validator: (value) =>
                    value == null || value.isEmpty ? 'Enter phone' : null,
              ),
              const SizedBox(height: 10),
              DropdownButtonFormField<String>(
                value: role,
                items: const [
                  DropdownMenuItem(value: 'Farmer', child: Text("Farmer")),
                  DropdownMenuItem(value: 'Buyer', child: Text("Buyer")),
                ],
                onChanged: (value) {
                  setState(() {
                    role = value ?? 'Farmer';
                  });
                },
                decoration: const InputDecoration(labelText: 'Select Role'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    _formKey.currentState?.save();
                    if (role == 'Farmer') {
                      Navigator.pushNamed(context, '/farmer_dashboard');
                    } else {
                      Navigator.pushNamed(context, '/buyer_dashboard');
                    }
                  }
                },
                child: const Text("Continue"),
              )
            ],
          ),
        ),
      ),
    );
  }
}