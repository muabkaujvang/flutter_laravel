
import 'package:flutter/material.dart';
import 'package:frontend_laravel/screens/login_screen.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool isLoggingOut = false;

  void logout() async {
    setState(() {
      isLoggingOut = true;
    });

    // Show a loading dialog
    showDialog(
      context: context,
      barrierDismissible: false, // Prevent closing
      builder: (context) {
        return const AlertDialog(
          content: Row(
            children: [
              CircularProgressIndicator(),
              SizedBox(width: 20),
              Text("Logging out..."),
            ],
          ),
        );
      },
    );

    // Simulate logout delay (2 seconds)
    await Future.delayed(const Duration(seconds: 2));

    // Close the loading dialog
    if (mounted) {
      Navigator.of(context).pop();
    }

    // Navigate to Login Page and remove all previous screens
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
      (_) => false,
    );

    setState(() {
      isLoggingOut = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
        backgroundColor: Colors.blue,
      ),
      body: ListView(
        children: [
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text("Profile"),
            subtitle: const Text("Update your profile details"),
            onTap: () {
              // Navigate to Profile Page
            },
          ),
          ListTile(
            leading: const Icon(Icons.lock),
            title: const Text("Change Password"),
            onTap: () {
              // Navigate to Change Password Page
            },
          ),
          ListTile(
            leading: const Icon(Icons.notifications),
            title: const Text("Notifications"),
            trailing: Switch(
              value: true, // Replace with state
              onChanged: (bool value) {
                // Handle switch
              },
            ),
          ),
          ListTile(
            leading: const Icon(Icons.dark_mode),
            title: const Text("Dark Mode"),
            trailing: Switch(
              value: false, // Replace with state
              onChanged: (bool value) {
                // Handle theme change
              },
            ),
          ),
          ListTile(
            leading: const Icon(Icons.language),
            title: const Text("Language"),
            subtitle: const Text("English"),
            onTap: () {
              // Open language selection dialog
            },
          ),
          ListTile(
            leading: const Icon(Icons.exit_to_app),
            title: const Text("Logout"),
            onTap: logout, // Call the logout function
          ),
        ],
      ),
    );
  }
}
