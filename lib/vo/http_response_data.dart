
class HttpResponseData {
  final String rc;
  final String message;
  final dynamic data;

  HttpResponseData({required this.rc, required this.message, this.data});

  HttpResponseData.fromMap(Map<String, dynamic> map): this(
    rc: map['rc'],
    message: map['message'],
    data: map['data']
  );

  Map<String, dynamic> toMap() {
    return {
      'rc': rc,
      'message': message,
      'data': data,
    };
  }

  @override
  String toString() {
    return 'HttpResponseData{rc: $rc, message: $message, data: $data}';
  }

}