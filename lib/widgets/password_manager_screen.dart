import 'dart:async';
import 'dart:io';
import 'dart:isolate';
import 'dart:ui';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:lottie/lottie.dart';
import 'package:magic_password/services/password_manager.dart';
import 'package:magic_password/widgets/decrypt_password_section.dart';
import 'package:magic_password/widgets/encrypt_password_section.dart';
import 'package:magic_password/widgets/generate_key_section.dart';
import 'package:magic_password/widgets/generate_password_section.dart';

class PasswordManagerScreen extends StatefulWidget {
  const PasswordManagerScreen({super.key});

  @override
  PasswordManagerScreenState createState() => PasswordManagerScreenState();
}

class PasswordManagerScreenState extends State<PasswordManagerScreen> {
  final PasswordManager passwordManager = PasswordManager();
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  // Controllers
  final TextEditingController keyController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController encryptedPasswordController =
      TextEditingController();
  final TextEditingController decryptKeyController = TextEditingController();

  // State Variables
  bool _isLoading = false;
  String generatedKey = '';
  String generatedPassword = '';
  String keyName = '';
  String encryptedPassword = '';
  String decryptedPassword = '';
  String inputPassword = '';
  String inputKey = '';
  String inputDecryptKey = '';
  int passwordLength = 20;

  List<String> savedPasswordNames = [];

  static const List<String> supportedPlatforms = ['android', 'ios', 'linux'];
  static const int minPasswordLength = 8;
  static const int maxPasswordLength = 32;

  @override
  void initState() {
    _loadSavedPasswordNames();
    super.initState();
  }

  @override
  void dispose() {
    keyController.dispose();
    nameController.dispose();
    passwordController.dispose();
    encryptedPasswordController.dispose();
    decryptKeyController.dispose();
    super.dispose();
  }

  void generateKey() {
    setState(() {
      generatedKey = passwordManager.generateRandomKey().substring(0, 32);
    });
  }

  void generatePassword() {
    setState(() {
      generatedPassword =
          passwordManager.generatePassword(length: passwordLength);
    });
  }

