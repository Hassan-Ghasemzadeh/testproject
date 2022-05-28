extension SetValue<T> on List<T> {
  void setValueWhere(bool Function(T) test, T value,
      [bool addIfNotFound = false]) {
    final currentPos = indexWhere(test);
    if (currentPos != -1) {
      this[currentPos] = value;
    } else if (addIfNotFound) {
      add(value);
    } else {
      throw Exception('test failed ');
    }
  }
}
