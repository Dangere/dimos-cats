import 'package:dimos_cats/core/localization/generated/l10n/app_localizations.dart';
import 'package:dimos_cats/view/widgets/shared/bezier_curve.dart';
import 'package:dimos_cats/view/widgets/shared/blob_decoration.dart';
import 'package:flutter/material.dart';
import 'package:liquid_glass_easy/liquid_glass_easy.dart';

class AdoptButton extends StatelessWidget {
  const AdoptButton({
    super.key,
    required this.backgroundToReflect,
    required this.onTap,
  });

  final VoidCallback onTap;

  final Widget backgroundToReflect;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 250,
      height: 70,
      child: LiquidGlassView(
        backgroundWidget: Stack(
          alignment: Alignment.center,
          clipBehavior: Clip.none,
          children: [
            // Positioned(
            //   child: SizedBox(
            //     height: 400,
            //     width: 400,
            //     child: Container(color: Colors.red),
            //   ),
            // ),
            Positioned(
              // bottom: -20,
              left: -20,
              right: -20,
              child: SizedBox(
                child: Container(
                  height: 100,
                  width: 300,
                  color: Theme.of(context).colorScheme.surface,
                  // child: Icon(Icons.abc),
                ),
              ),
            ),
            Positioned(
              child: BezierCurve(
                normalizedPoints: [
                  Offset(-0.6, 0.3),
                  Offset(-0.2, 0.6),

                  // Offset(-0.2, 0.8),
                  Offset(0.1, 0.3),

                  // Offset(0.6, 0.2),
                  Offset(0.8, 1.05),
                  // Offset(1, 1),
                  Offset(1.2, 0.8),
                ],
                t: 1,
                size: Size(MediaQuery.of(context).size.width, 700),
              ),
            ),
            // Positioned(
            //   bottom: -20,
            //   right: 200,

            //   child: SizedBox(height: 100, child: BlobDecoration()),
            // ),
          ],
        ),
        child: LiquidGlassLens(
          style: LiquidGlassStyle(
            shape: LiquidGlassShape.squircle(
              cornerRadius: 44,
              lightIntensity: 1,
              // lightColor: Theme.of(context).colorScheme.primary,
            ),
            refraction: LiquidGlassRefraction(
              distortion: 0.5,
              distortionWidth: 30,
              chromaticAberration: 0.03,
              magnification: 0.9,
            ),
          ),
          child: Center(
            child: Text(
              AppLocalizations.of(context).adopt,
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
