import 'package:provider/provider.dart';
import 'package:terminal_bimodal/src/components/app_large_text.dart';
import 'package:terminal_bimodal/src/components/app_text.dart';
import 'package:terminal_bimodal/src/components/responsive_button.dart';
import 'package:flutter/material.dart';
import 'package:terminal_bimodal/src/screens/home/dashboard.dart';
import 'package:terminal_bimodal/src/screens/navigation/nav_bar2.dart';

import '../auth/auth.dart';

class WelcomePage extends StatefulWidget {
  WelcomePage({Key? key}) : super(key: key);

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  List images = [
    'portada1.png',
    'portada2.png',
    'portada3.png',
  ];
  List largeTexts = [
    'Bienvenido a la T. Bimodal',
    'Sistema Móvil Oficial',
    'Logueate Administrador'
  ];
  List texts = [
    'Santa Cruz de la Sierra',
    'Developed by Solution',
    'Solo personal autorizado'
  ];
  List smallTexts = [
    'Horarios de 6:00 a 18:00 Horas de Lunes a Viernes. Salidas a prov.y dptos.',
    'All Rights reserved @2022',
    'Si eres administrador o encargado de controlar el Sistema, logeate aquí para acceder.'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
          scrollDirection: Axis.vertical,
          itemCount: images.length,
          itemBuilder: (context, index) {
            return Container(
              width: double.maxFinite,
              height: double.maxFinite,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    "img/" + images[index],
                  ),
                  alignment: Alignment.bottomCenter,
                  fit: BoxFit.contain,
                ),
              ),
              child: Container(
                margin: const EdgeInsets.only(top: 100, left: 20, right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppLargeText(text: largeTexts[index]),
                        AppText(text: texts[index], size: 30),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          width: 250,
                          child: AppText(
                            text: smallTexts[index],
                            color: Color(0xFF878593),
                            size: 14,
                          ),
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        ResponsiveButton(
                          width: 120,
                        ),
                      ],
                    ),
                    Column(
                      children: List.generate(3, (indexDots) {
                        return Container(
                          margin: const EdgeInsets.only(bottom: 2),
                          width: 8,
                          height: index == indexDots ? 25 : 8,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: index == indexDots
                                ? Colors.green[800]
                                : Colors.green[800]?.withOpacity(0.3),
                          ),
                        );
                      }),
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
