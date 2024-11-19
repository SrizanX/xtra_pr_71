import '../../../../domain/result.dart';
import 'mapper.dart';

final class ResultMapper {
  static final _instance = ResultMapper._();

  ResultMapper._();

  factory ResultMapper() => _instance;

  Result<DomainModel> map<NetworkModel, DomainModel>({
    required Result<NetworkModel> result,
    required Mapper<NetworkModel, DomainModel> mapper,
  }) {
    switch (result) {
      case Successful<NetworkModel>():
        return Successful(data: mapper.map(result.data));
      case Failed<NetworkModel>():
        return Failed(message: result.message, exception: result.exception);
    }
  }
}
