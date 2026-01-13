import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:todo_app/core/Extentions/responsive-extention.dart';

class BuildIllustration extends StatelessWidget {
  const BuildIllustration({super.key});

  @override
  Widget build(BuildContext context) {
  
    return SvgPicture.asset(
      'assets/images/Comfort zone-pana.svg',
      width: context.screenWidth * 0.6,
      height: context.isPortrait
          ? context.screenHeight * 0.27
          : context.screenHeight * 0.5,
    );
  }
}