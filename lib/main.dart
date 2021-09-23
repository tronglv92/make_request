import 'package:makerequest/my_app.dart';
import 'package:makerequest/utils/app_config.dart';
import 'package:makerequest/utils/app_theme.dart';

Future<void> main() async {
  /// Init dev config
  AppConfig(env: Env.dev(), theme: AppTheme.origin());
  await myMain();
}
