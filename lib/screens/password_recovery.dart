import 'package:chat_test/res/assets/colors.gen.dart';
import 'package:chat_test/theme/app_typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PasswordRecoveryScreen extends StatefulWidget {
  const PasswordRecoveryScreen({super.key});

  @override
  State<PasswordRecoveryScreen> createState() => _PasswordRecoveryScreenState();
}

class _PasswordRecoveryScreenState extends State<PasswordRecoveryScreen> {
  final _codeController = TextEditingController();
  final _codeFocus = FocusNode();

  String _code = '';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xffF6F5FF),
          elevation: 0,
          leading: InkWell(
              onTap: () {},
              child: const Icon(
                Icons.arrow_back,
                color: ColorName.color1,
                size: 30,
              )),
        ),
        backgroundColor: const Color(0xffF6F5FF),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 15),
              Text(
                'Мы отправили вам\nСМС код',
                style: AppTypography.fregatBold20
                    .copyWith(color: ColorName.color8),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              Container(
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20)),
                    color: ColorName.white),
                child: Column(
                  children: [
                    const SizedBox(height: 32),
                    RichText(
                      text: TextSpan(
                        text: 'На номер: ',
                        style: AppTypography.nunitoRegular18
                            .copyWith(color: ColorName.color2),
                        children: <TextSpan>[
                          TextSpan(
                            text: '+7 917 999-99-99',
                            style: AppTypography.nunitoRegular18
                                .copyWith(color: ColorName.color7),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 32),
                    Column(
                      children: [
                        Stack(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: List.generate(
                                4,
                                (index) {
                                  String text = '';
                                  if (_code.length > index) {
                                    text = _code[index];
                                  }
                                  return Container(
                                    alignment: Alignment.center,
                                    width: 70,
                                    height: 76,
                                    decoration: BoxDecoration(
                                      color: text.isEmpty
                                          ? const Color(0xffF7F7F7)
                                          : const Color(0xffE2FFE3),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Text(
                                      text,
                                      style: AppTypography.nunitoBold29
                                          .copyWith(color: ColorName.color8),
                                    ),
                                  );
                                },
                              ),
                            ),
                            Visibility(
                              visible: false,
                              maintainState: true,
                              maintainAnimation: true,
                              maintainSize: true,
                              maintainInteractivity: true,
                              child: TextField(
                                controller: _codeController,
                                focusNode: _codeFocus,
                                keyboardType: TextInputType.number,
                                maxLength: 4,
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                ),
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(
                                      RegExp(r'^[0-9]+$')),
                                ],
                                onChanged: (val) {
                                  setState(() {
                                    _code = val;
                                  });

                                  if (val.length == 4) {
                                    _codeFocus.unfocus();
                                  }
                                  print(_code);
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 32),
                    Text(
                      'Повторная отправка будет возможна\nчерез: 56 секунд',
                      style: AppTypography.nunitoRegular18
                          .copyWith(color: ColorName.color8),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 32),
                    Column(
                      children: [
                        Row(
                          children: [
                            _buildButton('1'),
                            _buildButton('2'),
                            _buildButton('3'),
                          ],
                        ),
                        const SizedBox(height: 30),
                        Row(
                          children: [
                            _buildButton('4'),
                            _buildButton('5'),
                            _buildButton('6'),
                          ],
                        ),
                        const SizedBox(height: 30),
                        Row(
                          children: [
                            _buildButton('7'),
                            _buildButton('8'),
                            _buildButton('9'),
                          ],
                        ),
                        const SizedBox(height: 30),
                        Row(
                          children: [
                            _buildButton('', onPressed: null),
                            _buildButton('0'),
                            _codeController.text.isNotEmpty
                                ? _buildButton('⌫', onPressed: _backspace)
                                : _buildButton('', onPressed: null),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildButton(String text, {VoidCallback? onPressed}) {
    return Expanded(
      child: TextButton(
        onPressed: onPressed ?? () => _input(text),
        child: Text(
          text,
          style: AppTypography.nunitoBold29.copyWith(color: ColorName.color8),
        ),
      ),
    );
  }

  _input(text) {
    if (_codeController.text.length < 4) {
      setState(() {
        _codeController.text = _codeController.text + text;
        _code = _codeController.text;
      });
    }
  }

  _backspace() {
    if (_codeController.text.isNotEmpty) {
      setState(() {
        _codeController.text =
            _codeController.text.substring(0, _codeController.text.length - 1);
        _code = _codeController.text;
      });
    }
  }
}
