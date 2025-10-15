import 'package:flutter/material.dart';
import 'package:butterfly_app/services/login_register_service.dart';
import 'package:butterfly_app/pages/intro_page.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool darkMode = false;
  bool notifications = true;
  String language = 'English';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: Text(
              'Genereak Settings',
              style: TextStyle(fontSize: 13, color: Colors.grey),
            ),
          ),

          // Dark Mode
          SwitchListTile(
            value: darkMode,
            title: const Text('Dark Mode'),
            subtitle: const Text('Use Dark Mode theme'),
            onChanged: (v) => setState(() => darkMode = v),
          ),

          // Notifications
          SwitchListTile(
            value: notifications,
            title: const Text('Notifications'),
            subtitle: const Text('Active notifications'),
            onChanged: (v) => setState(() => notifications = v),
          ),

          const Divider(height: 32),

          // Sprache
          ListTile(
            title: const Text('Language'),
            subtitle: Text(language),
            leading: const Icon(Icons.language),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => _pickLanguage(context),
          ),

          const Divider(height: 32),

          // Über die App
          ListTile(
            leading: const Icon(Icons.info_outline),
            title: const Text('About'),
            onTap: () {
              showAboutDialog(
                context: context,
                applicationName: 'Butterfly App',
                applicationVersion: '1.0.0',
                applicationIcon: const FlutterLogo(),
                children: const [
                  SizedBox(height: 8),
                  Text('An app to identify and learn about butterflies.'),
                ],
              );
            },
          ),

          // Cache leeren
          ListTile(
            leading: const Icon(Icons.cleaning_services_outlined),
            title: const Text('Cache leeren'),
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Cache geleert (Demo).')),
              );
            },
          ),

          const Divider(height: 32),

          // Logout Button
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: ElevatedButton.icon(
              icon: const Icon(Icons.logout),
              label: const Text('Logout'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
              onPressed: _logout,
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  void _pickLanguage(BuildContext context) async {
    final selected = await showModalBottomSheet<String>(
      context: context,
      builder: (ctx) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: const Text('Deutsch'),
              onTap: () => Navigator.pop(ctx, 'Deutsch'),
            ),
            ListTile(
              title: const Text('English'),
              onTap: () => Navigator.pop(ctx, 'English'),
            ),
            ListTile(
              title: const Text('Français'),
              onTap: () => Navigator.pop(ctx, 'Français'),
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );

    if (selected != null) {
      setState(() => language = selected);
    }
  }

  Future<void> _logout() async {
    final success = await LoginRegisterService.logout();

    if (mounted) {
      if (success) {
        // Zur IntroPage zurückkehren und Navigation-Stack leeren
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => const IntroPage()),
          (route) => false,
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Logout fehlgeschlagen')),
        );
      }
    }
  }
}
