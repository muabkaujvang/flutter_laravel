import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:frontend_laravel/screens/dashboard_screen.dart';
import 'package:frontend_laravel/screens/register_screen.dart';
import 'package:http/http.dart' as http;
import 'package:frontend_laravel/api_path.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool showPassword = true;
  bool rememberMe = false;
  bool isLoading = false;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final storage = const FlutterSecureStorage();

  Future<void> submitLogin() async {
    if (!formKey.currentState!.validate()) return; // Ensure form validation

    setState(() => isLoading = true);

    try {
      final response = await http.post(
        Uri.parse(ApiPath.LOGIN), // Ensure correct API path
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': emailController.text.trim(),
          'password': passwordController.text.trim(),
        }),
      );

      final responseBody = jsonDecode(response.body);
      if (response.statusCode == 200) {
        String userId = responseBody['user']['id'].toString();
        String email = responseBody['user']['email'].toString();
        String phone = responseBody['user']['phonenumber'].toString();
        storage.write(key: 'userId', value: userId);
        storage.write(key: 'email', value: email);
        storage.write(key:'phone', value: phone);
        log('data=$userId ,$email,$phone');

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(responseBody['message'] ?? 'Login successful!')),
        );

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const DashboardScreen()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(responseBody['error'] ?? 'Invalid email or password')),
        );
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Network error! Please try again.')),
      );
    } finally {
      setState(() => isLoading = false);
    }
  }

  // initState() {
  //   super.initState();
  //   emailController.text = 'test@example.com';
  //   passwordController.text = 'password123';
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[900],
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 100),
                const Text(
                  'Welcome Back!',
                  style: TextStyle(fontSize: 32, color: Colors.white, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                const Text('Sign in to continue', style: TextStyle(fontSize: 16, color: Colors.white)),
                const SizedBox(height: 50),

                // Email Input
                TextFormField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: inputDecoration('Email', Icons.email),
                  style: const TextStyle(color: Colors.white),
                  validator: (value) => value == null || value.isEmpty ? 'Enter your email' : null,
                ),
                const SizedBox(height: 20),

                // Password Input
                TextFormField(
                  controller: passwordController,
                  obscureText: showPassword,
                  decoration: inputDecoration('Password', Icons.lock).copyWith(
                    suffixIcon: IconButton(
                      icon: Icon(showPassword ? Icons.visibility_off : Icons.visibility, color: Colors.white),
                      onPressed: () => setState(() => showPassword = !showPassword),
                    ),
                  ),
                  style: const TextStyle(color: Colors.white),
                  validator: (value) => value == null || value.length < 6 ? 'Password must be at least 6 characters' : null,
                ),
                const SizedBox(height: 5),

                // Remember Me & Forgot Password
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Checkbox(
                          value: rememberMe,
                          onChanged: (value) => setState(() => rememberMe = value!),
                          checkColor: Colors.blue[900],
                          activeColor: Colors.white,
                        ),
                        const Text('Remember me', style: TextStyle(color: Colors.white)),
                      ],
                    ),
                    TextButton(
                      onPressed: () {},
                      child: const Text('Forgot Password?', style: TextStyle(color: Colors.white70)),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // Login Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: isLoading ? null : submitLogin, // Prevent multiple taps
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.blue[900],
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: isLoading
                        ? const CircularProgressIndicator(color: Colors.blue)
                        : const Text('Sign In', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  ),
                ),
                const SizedBox(height: 20),

                // Sign Up
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Don't have an account?", style: TextStyle(color: Colors.white70)),
                    TextButton(
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const RegisterScreen()),
                      ),
                      child: const Text('Sign Up', style: TextStyle(color: Colors.white)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  InputDecoration inputDecoration(String hint, IconData icon) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(color: Colors.white70),
      prefixIcon: Icon(icon, color: Colors.white),
      filled: true,
      fillColor: Colors.blue[800],
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Colors.white),
      ),
      contentPadding: const EdgeInsets.symmetric(vertical: 18),
    );
  }
}
