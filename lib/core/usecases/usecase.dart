abstract class Usecase<Type, Params> {
  Future<dynamic> call(Params params);
}
