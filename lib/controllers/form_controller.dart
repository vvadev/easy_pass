import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lerua_transport/controllers/pdf_controller.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class FormController extends GetxController {
  String carType = 'фура';
  TextEditingController phoneController = TextEditingController();
  String phone = '';
  TextEditingController surnameController = TextEditingController();
  String surname = '';
  TextEditingController carNumberController = TextEditingController();
  String carNumber = '';
  TextEditingController numPalletsController = TextEditingController();
  int numPallets = 0;
  String unloadintType = 'боковая';
  String appointedTime = 'не выбрано';
  TextEditingController appointedTimeController = TextEditingController();
  String date = 'не выбрано';
  TextEditingController dateController = TextEditingController();

  void generatePDF() async {
    PDFController pdfController = Get.put(PDFController());
    pw.Document pdf = await pdfController.generatePDF(carType, phone, surname,
        carNumber, numPallets, unloadintType, appointedTime, date);
    await sharePDF(pdf);
    clearForm();
  }

  Future<void> sharePDF(pw.Document pdf) async {
    await Printing.layoutPdf(
        onLayout: (PdfPageFormat format) async => pdf.save());
  }

  Future<void> selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      builder: (BuildContext context, Widget? child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: child!,
        );
      },
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      final now = DateTime.now();
      appointedTime = DateFormat('HH:mm').format(
          DateTime(now.year, now.month, now.day, picked.hour, picked.minute));

      update();
    }
  }

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      locale: const Locale('ru', 'RU'),
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2023),
      lastDate: DateTime(2024),
    );
    if (picked != null) {
      date = DateFormat('yyyy-MM-dd').format(picked).toString();
      update();
    }
  }

  void validateForm() {
    if (phone.isEmpty) {
      Get.snackbar(
        'Ошибка',
        'Введите номер телефона',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } else if (surname.isEmpty) {
      Get.snackbar(
        'Ошибка',
        'Введите фамилию',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } else if (carNumber.isEmpty) {
      Get.snackbar(
        'Ошибка',
        'Введите гос. номер',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } else if (numPallets == 0) {
      Get.snackbar(
        'Ошибка',
        'Введите количество паллет',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } else if (unloadintType.isEmpty) {
      Get.snackbar(
        'Ошибка',
        'Введите тип разгрузки',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } else if (appointedTime == 'не выбрано') {
      Get.snackbar(
        'Ошибка',
        'Выберите время',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } else if (date == 'не выбрано') {
      Get.snackbar(
        'Ошибка',
        'Выберите дату',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } else {
      generatePDF();
      Get.snackbar(
        'Успешно',
        'Форма отправлена',
        backgroundColor: Colors.green,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  void changeCarType(String value) {
    carType = value;
    update();
  }

  void changeTelephone(String value) {
    phone = value;
  }

  void changeSurname(String value) {
    surname = value;
  }

  void changeCarNumber(String value) {
    carNumber = value;
  }

  void changeNumPallets(int value) {
    numPallets = value;
  }

  void changeUnloadingType(String value) {
    unloadintType = value;
    update();
  }

  void changeAppointedTime(String value) {
    appointedTime = value;
    update();
  }

  void changeDate(String value) {
    date = value;
    update();
  }

  void clearForm() {
    carType = 'фура';
    phone = '';
    surname = '';
    carNumber = '';
    numPallets = 0;
    unloadintType = 'боковая';
    appointedTime = 'не выбрано';
    date = 'не выбрано';
    phoneController.clear();
    surnameController.clear();
    carNumberController.clear();
    numPalletsController.clear();
    dateController.clear();
    appointedTimeController.clear();
    update();
  }
}
