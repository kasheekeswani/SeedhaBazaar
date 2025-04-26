import 'package:flutter/material.dart';

class MeetingPage extends StatelessWidget {
  const MeetingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Request a Meeting'),
        backgroundColor: const Color(0xFF490839),
        foregroundColor: Colors.white,
      ),
      body: const MeetingRequestForm(),
    );
  }
}

class MeetingRequestForm extends StatefulWidget {
  const MeetingRequestForm({super.key});

  @override
  State<MeetingRequestForm> createState() => _MeetingRequestFormState();
}

class _MeetingRequestFormState extends State<MeetingRequestForm> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _reasonController = TextEditingController();
  DateTime? _selectedDateTime;

  Future<void> _pickDateTime(BuildContext context) async {
    final DateTime? date = await showDatePicker(
      context: context,
      initialDate: DateTime.now().add(const Duration(days: 1)),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );

    if (date == null) return;

    final TimeOfDay? time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (time == null) return;

    setState(() {
      _selectedDateTime = DateTime(
        date.year,
        date.month,
        date.day,
        time.hour,
        time.minute,
      );
    });
  }

  void _submitRequest() {
    final name = _nameController.text.trim();
    final reason = _reasonController.text.trim();

    if (name.isEmpty || reason.isEmpty || _selectedDateTime == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all the fields.')),
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Meeting request submitted!\nName: $name\nDate: ${_selectedDateTime!.toLocal()}\nReason: $reason',
        ),
      ),
    );

    // Optionally: clear form
    _nameController.clear();
    _reasonController.clear();
    setState(() => _selectedDateTime = null);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Your Name'),
          const SizedBox(height: 8),
          TextField(
            controller: _nameController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Enter your name',
            ),
          ),
          const SizedBox(height: 16),
          const Text('Meeting Reason'),
          const SizedBox(height: 8),
          TextField(
            controller: _reasonController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'e.g., Project discussion',
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () => _pickDateTime(context),
            child: const Text('Pick Date & Time'),
          ),
          if (_selectedDateTime != null)
            Padding(
              padding: const EdgeInsets.only(top: 12),
              child: Text('Selected: ${_selectedDateTime!.toLocal()}'),
            ),
          const SizedBox(height: 24),
          Center(
            child: ElevatedButton.icon(
              icon: const Icon(Icons.send),
              label: const Text('Submit Request'),
              onPressed: _submitRequest,
            ),
          ),
        ],
      ),
    );
  }
}
