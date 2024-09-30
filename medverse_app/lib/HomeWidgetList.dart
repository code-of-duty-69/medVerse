import 'package:flutter/material.dart';

class HomeWidgetList extends StatefulWidget {
  const HomeWidgetList({Key? key}) : super(key: key);

  @override
  _HomeWidgetListState createState() => _HomeWidgetListState();
}

class _HomeWidgetListState extends State<HomeWidgetList> {
  int? _expandedIndex;

  final List<String> _imagePaths = [
    'images/doc1.png',
    'images/doc2.png',
    'images/doc3.png',
    'images/doc4.png',
    'images/doc5.png'
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 5,
      itemBuilder: (context, index) => _buildExpandableWidget(index),
    );
  }

  Widget _buildExpandableWidget(int index) {
    bool isExpanded = _expandedIndex == index;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: isExpanded ? null : 225,
      child: Card(
        color: const Color(0xFF034C81),
        child: Column(
          children: [
            GestureDetector(
              onTap: () =>
                  setState(() => _expandedIndex = isExpanded ? null : index),
              child: Container(
                height: 225,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(_imagePaths[index]),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black.withOpacity(0.7)
                      ],
                    ),
                  ),
                  alignment: Alignment.bottomLeft,
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    'Hospital ${index + 1}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            if (isExpanded) ...[
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  'This is the detailed information about Hospital ${index + 1}. '
                  'It provides various medical services and has state-of-the-art facilities.',
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                height: 100,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 5,
                  itemBuilder: (context, imageIndex) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: _buildDoctorImage(imageIndex),
                  ),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildDoctorImage(int index) {
    return GestureDetector(
      onTap: () => _showDoctorDetails(index),
      child: CircleAvatar(
        radius: 40,
        backgroundImage: AssetImage('images/doc${index + 1}.png'),
      ),
    );
  }

  void _showDoctorDetails(int index) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        color: const Color(0xFF5BA2F4),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 16),
            CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('assets/doctor${index + 1}.jpg'),
            ),
            const SizedBox(height: 16),
            Text(
              'Dr. Name ${index + 1}',
              style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            const SizedBox(height: 8),
            const Text(
              'Specialization',
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF7F858C),
                foregroundColor: Colors.white,
              ),
              onPressed: () {
                // TODO: Implement booking functionality
                Navigator.pop(context);
              },
              child: const Text('Book Appointment'),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
