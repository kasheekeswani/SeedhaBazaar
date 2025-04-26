import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class CredentialsPage extends StatefulWidget {
  const CredentialsPage({super.key});

  @override
  State<CredentialsPage> createState() => _CredentialsPageState();
}

class _CredentialsPageState extends State<CredentialsPage> {
  final _formKey = GlobalKey<FormState>();

  String fullName = '';
  String phone = '';
  String address = '';
  String altName = '';
  String landArea = '';
  String idNumber = '';
  String role = 'Farmer';
  File? pdfFile;

  final Color plum = const Color(0xFF490839);
  final Color orange = const Color(0xFFFF5C00);

  String? validatePdfFile(File? file) {
    if (file == null) return 'Please upload Aadhar/PAN PDF';
    if (file.lengthSync() > 50 * 1024) return 'File must be less than 50KB';
    return null;
  }

  Future<void> pickPdf() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null && result.files.single.path != null) {
      final file = File(result.files.single.path!);
      if (file.lengthSync() <= 50 * 1024) {
        setState(() => pdfFile = file);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("PDF size must be less than 50KB")),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Enter Your Details",
          style: TextStyle(fontFamily: 'Poppins'),
        ),
        backgroundColor: plum,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              _buildTextField(
                label: 'Full Name',
                onSaved: (v) => fullName = v!,
                validator: _requiredValidator,
              ),
              const SizedBox(height: 20),
              _buildTextField(
                label: 'Phone Number',
                keyboardType: TextInputType.phone,
                onSaved: (v) => phone = v!,
                validator: _requiredValidator,
              ),
              const SizedBox(height: 20),
              _buildTextField(
                label: 'Address',
                onSaved: (v) => address = v!,
                validator: _requiredValidator,
              ),
              const SizedBox(height: 20),
              _buildTextField(
                label: 'Any Other Name Known As',
                onSaved: (v) => altName = v!,
                validator: _requiredValidator,
              ),
              const SizedBox(height: 20),
              _buildTextField(
                label: 'Area of Land (in acres)',
                keyboardType: TextInputType.number,
                onSaved: (v) => landArea = v!,
                validator: _requiredValidator,
              ),
              const SizedBox(height: 20),
              _buildTextField(
                label: 'Aadhar/PAN Number',
                onSaved: (v) => idNumber = v!,
                validator: _requiredValidator,
              ),
              const SizedBox(height: 20),
              DropdownButtonFormField<String>(
                value: role,
                items: const [
                  DropdownMenuItem(value: 'Farmer', child: Text("Farmer")),
                  DropdownMenuItem(value: 'Buyer', child: Text("Buyer")),
                ],
                onChanged: (v) => setState(() => role = v!),
                decoration: InputDecoration(
                  labelText: 'Select Role',
                  labelStyle: TextStyle(color: plum, fontFamily: 'Poppins'),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                style: const TextStyle(fontFamily: 'Poppins', fontSize: 16),
              ),
              const SizedBox(height: 20),
              Align(
                alignment: Alignment.centerLeft,
                child: ElevatedButton.icon(
                  onPressed: pickPdf,
                  icon: const Icon(Icons.upload_file),
                  label: Text(
                    pdfFile == null
                        ? 'Upload Aadhar/PAN (PDF < 50KB)'
                        : 'File Selected',
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: orange,
                    foregroundColor: Colors.white,
                    textStyle: const TextStyle(fontFamily: 'Poppins'),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              GestureDetector(
                onTap: () {
                  final pdfError = validatePdfFile(pdfFile);
                  if (_formKey.currentState?.validate() ?? false &&
                      pdfError == null) {
                    _formKey.currentState?.save();
                    Navigator.pushNamed(context, '/home');
                  } else if (pdfError != null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(pdfError)),
                    );
                  }
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 14),
                  decoration: BoxDecoration(
                    color: orange,
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                        color: orange.withOpacity(0.3),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: const Text(
                    "Continue",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String? _requiredValidator(String? value) {
    return (value == null || value.isEmpty) ? 'This field is required' : null;
  }

  Widget _buildTextField({
    required String label,
    required FormFieldSetter<String> onSaved,
    required FormFieldValidator<String> validator,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextFormField(
      onSaved: onSaved,
      validator: validator,
      keyboardType: keyboardType,
      style: const TextStyle(fontFamily: 'Poppins'),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: plum, fontFamily: 'Poppins'),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: orange),
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}
