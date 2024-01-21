class ApiResponse {
  bool success = false;
  dynamic data;
  String? message;
  String? version;

  ApiResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'];
    message = json['message'];
    version = json['version'];
  }
}
