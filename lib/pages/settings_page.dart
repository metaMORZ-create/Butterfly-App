import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool darkMode = false;
  bool notifications = true;
  String language = 'Deutsch';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Einstellungen'),
      ),
      body: ListView(
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: Text(
              'Allgemein',
              style: TextStyle(fontSize: 13, color: Colors.grey),
            ),
          ),

          // Dark Mode
          SwitchListTile(
            value: darkMode,
            title: const Text('Dark Mode'),
            subtitle: const Text('Dunkles App-Design verwenden'),
            onChanged: (v) => setState(() => darkMode = v),
          ),

          // Notifications
          SwitchListTile(
            value: notifications,
            title: const Text('Benachrichtigungen'),
            subtitle: const Text('Push-Mitteilungen aktivieren'),
            onChanged: (v) => setState(() => notifications = v),
          ),

          const Divider(height: 32),

          // Sprache
          ListTile(
            title: const Text('Sprache'),
            subtitle: Text(language),
            leading: const Icon(Icons.language),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => _pickLanguage(context),
          ),

          const Divider(height: 32),

          // Über die App
          ListTile(
            leading: const Icon(Icons.info_outline),
            title: const Text('Über die App'),
            onTap: () {
              showAboutDialog(
                context: context,
                applicationName: 'MapMates',
                applicationVersion: '1.0.0',
                applicationIcon: const FlutterLogo(),
                children: const [
                  SizedBox(height: 8),
                  Text('Eine kleine App, die besuchte Orte bunt markiert.'),
                ],
              );
            },
          ),

          // Platzhalter-Aktion (z. B. Cache leeren)
          ListTile(
            leading: const Icon(Icons.cleaning_services_outlined),
            title: const Text('Cache leeren'),
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Cache geleert (Demo).')),
              );
            },
          ),
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
}
