import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'views/screen/home/home.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then((_) => {
    runApp(const ProviderScope(child: BorcelleStore())),
  });
}
class BorcelleStore extends StatelessWidget {
  const BorcelleStore({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Home(),
      title: 'Borcelle Store',
      debugShowCheckedModeBanner: false,
    );
  }
}