import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart'; // Añadido para usar Google Fonts

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final TextEditingController _emailController = TextEditingController();

  // Mensaje de error en rojo si el email no contiene '@'
  String? _errorMessage; // Mensaje de error en rojo si el email no contiene '@'

  @override
  Widget build(BuildContext context) {
    // Colores base (verdes) para la UI
    const Color primaryGreen = Color(0xFF2E7D32);
    const Color buttonGreen = Color(0xFF43A047);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryGreen,
        title: Text(
          'Olvidé mi contraseña',
          style: GoogleFonts.roboto(
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
      body: SizedBox(
        // Abarca todo el alto y ancho de la pantalla
        width: double.infinity,
        height: double.infinity,
        // Fondo con gradiente que llena la pantalla
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFE8F5E9), Color(0xFFC8E6C9)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: SingleChildScrollView(
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
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 6,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: TextField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    style: const TextStyle(fontSize: 16),
                    decoration: InputDecoration(
                      labelText: 'Ingresa el email',
                      labelStyle: TextStyle(color: Colors.grey.shade700),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 14,
                      ),
                    ),
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
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 5,
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
                    child: Text(
                      'Enviar',
                      style: GoogleFonts.roboto(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // Texto "¿Correo electrónico no reconocido?"
                TextButton(
                  onPressed: () {
                    // TODO: Acciones adicionales
                  },
                  child: Text(
                    '¿Correo electrónico no reconocido?',
                    style: GoogleFonts.roboto(
                      color: primaryGreen,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
