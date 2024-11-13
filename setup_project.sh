#!/bin/bash

# Display menu
echo "Select an option:"
echo "1) Full Project Setup"
echo "2) New Feature Setup"
read -p "Enter choice [1 or 2]: " choice

if [[ "$choice" == "1" ]]; then
  # Option 1: Full Project Setup
  echo "Setting up full project structure..."

  # Create basic folder structure
  mkdir -p lib/{app/view,core/{configs,constants,extensions,theme,utils},data/{datasources/{local,remote},models,repositories},domain/{entities,repositories},features/{auth/{providers,view/widgets},home/{providers,view}},l10n/arb}

  # Create basic files
  # App
  cat > lib/app/app.dart << 'EOF'
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'view/app.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp(
        theme: ThemeData.light(),
        darkTheme: ThemeData.dark(),
        home: const AppView(),
      ),
    );
  }
}
EOF

  # App View
  cat > lib/app/view/app.dart << 'EOF'
import 'package:flutter/material.dart';

class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('App View'),
      ),
    );
  }
}
EOF

  # Bootstrap
  cat > lib/bootstrap.dart << 'EOF'
import 'dart:async';
import 'package:flutter/material.dart';

Future<void> bootstrap(FutureOr<Widget> Function() builder) async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(await builder());
}
EOF

  # Main
  cat > lib/main.dart << 'EOF'
import 'package:flutter/material.dart';
import 'app/app.dart';
import 'bootstrap.dart';

void main() {
  bootstrap(() => const App());
}
EOF

  # Localization (L10n)
  cat > lib/l10n/arb/app_en.arb << 'EOF'
{
    "@@locale": "en",
    "appTitle": "App Title",
    "@appTitle": {
        "description": "The title of the application"
    }
}
EOF

  cat > lib/l10n/arb/app_vi.arb << 'EOF'
{
    "@@locale": "vi",
    "appTitle": "Tiêu đề ứng dụng",
    "@appTitle": {
        "description": "Tiêu đề của ứng dụng"
    }
}
EOF

  # Auth Provider
  cat > lib/features/auth/providers/auth_provider.dart << 'EOF'
import 'package:riverpod_annotation/riverpod_annotation.dart';

@riverpod
class AuthNotifier extends _$AuthNotifier {
  @override
  FutureOr<void> build() async {
    // TODO: implement build
  }
}
EOF

  # User Repository
  cat > lib/domain/repositories/i_user_repository.dart << 'EOF'
abstract class IUserRepository {
  // TODO: Add repository methods
}
EOF

  cat > lib/data/repositories/user_repository.dart << 'EOF'
import '../../domain/repositories/i_user_repository.dart';

class UserRepository implements IUserRepository {
  // TODO: Implement repository methods
}
EOF

  # Add .gitkeep in empty folders
  find lib -type d -empty -exec touch {}/.gitkeep \;

  # Check and add necessary packages using flutter pub add
  echo "Adding necessary dependencies..."

  flutter pub add flutter_riverpod
  flutter pub add riverpod_annotation
  flutter pub add freezed_annotation
  flutter pub add json_annotation

  flutter pub add --dev flutter_test
  flutter pub add --dev riverpod_generator
  flutter pub add --dev build_runner
  flutter pub add --dev freezed
  flutter pub add --dev json_serializable

  # Remove very_good_analysis from analysis_options.yaml
  if [ -f analysis_options.yaml ]; then
    sed -i '/very_good_analysis/d' analysis_options.yaml
  else
    cat > analysis_options.yaml << 'EOF'
linter:
  rules:
    public_member_api_docs: false
EOF
  fi

  # Completion message
  echo "Project structure created successfully!"
  echo "Run 'flutter pub get' to install dependencies"
  echo "Run 'dart run build_runner build' to generate code"

  # Run flutter pub get automatically
  flutter pub get

elif [[ "$choice" == "2" ]]; then
  # Option 2: New Feature Setup
  echo "Setting up new feature..."

  # Prompt for the feature name
  read -p "Enter the feature name: " feature_name

  # Define the base path for the features directory
  base_path="lib/features"
  feature_path="$base_path/$feature_name"

  # Check if the feature already exists
  if [ -d "$feature_path" ]; then
      echo "Feature '$feature_name' already exists in $base_path."
      exit 1
  fi

  # Create the main feature directory and subdirectories
  mkdir -p "$feature_path/providers"
  mkdir -p "$feature_path/views"
  mkdir -p "$feature_path/widgets"
  mkdir -p "$feature_path/states"

  # Confirm completion
  echo "Feature '$feature_name' has been created with the following structure:"
  echo "$feature_path/"
  echo "├── providers/"
  echo "├── views/"
  echo "├── widgets/"
  echo "└── states/"

else
  echo "Invalid choice. Please run the script again and choose either 1 or 2."
  exit 1
fi