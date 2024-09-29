import 'package:flutter/material.dart';

class Chatbotpage extends StatefulWidget {
  const Chatbotpage({super.key});

  @override
  State<Chatbotpage> createState() => _ChatbotpageState();
}

class _ChatbotpageState extends State<Chatbotpage> {
  final _textControl = TextEditingController();
  final List<String> _messages = []; // List to store messages

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MEDVERSE'),
        backgroundColor: const Color.fromARGB(255, 43, 147, 231),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            // Expanded area for showing message history in a scrollable list
            Expanded(
              child: ListView.builder(
                itemCount: _messages.length,
                itemBuilder: (context, index) {
                  return Align(
                    alignment:
                        Alignment.centerRight, // Right-align the messages
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 5.0),
                      padding: const EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        color: Colors.blue[100], // Light blue background
                        borderRadius:
                            BorderRadius.circular(12.0), // Rounded corners
                        border: Border.all(
                          color: Colors.blue,
                          width: 1.5,
                        ),
                      ),
                      child: Text(
                        _messages[index],
                        style: const TextStyle(fontSize: 16.0),
                      ),
                    ),
                  );
                },
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _textControl,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      hintText: "How can I help you today?",
                      suffix: IconButton(
                        onPressed: () {
                          _textControl.clear();
                        },
                        icon: const Icon(Icons.clear),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                MaterialButton(
                  onPressed: () {
                    setState(() {
                      if (_textControl.text.isNotEmpty) {
                        _messages.add(_textControl.text);
                        _textControl.clear();
                      }
                    });
                  },
                  color: Colors.blue,
                  child: const Text(
                    "Send",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
