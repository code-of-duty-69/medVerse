import 'package:flutter/material.dart';

class MedicalDetails extends StatefulWidget {
  const MedicalDetails({super.key});

  @override
  State<MedicalDetails> createState() => _MedicaldetailsState();
}

class _MedicaldetailsState extends State<MedicalDetails> {
  final Color primaryColor = const Color(0xFF2C3E50);
  final Color accentColor = const Color(0xFF3498DB);
  final Color backgroundColor = const Color(0xFFF5F6FA);

  final List<Map<String, dynamic>> hospitals = [
    {
      'name': 'Kauvery Hospital',
      'image': 'images/Hlogo1.png',
      'rating': 4.5,
      'about': 'Kauvery hospital launched its first hospital more than two decades ago, the founders of Kauvery Hospital have been determined on creating world class healthcare facilities that shall be affordable. The founding doctors set off on this dream in 1999 with a 30-bed hospital in Trichy, with single-minded focus on offering \'best-in-class healthcare, with a personal touch.',
    },
    {
      'name': 'Chennai National Hospital',
      'image': 'images/Hlogo2.png',
      'rating': 3.4,
      'about': 'Chennai National Hospital is an exclusive 120 bed Multi-Speciality Hospital located in the heart of Chennai city. At CNH we strive to deliver the highest standards of healthcare, be it having the finest doctors, cutting edge technology, state-of-the-art infrastructure or nursing with a smile.',
    },
    {
      'name': 'Sir Ivan Stedeford Hospital',
      'image': 'images/Hlogo4.png',
      'rating': 3.5,
      'about': 'The Hospital is situated in an area of 25 acres and was started on 25th February 1966. Initially, the Hospital functioned with an Out-Patient Department. The Hospital has expanded its activity and has grown into a 236 bedded multi speciality hospital.',
    },
    {
      'name': 'Billroth Hospital',
      'image': 'images/Hlogo5.png',
      'rating': 4.6,
      'about': 'Billroth Hospitals was founded by the late Dr. V. Jeganathan, starting with 30 beds and expanding to 350 beds by 2007, including the acquisition of Kalliapa Hospitals. Under Dr. Rajesh\'s leadership, Billroth became a super-specialty hospital, introducing the first dual CT scan in Tamil Nadu and pioneering cancer treatments.',
    },
    {
      'name': 'Prasanth Hospital',
      'image': 'images/Hlogo3.png',
      'rating': 4.8,
      'about': 'When we began operations at Prashanth Fertility Research Centre, we focused exclusively on Infertility. We offered the latest methodologies and technologies to assist childless couples realise their dreams and delivered on that promise and much more.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: hospitals.length,
        itemBuilder: (context, index) {
          return _buildHospitalCard(context, hospitals[index]);
        },
      ),
    );
  }

  Widget _buildHospitalCard(BuildContext context, Map<String, dynamic> hospital) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.only(bottom: 16.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: () => _showHospitalDetails(context, hospital),
        child: Container(
          height: 120,
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: Image.asset(
                  hospital['image'],
                  alignment: Alignment.topLeft,
                  fit: BoxFit.contain,
                  
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Icon(Icons.star, color: Colors.amber[700], size: 24),
                        const SizedBox(width: 4),
                        Text(
                          hospital['rating'].toString(),
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showHospitalDetails(BuildContext context, Map<String, dynamic> hospital) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: Container(
            width: double.infinity,
            height: double.infinity,
            margin: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: [
                Container(
                  height: 200,
                  decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                  ),
                  child: Stack(
                    children: [
                      Center(
                        child: Image.asset(
                          alignment: Alignment.topLeft,
                          hospital['image'],
                          height: 150,
                          fit: BoxFit.contain,
                        ),
                      ),
                      Positioned(
                        top: 10,
                        right: 10,
                        child: IconButton(
                          icon: const Icon(Icons.close, color: Colors.white),
                          onPressed: () => Navigator.of(context).pop(),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              hospital['name'],
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                              decoration: BoxDecoration(
                                color: accentColor,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Row(
                                children: [
                                  Icon(Icons.star, color: Colors.amber[700], size: 20),
                                  const SizedBox(width: 4),
                                  Text(
                                    hospital['rating'].toString(),
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Text(
                          'About',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          hospital['about'],
                          style: TextStyle(
                            fontSize: 16,
                            color: primaryColor.withOpacity(0.8),
                            height: 1.5,
                          ),
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () {
                            // Add functionality for booking appointment
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: accentColor,
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: const Center(
                            child: Text(
                              'Book Appointment',
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}