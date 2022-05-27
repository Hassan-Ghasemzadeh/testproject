abstract class UseCase<T, P> {
  Future<P> invoke(T t);
}
