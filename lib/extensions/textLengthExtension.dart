extension StringLengthExtension on String {
  String trimToLength(int max) {
    return this.substring(0, max);
  }
}
