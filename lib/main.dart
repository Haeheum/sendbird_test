import 'package:flutter/material.dart';
import 'package:sendbird_test/sendbird_platform_interface.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static const _appId = '78A2FFBF-5745-454F-83E1-D56FA566EA81';
  static const _userId = 'user2';
  static const _callee = 'honey';

  @override
  void initState() {
    super.initState();

    SendbirdPlatform.instance.init(appId: _appId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Center(child: Text('Sendbird Calls'))),
      body: Center(
          child: Column(
        children: [
          TextButton(
              onPressed: () {
                SendbirdPlatform.instance.authenticate(
                  userId: _userId,
                );
              },
              child: const Text('인증')),
          TextButton(
              onPressed: () {
                SendbirdPlatform.instance.call(callee: _callee);
              },
              child: const Text('걸기')),
          TextButton(
              onPressed: () {
                SendbirdPlatform.instance.receiveCall();
              },
              child: const Text('받기')),
          TextButton(
              onPressed: () {
                SendbirdPlatform.instance.endCall();
              },
              child: const Text('끊기'))
        ],
      )),
    );
  }
}
