class ApiResponse {
  final bool success;
  final dynamic data;
  final String? message;
  final String? version;

  ApiResponse({
    required this.success,
    required this.data,
    required this.message,
    required this.version,
  });

  ApiResponse copyWith({
    bool? success,
    dynamic data,
    String? message,
    String? version,
  }) {
    return ApiResponse(
      success: success ?? this.success,
      data: data ?? this.data,
      message: message ?? this.message,
      version: version ?? this.version,
    );
  }

  factory ApiResponse.fromMap(Map<String, dynamic> map) {
    return ApiResponse(
      success: map['success'] as bool,
      data: map['data'] as dynamic,
      message: map['message'] != null ? map['message'] as String : null,
      version: map['version'] != null ? map['version'] as String : null,
    );
  }

  @override
  String toString() {
    return 'ApiResponse(success: $success, data: $data, message: $message, version: $version)';
  }

  @override
  bool operator ==(covariant ApiResponse other) {
    if (identical(this, other)) return true;

    return other.success == success &&
        other.data == data &&
        other.message == message &&
        other.version == version;
  }

  @override
  int get hashCode {
    return success.hashCode ^
        data.hashCode ^
        message.hashCode ^
        version.hashCode;
  }
}
