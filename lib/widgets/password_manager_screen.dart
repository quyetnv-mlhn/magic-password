import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
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
  void dispose() {
    // Dispose controllers to free up resources
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

  void encryptPassword() {
    setState(() {
      encryptedPassword =
          passwordManager.encryptPassword(inputPassword, inputKey);
    });
  }

  void decryptPassword() {
    setState(() {
      try {
        decryptedPassword = passwordManager.decryptPassword(
          encryptedPasswordController.text,
          inputDecryptKey,
        );
      } catch (e) {
        decryptedPassword = 'Decryption failed: Invalid key or data';
      }
    });
  }

  Future<void> _savePassword(String name, String encryptedPassword) async {
    if (!supportedPlatforms.contains(Platform.operatingSystem)) {
      _showSnackBar('Platform not supported for secure storage', Colors.red);
      return;
    }

    try {
      await _storage.write(key: name, value: encryptedPassword);
      _showSnackBar('Password saved successfully', Colors.green);
      await _loadSavedPasswordNames();
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
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Password Manager'),
          backgroundColor: Colors.blue,
        ),
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.blue.shade50, Colors.white],
            ),
          ),
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GenerateKeySection(
                  generatedKey: generatedKey,
                  onGenerateKey: generateKey,
                ),
                GeneratePasswordSection(
                  passwordLength: passwordLength,
                  onPasswordLengthChanged: (value) =>
                      setState(() => passwordLength = value),
                  generatedPassword: generatedPassword,
                  onGeneratePassword: generatePassword,
                ),
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
                DecryptPasswordSection(
                  onDecryptPassword: decryptPassword,
                  decryptedPassword: decryptedPassword,
                  decryptKeyController: decryptKeyController,
                  encryptedPasswordController: encryptedPasswordController,
                  onDecryptKeyChanged: (value) => inputDecryptKey = value,
                  savedPasswordNames: savedPasswordNames,
                  onSelectPasswordName: (name) => _loadEncryptedPassword(name),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
