import 'package:flutter_driver/driver_extension.dart';
import 'package:reel_n_scan/config/globals.dart';
import 'package:reel_n_scan/main.dart' as app;

void main() {
  // This line enables the extension.
  enableFlutterDriverExtension();

  areWeInIntegrationTest = true;

  // Call the `main()` function of the app, or call `runApp` with
  // any widget you are interested in testing.
  app.main();
}
