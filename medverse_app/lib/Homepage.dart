import 'package:flutter/material.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  _HospitalPageState createState() => _HospitalPageState();
}

class _HospitalPageState extends State<Homepage> {
  int? selectedHospital;
  int? selectedDoctor;

  final Color textColor = const Color(0xFF041f30);

  // Hospital 1 data
  final Map<String, dynamic> hospital1 = {
    'name': 'Kauvery Hospital',
    'image': 'images/logo1.png',
    'about': 'Kauvery hospital launched its first hospital more than two decades ago, the founders of Kauvery Hospital have been determined on creating world class healthcare facilities that shall be affordable. The founding doctors set off on this dream in 1999 with a 30-bed hospital in Trichy, with single-minded focus on offering ‘best-in-class healthcare, with a personal touch.’ This was a very new concept in a tier 2 city like Trichy which lacked a tertiary care hospital at the time. Today, Kauvery is a multi-specialty hospital chain with 2250+ beds in six locations including Trichy, Chennai, Salem, Hosur, Tirunelveli and Bengaluru. With twelve hospitals and a workforce of over 8000+ Kauvery’s mission is to provide exemplary secondary and tertiary care.',
    'doctors': [
      {
        'name': 'Dr. John Doe',
        'image': 'images/Kauvery/doctors/doc1.png',
        'specialty': 'Cardiology'
      },
      {
        'name': 'Dr. Jane Smith',
        'image': 'images/Kauvery/doctors/doc2.png',
        'specialty': 'Neurology'
      },
    ],
  };

  // Hospital 2 data
  final Map<String, dynamic> hospital2 = {
    'name': 'Chennai national Hospital',
    'image': 'images/logo2.png',
    'about': 'Leading healthcare institution with cutting-edge technology.',
    'doctors': [
      {
        'name': 'Dr. Mike Johnson',
        'image': 'images/CNH/doctors/doc1.png',
        'specialty': 'Orthopedics'
      },
      {
        'name': 'Dr. Sarah Wilson',
        'image': 'images/CNH/doctors/doc2.png',
        'specialty': 'Pediatrics'
      },
    ],
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hospitals'),
        backgroundColor: const Color(0xFF6d4dd3),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHospitalContainer(hospital1),
            const SizedBox(height: 20),
            _buildHospitalContainer(hospital2),
          ],
        ),
      ),
    );
  }

  Widget _buildHospitalContainer(Map<String, dynamic> hospital) {
    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
            child: Image.asset(
              hospital['image'],
              width: double.infinity,
              height: 200,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  hospital['name'],
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: textColor,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  hospital['about'],
                  style: TextStyle(color: textColor, fontSize: 16),
                ),
                const SizedBox(height: 16),
                Text(
                  'Our Doctors',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: textColor,
                  ),
                ),
                const SizedBox(height: 8),
                SizedBox(
                  height: 200,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: hospital['doctors'].length,
                    itemBuilder: (context, index) =>
                        _buildDoctorCard(hospital['doctors'][index]),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDoctorCard(Map<String, dynamic> doctor) {
    return Container(
      width: 150,
      margin: const EdgeInsets.only(right: 16),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
              child: Image.asset(
                doctor['image'],
                height: 100,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    doctor['name'],
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: textColor,
                    ),
                  ),
                  Text(
                    doctor['specialty'],
                    style: TextStyle(
                      color: textColor.withOpacity(0.7),
                    ),
                  ),
                  const SizedBox(height: 4),
                  ElevatedButton(
                    onPressed: () {
                      // Handle appointment booking
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF6d4dd3),
                    ),
                    child: const Text('Book'),
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