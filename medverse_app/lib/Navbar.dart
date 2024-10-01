import 'package:flutter/material.dart';
import 'package:medverse_app/Reminderpage.dart';
import 'Scanpage.dart';
import 'Chatbotpage.dart';
import 'Appointmentpage.dart';

class Navbar extends StatelessWidget {
  const Navbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const UserAccountsDrawerHeader(
            accountName: Text("placeholder"),
            accountEmail: Text("placeholder@gmail.com"),
            decoration: BoxDecoration(
                color: Color(0x00000000),
                image: DecorationImage(
                    image: AssetImage('images/DrawerHeader.jpg'),
                    fit: BoxFit.cover)),
          ),
          ListTile(
            leading: const Icon(Icons.account_circle),
            title: const Text("Profile"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ChatbotPage()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.message_rounded),
            title: const Text("Medbot"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ChatbotPage()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.book_rounded),
            title: const Text("Appointments"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const AppointmentPage()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.calendar_month),
            title: const Text("Heads-up"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Reminderpage()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.camera_alt_outlined),
            title: const Text("Scan Prescription"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ScanPage()),
              );
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text("Settings"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ChatbotPage()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text("Sign out"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ChatbotPage()),
              );
            },
          ),
        ],
      ),
    );
  }
}
