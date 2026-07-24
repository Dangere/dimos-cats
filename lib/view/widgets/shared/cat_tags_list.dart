import 'package:dimos_cats/core/localization/generated/l10n/app_localizations.dart';
import 'package:dimos_cats/models/cat.dart';
import 'package:dimos_cats/models/enums/cat_tag.dart';
import 'package:flutter/material.dart';

class CatsTagList extends StatefulWidget {
  const CatsTagList({super.key, required this.cat, this.height});

  final double? height;

  final Cat cat;

  @override
  State<CatsTagList> createState() => _CatsTagListState();
}

class _CatsTagListState extends State<CatsTagList> {
  List<CatTag> tags = [];

  @override
  void initState() {
    tags = List.from(widget.cat.tags);

    if (widget.cat.medicalDescription != null) {
      tags.insert(0, CatTag.medicalAttention);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String getTagTitle(CatTag tag) {
      return switch (tag) {
        CatTag.big => AppLocalizations.of(context).tag_big,
        CatTag.fluffy => AppLocalizations.of(context).tag_fluffy,
        CatTag.moody => AppLocalizations.of(context).tag_moody,
        CatTag.cuddly => AppLocalizations.of(context).tag_cuddly,
        CatTag.bites => AppLocalizations.of(context).tag_bites,
        CatTag.neutered => AppLocalizations.of(context).tag_neutered,
        CatTag.medicalAttention => AppLocalizations.of(
          context,
        ).tag_medicalAttention,
        CatTag.friendly => AppLocalizations.of(context).tag_friendly,
        CatTag.playful => AppLocalizations.of(context).tag_playful,
        CatTag.shy => AppLocalizations.of(context).tag_shy,
        CatTag.lazy => AppLocalizations.of(context).tag_lazy,
        CatTag.active => AppLocalizations.of(context).tag_active,
        CatTag.goofy => AppLocalizations.of(context).tag_goofy,
        CatTag.sweet => AppLocalizations.of(context).tag_sweet,
        CatTag.caring => AppLocalizations.of(context).tag_caring,
        CatTag.loving => AppLocalizations.of(context).tag_loving,
        CatTag.talkative => AppLocalizations.of(context).tag_talkative,
        CatTag.social => AppLocalizations.of(context).tag_social,
        CatTag.lean => AppLocalizations.of(context).tag_lean,
        CatTag.deaf => AppLocalizations.of(context).tag_deaf,
        CatTag.anxious => AppLocalizations.of(context).tag_anxious,
        CatTag.small => AppLocalizations.of(context).tag_small,
      };
    }

    String getYearsAndMonths() {
      var years = DateTime.now().year - widget.cat.birthday!.year;
      var months = DateTime.now().month - widget.cat.birthday!.month;

      if (years > 0)
        return years.toString() + " " + AppLocalizations.of(context).tag_years;
      else
        return months.toString() +
            " " +
            AppLocalizations.of(context).tag_months;
    }

    final isLTR = Directionality.of(context) == TextDirection.ltr;

    return Container(
      height: widget.height,
      alignment: isLTR ? Alignment.topLeft : Alignment.topRight,

      child: Wrap(
        spacing: 8.0,
        runSpacing: 8.0,
        clipBehavior: Clip.hardEdge,
        children:
            tags.map((tag) {
                if (tag == CatTag.medicalAttention) {
                  return _Tag(
                    text: getTagTitle(tag),
                    color: Colors.red.shade400,
                  );
                }

                return _Tag(text: getTagTitle(tag), color: null);
              }).toList()
              ..insert(
                0,
                _Tag(text: getYearsAndMonths(), color: Colors.yellow.shade900),
              )
              ..insert(
                0,
                _Tag(
                  text: widget.cat.male
                      ? AppLocalizations.of(context).tag_male
                      : AppLocalizations.of(context).tag_female,
                  color: widget.cat.male
                      ? Colors.blue.shade300
                      : Colors.pink.shade300,
                ),
              ),
      ),
    );
  }
}

class _Tag extends StatelessWidget {
  const _Tag({this.color, required this.text});

  final Color? color;
  final String text;

  @override
  Widget build(BuildContext context) {
    Color textColor = Theme.of(context).colorScheme.onPrimary;

    return Container(
      // height: height,
      padding: const EdgeInsets.symmetric(horizontal: 10.0),

      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(40),
        color: color ?? Theme.of(context).colorScheme.primary,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5.0),
        child: Text(
          text,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(color: textColor, fontSize: 14, height: 1.5),
        ),
      ),
    );
  }
}
