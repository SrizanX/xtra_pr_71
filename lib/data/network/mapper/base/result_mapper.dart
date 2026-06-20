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
        // Guard against malformed/unexpected payloads: a parsing failure
        // becomes a Failed result instead of an uncaught exception.
        try {
          return Successful(data: mapper.map(result.data));
        } on Exception catch (e) {
          return Failed(message: "Unexpected response from router", exception: e);
        } catch (e) {
          return Failed(
            message: "Unexpected response from router",
            exception: Exception(e.toString()),
          );
        }
      case Failed<NetworkModel>():
        // Preserve the transport-level classification (unreachable / wrong
        // device) so the UI can guide the user appropriately.
        return Failed(
          message: result.message,
          exception: result.exception,
          kind: result.kind,
        );
    }
  }
}
