import 'package:chat_test/features/get_fate/presentation/bloc/fate_bloc.dart';
import 'package:chat_test/res/assets/colors.gen.dart';
import 'package:chat_test/screens/fate_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'injection_container.dart' as di;
import 'injection_container.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => sl<FateBloc>(),
        ),
      ],
      child: MaterialApp(
        theme: ThemeData(
            primaryColor: ColorName.color7,
            buttonTheme: const ButtonThemeData(buttonColor: ColorName.color7)),
        debugShowCheckedModeBanner: false,
        home: const FateScreen(),
      ),
    );
  }
}
