import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lerua_transport/controllers/pdf_controller.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PDFController>(
        init: PDFController(),
        builder: (controller) {
          return Scaffold(
              appBar: AppBar(
                title: const Text('Настройки'),
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  controller.savePDFSettings();
                },
                child: const Icon(Icons.save),
              ),
              body: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          child: Column(
                            children: [
                              Container(
                                child: Column(
                                  children: [
                                    Slider(
                                      value: controller.formWidth,
                                      min: 50,
                                      max: 500,
                                      divisions: 100,
                                      label: controller.formWidth.toString(),
                                      onChanged: (double value) {
                                        controller.changeFormWidth(value);
                                      },
                                    ),
                                    Row(
                                      children: [
                                        Text('Размер шрифта',
                                            style: GoogleFonts.getFont(
                                                'Montserrat',
                                                fontSize: 18)),
                                        const Spacer(),
                                        DropdownButton(
                                            value: controller.fontSize,
                                            items: [
                                              DropdownMenuItem(
                                                value: 10,
                                                child: Text('10',
                                                    style: GoogleFonts.getFont(
                                                        'Montserrat',
                                                        fontSize: 18)),
                                              ),
                                              DropdownMenuItem(
                                                value: 12,
                                                child: Text('12',
                                                    style: GoogleFonts.getFont(
                                                        'Montserrat',
                                                        fontSize: 18)),
                                              ),
                                              DropdownMenuItem(
                                                value: 14,
                                                child: Text('14',
                                                    style: GoogleFonts.getFont(
                                                        'Montserrat',
                                                        fontSize: 18)),
                                              ),
                                              DropdownMenuItem(
                                                value: 16,
                                                child: Text('16',
                                                    style: GoogleFonts.getFont(
                                                        'Montserrat',
                                                        fontSize: 18)),
                                              ),
                                              DropdownMenuItem(
                                                value: 18,
                                                child: Text('18',
                                                    style: GoogleFonts.getFont(
                                                        'Montserrat',
                                                        fontSize: 18)),
                                              ),
                                              DropdownMenuItem(
                                                value: 20,
                                                child: Text('20',
                                                    style: GoogleFonts.getFont(
                                                        'Montserrat',
                                                        fontSize: 18)),
                                              ),
                                              DropdownMenuItem(
                                                value: 22,
                                                child: Text('22',
                                                    style: GoogleFonts.getFont(
                                                        'Montserrat',
                                                        fontSize: 18)),
                                              ),
                                              DropdownMenuItem(
                                                value: 24,
                                                child: Text('24',
                                                    style: GoogleFonts.getFont(
                                                        'Montserrat',
                                                        fontSize: 18)),
                                              ),
                                              DropdownMenuItem(
                                                value: 26,
                                                child: Text('26',
                                                    style: GoogleFonts.getFont(
                                                        'Montserrat',
                                                        fontSize: 18)),
                                              ),
                                              DropdownMenuItem(
                                                value: 28,
                                                child: Text('28',
                                                    style: GoogleFonts.getFont(
                                                        'Montserrat',
                                                        fontSize: 18)),
                                              ),
                                              DropdownMenuItem(
                                                value: 30,
                                                child: Text('30',
                                                    style: GoogleFonts.getFont(
                                                        'Montserrat',
                                                        fontSize: 18)),
                                              ),
                                            ],
                                            onChanged: (num? value) {
                                              controller.changeFontSize(
                                                  value!.toDouble());
                                            }),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Row(
                                children: [
                                  Text(
                                    'Формат листа',
                                    style: GoogleFonts.getFont('Montserrat',
                                        fontSize: 18),
                                  ),
                                  const Spacer(),
                                  DropdownButton(
                                      value: controller.pageFormat,
                                      items: [
                                        DropdownMenuItem(
                                          value: PdfPageFormat.a4,
                                          child: Text('A4',
                                              style: GoogleFonts.getFont(
                                                  'Montserrat',
                                                  fontSize: 18)),
                                        ),
                                        DropdownMenuItem(
                                          value: PdfPageFormat.a5,
                                          child: Text('A5',
                                              style: GoogleFonts.getFont(
                                                  'Montserrat',
                                                  fontSize: 18)),
                                        ),
                                        DropdownMenuItem(
                                          value: PdfPageFormat.a6,
                                          child: Text('A6',
                                              style: GoogleFonts.getFont(
                                                  'Montserrat',
                                                  fontSize: 18)),
                                        ),
                                      ],
                                      onChanged: (PdfPageFormat? value) {
                                        controller.changePageFormat(value!);
                                      }),
                                ],
                              ),
                              Container(
                                height: 500,
                                child: PdfPreview(
                                  useActions: false,
                                  initialPageFormat: controller.pageFormat,
                                  maxPageWidth:
                                      MediaQuery.of(context).size.width,
                                  build: (format) => controller
                                      .generatePDF(
                                        'Фура',
                                        '+71234567890',
                                        'Петров Петр',
                                        'А123БВ45',
                                        1,
                                        'Боковая',
                                        '00:00',
                                        '2023-01-01',
                                      )
                                      .then((value) => value.save()),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  )));
        });
  }
}
