import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:wrote_guess/logic/logic_data.dart';
import 'package:wrote_guess/pages/page_guess.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); //#hive
  await Hive.initFlutter(); //#hive
  await Hive.openBox('hive_cobasoal'); //#hive

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => OdataListKata()),
        ],
        child: MaterialApp(
          title: 'Kado Untukmu',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
              fontFamily: 'Poppins',
              useMaterial3: true,
              colorScheme: ColorScheme.fromSeed(
                      seedColor: const Color.fromARGB(255, 255, 223, 41))
                  .copyWith(background: Colors.grey[100]),
              appBarTheme: AppBarTheme(backgroundColor: Colors.grey[100])),
          home: const PageGuess(),
        ));
  }
}
