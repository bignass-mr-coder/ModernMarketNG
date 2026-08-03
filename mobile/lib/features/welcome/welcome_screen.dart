import 'package:flutter/material.dart';
import '../onboarding/onboarding_screen.dart';
import '../auth/login_screen.dart';
class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.storefront,
                size: 100,
                color: Color(0xFF1565C0),
              ),
              const SizedBox(height: 20),
              const Text(
                "Welcome to",
                style: TextStyle(fontSize: 20),
              ),
              const Text(
                "Modern Market NG",
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1565C0),
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                "Nigeria's Local Digital Marketplace",
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const OnboardingScreen(),
                      ),
                    );
                  },
                  child: const Text("Get Started"),
                ),
              ),

              const SizedBox(height: 12),

              TextButton(
  onPressed: () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const LoginScreen(),
      ),
    );
  },
  child: const Text("Already have an account? Sign In"),
),
              
            ],
          ),
        ),
      ),
    );
  }
}