  Future<void> encryptPassword() async {
    final params = {'password': inputPassword, 'key': inputKey};
    setState(() => _isLoading = true);

    try {
      final encrypted = await Future.wait([
        kIsWeb
            ? Future.value(
                passwordManager.encryptPassword(
                  inputPassword,
                  inputKey,
                ),
              )
            : _runInIsolate(_encryptPasswordInIsolate, params),
        Future.delayed(const Duration(seconds: 1)),
      ]);
      setState(() {
        encryptedPassword = encrypted[0];
      });
    } catch (e) {
      setState(() {
        encryptedPassword = 'Encryption failed: $e';
      });
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> decryptPassword() async {
    final params = {
      'encryptedPassword': encryptedPasswordController.text,
      'key': inputDecryptKey,
    };
    setState(() => _isLoading = true);

    try {
      final decrypted = await Future.wait([
        kIsWeb
            ? Future.value(
                passwordManager.decryptPassword(
                  encryptedPasswordController.text,
                  decryptKeyController.text,
                ),
              )
            : _runInIsolate(_decryptPasswordInIsolate, params),
        Future.delayed(const Duration(seconds: 1)),
      ]);
      setState(() {
        decryptedPassword = decrypted[0];
      });
    } catch (e) {
      setState(() {
        decryptedPassword = 'Decryption failed: Invalid key or data: $e';
      });
    } finally {
      setState(() => _isLoading = false);
    }
  }

  static String _encryptPasswordInIsolate(Map<String, String> params) {
    final password = params['password']!;
    final key = params['key']!;
    return PasswordManager().encryptPassword(password, key);
  }

  static String _decryptPasswordInIsolate(Map<String, String> params) {
    final encryptedPassword = params['encryptedPassword']!;
    final key = params['key']!;
    return PasswordManager().decryptPassword(encryptedPassword, key);
  }

  Future<String> _runInIsolate(
    String Function(Map<String, String>) function,
    Map<String, String> params,
  ) async {
    final receivePort = ReceivePort();
    await Isolate.spawn(
      _isolateEntryPoint,
      [receivePort.sendPort, function, params],
    );

    final result = await receivePort.first;
    if (result is String && result.startsWith('Error:')) {
      throw Exception(result);
    }
    return result;
  }

  static void _isolateEntryPoint(List<dynamic> args) async {
    final SendPort sendPort = args[0];
    final String Function(Map<String, String>) function = args[1];
    final Map<String, String> params = args[2];

    try {
      final result = function(params);
      sendPort.send(result);
    } catch (e) {
      sendPort.send('Error: $e');
    }
  }

  Future<void> _savePassword(String name, String encryptedPassword) async {
    try {
      if (kIsWeb || !supportedPlatforms.contains(Platform.operatingSystem)) {
        throw UnsupportedError(
          'Secure storage is not supported on ${kIsWeb ? 'web platform' : Platform.operatingSystem}. Only Android, iOS and Linux are supported.',
        );
      }

      await _storage.write(key: name, value: encryptedPassword);
      await _loadSavedPasswordNames();
      _showSnackBar('Password saved successfully', Colors.green);
    } on UnsupportedError catch (e) {
      _showSnackBar(e.message ?? 'Unsupported error', Colors.orange);
    } catch (e) {
      _showSnackBar('Failed to save password: $e', Colors.red);
    }
  }

  Future<void> _loadSavedPasswordNames() async {
    final allKeys = await _storage.readAll();
    setState(() {
      savedPasswordNames = allKeys.keys.toList();
    });
  }

  Future<void> _loadEncryptedPassword(String? name) async {
    if (name == null) return;

    final encrypted = await _storage.read(key: name);
    if (encrypted != null) {
      encryptedPasswordController.text = encrypted;
    }
  }

  void _showSnackBar(String message, Color color) {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: color,
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Stack(
        children: [
          Scaffold(
            appBar: AppBar(
              title: const Text(
                'Password Manager',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 24,
                  letterSpacing: 0.5,
                ),
              ),
              centerTitle: true,
              elevation: 0,
              backgroundColor: Colors.transparent,
              flexibleSpace: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.blue.shade800,
                      Colors.purple.shade800,
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
              ),
            ),
            body: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.grey.shade100,
                    Colors.white,
                  ],
                ),
              ),
              child: SingleChildScrollView(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: Column(
                  children: [
                    _buildFeatureCard(
                      title: "Security Center",
                      child: Column(
                        children: [
                          GenerateKeySection(
                            generatedKey: generatedKey,
                            onGenerateKey: generateKey,
                          ),
                          const Divider(height: 32),
                          GeneratePasswordSection(
                            passwordLength: passwordLength,
                            onPasswordLengthChanged: (value) =>
                                setState(() => passwordLength = value),
                            generatedPassword: generatedPassword,
                            onGeneratePassword: generatePassword,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    _buildFeatureCard(
                      title: "Password Management",
                      child: Column(
                        children: [
                          EncryptPasswordSection(
                            onEncryptPassword: encryptPassword,
                            encryptedPassword: encryptedPassword,
                            keyController: keyController,
                            nameController: nameController,
                            passwordController: passwordController,
                            onKeyChanged: (value) => inputKey = value,
                            onPasswordChanged: (value) => inputPassword = value,
                            onSavePassword: (name) =>
                                _savePassword(name, encryptedPassword),
                            onNameChanged: (name) => keyName = name,
                          ),
                          const Divider(height: 32),
                          DecryptPasswordSection(
                            onDecryptPassword: decryptPassword,
                            decryptedPassword: decryptedPassword,
                            decryptKeyController: decryptKeyController,
                            encryptedPasswordController:
                                encryptedPasswordController,
                            onDecryptKeyChanged: (value) =>
                                inputDecryptKey = value,
                            savedPasswordNames: savedPasswordNames,
                            onSelectPasswordName: (name) =>
                                _loadEncryptedPassword(name),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          if (_isLoading) _buildLoadingOverlay(),
        ],
      ),
    );
  }

  Widget _buildFeatureCard({required String title, required Widget child}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 20,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blue.shade600, Colors.purple.shade600],
              ),
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(20)),
            ),
            child: Row(
              children: [
                Icon(
                  title.contains("Security") ? Icons.security : Icons.password,
                  color: Colors.white,
                  size: 24,
                ),
                const SizedBox(width: 12),
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: child,
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingOverlay() {
    return Container(
      color: Colors.black.withOpacity(0.3),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: Center(
          child: Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                kIsWeb
                    ? const CircularProgressIndicator.adaptive()
                    : Lottie.asset(
                        'assets/jsons/loading_lotie.json',
                        width: 100,
                        height: 100,
                      ),
                const SizedBox(height: 16),
                const Text(
                  'Processing...',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
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
