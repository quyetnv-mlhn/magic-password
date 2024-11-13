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
  String toString() {
    final fields = <String>[
      messageKey,
      if (code != null) 'code: $code',
      if (data != null) 'data: $data',
    ];
    return '${fields.join(', ')})';
  }
}
