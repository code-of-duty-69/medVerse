import 'package:flutter/material.dart';

class HomeWidgetList extends StatefulWidget {
  const HomeWidgetList({super.key});

  @override
  _ScrollableWidgetListState createState() => _ScrollableWidgetListState();
}

class _ScrollableWidgetListState extends State<HomeWidgetList> {
  // Keep track of which widgets are expanded
  final List<bool> _isExpanded = [
    false,
    false,
    false,
    false,
    false
  ]; // Adjust based on the number of widgets

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: List.generate(5, (index) => _buildExpandableWidget(index)),
      ),
    );
  }

  // This builds each widget with underlined text and the expandable content
  Widget _buildExpandableWidget(int index) {
    return Column(
      key: ValueKey(index),
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              _isExpanded[index] = !_isExpanded[index];
            });
          },
          child: Container(
            padding: const EdgeInsets.all(16.0),
            width: double.infinity,
            height: 145,
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(width: 1.0, color: Colors.black),
              ),
            ),
            child: Text(
              'Hospital ${index + 1}',
              style: const TextStyle(
                fontSize: 18.0,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
        ),
        // Dropdown content that will appear when the widget is clicked
        AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          height: _isExpanded[index] ? 1250.0 : 0.0, // Dropdown height
          child: _isExpanded[index]
              ? Container(
                  color: const Color.fromARGB(255, 209, 233, 253),
                  width: double.infinity,
                  padding: const EdgeInsets.all(16.0),
                  child: const Text(
                    'Doctors: ',
                    style: TextStyle(fontSize: 16.0),
                  ),
                )
              : const SizedBox.shrink(),
        ),
      ],
    );
  }
}
