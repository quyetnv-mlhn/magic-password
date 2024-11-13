import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'master_key_provider.g.dart';

@Riverpod(keepAlive: true)
class MasterKeyNotifier extends _$MasterKeyNotifier {
  @override
  String? build() => null;

  bool get isInitialized => state != null && state!.isNotEmpty;

  void setMasterKey(String key) => state = key;

  void clearMasterKey() => state = null;
}
