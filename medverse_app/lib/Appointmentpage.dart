import 'package:flutter/material.dart';

class AppointmentPage extends StatelessWidget {
  const AppointmentPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // App Bar
            Container(
              padding: const EdgeInsets.all(16.0),
              color: const Color(0xFFFF5C5C),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(Icons.arrow_back, color: Colors.white),
                  ),
                  const SizedBox(width: 16),
                  const Text(
                    'MY APPOINTMENTS',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            
            // Tabs
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Color(0xFFFF5C5C),
                          width: 2,
                        ),
                      ),
                    ),
                    child: const Text(
                      'Upcoming',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: const Text(
                      'Completed',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            
            // Sort Bar
            Container(
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: Colors.grey, width: 0.5),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: const [
                      Text('Sort By'),
                      SizedBox(width: 8),
                      Text(
                        'Appointment Date',
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                      Icon(Icons.arrow_drop_down),
                    ],
                  ),
                  const Text(
                    'Last Updated at 00:21:11 02 Oct, 2024',
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),
            ),
            
            // Note
            Container(
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: Colors.grey, width: 0.5),
                ),
              ),
              child: RichText(
                text: const TextSpan(
                  style: TextStyle(color: Colors.grey, fontSize: 14),
                  children: [
                    TextSpan(
                      text: 'Note: ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text: 'Appointment time displayed is liable to change. '
                          'Please check with the hospital for confirmation.',
                    ),
                  ],
                ),
              ),
            ),
            
            // Appointment List
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: const [
                  AppointmentCard(
                    doctor: 'Dr. Smith',
                    hospital: 'Central Hospital',
                    department: 'Cardiology',
                    date: 'Wed, 25 Sept, 2024',
                    bookedOn: '15 Jul, 2024',
                    status: 'CANCELLED',
                    appointmentId: '4723775807',
                  ),
                  SizedBox(height: 16),
                  AppointmentCard(
                    doctor: 'Dr. Johnson',
                    hospital: 'City Medical Center',
                    department: 'Orthopedics',
                    date: 'Sat, 21 Sept, 2024',
                    bookedOn: '15 Jul, 2024',
                    status: 'CONFIRMED',
                    appointmentId: '4403806257',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AppointmentCard extends StatelessWidget {
  final String doctor;
  final String hospital;
  final String department;
  final String date;
  final String bookedOn;
  final String status;
  final String appointmentId;

  const AppointmentCard({
    Key? key,
    required this.doctor,
    required this.hospital,
    required this.department,
    required this.date,
    required this.bookedOn,
    required this.status,
    required this.appointmentId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        doctor,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(hospital),
                      Text(department),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text('ID: $appointmentId'),
                    const SizedBox(height: 4),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: status == 'CANCELLED'
                            ? Colors.red[50]
                            : Colors.green[50],
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        status,
                        style: TextStyle(
                          color: status == 'CANCELLED'
                              ? Colors.red
                              : Colors.green,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text('Date: $date'),
            Text('Booked on: $bookedOn'),
          ],
        ),
      ),
    );
  }
}