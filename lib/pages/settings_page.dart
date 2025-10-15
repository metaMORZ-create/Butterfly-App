import 'package:flutter/material.dart';
import 'package:butterfly_app/services/login_register_service.dart';
import 'package:butterfly_app/pages/intro_page.dart';

// NEU:
import 'package:shared_preferences/shared_preferences.dart';
import 'package:butterfly_app/services/retrieval_service.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool darkMode = false;
  bool notifications = true;
  String language = 'English';

  // Level/XP-Status
  bool _loadingLevel = true;
  String? _levelError;
  int _uploadsCount = 0;
  int _level = 0;
  double _progress = 0.0; // 0..1 Anteil zur nächsten Stufe
  int _xpIntoLevel = 0;   // XP innerhalb der aktuellen Stufe
  int _xpNeeded = 0;      // XP die für den nächsten Aufstieg insgesamt nötig sind

  @override
  void initState() {
    super.initState();
    _loadLevel();
  }

  // --- Level-Logik ---
  // Benötigte XP, um von Level (L) -> (L+1) zu kommen (progressive Steigerung)
  int _xpNeededForStep(int levelNext) {
    // levelNext = 1 => 5, levelNext = 2 => 10, etc.
    return 5 * levelNext;
  }

  // Gesamte XP bis inklusive Level L (d. h. Schwelle um L erreicht zu haben)
  int _xpThresholdForLevel(int L) {
    // Summe 5 * k, k=1..L = 5 * L * (L+1) / 2
    return (5 * L * (L + 1)) ~/ 2;
  }

  void _computeLevelFromXP(int xp) {
    // Finde größtes L mit xp >= threshold(L)
    int L = 0;
    while (xp >= _xpThresholdForLevel(L + 1)) {
      L++;
    }
    final currentThreshold = _xpThresholdForLevel(L);
    final nextStepNeed = _xpNeededForStep(L + 1); // Bedarf für L->L+1
    final xpInLevel = xp - currentThreshold;
    final progress = nextStepNeed > 0 ? (xpInLevel / nextStepNeed).clamp(0.0, 1.0) : 0.0;

    setState(() {
      _level = L;
      _xpIntoLevel = xpInLevel;
      _xpNeeded = nextStepNeed;
      _progress = progress;
    });
  }

  Future<void> _loadLevel() async {
    setState(() {
      _loadingLevel = true;
      _levelError = null;
    });
    try {
      final prefs = await SharedPreferences.getInstance();
      final userId = prefs.getInt('user_id');
      if (userId == null) {
        setState(() {
          _uploadsCount = 0;
          _computeLevelFromXP(0);
          _loadingLevel = false;
          _levelError = 'Nicht eingeloggt';
        });
        return;
      }

      // Hole Uploads (du hast die Funktion bereits)
      final uploads = await RetrievalService.getUserUploads(
        userId: userId,
        limit: 1000,          // großzügig; falls sehr viele Bilder: ggf. Pagination
        sort: "desc",
        withButterfly: false, // fürs Level egal
      );
      final count = uploads.length;

      setState(() {
        _uploadsCount = count;
        _computeLevelFromXP(count);
        _loadingLevel = false;
      });
    } catch (e) {
      setState(() {
        _levelError = 'Level konnte nicht geladen werden: $e';
        _loadingLevel = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final levelCard = Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: _buildLevelCard(context),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: RefreshIndicator(
        onRefresh: _loadLevel,
        child: ListView(
          children: [
            // --- NEU: Levelkarte ---
            levelCard,

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
      ),
    );
  }

  // --- Level Card UI ---
  Widget _buildLevelCard(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    if (_loadingLevel) {
      return _levelSkeleton(scheme);
    }

    if (_levelError != null) {
      return Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Icon(Icons.info_outline, color: scheme.primary),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  _levelError!,
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
              ),
              IconButton(
                tooltip: 'Neu laden',
                onPressed: _loadLevel,
                icon: const Icon(Icons.refresh),
              ),
            ],
          ),
        ),
      );
    }

    return Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              children: [
                Icon(Icons.military_tech, color: scheme.primary),
                const SizedBox(width: 8),
                Text(
                  'User Level',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                ),
                const Spacer(),
                // Refresh
                IconButton(
                  tooltip: 'Neu laden',
                  onPressed: _loadLevel,
                  icon: const Icon(Icons.refresh),
                ),
              ],
            ),
            const SizedBox(height: 8),
            // Level + Uploads
            Row(
              children: [
                Text(
                  'Level $_level',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.w800,
                      ),
                ),
                const SizedBox(width: 12),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: scheme.primaryContainer,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text('Uploads: $_uploadsCount'),
                ),
              ],
            ),
            const SizedBox(height: 12),
            // Progressbar
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: LinearProgressIndicator(
                value: _progress, // 0..1
                minHeight: 10,
              ),
            ),
            const SizedBox(height: 8),
            // Progress-Label
            Text(
              '$_xpIntoLevel / $_xpNeeded XP bis Level ${_level + 1}',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Colors.grey[700],
                  ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _levelSkeleton(ColorScheme scheme) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Icon(Icons.military_tech, color: scheme.primary),
            const SizedBox(width: 12),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _GreyBox(width: 120, height: 18),
                  SizedBox(height: 8),
                  _GreyBox(width: double.infinity, height: 10),
                ],
              ),
            ),
          ],
        ),
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

// --- kleines Placeholder/Skelett für den Ladezustand ---
class _GreyBox extends StatelessWidget {
  final double width;
  final double height;
  const _GreyBox({required this.width, required this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.black12,
        borderRadius: BorderRadius.circular(6),
      ),
    );
  }
}
