import 'package:clean_archi_chat/src/common/typedef/common_typedef.dart';

abstract class UsecaseWithoutParams<T> {
  const UsecaseWithoutParams();
  ResultFuture<T> call();
}

abstract class UsecaseWithParams<T, P> {
  const UsecaseWithParams();
  ResultFuture<T> call(P params);
}
