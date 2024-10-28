import 'package:flutter/material.dart';
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
  PasswordManager passwordManager = PasswordManager();
  String generatedKey = '';
  String generatedPassword = '';
  String encryptedPassword = '';
  String decryptedPassword = '';
  String inputPassword = '';
  String inputKey = '';
  String inputDecryptKey = '';
  int passwordLength = 16;

  TextEditingController keyController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController encryptedPasswordController = TextEditingController();
  TextEditingController decryptKeyController = TextEditingController();

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
                  onPasswordLengthChanged: (value) {
                    setState(() => passwordLength = value);
                  },
                  generatedPassword: generatedPassword,
                  onGeneratePassword: generatePassword,
                ),
                EncryptPasswordSection(
                  onEncryptPassword: encryptPassword,
                  encryptedPassword: encryptedPassword,
                  keyController: keyController,
                  passwordController: passwordController,
                  onKeyChanged: (value) => inputKey = value,
                  onPasswordChanged: (value) => inputPassword = value,
                ),
                DecryptPasswordSection(
                  onDecryptPassword: decryptPassword,
                  decryptedPassword: decryptedPassword,
                  decryptKeyController: decryptKeyController,
                  encryptedPasswordController: encryptedPasswordController,
                  onDecryptKeyChanged: (value) => inputDecryptKey = value,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
