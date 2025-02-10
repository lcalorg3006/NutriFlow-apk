import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String? _emailError;
  String? _passwordError;

  void _validateEmail() {
    setState(() {
      _emailError = _emailController.text.contains('@') ? null : 'El correo debe contener "@"';
    });
  }

  void _validatePassword() {
    final password = _passwordController.text;
    final bool hasUppercase = password.contains(RegExp(r'[A-Z]'));
    final bool hasLowercase = password.contains(RegExp(r'[a-z]'));
    final bool hasDigit = password.contains(RegExp(r'\d'));
    final bool hasMinLength = password.length >= 8;

    setState(() {
      _passwordError = (hasUppercase && hasLowercase && hasDigit && hasMinLength)
          ? null
          : 'La contraseña debe incluir:\n- Min 1 mayúscula\n- Min 1 minúscula\n- Min 1 número\n- Min 8 caracteres';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Correo electrónico',
                errorText: _emailError,
              ),
              onChanged: (_) => _validateEmail(),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: 'Contraseña',
                errorText: _passwordError,
              ),
              obscureText: true,
              onChanged: (_) => _validatePassword(),
            ),
          ],
        ),
      ),
    );
  }
}
