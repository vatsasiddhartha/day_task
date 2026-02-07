import 'package:day_task/services/auth_services.dart';
import 'package:flutter/material.dart';
import '../utils/app_colors.dart';
import '../widgets/auth_text_field.dart';
import '../widgets/primary_button.dart';
import 'login_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final AuthService _authService = AuthService();

  bool hidePassword = true;
  bool agreeTerms = false;
  bool isLoading = false;

  Future<void> _signup() async {
    if (!agreeTerms) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please accept terms & conditions")),
      );
      return;
    }

    if (emailController.text.isEmpty ||
        passwordController.text.isEmpty ||
        nameController.text.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("All fields are required")));
      return;
    }

    setState(() => isLoading = true);

    try {
      await _authService.signup(
        name: nameController.text.trim(),
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Signup successful. Please login.")),
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const LoginScreen()),
      );
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.toString())));
    } finally {
      setState(() => isLoading = false);
    }
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

              /// Logo
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
                "Create your account",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),

              const SizedBox(height: 30),

              const Text(
                "Full Name",
                style: TextStyle(color: AppColors.textSecondary),
              ),
              const SizedBox(height: 8),

              AuthTextField(
                hint: "Your name",
                icon: Icons.person_outline,
                controller: nameController,
              ),

              const SizedBox(height: 20),

              const Text(
                "Email Address",
                style: TextStyle(color: AppColors.textSecondary),
              ),
              const SizedBox(height: 8),

              AuthTextField(
                hint: "example@gmail.com",
                icon: Icons.email_outlined,
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
                    color: Colors.white,
                  ),
                  onPressed: () {
                    setState(() => hidePassword = !hidePassword);
                  },
                ),
              ),

              const SizedBox(height: 16),

              /// Terms
              Row(
                children: [
                  Checkbox(
                    value: agreeTerms,
                    activeColor: AppColors.primary,
                    onChanged: (value) {
                      setState(() => agreeTerms = value ?? false);
                    },
                  ),
                  const Expanded(
                    child: Text(
                      "I agree to Privacy Policy & Terms",
                      style: TextStyle(color: AppColors.textSecondary),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              PrimaryButton(
                text: isLoading ? "Creating Account..." : "Sign Up",
                onTap: () {
                  if (!isLoading) {
                    _signup();
                  }
                },
              ),

              const SizedBox(height: 30),

              /// Login redirect
              Center(
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (_) => const LoginScreen()),
                    );
                  },
                  child: const Text(
                    "Already have an account? Log In",
                    style: TextStyle(
                      color: AppColors.primary,
                      fontWeight: FontWeight.bold,
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
