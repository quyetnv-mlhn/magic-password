import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:magic_password/features/generate_password/widgets/account_type_selector.dart';

import 'package:magic_password/core/configs/app_sizes.dart';
import 'package:magic_password/features/generate_password/providers/password_generator_provider.dart';
import 'package:magic_password/features/generate_password/widgets/action_buttons.dart';
import 'package:magic_password/features/generate_password/widgets/length_slider.dart';
import 'package:magic_password/features/generate_password/widgets/password_display.dart';
import 'package:magic_password/features/generate_password/widgets/password_options.dart';
import 'package:magic_password/features/generate_password/widgets/user_id_field.dart';

class PasswordGeneratorScreen extends ConsumerStatefulWidget {
  const PasswordGeneratorScreen({super.key});

  @override
  ConsumerState<PasswordGeneratorScreen> createState() =>
      _PasswordGeneratorScreenState();
}

class _PasswordGeneratorScreenState
    extends ConsumerState<PasswordGeneratorScreen> {
  final TextEditingController _userIdController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _userIdController.addListener(() {
      ref
          .read(passwordGeneratorNotifierProvider.notifier)
          .updateUserId(_userIdController.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(passwordGeneratorNotifierProvider);
    final textTheme = Theme.of(context).textTheme;

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Password Generator', style: textTheme.titleLarge),
        ),
        body: SingleChildScrollView(
          padding: paddingAllM,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const AccountTypeSelector(),
              verticalSpaceL,
              UserIdField(controller: _userIdController),
              verticalSpaceL,
              PasswordDisplay(password: state.generatedPassword),
              verticalSpaceL,
              PasswordLengthSlider(length: state.passwordLength),
              verticalSpaceL,
              const PasswordOptions(),
              verticalSpaceXL,
              ActionButtons(
                password: state.generatedPassword,
                canSave: state.userId.isNotEmpty &&
                    state.generatedPassword.isNotEmpty,
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _userIdController.dispose();
    super.dispose();
  }
}
