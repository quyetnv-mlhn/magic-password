import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:magic_password/core/extensions/theme_ext.dart';
import 'package:magic_password/features/password/states/password_state.dart';
import 'package:magic_password/widgets/decrypt_password_section.dart';
import 'package:magic_password/widgets/encrypt_password_section.dart';
import 'package:magic_password/widgets/generate_key_section.dart';
import 'package:magic_password/widgets/generate_password_section.dart';
import 'package:magic_password/features/password/providers/password_provider.dart';
import 'package:magic_password/core/widgets/loading_overlay.dart';

class PasswordScreen extends ConsumerStatefulWidget {
  const PasswordScreen({super.key});

  @override
  ConsumerState<PasswordScreen> createState() => _PasswordScreenState();
}

class _PasswordScreenState extends ConsumerState<PasswordScreen> {
  final TextEditingController keyController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController encryptedPasswordController =
      TextEditingController();
  final TextEditingController decryptKeyController = TextEditingController();

  @override
  void dispose() {
    keyController.dispose();
    nameController.dispose();
    passwordController.dispose();
    encryptedPasswordController.dispose();
    decryptKeyController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    ref.listenManual(
      passwordNotifierProvider.select((state) => state.loadedEncryptedPassword),
      (previous, next) {
        if (next.isNotEmpty) {
          encryptedPasswordController.text = next;
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(passwordNotifierProvider);

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Stack(
        children: [
          Scaffold(
            appBar: _buildAppBar(context),
            body: _buildBody(context, state),
          ),
          if (state.isLoading) const LoadingOverlay(),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      title: Text(
        'Password Manager',
        style: context.textTheme.titleLarge,
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
    );
  }

  Widget _buildBody(BuildContext context, PasswordState state) {
    return DecoratedBox(
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
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
        child: Column(
          children: [
            _buildFeatureCard(
              context,
              title: "Security Center",
              child: Column(
                children: [
                  GenerateKeySection(
                    generatedKey: state.generatedKey,
                    onGenerateKey: () => ref
                        .read(passwordNotifierProvider.notifier)
                        .generateKey(),
                  ),
                  const Divider(height: 32),
                  GeneratePasswordSection(
                    passwordLength: state.passwordLength,
                    onPasswordLengthChanged: (value) => ref
                        .read(passwordNotifierProvider.notifier)
                        .updatePasswordLength(value),
                    generatedPassword: state.generatedPassword,
                    onGeneratePassword: () => ref
                        .read(passwordNotifierProvider.notifier)
                        .generatePassword(),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            _buildFeatureCard(
              context,
              title: "Password Management",
              child: Column(
                children: [
                  EncryptPasswordSection(
                    onEncryptPassword: () => ref
                        .read(passwordNotifierProvider.notifier)
                        .encryptPassword(),
                    encryptedPassword: state.encryptedPassword,
                    keyController: keyController,
                    nameController: nameController,
                    passwordController: passwordController,
                    onKeyChanged: (value) => ref
                        .read(passwordNotifierProvider.notifier)
                        .updateInputKey(value),
                    onPasswordChanged: (value) => ref
                        .read(passwordNotifierProvider.notifier)
                        .updateInputPassword(value),
                    onSavePassword: (name) {},
                    onNameChanged: (String value) {},
                  ),
                  const Divider(height: 32),
                  DecryptPasswordSection(
                    onDecryptPassword: () => ref
                        .read(passwordNotifierProvider.notifier)
                        .decryptPassword(
                          encryptedPasswordController.text,
                          decryptKeyController.text,
                        ),
                    decryptedPassword: state.decryptedPassword,
                    decryptKeyController: decryptKeyController,
                    encryptedPasswordController: encryptedPasswordController,
                    onDecryptKeyChanged: (value) => ref
                        .read(passwordNotifierProvider.notifier)
                        .updateInputDecryptKey(value),
                    savedPasswords: state.savedPasswords,
                    onSelectPasswordName: (name) => ref
                        .read(passwordNotifierProvider.notifier)
                        .loadEncryptedPassword(name),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureCard(
    BuildContext context, {
    required String title,
    required Widget child,
  }) {
    return DecoratedBox(
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
                  style: context.textTheme.titleMedium,
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
}
