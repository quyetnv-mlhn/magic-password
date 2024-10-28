import 'dart:convert';
import 'dart:math';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:flutter/services.dart';
import "package:crypto/crypto.dart" show Hmac, sha256;

class PasswordManager {
  static const int saltLength = 16;
  static const int keyLength = 32;
  static const int pbkdf2Iterations = 10000;

  // Function to generate a random salt
  String _generateSalt() {
    final random = Random.secure();
    final salt = List<int>.generate(saltLength, (i) => random.nextInt(256));
    return base64Url.encode(salt);
  }

  // Function to derive a key from a password and salt using PBKDF2
  List<int> _deriveKey(String masterPassword, String salt) {
    final key = utf8.encode(masterPassword); // Convert password to bytes
    final saltBytes = base64Url.decode(salt); // Decode the salt

    var hmacSha256 = Hmac(sha256, key); // Create HMAC-SHA256 instance
    var derivedKey = List<int>.filled(keyLength, 0); // Initialize key list
    var block = List<int>.filled(saltBytes.length + 4, 0); // Initialize block
    block.setRange(0, saltBytes.length, saltBytes); // Set salt in block

    // Loop to generate the key
    for (var i = 0, j = 0; i < keyLength; i++, j++) {
      if (j >= 32) {
        // Reset j after every 32 iterations
        j = 0;
        block[saltBytes.length] =
            (block[saltBytes.length] + 1) & 0xff; // Increment block counter
      }

      // Calculate the derived key
      if (j == 0) {
        var u = hmacSha256.convert(block).bytes; // First iteration
        var t = List<int>.from(u); // Initialize t with u

        // Perform PBKDF2 iterations
        for (var k = 1; k < pbkdf2Iterations; k++) {
          u = hmacSha256.convert(u).bytes; // Repeated HMAC-SHA256
          for (var l = 0; l < t.length; l++) {
            t[l] ^= u[l]; // XOR to accumulate the derived key
          }
        }

        derivedKey.setRange(
          i,
          min(i + 32, keyLength),
          t,
        ); // Set the derived key
        i += 31;
      }
    }

    return derivedKey;
  }

  // Function to encrypt a password using AES-GCM
  String encryptPassword(String password, String masterKey) {
    final salt = _generateSalt(); // Generate salt
    final key = _deriveKey(masterKey, salt); // Derive key using PBKDF2
    final iv = encrypt.IV
        .fromSecureRandom(12); // Generate random IV (Initialization Vector)

    // Create AES encrypter using AES-GCM mode
    final encrypter = encrypt.Encrypter(
      encrypt.AES(encrypt.Key(Uint8List.fromList(key)),
          mode: encrypt.AESMode.gcm),
    );
    final encrypted =
        encrypter.encrypt(password, iv: iv); // Encrypt the password

    // Combine salt, IV, and encrypted data
    final combined = '$salt|${base64Encode(iv.bytes + encrypted.bytes)}';
    return base64Encode(
      utf8.encode(combined),
    ); // Return encrypted result as base64
  }

  // Function to decrypt a password using AES-GCM
  String decryptPassword(String encryptedPassword, String masterKey) {
    final decoded =
        utf8.decode(base64Decode(encryptedPassword)); // Decode base64
    final parts = decoded.split('|'); // Split into salt and encrypted data
    if (parts.length != 2) {
      throw const FormatException('Invalid encrypted password format');
    }

    final salt = parts[0]; // Extract salt
    final data = base64Decode(parts[1]); // Decode the encrypted data

    final key = _deriveKey(masterKey, salt); // Derive the key using the salt
    final iv = encrypt.IV(data.sublist(0, 12)); // Extract IV
    final encryptedData =
        encrypt.Encrypted(data.sublist(12)); // Extract encrypted part

    // Create AES encrypter for decryption
    final encrypter = encrypt.Encrypter(
      encrypt.AES(encrypt.Key(Uint8List.fromList(key)),
          mode: encrypt.AESMode.gcm),
    );

    try {
      return encrypter.decrypt(encryptedData, iv: iv); // Attempt to decrypt
    } catch (e) {
      throw const FormatException(
        'Decryption failed. Ensure the master password is correct.',
      );
    }
  }

  // Function to generate a random password
  String generatePassword({int length = 16, bool useSpecialChars = true}) {
    const lowercaseChars = 'abcdefghijklmnopqrstuvwxyz';
    const uppercaseChars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
    const numbers = '0123456789';
    const specialChars = '@#%^&*()_+=';

    String chars =
        lowercaseChars + uppercaseChars + numbers; // Base character set
    if (useSpecialChars) {
      chars += specialChars; // Add special characters if needed
    }

    final random = Random.secure();
    return List.generate(length, (index) => chars[random.nextInt(chars.length)])
        .join(''); // Generate random password
  }

  // Function to generate a random key
  String generateRandomKey() {
    final random = Random.secure();
    final values = List<int>.generate(
      32,
      (i) => random.nextInt(256),
    ); // Generate 32-byte key for AES-256
    return base64UrlEncode(values); // Return the key as a base64-encoded string
  }
}
