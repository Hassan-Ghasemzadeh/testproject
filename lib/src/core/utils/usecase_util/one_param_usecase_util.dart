abstract class UseCase<T, P> {
  Future<T> invoke(P p);
}
