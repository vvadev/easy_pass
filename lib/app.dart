import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lerua_transport/controllers/app_controller.dart';
import 'package:lerua_transport/controllers/form_controller.dart';
import 'package:lerua_transport/widgets/form_widget.dart';
import 'package:url_launcher/url_launcher.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  Future<void> _launchTelegramUrl() async {
    if (!await launchUrl(Uri.parse('https://vk.com/vvadev'))) {
      throw Exception('Could not launch https://vk.com/vvadev');
    }
  }

  @override
  Widget build(BuildContext context) {
    FormController formController = Get.put(FormController());

    return GetBuilder<AppController>(
        init: AppController(),
        builder: (controller) {
          return Scaffold(
            // floatingActionButton: FloatingActionButton(
            //   onPressed: () {
            //     formController.validateForm();
            //   },
            //   child: const Icon(Icons.save),
            // ),
            appBar: AppBar(
              actions: [
                IconButton(
                  onPressed: () {
                    Get.toNamed('/settings');
                  },
                  icon: const Icon(Icons.settings),
                ),
                IconButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text('О программе',
                                style: GoogleFonts.getFont('Montserrat')),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                    'Версия: BETA ${controller.appVersion}\nАвтор: VVA Dev',
                                    style: GoogleFonts.getFont('Montserrat')),
                                const SizedBox(height: 8),
                                Text(
                                    'Использование программы в коммерческих целях без разрешения разработчика строго запрещено!',
                                    style: GoogleFonts.getFont('Montserrat',
                                        fontSize: 12)),
                              ],
                            ),
                            actions: [
                              IconButton(
                                onPressed: () {
                                  _launchTelegramUrl();
                                },
                                icon: const Icon(Icons.mail),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text('Закрыть',
                                    style: GoogleFonts.getFont('Montserrat')),
                              ),
                            ],
                          );
                        });
                  },
                  icon: const Icon(Icons.info),
                ),
              ],
              title: RichText(
                text: TextSpan(
                    text: 'Easy Pass',
                    style: GoogleFonts.getFont('Comfortaa',
                        color: const Color.fromARGB(255, 42, 99, 44),
                        fontSize: 21),
                    children: [
                      TextSpan(
                        text: ' by VVA Dev',
                        style: GoogleFonts.getFont('Comfortaa', fontSize: 12),
                      ),
                    ]),
              ),
            ),
            body: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Text('Введите данные',
                        style: GoogleFonts.getFont('Montserrat', fontSize: 24)),
                    const FormWidget(),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        formController.validateForm();
                      },
                      child: const Text(
                        'Печатать',
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
