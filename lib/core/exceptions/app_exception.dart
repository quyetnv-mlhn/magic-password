abstract class AppException implements Exception {
  final String messageKey;
  final String? code;
  final dynamic data;

  const AppException({
    required this.messageKey,
    this.code,
    this.data,
  });

  @override
  String toString() =>
      'AppException(messageKey: $messageKey, code: $code, data: $data)';
}
