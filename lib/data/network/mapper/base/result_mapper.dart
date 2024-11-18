import '../../../../domain/result.dart';
import 'mapper.dart';

final class ResultMapper {
  static final _instance = ResultMapper._();

  ResultMapper._();

  factory ResultMapper() => _instance;

  Result<DomainModel> map<NetworkModel, DomainModel>({
    required Result<NetworkModel> response,
    required Mapper<NetworkModel, DomainModel> mapper,
  }) {
    switch (response) {
      case Successful<NetworkModel>():
        return Successful(data: mapper.map(response.data));
      case Failed<NetworkModel>():
        return Failed(message: response.message, exception: response.exception);
    }
  }
}
