enum FilterTaskState {
  all,
  active,
  completed;

  @override
  String toString() {
    switch (this) {
      case FilterTaskState.all:
        return 'All';
      case FilterTaskState.active:
        return 'active';
      case FilterTaskState.completed:
        return 'completed';
    }
  }
}
