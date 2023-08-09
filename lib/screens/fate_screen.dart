import 'package:chat_test/features/get_fate/presentation/bloc/fate_bloc.dart';
import 'package:chat_test/res/assets/colors.gen.dart';
import 'package:chat_test/screens/home_screen.dart';
import 'package:chat_test/theme/app_typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FateScreen extends StatefulWidget {
  const FateScreen({super.key});

  @override
  State<FateScreen> createState() => _FateScreenState();
}

class _FateScreenState extends State<FateScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorName.white,
        appBar: AppBar(
          backgroundColor: ColorName.white,
          elevation: 0,
          title: Text(
            'Задай вопрос',
            style: AppTypography.gilroySemiBold25
                .copyWith(color: ColorName.color1),
          ),
          centerTitle: true,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              BlocBuilder<FateBloc, FateState>(
                builder: (context, state) {
                  if (state is EmptyState) {
                    return const Text('Нажми на кнопку');
                  } else if (state is LoadingState) {
                    return const CircularProgressIndicator();
                  } else if (state is LoadedState) {
                    return Text(
                      state.fate.text,
                      style: AppTypography.gilroyMedium16
                          .copyWith(color: ColorName.color1),
                    );
                  } else if (state is ErrorState) {
                    return Text(state.message);
                  }
                  return Container();
                },
              ),
              const SizedBox(height: 15),
              ElevatedButton(
                onPressed: () {
                  BlocProvider.of<FateBloc>(context).add(GetFateEvent());
                },
                child: Text('Узнать предсказание',
                    style: AppTypography.nunitoSemiBold18),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const BottomNavigationBarExample()));
                },
                child: Text('Следующий экран',
                    style: AppTypography.nunitoSemiBold18),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
