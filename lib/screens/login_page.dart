import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'forgot_password_page.dart';
import 'normal_screen.dart'; // Navegamos aquí tras un login correcto

// Configuración de GoogleSignIn (ejemplo)
final GoogleSignIn _googleSignIn = GoogleSignIn(
  scopes: <String>['email'],
);

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // Controladores de email y contraseña
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Mensajes de error en rojo si la validación falla
  String? _emailError;
  String? _passwordError;

  bool _isLoading = false;
  bool _isPasswordHidden = true; // Controla la visibilidad en el TextField, nada más

  // Función de login con email/contraseña
  Future<void> _loginWithEmail() async {
    // Limpiamos posibles errores antes de validar
    setState(() {
      _emailError = null;
      _passwordError = null;
      _isLoading = true;
    });

    // Obtenemos lo que el usuario escribió
    final String email = _emailController.text.trim();
    final String password = _passwordController.text;

    // ---------- VALIDACIÓN DEL EMAIL ----------
    if (!email.contains('@')) {
      setState(() {
        _emailError = 'El correo debe contener "@"';
        _isLoading = false;
      });
      return; // No continuamos
    }

    // ---------- VALIDACIÓN DE CONTRASEÑA ----------
    final bool hasUppercase = password.contains(RegExp(r'[A-Z]'));
    final bool hasLowercase = password.contains(RegExp(r'[a-z]'));
    final bool hasDigit = password.contains(RegExp(r'\d'));
    final bool hasMinLength = password.length >= 8;

    if (!hasUppercase || !hasLowercase || !hasDigit || !hasMinLength) {
      setState(() {
        _passwordError = 'La contraseña debe incluir:\n'
            '- Min 1 mayúscula\n'
            '- Min 1 minúscula\n'
            '- Min 1 dígito\n'
            '- Min 8 caracteres';
        _isLoading = false;
      });
      return; 
    }

    // Si pasó las validaciones, simulamos algún proceso (1 segundo)
    await Future.delayed(const Duration(seconds: 1));
    setState(() => _isLoading = false);

    // Navegamos a la pantalla normal
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const NormalScreen()),
    );
  }

  // Función de login con Google (sin validaciones de email/contraseña)
  Future<void> _loginWithGoogle() async {
    try {
      setState(() => _isLoading = true);
      await _googleSignIn.signIn(); // Inicia el proceso de GoogleSignIn
    } catch (e) {
      debugPrint('Error al iniciar sesión con Google: $e');
    } finally {
      setState(() => _isLoading = false);
    }

    // Para la demo, navegamos a NormalScreen
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const NormalScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Colores base (verdes) para la UI
    const Color primaryGreen = Color(0xFF2E7D32);
    const Color buttonGreen = Color(0xFF43A047);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryGreen,
        centerTitle: true,
        title: const Text(
          'NutriFlow',
          style: TextStyle(
            fontFamily: 'Georgia',
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      body: Stack(
        children: [
          // Contenido principal
          SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                const SizedBox(height: 40),
                Image.asset(
                  'assets/dieta.png',
                  width: 250,
                  height: 250,
                ),
                const SizedBox(height: 20),
                const Text(
                  'Inicio de sesión de usuario',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 30),

                // ------------------- EMAIL -------------------
                // Error en rojo si lo hay
                if (_emailError != null) ...[
                  Text(
                    _emailError!,
                    style: const TextStyle(color: Colors.red),
                  ),
                  const SizedBox(height: 4),
                ],
                TextField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    labelText: 'Dirección de email',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),

                // ------------------- CONTRASEÑA -------------------
                // Error en rojo si lo hay
                if (_passwordError != null) ...[
                  Text(
                    _passwordError!,
                    style: const TextStyle(color: Colors.red),
                  ),
                  const SizedBox(height: 4),
                ],
                TextField(
                  controller: _passwordController,
                  // El texto está siempre disponible, aunque no se vea
                  obscureText: _isPasswordHidden,
                  decoration: InputDecoration(
                    labelText: 'Contraseña',
                    border: const OutlineInputBorder(),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _isPasswordHidden
                          ? Icons.visibility
                          : Icons.visibility_off,
                      ),
                      onPressed: () {
                        // Solo alterna la visibilidad, no afecta el texto
                        setState(() {
                          _isPasswordHidden = !_isPasswordHidden;
                        });
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 10),

                // ¿Olvidaste la contraseña?
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      // Navegar a "Olvidé mi contraseña"
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ForgotPasswordPage(),
                        ),
                      );
                    },
                    child: const Text(
                      '¿Olvidaste la contraseña?',
                      style: TextStyle(color: Colors.green),
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // Botón: Inicia Sesión
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _loginWithEmail,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: buttonGreen,
                    ),
                    child: const Text(
                      'Inicia Sesión',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // Separador
                Row(
                  children: const [
                    Expanded(child: Divider(thickness: 1)),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text('O'),
                    ),
                    Expanded(child: Divider(thickness: 1)),
                  ],
                ),
                const SizedBox(height: 20),

                // Botón: Continuar con Google
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: OutlinedButton.icon(
                    icon: Image.network(
                      'https://upload.wikimedia.org/wikipedia/commons/thumb/c/c1/Google_%22G%22_logo.svg/768px-Google_%22G%22_logo.svg.png',
                      width: 24,
                      height: 24,
                    ),
                    onPressed: _isLoading ? null : _loginWithGoogle,
                    label: const Text(
                      'Continuar con Google',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Indicador de carga si _isLoading == true
          if (_isLoading)
            Container(
              color: Colors.black54,
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            ),
        ],
      ),
    );
  }
}
