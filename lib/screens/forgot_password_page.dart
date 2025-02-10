import 'package:flutter/material.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final TextEditingController _emailController = TextEditingController();
  String? _errorMessage; // Mensaje de error en rojo si el email no contiene '@'

  @override
  Widget build(BuildContext context) {
    const Color primaryGreen = Color(0xFF2E7D32);
    const Color buttonGreen = Color(0xFF43A047);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryGreen,
        title: const Text(
          'Olvidé mi contraseña',
          style: TextStyle(
            fontFamily: 'Georgia',
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
          color: Colors.white,
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Si hay error, lo mostramos en rojo encima del TextField
            if (_errorMessage != null) ...[
              Text(
                _errorMessage!,
                style: const TextStyle(color: Colors.red),
              ),
              const SizedBox(height: 4),
            ],

            // Campo de texto para el email
            TextField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                labelText: 'Ingresa el email',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),

            // Botón Enviar
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: buttonGreen,
                ),
                onPressed: () {
                  final String email = _emailController.text.trim();
                  // Verificamos si contiene '@'
                  if (!email.contains('@')) {
                    setState(() {
                      _errorMessage = 'El correo debe contener "@".';
                    });
                  } else {
                    setState(() {
                      _errorMessage = null; // Limpia el error si todo está bien
                    });
                    // TODO: Lógica para recuperar contraseña
                  }
                },
                child: const Text(
                  'Enviar',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Texto "¿Correo electrónico no reconocido?"
            TextButton(
              onPressed: () {
                // TODO: Acciones adicionales
              },
              child: const Text(
                '¿Correo electrónico no reconocido?',
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
