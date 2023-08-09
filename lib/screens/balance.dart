import 'package:chat_test/res/assets/assets.gen.dart';
import 'package:chat_test/res/assets/colors.gen.dart';
import 'package:chat_test/theme/app_typography.dart';
import 'package:chat_test/widgets/app_button.dart';
import 'package:chat_test/widgets/text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BalanceScreen extends StatefulWidget {
  const BalanceScreen({super.key});

  @override
  State<BalanceScreen> createState() => _BalanceScreenState();
}

class _BalanceScreenState extends State<BalanceScreen>
    with InputValidationMixin {
  bool isChecked = false;
  final _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController numberCardController = TextEditingController();
  TextEditingController dateCardController = TextEditingController();
  TextEditingController cvvCardController = TextEditingController();
  TextEditingController balanceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorName.color10,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(77.0),
        child: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          centerTitle: true,
          title: Text(
            'Баланс',
            style: AppTypography.fregatBold20.copyWith(color: ColorName.color8),
          ),
          leading: InkWell(
              onTap: () {},
              child: const Icon(
                Icons.arrow_back,
                color: ColorName.color1,
                size: 30,
              )),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 15),
              child: Assets.icons.info.svg(),
            )
          ],
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(20),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 36),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Заполните информацию\nо вашей карте',
                    style: AppTypography.nunitoSemiBold18
                        .copyWith(color: ColorName.color8),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 27),
                Text(
                  'Имя Фамилия',
                  style: AppTypography.nunitoRegular12
                      .copyWith(color: ColorName.color8),
                ),
                const SizedBox(height: 12),
                TextFieldApp(
                  inputFormatter: [],
                  controller: nameController,
                  validate: (value) =>
                      isNotNull(value) ? 'Заполните поле' : null,
                  textInputType: TextInputType.text,
                ),
                const SizedBox(height: 12),
                Text(
                  'Номер карты',
                  style: AppTypography.nunitoRegular12
                      .copyWith(color: ColorName.color8),
                ),
                const SizedBox(height: 12),
                TextFieldApp(
                  inputFormatter: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(19),
                    CardNumberInputFormatter(),
                  ],
                  controller: numberCardController,
                  validate: (value) =>
                      isNotNull(value) ? 'Заполните поле' : null,
                  textInputType: TextInputType.number,
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 2 - 25,
                      child: TextFieldApp(
                        inputFormatter: [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(4),
                          CardMonthInputFormatter(),
                        ],
                        controller: dateCardController,
                        validate: (value) =>
                            isNotNull(value) ? 'Заполните поле' : null,
                        textInputType: TextInputType.number,
                      ),
                    ),
                    const SizedBox(width: 8),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 2 - 25,
                      child: TextFieldApp(
                        inputFormatter: [
                          LengthLimitingTextInputFormatter(3),
                        ],
                        controller: cvvCardController,
                        validate: (value) =>
                            isNotNull(value) ? 'Заполните поле' : null,
                        textInputType: TextInputType.number,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  'Сумма пополнения баланса',
                  style: AppTypography.nunitoRegular12
                      .copyWith(color: ColorName.color8),
                ),
                const SizedBox(height: 11),
                TextFieldApp(
                  inputFormatter: [],
                  controller: balanceController,
                  validate: (value) =>
                      isNotNull(value) ? 'Заполните поле' : null,
                  textInputType: TextInputType.number,
                ),
                const SizedBox(height: 22),
                Row(
                  children: [
                    SizedBox(
                      height: 21,
                      width: 21,
                      child: Checkbox(
                        checkColor: Colors.white,
                        //fillColor: MaterialStateProperty.resolveWith(getColor),
                        value: isChecked,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6)),
                        onChanged: (bool? value) {
                          setState(() {
                            isChecked = value!;
                          });
                        },
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      'Запомнить данные карты',
                      style: AppTypography.nunitoRegular16
                          .copyWith(color: ColorName.color8),
                    ),
                  ],
                ),
                const SizedBox(height: 64),
                SizedBox(
                  width: MediaQuery.of(context).size.width - 40,
                  child: AppButton(
                    text: 'Продолжить',
                    onPressed: () {
                      if (_formKey.currentState!.validate() && isChecked) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Processing Data')),
                        );
                      } else {
                        if (!_formKey.currentState!.validate() && !isChecked) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content:
                                    Text('Заполните поля и поставте галку')),
                          );
                        } else if (!_formKey.currentState!.validate()) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Заполните поля')));
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Поставь галку')));
                        }
                      }
                    },
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
