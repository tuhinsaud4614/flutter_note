class PlatformExceptionMsg implements Exception {
  final String message;
  PlatformExceptionMsg(this.message);
  @override
  String toString() {
    return message;
  }
}