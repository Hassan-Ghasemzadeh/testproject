abstract class UseCase<T, P, D> {
  Future<T> invoke(T t, P p, D d);
}
