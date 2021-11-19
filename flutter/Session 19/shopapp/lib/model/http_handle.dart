class HttpHandle implements Exception {
  String msg;
  HttpHandle(this.msg);

  @override
  String toString() {
    return msg;
  }
}
