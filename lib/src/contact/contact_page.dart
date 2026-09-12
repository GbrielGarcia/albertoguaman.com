import 'package:albertoguaman/l10n/app_localizations.dart';
import 'package:albertoguaman/src/contact/contact_form.dart';
import 'package:albertoguaman/src/utils/utils.dart';
import 'package:albertoguaman/src/widget/widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ContactPage extends StatelessWidget {
  const ContactPage({super.key});

  @override
  Widget build(BuildContext context) {
    final al = AppLocalizations.of(context)!;
    final isNarrow = context.isMobile || context.isMobileLarge;
    final bodySize = TextStyleSize.textDescriptionSize(context.screenWidth);

    return SitePageFrame(
      title: al.contact,
      subtitle: al.contactHint,
      showWhatsAppFab: true,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const AvailabilityBadge(showCta: false),
          SizedBox(height: SizeUtils.l),
          containerBottom(
            () => laucherURL('mailto:contacto@albertoguaman.com'),
            al.contactEmail,
            al.contactEmail,
            width: double.infinity,
            variant: PortfolioButtonVariant.solid,
            padding: 0,
          ),
          SizedBox(height: SizeUtils.s),
          containerBottom(
            () => laucherURL('https://wa.me/593992889078'),
            '+593 99 288 9078',
            al.contacMe,
            width: double.infinity,
            padding: 0,
          ),
          SizedBox(height: SizeUtils.s),
          containerBottom(
            () => laucherURL(AssetsUtil.cvDev2026),
            AssetsUtil.cvDev2026,
            al.downloadCv,
            width: double.infinity,
            padding: 0,
          ),
          SizedBox(height: SizeUtils.xl),
          Text(
            al.cvPreview.toUpperCase(),
            style: StyleText.textPortfolio(
              fontSize: bodySize,
              fontWeight: FontWeight.w700,
              color: UtilsColor.colorBlue,
            ),
          ),
          SizedBox(height: SizeUtils.m),
          buildCvPreview(
            pdfUrl: AssetsUtil.cvDev2026,
            height: isNarrow ? 480 : 720,
          ),
          SizedBox(height: SizeUtils.l),
          const AvailabilityPanel(),
          SizedBox(height: SizeUtils.xl),
          const ContactForm(),
          SizedBox(height: SizeUtils.l),
          containerBottom(
            () => context.go('/cv'),
            '/cv',
            al.cvPageTitle,
            width: double.infinity,
            padding: 0,
          ),
          SizedBox(height: SizeUtils.xl),
          Text(
            'Redes',
            style: StyleText.textPortfolio(
              fontSize: bodySize,
              fontWeight: FontWeight.w700,
              color: UtilsColor.colorMuted,
            ),
          ),
          SizedBox(height: SizeUtils.m),
          iconDataRow(),
        ],
      ),
    );
  }
}
