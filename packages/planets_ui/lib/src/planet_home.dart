import 'package:flutter/material.dart';
import 'package:planets_ui/src/starry_backgroud.dart';
import 'package:planets_ui/util/colors.dart';
import 'package:planets_ui/util/dimens_extensio.dart';

class PlanetHomeLayout extends StatelessWidget {
  const PlanetHomeLayout({
    required this.deviceType,
    required this.onPressed,
    super.key,
  });
  final DeviceType deviceType;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    // Determina el tipo de dispositivo (móvil o tableta)
    final isMobile = deviceType == DeviceType.mobile;

    return Container(
      padding: context.all(0.01),
      decoration: const BoxDecoration(color: primaryBase),
      child: isMobile ? _buildMobileLayout(context) : _buildDesktopLayout(context),
    );
  }

  // Construye el layout para dispositivos móviles
  Widget _buildMobileLayout(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: _buildContent(context),
    );
  }

  // Construye el layout para dispositivos de escritorio
  Widget _buildDesktopLayout(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: _buildContent(context),
    );
  }

  // Construye las secciones de contenido (primera y segunda)
  List<Widget> _buildContent(BuildContext context) {
    return [
      _buildFirstSection(context),
      _buildSecondSection(context, onPressed),
    ];
  }

  // Construye la primera sección (saludo)
  Widget _buildFirstSection(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: secondaryBase,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Stack(
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _headingText(),
                  const SizedBox(height: 10),
                  buildSubheadingText(
                    context,
                    text: 'Aquí podrá encontrar contenido sobre planetas',
                  ),
                ],
              ),
            ),
            StarryBackground(
              height: context.height(),
              width: context.width(),
            ),
          ],
        ),
      ),
    );
  }

  // Construye la segunda sección (botón de inicio)
  Widget _buildSecondSection(BuildContext context, VoidCallback onPressed) {
    return Expanded(
      child: SizedBox(
        height: context.width(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Viaja por el espacio',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Inicia y ve la magia',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 30),
            _startButton(context, onPressed),
          ],
        ),
      ),
    );
  }

  // Botón de "Iniciar"
  Widget _startButton(BuildContext context, VoidCallback onPressed) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        margin: context.symmetric(.1, 0),
        padding: context.symmetric(0, .02),
        decoration: BoxDecoration(
          color: secondaryBase,
          borderRadius: BorderRadius.circular(10),
        ),
        child: const Center(
          child: Text(
            'Iniciar',
            style: TextStyle(
              color: primaryBase,
              fontSize: 25,
            ),
          ),
        ),
      ),
    );
  }

// Widget para el título "Hola!"
  Widget _headingText() {
    return const Text(
      'Hola!',
      style: TextStyle(
        fontSize: 60,
        color: primaryBase,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  /// Widget para el texto secundario
  Widget buildSubheadingText(BuildContext context, {required String text}) {
    final fontSize = context.deviceType == DeviceType.mobile ? 24.0 : 30.0; 
    final widthSize = context.deviceType == DeviceType.mobile ? 0.8 : 0.3; 

    return SizedBox(
      width: context.width(widthSize), 
      child: Text(
        text,
        style: TextStyle(
          fontSize: fontSize,
          color: primaryBase,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
