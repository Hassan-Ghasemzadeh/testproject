abstract class UseCase<T, P> {
  Future<T> invoke(T t, P p);
}
