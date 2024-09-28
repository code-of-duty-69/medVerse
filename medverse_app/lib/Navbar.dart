import 'package:flutter/material.dart';
import 'package:medverse_app/HomeWidgetList.dart';
import 'Chatbotpage.dart';

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
                color: Color(000),
                image: DecorationImage(
                    image: AssetImage('images/DrawerHeader.jpg'),
                    fit: BoxFit.cover)),
          ),
          ListTile(
            leading: const Icon(Icons.account_circle),
            title: const Text("Profile"),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text("Home"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HomeWidgetList()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.message_rounded),
            title: const Text("Chatbot"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Chatbotpage()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.book_rounded),
            title: const Text("Appointments"),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.calendar_month),
            title: const Text("Reminders"),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.phone),
            title: const Text("Contact us"),
            onTap: () {},
          ),
          Divider(),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text("Settings"),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text("Sign out"),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
