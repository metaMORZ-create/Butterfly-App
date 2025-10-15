import "package:flutter/material.dart";
import "package:butterfly_app/components/intro_page/login_button.dart";
import "package:butterfly_app/components/intro_page/register_button.dart";

class IntroPage extends StatefulWidget {
  const IntroPage({super.key});

  @override
  State<IntroPage> createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo (Platzhalter – kann jederzeit durch ein Asset ersetzt werden)
              const Icon(Icons.bug_report, size: 100, color: Colors.purple),

              const SizedBox(height: 10),

              // Sub Title
              const Text(
                "„Discovering Butterflies made easy“",
                style: TextStyle(color: Colors.grey, fontSize: 16),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 48),

              // Registrieren & Login (wie in deinem Beispiel)
              const RegisterButton(),
              const SizedBox(height: 20),
              const LoginButton(),
            ],
          ),
        ),
      ),
    );
  }
}
