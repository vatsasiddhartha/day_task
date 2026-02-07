import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../screens/home_screen.dart';
import '../screens/signup_screen.dart';
import '../utils/app_colors.dart';
import '../widgets/auth_text_field.dart';
import '../widgets/primary_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool hidePassword = true;
  bool isLoading = false;

  final supabase = Supabase.instance.client;

  Future<void> _login() async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      _showMessage("Email and password are required");
      return;
    }

    setState(() => isLoading = true);

    try {
      final response = await supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );

      if (response.user != null) {
        // ✅ LOGIN SUCCESS
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const HomeScreen()),
        );
      }
    } on AuthException catch (e) {
      _showMessage(e.message);
    } catch (e) {
      _showMessage("Something went wrong. Try again.");
    } finally {
      setState(() => isLoading = false);
    }
  }

  void _showMessage(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),

              /// LOGO
              Center(
                child: Column(
                  children: const [
                    CircleAvatar(
                      radius: 35,
                      backgroundColor: AppColors.primary,
                      child: Icon(Icons.timer, size: 40, color: Colors.black),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "DayTask",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 40),

              const Text(
                "Welcome Back!",
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),

              const SizedBox(height: 30),

              const Text(
                "Email Address",
                style: TextStyle(color: AppColors.textSecondary),
              ),
              const SizedBox(height: 8),

              AuthTextField(
                hint: "example@gmail.com",
                icon: Icons.person_outline,
                controller: emailController,
              ),

              const SizedBox(height: 20),

              const Text(
                "Password",
                style: TextStyle(color: AppColors.textSecondary),
              ),
              const SizedBox(height: 8),

              AuthTextField(
                hint: "••••••••",
                icon: Icons.lock_outline,
                controller: passwordController,
                isPassword: hidePassword,
                suffix: IconButton(
                  icon: Icon(
                    hidePassword ? Icons.visibility_off : Icons.visibility,
                  ),
                  onPressed: () async {
                    setState(() {
                      hidePassword = !hidePassword;
                    });
                  },
                ),
              ),

              const SizedBox(height: 30),

              /// LOGIN BUTTON
              PrimaryButton(
                text: isLoading ? "Logging in..." : "Log In",
                onTap: () {
                  if (!isLoading) {
                    _login();
                  }
                },
              ),

              const SizedBox(height: 30),

              Center(
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (_) => const SignupScreen()),
                    );
                  },
                  child: RichText(
                    text: const TextSpan(
                      children: [
                        TextSpan(
                          text: "Don’t have an account? ",
                          style: TextStyle(color: AppColors.textSecondary),
                        ),
                        TextSpan(
                          text: "Sign Up",
                          style: TextStyle(
                            color: AppColors.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
