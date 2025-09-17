import 'package:flutter/material.dart';
import '../services/auth_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth = AuthService();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _isLogin = true;
  bool _loading = false;

  void _toggleMode() {
    setState(() => _isLogin = !_isLogin);
  }

  Future<void> _submit() async {
    setState(() => _loading = true);
    try {
      if (_isLogin) {
        await _auth.signInWithEmail(
          _emailController.text,
          _passwordController.text,
        );
      } else {
        await _auth.signUpWithEmail(
          _emailController.text,
          _passwordController.text,
        );
      }
      if (mounted) Navigator.pushReplacementNamed(context, '/home');
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Error: $e")));
    } finally {
      setState(() => _loading = false);
    }
  }

  Future<void> _googleSignIn() async {
    try {
      await _auth.signInWithGoogle();
      if (mounted) Navigator.pushReplacementNamed(context, '/home');
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Google Sign-In failed: $e")));
    }
  }

  Future<void> _googleSignUp() async {
    try {
      await _auth.signUpWithGoogle();
      if (mounted) Navigator.pushReplacementNamed(context, '/home');
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Google Sign-Up failed: $e")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_isLogin ? "Login" : "Register")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: "Email"),
            ),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: "Password"),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            _loading
                ? const CircularProgressIndicator()
                : ElevatedButton(
                  onPressed: _submit,
                  child: Text(_isLogin ? "Login" : "Register"),
                ),
            TextButton(
              onPressed: _toggleMode,
              child: Text(
                _isLogin
                    ? "Create an account"
                    : "Already have an account? Login",
              ),
            ),
            const Divider(),
            ElevatedButton.icon(
              onPressed: _isLogin ? _googleSignIn : _googleSignUp,
              icon: const Icon(Icons.login),
              label: Text(
                _isLogin ? "Sign in with Google" : "Sign up with Google",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
