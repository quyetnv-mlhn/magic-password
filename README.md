# Password Manager Flutter App

## Overview
This Password Manager is a Flutter application designed to help users generate secure passwords, encrypt sensitive information, and manage their digital credentials safely. It provides a user-friendly interface for key generation, password creation, encryption, and decryption.

## Features
- Generate secure random keys
- Create strong passwords with customizable length
- Encrypt passwords or sensitive information
- Decrypt encrypted data
- Copy generated keys, passwords, and encrypted data to clipboard

## Prerequisites
Before you begin, ensure you have met the following requirements:
- Flutter SDK (latest stable version)
- Dart SDK (latest stable version)
- Android Studio / VS Code with Flutter extensions
- A mobile device or emulator for testing

## Installation
1. Clone the repository:
   ```bash
   git clone https://github.com/quyetnv-mlhn/MagicPassword.git
   ```

2. Navigate to the project directory:
   ```bash
   cd MagicPassword
   ```

3. Get the dependencies:
   ```bash
   flutter pub get
   ```

## Generating Splash Screen and Launcher Icons

Before running the app, ensure that splash screens and launcher icons are generated:

1. Generate the native splash screen:
   ```bash
   dart run flutter_native_splash:create
   ```

2. Generate launcher icons:
   ```bash
   dart run flutter_launcher_icons:generate
   ```
   
## Deployment to Firebase Hosting
   ```bash
   firebase deploy --only hosting:magic-password-quyetnv
   ```

## Build the App for Different Platforms

To build the release version of the app for different platforms, use the following commands:

1. **Android APK:**
   ```bash
   flutter build apk --release
   ```

2. **Android App Bundle:**
   ```bash
   flutter build appbundle --release
   ```

3. **iOS:**
   ```bash
   flutter build ios --release
   ```

4. **Web:**
   ```bash
   flutter build web --release
   ```

5. **Windows:**
   ```bash
   flutter build windows --release
   ```

6. **macOS:**
   ```bash
   flutter build macos --release
   ```

7. **Linux:**
   ```bash
   flutter build linux --release
   ```

## Usage

To run the app on your local machine:

1. Ensure you have an emulator running or a physical device connected.
2. Run the following command in the project directory:
   ```bash
   flutter run
   ```

## How to Use the App

1. **Generate Security Key**:
   - Tap on "Generate Key" to create a secure random key.
   - The generated key will be displayed and can be copied to the clipboard.

2. **Generate Random Password**:
   - Use the slider to set the desired password length (8-32 characters).
   - Tap on "Generate Password" to create a strong random password.
   - The generated password will be displayed and can be copied.

3. **Encrypt Password**:
   - Enter your encryption key in the "Enter Key" field.
   - Input the password or data you want to encrypt in the "Enter Password" field.
   - Tap "Encrypt Password" to generate the encrypted version.
   - The encrypted password will be displayed and can be copied.

4. **Decrypt Password**:
   - Enter the encrypted password in the "Enter Encrypted Password" field.
   - Input the decryption key in the "Enter Decryption Key" field.
   - Tap "Decrypt Password" to reveal the original password.
   - The decrypted password will be displayed if successful.

## Security Note

This app is designed for educational purposes and basic password management. For highly sensitive data, consider using enterprise-grade password management solutions.

## Contributing

Contributions to improve the Password Manager are welcome. Please follow these steps:

1. Fork the repository
2. Create a new branch (`git checkout -b feature/AmazingFeature`)
3. Make your changes
4. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
5. Push to the branch (`git push origin feature/AmazingFeature`)
6. Open a Pull Request

## License

Distributed under the MIT License. See `LICENSE` file for more information.

## Contact

@quyetnv - quyetnv.mlhn@gmail.com

Project Link: https://github.com/quyetnv-mlhn/MagicPassword