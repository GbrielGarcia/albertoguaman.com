import 'package:albertoguaman/l10n/app_localizations.dart';
import 'package:albertoguaman/src/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Nav tipográfica: horizontal centrada (header) o vertical (drawer).
class SiteNav extends StatelessWidget {
  const SiteNav({
    super.key,
    this.axis = Axis.horizontal,
    this.onNavigate,
    this.compact = false,
  });

  final Axis axis;
  final VoidCallback? onNavigate;
  final bool compact;

  static List<({String path, String Function(AppLocalizations) label})> items(
          AppLocalizations al) =>
      [
        (path: '/', label: (a) => a.home),
        (path: '/servicios', label: (_) => 'Servicios'),
        (path: '/casos', label: (a) => a.navCaseStudies),
        (path: '/recomendaciones', label: (a) => a.navTestimonials),
        (path: '/blog', label: (a) => a.blog),
        (path: '/galeria', label: (a) => a.gallery),
        (path: '/contacto', label: (a) => a.contact),
      ];

  bool _isActive(String current, String path) {
    if (path == '/') return current == '/';
    return current == path || current.startsWith('$path/');
  }

  @override
  Widget build(BuildContext context) {
    final al = AppLocalizations.of(context)!;
    final location = GoRouterState.of(context).uri.path;
    final normalized = location.endsWith('/') && location.length > 1
        ? location.substring(0, location.length - 1)
        : location;
    final fontSize = axis == Axis.horizontal
        ? TextStyleSize.textDescriptionSize(context.screenWidth) *
            (compact ? 0.88 : 0.92)
        : TextStyleSize.textDescriptionSize(context.screenWidth) * 1.05;

    final links = items(al).map((item) {
      final active = _isActive(normalized, item.path);
      return GestureDetector(
        onTap: () {
          onNavigate?.call();
          if (normalized != item.path) {
            context.go(item.path);
          }
        },
        child: MouseRegion(
          cursor: SystemMouseCursors.click,
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: axis == Axis.vertical ? 0 : SizeUtils.s,
              vertical: SizeUtils.s / 2,
            ),
            child: Text(
              item.label(al),
              textAlign:
                  axis == Axis.vertical ? TextAlign.left : TextAlign.center,
              style: StyleText.textPortfolio(
                fontSize: fontSize,
                fontWeight: active ? FontWeight.w700 : FontWeight.w500,
                color: active
                    ? UtilsColor.colorBlue
                    : UtilsColor.colorMuted,
                height: 1.2,
              ),
            ),
          ),
        ),
      );
    }).toList();

    if (axis == Axis.vertical) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: links,
      );
    }

    return SizedBox(
      height: 36,
      child: Center(
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: links,
          ),
        ),
      ),
    );
  }
}
