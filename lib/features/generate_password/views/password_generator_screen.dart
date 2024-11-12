import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/configs/app_sizes.dart';
import '../providers/password_generator_provider.dart';
import '../widgets/action_buttons.dart';
import '../widgets/length_slider.dart';
import '../widgets/password_display.dart';
import '../widgets/password_options.dart';
import '../widgets/social_media_selector.dart';
import '../widgets/user_id_field.dart';

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
          leading: const BackButton(),
          title: Text('Password Generator', style: textTheme.titleLarge),
        ),
        body: SingleChildScrollView(
          padding: paddingAllM,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SocialMediaSelector(),
              verticalSpaceL,
              UserIdField(controller: _userIdController),
              verticalSpaceL,
              PasswordDisplay(password: state.generatedPassword),
              verticalSpaceL,
              PasswordLengthSlider(length: state.passwordLength),
              verticalSpaceL,
              const PasswordOptions(),
              verticalSpaceXL,
              ActionButtons(password: state.generatedPassword),
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
