abstract class UseCase<T, P, D> {
  Future<T> invoke(P p, D d);
}
