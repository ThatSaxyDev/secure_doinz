import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:secure_doinz/dialog_manager.dart';
import 'package:secure_doinz/providers/auth_providers.dart';

final navigatorKey = GlobalKey<NavigatorState>();

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 160, 156, 168)),
        useMaterial3: true,
      ),
      home: const Screen1(),
    );
  }
}

class Screen1 extends ConsumerWidget {
  const Screen1({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool isAuthLoading = ref.watch(authControllerProvider);
    return Scaffold(
      body: Center(
        child: isAuthLoading
            ? const SizedBox(
                height: 40,
                width: 40,
                child: CircularProgressIndicator(),
              )
            : ElevatedButton(
                onPressed: () {
                  ref.read(authControllerProvider.notifier).signUpUser(
                    sideEffect: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const Screen2(),
                      ));
                    },
                  );
                },
                child: const Text('Sign up'),
              ),
      ),
    );
  }
}

class Screen2 extends ConsumerWidget {
  const Screen2({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Center(
          child: ElevatedButton(
        onPressed: () {
          ref.read(authRepositoryProvider).apiCallANDPrintToken();
        },
        child: const Text('Print token'),
      )),
    );
  }
}
