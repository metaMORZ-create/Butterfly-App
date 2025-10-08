import "package:butterfly_app/pages/login_page.dart";
import "package:flutter/material.dart";

class LoginButton extends StatelessWidget {
  const LoginButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => LoginPage()),
          );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[900],
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.all(25),
        child: const Center(
          child: Text("Login", style: TextStyle(color: Colors.white)),
        ),
      ),
    );
  }
}
