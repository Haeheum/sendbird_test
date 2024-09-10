import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:sendbird_test/sendbird_platform_interface.dart';

class SendbirdMethodChannel extends SendbirdPlatform {
  static const channelName = 'sendbird';
  final channel = const MethodChannel(channelName);

  @override
  Future<bool> init({required String appId}) async {
    return await channel.invokeMethod('init', {'appId': appId});
  }

  @override
  Future<void> authenticate({
    required String userId,
    String? accessToken,
    String? pushToken,
  }) async {
    await channel.invokeMethod(
      'authenticate',
      {
        'userId': userId,
        'accessToken': accessToken,
        'pushToken': pushToken,
      },
    );
    return;
  }

  @override
  Future<void> call({required String callee}) async {
    await channel.invokeMethod('call', {'callee': callee});
    return;
  }

  @override
  Future<void> receiveCall() async {
    await channel.invokeMethod('receiveCall');
    return;
  }

  @override
  Future<void> endCall() async {
    await channel.invokeMethod('endCall');
    return;
  }
}
