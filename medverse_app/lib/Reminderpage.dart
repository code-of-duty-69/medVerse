import 'package:flutter/material.dart';

class Reminderpage extends StatefulWidget {
  const Reminderpage({super.key});

  @override
  State<Reminderpage> createState() => _ReminderpageState();
}

class _ReminderpageState extends State<Reminderpage> {
  final List<Map<String, dynamic>> _reminders =
      []; // Store reminders with name, date, and time
  final TextEditingController _nameController = TextEditingController();
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MEDVERSE'),
        backgroundColor: const Color.fromARGB(255, 43, 147, 231),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Existing Reminders Section
              const Text(
                "Existing Reminders",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              _reminders.isEmpty
                  ? const Text("No reminders yet.",
                      style: TextStyle(fontSize: 16))
                  : ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: _reminders.length,
                      itemBuilder: (context, index) {
                        return _buildReminderTile(index);
                      },
                    ),
              const SizedBox(height: 20),
              const Divider(),
              // Add New Reminder Section
              const Text(
                "Add New Reminder",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Reminder Name",
                ),
              ),
              const SizedBox(height: 10),

              // Date and Time Pickers
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _pickDate,
                      child: Text(
                        _selectedDate == null
                            ? "Pick Date"
                            : "${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}",
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _pickTime,
                      child: Text(
                        _selectedTime == null
                            ? "Pick Time"
                            : "${_selectedTime!.hour}:${_selectedTime!.minute}",
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),

              // Create Reminder Button
              ElevatedButton(
                onPressed: _addReminder,
                child: const Text("Create Reminder"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Build each reminder tile with options to edit/delete
  Widget _buildReminderTile(int index) {
    return ExpansionTile(
      title: Text(_reminders[index]['name']),
      subtitle:
          Text("${_reminders[index]['date']} at ${_reminders[index]['time']}"),
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ElevatedButton(
                onPressed: () => _deleteReminder(index),
                child: const Text("Delete Reminder"),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // Function to pick a date
  Future<void> _pickDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  // Function to pick a time
  Future<void> _pickTime() async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  // Add new reminder to the list
  void _addReminder() {
    if (_nameController.text.isNotEmpty &&
        _selectedDate != null &&
        _selectedTime != null) {
      setState(() {
        _reminders.add({
          'name': _nameController.text,
          'date':
              "${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}",
          'time': "${_selectedTime!.hour}:${_selectedTime!.minute}",
        });
        _nameController.clear();
        _selectedDate = null;
        _selectedTime = null;
      });
    }
  }

  // Delete reminder from the list
  void _deleteReminder(int index) {
    setState(() {
      _reminders.removeAt(index);
    });
  }
}
