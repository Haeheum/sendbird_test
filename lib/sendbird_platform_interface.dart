import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'sendbird_method_channel.dart';

abstract class SendbirdPlatform extends PlatformInterface {
  SendbirdPlatform() : super(token: _token);

  static final Object _token = Object();
  static SendbirdPlatform _instance = SendbirdMethodChannel();

  static SendbirdPlatform get instance => _instance;

  static set instance(SendbirdPlatform instance) {
    PlatformInterface.verify(instance, _token);
    _instance = instance;
  }

  Future<void> init({required String appId}) => throw UnimplementedError();

  Future<void> authenticate({
    required String userId,
    String? accessToken,
    String? pushToken,
  }) =>
      throw UnimplementedError();

  Future<void> call({required String callee}) => throw UnimplementedError();

  Future<void> receiveCall() => throw UnimplementedError();

  Future<void> endCall() => throw UnimplementedError();
}
