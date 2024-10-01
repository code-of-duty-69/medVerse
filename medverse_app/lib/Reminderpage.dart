import 'package:flutter/material.dart';

class Reminderpage extends StatefulWidget {
  const Reminderpage({super.key});

  @override
  State<Reminderpage> createState() => _ReminderpageState();
}

class _ReminderpageState extends State<Reminderpage> {
  final List<Map<String, dynamic>> _reminders = [];
  final TextEditingController _nameController = TextEditingController();
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;
  bool _isEveryday = false;

  // Colors
  final Color primaryColor = const Color(0xFF2196F3);
  final Color backgroundColor = const Color(0xFFF5F6FA);
  final Color cardColor = Colors.white;
  final Color textColor = const Color(0xFF1A1A1A);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: Container(
          height: 96,
          width: 150,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                spreadRadius: 2,
                blurRadius: 6,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              'images/logo.png',
              fit: BoxFit.cover,
            ),
          ),
        ),
        backgroundColor: primaryColor,
        toolbarHeight: 110.0,
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showAddReminderDialog(),
        backgroundColor: primaryColor,
        icon: const Icon(Icons.add),
        label: const Text('New'),
      ),
      body: _reminders.isEmpty
          ? Center(
              child: Text(
                "No reminders yet",
                style: TextStyle(
                  fontSize: 18,
                  color: textColor.withOpacity(0.6),
                ),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _reminders.length,
              itemBuilder: (context, index) => _buildReminderCard(index),
            ),
    );
  }

  Widget _buildReminderCard(int index) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ExpansionTile(
        title: Text(
          _reminders[index]['name'],
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: textColor,
            fontSize: 18,
          ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Row(
            children: [
              Icon(Icons.calendar_today, size: 16, color: textColor.withOpacity(0.6)),
              const SizedBox(width: 8),
              Text(
                _reminders[index]['date'],
                style: TextStyle(color: textColor.withOpacity(0.6)),
              ),
              const SizedBox(width: 16),
              Icon(Icons.access_time, size: 16, color: textColor.withOpacity(0.6)),
              const SizedBox(width: 8),
              Text(
                _reminders[index]['time'],
                style: TextStyle(color: textColor.withOpacity(0.6)),
              ),
            ],
          ),
        ),
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (_reminders[index]['Everyday'] == true)
                  Chip(
                    label: const Text('Everyday'),
                    backgroundColor: primaryColor.withOpacity(0.1),
                    labelStyle: TextStyle(color: primaryColor),
                  ),
                IconButton(
                  icon: const Icon(Icons.delete_outline, color: Colors.red),
                  onPressed: () => _deleteReminder(index),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showAddReminderDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Add New Reminder',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: textColor,
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    labelText: 'Enter reminder name',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    filled: true,
                    fillColor: backgroundColor,
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () async {
                          await _pickDate();
                          setState(() {});
                        },
                        icon: const Icon(Icons.calendar_today),
                        label: Text(_selectedDate == null
                            ? 'Pick Date'
                            : "${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primaryColor,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () async {
                          await _pickTime();
                          setState(() {});
                        },
                        icon: const Icon(Icons.access_time),
                        label: Text(_selectedTime == null
                            ? 'Pick Time'
                            : "${_selectedTime!.hour}:${_selectedTime!.minute}"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primaryColor,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Checkbox(
                      value: _isEveryday,
                      onChanged: (bool? value) {
                        setState(() {
                          _isEveryday = value ?? false;
                        });
                      },
                      activeColor: primaryColor,
                    ),
                    const Text('Everyday'),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                        _resetForm();
                      },
                      child: Text('Cancel', style: TextStyle(color: textColor)),
                    ),
                    const SizedBox(width: 12),
                    ElevatedButton(
                      onPressed: () {
                        _addReminder();
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryColor,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 12,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text('Add Reminder'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

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
          'Everyday': _isEveryday,
        });
        _resetForm();
      });
    }
  }

  void _resetForm() {
    _nameController.clear();
    _selectedDate = null;
    _selectedTime = null;
    _isEveryday = false;
  }

  void _deleteReminder(int index) {
    setState(() {
      _reminders.removeAt(index);
    });
  }
}