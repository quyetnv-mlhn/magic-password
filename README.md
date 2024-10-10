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
   ```
   git clone https://github.com/yourusername/password-manager-flutter.git
   ```
2. Navigate to the project directory:
   ```
   cd password-manager-flutter
   ```
3. Get the dependencies:
   ```
   flutter pub get
   ```

## Usage
To run the app on your local machine:

1. Ensure you have an emulator running or a physical device connected.
2. Run the following command in the project directory:
   ```
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
Your Name - [@yourtwitter](https://twitter.com/yourtwitter) - email@example.com

Project Link: [https://github.com/yourusername/password-manager-flutter](https://github.com/yourusername/password-manager-flutter)