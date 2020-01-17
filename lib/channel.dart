import 'package:postgres/postgres.dart';
import 'package:sos10/controllers/devs_controller.dart';
import 'sos10.dart';

class Sos10BackendChannel extends ApplicationChannel {
  PostgreSQLConnection connection;

  @override
  Future prepare() async {
    final settings = ChannelSettings(options.configurationFilePath);
    logger.onRecord.listen((rec) => print("$rec ${rec.error ?? ""} ${rec.stackTrace ?? ""}"));
    connection = PostgreSQLConnection(
      settings.database.host,
      settings.database.port,
      settings.database.databaseName,
      username: settings.database.username,
      password: settings.database.password,
    );
    await connection.open();
  }

  @override
  Controller get entryPoint {
    final router = Router();
    router.route("/devs").link(() => DevsController(connection));
    router.route("/example").linkFunction((request) async {
      return Response.ok({"key": "value"});
    });

    return router;
  }
}

class ChannelSettings extends Configuration {
  ChannelSettings(String path): super.fromFile(File(path));

  DatabaseConfiguration database;
}
