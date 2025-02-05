import 'dart:async';

import 'package:get_it/get_it.dart';

final globalGetIt = GetIt.instance;

class Datasource {
  String getData() {
    return "010212112102120220";
  }
}

class ParamDatasource {
  String baseUrl;
  int port;

  ParamDatasource({
    required this.baseUrl,
    required this.port,
  });

  String getData() {
    return "$baseUrl:$port/010212112102120220";
  }
}

abstract class Service {
  Future<String> loadData();
}

class FastServiceImpl implements Service {
  static const name = 'Fast Server';

  Datasource datasource;

  FastServiceImpl({required this.datasource}) {
    print("$name initialized");
  }

  @override
  Future<String> loadData() {
    return Future.delayed(
      const Duration(seconds: 1),
      () => "Your data ${datasource.getData()} is ready from $name!",
    );
  }
}

class SlowServiceImpl with Disposable implements Service {
  static const name = 'Slow Server';

  @override
  Future<String> loadData() {
    return Future.delayed(
        const Duration(seconds: 5), () => "Your data is ready from $name!");
  }

  @override
  FutureOr onDispose() {
    print("OnDispose: $name");
  }
}

void initGetIt() {
  globalGetIt.registerSingleton(Datasource());
}

void main() async {
  initGetIt();
  registerFactoryParam(globalGetIt);

  final a =
      globalGetIt.get<ParamDatasource>(param1: "http://fjsjfks", param2: 5432);

  print(a.getData());
}

void testScope() async {
  globalGetIt.pushNewScope(
    init: (sc) {
      registerSingleton(sc);
    },
    scopeName: "scope_2",
    dispose: (){
      print("Disposing scope_2");
    }
  );

  final fastServer =
      globalGetIt.get<Service>(instanceName: FastServiceImpl.name);

  print(fastServer.hashCode);

  await globalGetIt.popScope();

  final fastServer2 =
      globalGetIt.get<Service>(instanceName: FastServiceImpl.name);

  print(fastServer2.hashCode);
}

void registerSingleton(GetIt getIt) {
  getIt.registerSingleton<Service>(
    FastServiceImpl(datasource: getIt.get()),
    instanceName: FastServiceImpl.name,
    dispose: (service) {
      print("Dispose from registerSingleton");
    },
  );

  getIt.registerSingleton<Service>(
    SlowServiceImpl(),
    instanceName: SlowServiceImpl.name,
  );
}

void registerLazySingleton(GetIt getIt) {
  getIt.registerLazySingleton<Service>(
    () => FastServiceImpl(datasource: getIt.get()),
    instanceName: FastServiceImpl.name,
    dispose: (service) {
      print("Dispose from registerLazySingleton");
    },
    useWeakReference: false,
  );
  getIt.registerLazySingleton<Service>(
    () => SlowServiceImpl(),
    instanceName: SlowServiceImpl.name,
    useWeakReference: false,
  );
}

void registerSingletonAsync(GetIt getIt) {
  getIt.registerSingletonAsync<Service>(() {
    return Future.delayed(
      const Duration(seconds: 1),
      () => FastServiceImpl(datasource: getIt.get()),
    );
  });

  getIt.registerSingletonAsync<Service>(() {
    return Future.delayed(
      const Duration(seconds: 3),
      () => SlowServiceImpl(),
    );
  });
}

void registerFactory(GetIt getIt) {
  getIt.registerFactory<Service>(
    () => FastServiceImpl(datasource: getIt.get()),
    instanceName: FastServiceImpl.name,
  );

  getIt.registerFactory<Service>(
    () => SlowServiceImpl(),
    instanceName: SlowServiceImpl.name,
  );
}

void registerFactoryParam(GetIt getIt) {
  globalGetIt.registerFactoryParam(
    (String baseUrl, int port) {
      return ParamDatasource(baseUrl: baseUrl, port: port);
    },
  );
}
