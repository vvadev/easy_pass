import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PDFController extends GetxController {
  @override
  void onInit() {
    loadPDFSettings();
    super.onInit();
  }

  double formWidth = 50;
  double fontSize = 12;
  PdfPageFormat pageFormat = PdfPageFormat.a6;

  void changePageFormat(PdfPageFormat format) {
    pageFormat = format;
    print(pageFormat);
    update();
  }

  void changeFormWidth(double width) {
    formWidth = width;
    update();
  }

  void changeFontSize(double size) {
    fontSize = size;
    update();
  }

  Future<void> savePDFSettings() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setDouble('formWidth', formWidth);
    prefs.setDouble('fontSize', fontSize);
    String format = '';
    if (pageFormat == PdfPageFormat.a6) {
      format = 'a6';
    } else if (pageFormat == PdfPageFormat.a5) {
      format = 'a5';
    } else if (pageFormat == PdfPageFormat.a4) {
      format = 'a4';
    } else {
      format = 'a4';
    }
    print(format);
    prefs.setString('pageFormat', format);

    Get.snackbar(
      'Успешно',
      'Настройки сохранены',
      backgroundColor: Colors.green,
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  Future<void> loadPDFSettings() async {
    final prefs = await SharedPreferences.getInstance();
    formWidth = prefs.getDouble('formWidth') ?? 50;
    fontSize = prefs.getDouble('fontSize') ?? 12;
    final format = prefs.getString('pageFormat') ?? 'a6';
    print(format);
    if (format == 'a6') {
      pageFormat = PdfPageFormat.a6;
    } else if (format == 'a5') {
      pageFormat = PdfPageFormat.a5;
    } else if (format == 'a4') {
      pageFormat = PdfPageFormat.a4;
    } else {
      pageFormat = PdfPageFormat.a4;
    }
    update();
  }

  Future<pw.Document> generatePDF(
    String carType,
    String phone,
    String surname,
    String carNumber,
    int numPallets,
    String unloadintType,
    String appointedTime,
    String date,
  ) async {
    final pdf = pw.Document();

    var font = await fontFromAssetBundle('assets/font/Montserrat-Light.ttf');
    pdf.addPage(
      pw.Page(
        pageTheme: pw.PageTheme(
          margin:
              const pw.EdgeInsets.only(top: 5, bottom: 5, left: 20, right: 20),
          pageFormat: pageFormat,
        ),
        build: (pw.Context context) {
          const drawerHeight = 8.0;
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            mainAxisAlignment: pw.MainAxisAlignment.start,
            children: [
              pw.Container(
                width: formWidth.toDouble(),
                decoration: pw.BoxDecoration(
                  border: pw.Border.all(
                    color: PdfColors.black,
                    width: 1,
                  ),
                ),
                padding: const pw.EdgeInsets.all(5),
                child: pw.Column(
                  mainAxisSize: pw.MainAxisSize.min,
                  mainAxisAlignment: pw.MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text(
                      'Тип транспорта: $carType',
                      style: pw.TextStyle(font: font, fontSize: fontSize),
                    ),
                    pw.Divider(height: drawerHeight),
                    pw.Text(
                      'Номер телефона: $phone',
                      style: pw.TextStyle(font: font, fontSize: fontSize),
                    ),
                    pw.Divider(height: drawerHeight),
                    pw.Text(
                      'ФИО: $surname',
                      style: pw.TextStyle(font: font, fontSize: fontSize),
                    ),
                    pw.Divider(height: drawerHeight),
                    pw.Text(
                      'Гос. номер: $carNumber',
                      style: pw.TextStyle(font: font, fontSize: fontSize),
                    ),
                    pw.Divider(height: drawerHeight),
                    pw.Text(
                      'Количество паллет: $numPallets',
                      style: pw.TextStyle(font: font, fontSize: fontSize),
                    ),
                    pw.Divider(height: drawerHeight),
                    pw.Text(
                      'Тип разгрузки: $unloadintType',
                      style: pw.TextStyle(font: font, fontSize: fontSize),
                    ),
                    pw.Divider(height: drawerHeight),
                    pw.Text(
                      'Назначенное время: $appointedTime',
                      style: pw.TextStyle(font: font, fontSize: fontSize),
                    ),
                    pw.Divider(height: drawerHeight),
                    pw.Text(
                      'Дата: $date',
                      style: pw.TextStyle(font: font, fontSize: fontSize),
                    ),
                  ],
                ),
              ),
              pw.SizedBox(height: 10),
              pw.Container(
                width: formWidth.toDouble(),
                decoration: pw.BoxDecoration(
                  border: pw.Border.all(
                    color: PdfColors.black,
                    width: 1,
                  ),
                ),
                padding: const pw.EdgeInsets.all(5),
                child: pw.Column(
                  mainAxisSize: pw.MainAxisSize.min,
                  mainAxisAlignment: pw.MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text(
                      'Тип транспорта: $carType',
                      style: pw.TextStyle(font: font, fontSize: fontSize),
                    ),
                    pw.Divider(height: drawerHeight),
                    pw.Text(
                      'Номер телефона: $phone',
                      style: pw.TextStyle(font: font, fontSize: fontSize),
                    ),
                    pw.Divider(height: drawerHeight),
                    pw.Text(
                      'ФИО: $surname',
                      style: pw.TextStyle(font: font, fontSize: fontSize),
                    ),
                    pw.Divider(height: drawerHeight),
                    pw.Text(
                      'Гос. номер: $carNumber',
                      style: pw.TextStyle(font: font, fontSize: fontSize),
                    ),
                    pw.Divider(height: drawerHeight),
                    pw.Text(
                      'Количество паллет: $numPallets',
                      style: pw.TextStyle(font: font, fontSize: fontSize),
                    ),
                    pw.Divider(height: drawerHeight),
                    pw.Text(
                      'Тип разгрузки: $unloadintType',
                      style: pw.TextStyle(font: font, fontSize: fontSize),
                    ),
                    pw.Divider(height: drawerHeight),
                    pw.Text(
                      'Назначенное время: $appointedTime',
                      style: pw.TextStyle(font: font, fontSize: fontSize),
                    ),
                    pw.Divider(height: drawerHeight),
                    pw.Text(
                      'Дата: $date',
                      style: pw.TextStyle(font: font, fontSize: fontSize),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );

    return pdf;
  }
}
