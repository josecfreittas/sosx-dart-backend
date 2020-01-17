import 'package:sos10/sos10.dart';

Future main() async {
  final app = Application<Sos10BackendChannel>()
    ..options.configurationFilePath = "config.yaml"
    ..options.port = 8888;

  await app.start(numberOfInstances: 1);

  print("Application started on port: ${app.options.port}.");
  print("Use Ctrl-C (SIGINT) to stop running the application.");
}
