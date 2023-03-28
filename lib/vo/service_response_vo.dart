
class ServiceResponseVO {
  final String rc;
  final String msg;
  final dynamic data;

  ServiceResponseVO(this.rc, this.msg, {this.data});

  @override
  String toString() {
    return 'ServiceResponseVO{rc: $rc, msg: $msg, data: $data}';
  }
}