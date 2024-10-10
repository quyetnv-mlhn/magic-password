import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:magic_password/password_manager.dart';

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

  void copyToClipboard(String text) {
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Copied to clipboard'),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Text(
        title,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildCopyableText(String label, String content) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(label,
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  SelectableText(content),
                ],
              ),
            ),
            IconButton(
              icon: const Icon(Icons.copy, color: Colors.blue),
              onPressed: () => copyToClipboard(content),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMultilineTextField({
    required TextEditingController controller,
    required String labelText,
    Function(String)? onChanged,
  }) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        border: const OutlineInputBorder(),
        alignLabelWithHint: true,
      ),
      maxLines: null,
      keyboardType: TextInputType.multiline,
      onChanged: onChanged,
    );
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
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSectionTitle('1. Generate Security Key'),
                  ElevatedButton.icon(
                    icon: const Icon(Icons.vpn_key),
                    label: const Text('Generate Key'),
                    onPressed: generateKey,
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.blue,
                    ),
                  ),
                  if (generatedKey.isNotEmpty)
                    _buildCopyableText('Generated Key:', generatedKey),
                  _buildSectionTitle('2. Generate Random Password'),
                  Row(
                    children: [
                      Expanded(
                        child: Slider(
                          value: passwordLength.toDouble(),
                          min: 8,
                          max: 32,
                          divisions: 24,
                          label: passwordLength.toString(),
                          onChanged: (value) {
                            setState(() {
                              passwordLength = value.toInt();
                            });
                          },
                        ),
                      ),
                      Text('Length: $passwordLength'),
                    ],
                  ),
                  ElevatedButton.icon(
                    icon: const Icon(Icons.password),
                    label: const Text('Generate Password'),
                    onPressed: generatePassword,
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.green,
                    ),
                  ),
                  if (generatedPassword.isNotEmpty)
                    _buildCopyableText(
                        'Generated Password:', generatedPassword),
                  _buildSectionTitle('3. Encrypt Password'),
                  _buildMultilineTextField(
                    controller: keyController,
                    labelText: 'Enter Key',
                    onChanged: (value) {
                      inputKey = value;
                    },
                  ),
                  const SizedBox(height: 8),
                  _buildMultilineTextField(
                    controller: passwordController,
                    labelText: 'Enter Password',
                    onChanged: (value) {
                      inputPassword = value;
                    },
                  ),
                  const SizedBox(height: 8),
                  ElevatedButton.icon(
                    icon: const Icon(Icons.lock),
                    label: const Text('Encrypt Password'),
                    onPressed: encryptPassword,
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.orange,
                    ),
                  ),
                  if (encryptedPassword.isNotEmpty)
                    _buildCopyableText(
                        'Encrypted Password:', encryptedPassword),
                  _buildSectionTitle('4. Decrypt Password'),
                  _buildMultilineTextField(
                    controller: encryptedPasswordController,
                    labelText: 'Enter Encrypted Password',
                  ),
                  const SizedBox(height: 8),
                  _buildMultilineTextField(
                    controller: decryptKeyController,
                    labelText: 'Enter Decryption Key',
                    onChanged: (value) {
                      inputDecryptKey = value;
                    },
                  ),
                  const SizedBox(height: 8),
                  ElevatedButton.icon(
                    icon: const Icon(Icons.lock_open),
                    label: const Text('Decrypt Password'),
                    onPressed: decryptPassword,
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.purple,
                    ),
                  ),
                  if (decryptedPassword.isNotEmpty)
                    _buildCopyableText(
                        'Decrypted Password:', decryptedPassword),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
