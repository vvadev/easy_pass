import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lerua_transport/controllers/form_controller.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';

class FormWidget extends StatelessWidget {
  const FormWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FormController>(
      init: FormController(),
      builder: (controller) {
        return ListView(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Тип машины:',
                  style: GoogleFonts.getFont('Montserrat', fontSize: 18),
                ),
                DropdownButton(
                  value: controller.carType,
                  items: [
                    DropdownMenuItem(
                      value: 'фура',
                      child: Text('Фура',
                          style: GoogleFonts.getFont('Montserrat')),
                    ),
                    DropdownMenuItem(
                      value: 'газель',
                      child: Text('Газель',
                          style: GoogleFonts.getFont('Montserrat')),
                    ),
                    DropdownMenuItem(
                      value: 'пятитонник',
                      child: Text('Пятитонник',
                          style: GoogleFonts.getFont('Montserrat')),
                    ),
                  ],
                  onChanged: (value) {
                    controller.changeCarType(value.toString());
                  },
                ),
              ],
            ),
            TextField(
              controller: controller.phoneController,
              decoration: InputDecoration(
                labelText: 'Телефон',
                labelStyle: GoogleFonts.getFont('Montserrat'),
              ),
              style: GoogleFonts.getFont('Montserrat'),
              keyboardType: TextInputType.phone,
              inputFormatters: [
                PhoneInputFormatter(
                  allowEndlessPhone: false,
                )
              ],
              onChanged: (value) {
                controller.changeTelephone(value);
              },
              textInputAction: TextInputAction.next,
            ),
            TextField(
              decoration: InputDecoration(
                labelText: 'ФИО',
                labelStyle: GoogleFonts.getFont('Montserrat'),
              ),
              style: GoogleFonts.getFont('Montserrat'),
              controller: controller.surnameController,
              onChanged: (value) {
                controller.changeSurname(value);
              },
              textInputAction: TextInputAction.next,
            ),
            TextField(
              controller: controller.carNumberController,
              decoration: InputDecoration(
                labelText: 'Гос. номер',
                labelStyle: GoogleFonts.getFont('Montserrat'),
              ),
              style: GoogleFonts.getFont('Montserrat'),
              onChanged: (value) {
                controller.changeCarNumber(value);
              },
              textInputAction: TextInputAction.next,
            ),
            TextField(
              decoration: InputDecoration(
                labelText: 'Кол-во паллет',
                labelStyle: GoogleFonts.getFont('Montserrat'),
              ),
              style: GoogleFonts.getFont('Montserrat'),
              controller: controller.numPalletsController,
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                FilteringTextInputFormatter.digitsOnly
              ],
              onChanged: (value) {
                try {
                  controller.changeNumPallets(int.parse(value));
                } catch (e) {
                  controller.changeNumPallets(0);
                }
              },
            ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Способ разгрузки:',
                  style: GoogleFonts.getFont('Montserrat', fontSize: 18),
                ),
                DropdownButton(
                  value: controller.unloadintType,
                  items: [
                    DropdownMenuItem(
                      value: 'боковая',
                      child: Text(
                        'Боковая',
                        style: GoogleFonts.getFont('Montserrat'),
                      ),
                    ),
                    DropdownMenuItem(
                      value: 'задняя',
                      child: Text(
                        'Задняя',
                        style: GoogleFonts.getFont('Montserrat'),
                      ),
                    ),
                  ],
                  onChanged: (value) {
                    FocusManager.instance.primaryFocus?.unfocus();
                    controller.changeUnloadingType(value.toString());
                  },
                ),
              ],
            ),
            // Row(
            //   children: [
            //     Text(
            //       'Время: ${controller.appointedTime}',
            //       style: GoogleFonts.getFont('Montserrat', fontSize: 18),
            //     ),
            //     const Spacer(),
            //     ElevatedButton(
            //       onPressed: () {
            //         FocusManager.instance.primaryFocus?.unfocus();
            //         controller.selectTime(context);
            //       },
            //       child: const Icon(Icons.edit),
            //     ),
            //   ],
            // ),
            TextField(
              decoration: InputDecoration(
                labelText: 'Время',
                labelStyle: GoogleFonts.getFont('Montserrat'),
              ),
              style: GoogleFonts.getFont('Montserrat'),
              controller: controller.appointedTimeController,
              keyboardType: TextInputType.number,
              inputFormatters: [
                MaskedInputFormatter(
                  '##:##',
                  allowedCharMatcher: RegExp(r'[0-9]'),
                ),
              ],
              onChanged: (value) {
                try {
                  controller.changeAppointedTime(value);
                } catch (e) {
                  controller.changeAppointedTime('Не выбрано');
                }
              },
            ),
            const SizedBox(height: 10),
            // Row(
            //   children: [
            //     Text(
            //       'Дата: ${controller.date}',
            //       style: GoogleFonts.getFont('Montserrat', fontSize: 18),
            //     ),
            //     const Spacer(),
            //     ElevatedButton(
            //       onPressed: () {
            //         FocusManager.instance.primaryFocus?.unfocus();
            //         controller.selectDate(context);
            //       },
            //       child: const Icon(Icons.edit),
            //     ),
            //   ],
            // ),
            TextField(
              decoration: InputDecoration(
                labelText: 'Дата',
                labelStyle: GoogleFonts.getFont('Montserrat'),
              ),
              style: GoogleFonts.getFont('Montserrat'),
              controller: controller.dateController,
              keyboardType: TextInputType.number,
              inputFormatters: [
                MaskedInputFormatter(
                  '##.##.####',
                  allowedCharMatcher: RegExp(r'[0-9]'),
                ),
              ],
              onChanged: (value) {
                try {
                  controller.changeDate(value);
                } catch (e) {
                  controller.changeDate('Не выбрано');
                }
              },
            ),
          ],
        );
      },
    );
  }
}
