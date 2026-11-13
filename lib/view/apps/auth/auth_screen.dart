import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:get/get.dart';
import 'package:gutsynced/app/controller/auth_controller.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authC = Get.find<AuthController>();
    final emailC = TextEditingController();
    final passC = TextEditingController();
    RxBool isSignIn = true.obs;

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildHeader(),
                const SizedBox(height: 48),
                Obx(() => Column(
                  children: [
                    if (authC.errorMessage.value.isNotEmpty)
                      Container(
                        padding: const EdgeInsets.all(12),
                        margin: const EdgeInsets.only(bottom: 16),
                        decoration: BoxDecoration(
                          color: Colors.red.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.red.withValues(alpha: 0.3)),
                        ),
                        child: Row(
                          children: [
                            const Icon(LucideIcons.circle_alert, color: Colors.red, size: 18),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(authC.errorMessage.value,
                                style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: Colors.red)),
                            ),
                          ],
                        ),
                      ),
                    TextField(
                      controller: emailC,
                      style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                      decoration: const InputDecoration(
                        hintText: 'Email',
                        prefixIcon: Icon(LucideIcons.mail),
                      ),
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: passC,
                      style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                      decoration: const InputDecoration(
                        hintText: 'Password',
                        prefixIcon: Icon(LucideIcons.lock),
                      ),
                      obscureText: true,
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      child: authC.authStatus.value == AuthStatus.loading
                          ? Container(
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  colors: [Color(0xFF6750A4), Color(0xFF9C82C4)],
                                ),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: const Center(
                                child: SizedBox(width: 20, height: 20,
                                  child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white)),
                              ),
                            )
                          : GestureDetector(
                              onTap: () => _submit(authC, emailC.text, passC.text, isSignIn.value),
                              child: Container(
                                padding: const EdgeInsets.symmetric(vertical: 16),
                                decoration: BoxDecoration(
                                  gradient: const LinearGradient(
                                    colors: [Color(0xFF6750A4), Color(0xFF9C82C4)],
                                  ),
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: Center(
                                  child: Text(isSignIn.value ? 'Sign In' : 'Create Account',
                                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white)),
                                ),
                              ),
                            ),
                    ),
                    const SizedBox(height: 16),
                    TextButton(
                      onPressed: () => isSignIn.value = !isSignIn.value,
                      child: Text(
                        isSignIn.value ? "Don't have an account? Sign Up" : 'Already have an account? Sign In',
                        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Color(0xFF9C82C4))),
                    ),
                    if (!isSignIn.value)
                      Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: Text(
                          'Sign up to backup your favorites to the cloud',
                          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w300, color: Colors.grey),
                          textAlign: TextAlign.center,
                        ),
                      ),
                  ],
                )),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF6750A4), Color(0xFF9C82C4)],
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          child: const Icon(LucideIcons.utensils_crossed, color: Colors.white, size: 40),
        ),
        const SizedBox(height: 24),
        const Text('GutSynced', style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white)),
        const SizedBox(height: 8),
        const Text('Your SIBO diet companion',
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w300, color: Colors.grey)),
      ],
    );
  }

  Future<void> _submit(AuthController authC, String email, String password, bool isSignIn) async {
    if (email.isEmpty || password.isEmpty) return;
    if (isSignIn) {
      await authC.signIn(email, password);
    } else {
      await authC.signUp(email, password);
    }
  }
}
