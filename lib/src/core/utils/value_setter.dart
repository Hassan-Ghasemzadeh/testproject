extension SetValue<T> on List<T> {
  void setValueWhere(bool Function(T) test, T value,
      [bool addIfNotFound = false]) {
    final currentPos = indexWhere(test);
    currentPos != -1 ? this[currentPos] = value : add(value);
  }
}
