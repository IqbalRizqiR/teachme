class ApiError {
  final String code;
  final String message;
  final Map<String, String>? fields;

  ApiError({
    required this.code,
    required this.message,
    this.fields,
  });

  factory ApiError.fromJson(Map<String, dynamic> json) {
    final error = json['error'] as Map<String, dynamic>;
    return ApiError(
      code: error['code'] as String,
      message: error['message'] as String,
      fields: (error['fields'] as Map<String, dynamic>?)?.map(
        (k, v) => MapEntry(k, v as String),
      ),
    );
  }

  @override
  String toString() => 'ApiError(code: $code, message: $message, fields: $fields)';
}
