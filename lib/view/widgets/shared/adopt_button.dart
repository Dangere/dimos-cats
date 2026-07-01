import 'package:dimos_cats/core/localization/generated/l10n/app_localizations.dart';
import 'package:dimos_cats/view/widgets/shared/bezier_curve.dart';
import 'package:dimos_cats/view/widgets/shared/blob_decoration.dart';
import 'package:flutter/material.dart';
import 'package:liquid_glass_easy/liquid_glass_easy.dart';

class AdoptButton extends StatelessWidget {
  const AdoptButton({super.key, required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 250,
      height: 70,
      child: LiquidGlassLens(
        style: LiquidGlassStyle(
          shape: LiquidGlassShape.squircle(
            cornerRadius: 44,
            lightIntensity: 1,
            borderWidth: 2,
            borderColor: Theme.of(
              context,
            ).colorScheme.primary.withValues(alpha: 0.5),
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
    );
  }
}
