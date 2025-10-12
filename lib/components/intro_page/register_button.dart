import "package:butterfly_app/pages/register_page.dart";
import "package:flutter/material.dart";

class RegisterButton extends StatelessWidget {
  const RegisterButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => RegisterPage()),
          );},
        
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[900],
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.all(25),
        child: const Center(
          child: Text("Register", style: TextStyle(color: Colors.white)),
        ),
      ),
    );
  }
}
