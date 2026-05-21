import 'package:albertoguaman/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

import '../utils/utils.dart';

class AboutProfileContent extends StatefulWidget {
  const AboutProfileContent({
    super.key,
    this.textAlign = TextAlign.start,
    this.fontWeight = FontWeight.normal,
    this.descriptionBold = false,
  });

  final TextAlign textAlign;
  final FontWeight fontWeight;
  final bool descriptionBold;

  @override
  State<AboutProfileContent> createState() => _AboutProfileContentState();
}

class _AboutProfileContentState extends State<AboutProfileContent> {
  bool _aboutProfileDevelopment = true;

  Widget _buildSwitch(AppLocalizations al) {
    Widget option(String label, bool selected, VoidCallback onTap) {
      return Expanded(
        child: Padding(
          padding: EdgeInsets.all(SizeUtils.s),
          child: InkWell(
            hoverColor: Colors.transparent,
            onTap: onTap,
            borderRadius: BorderRadius.circular(SizeUtils.m),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeInOut,
              decoration: BoxDecoration(
                color: selected
                    ? UtilsColor.colorSecondaryWhite
                    : Colors.transparent,
                border: Border.all(
                  color: selected
                      ? Colors.black
                      : UtilsColor.colorSecondaryWhite,
                ),
                borderRadius: BorderRadius.circular(SizeUtils.m),
              ),
              child: Padding(
                padding: EdgeInsets.all(SizeUtils.s),
                child: Text(
                  label.toUpperCase(),
                  textAlign: TextAlign.center,
                  style: StyleText.textPortfolio(
                    fontSize: SizeUtils.s1,
                    fontWeight: FontWeight.w500,
                    color: selected
                        ? UtilsColor.colorPrimaryDark
                        : UtilsColor.colorSecondaryWhite,
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    }

    return Row(
      children: [
        option(al.aboutProfileDevelopment, _aboutProfileDevelopment, () {
          if (!_aboutProfileDevelopment) {
            setState(() => _aboutProfileDevelopment = true);
          }
        }),
        option(al.aboutProfileAdvisor, !_aboutProfileDevelopment, () {
          if (_aboutProfileDevelopment) {
            setState(() => _aboutProfileDevelopment = false);
          }
        }),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final al = AppLocalizations.of(context)!;
    final descriptionSize =
        TextStyleSize.textDescriptionSize(context.screenWidth);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildSwitch(al),
        SizedBox(height: SizeUtils.m),
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          child: Text(
            _aboutProfileDevelopment
                ? al.descriptionAboutDevelopment
                : al.descriptionAbout,
            key: ValueKey(_aboutProfileDevelopment),
            textAlign: widget.textAlign,
            style: StyleText.textPortfolio(
              fontSize: descriptionSize,
              fontWeight: widget.descriptionBold
                  ? FontWeight.bold
                  : widget.fontWeight,
            ),
          ),
        ),
      ],
    );
  }
}
