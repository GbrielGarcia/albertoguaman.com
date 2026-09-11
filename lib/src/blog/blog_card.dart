import 'package:albertoguaman/l10n/app_localizations.dart';
import 'package:albertoguaman/src/model/model.dart';
import 'package:albertoguaman/src/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BlogPostCard extends StatelessWidget {
  const BlogPostCard({
    super.key,
    required this.post,
    this.compact = false,
  });

  final BlogPost post;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final al = AppLocalizations.of(context);
    final titleSize = compact
        ? TextStyleSize.textDescriptionSize(context.screenWidth) * 1.05
        : TextStyleSize.textTitleSize(context.screenWidth);
    final bodySize = TextStyleSize.textDescriptionSize(context.screenWidth);

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => context.go(post.route),
        child: Container(
          decoration: BoxDecoration(
            color: UtilsColor.colorSurface.withValues(alpha: 0.9),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: UtilsColor.hairline),
          ),
          clipBehavior: Clip.antiAlias,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (post.imageAsset.isNotEmpty)
                AspectRatio(
                  aspectRatio: compact ? 16 / 9 : 2.2,
                  child: Image.asset(
                    post.imageAsset,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => ColoredBox(
                      color: UtilsColor.colorBlue.withValues(alpha: 0.35),
                      child: Icon(
                        Icons.article_outlined,
                        color: UtilsColor.colorSecondaryWhite
                            .withValues(alpha: 0.5),
                      ),
                    ),
                  ),
                ),
              Padding(
                padding: EdgeInsets.all(SizeUtils.m),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Wrap(
                      spacing: SizeUtils.s,
                      runSpacing: SizeUtils.s / 2,
                      children: [
                        for (final cat in post.categories.take(3))
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: SizeUtils.s,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: UtilsColor.colorYellow
                                  .withValues(alpha: 0.18),
                              borderRadius: BorderRadius.circular(SizeUtils.m),
                            ),
                            child: Text(
                              cat,
                              style: StyleText.textPortfolio(
                                fontSize: bodySize * 0.78,
                                color: UtilsColor.colorYellow,
                              ),
                            ),
                          ),
                      ],
                    ),
                    SizedBox(height: SizeUtils.s),
                    Text(
                      post.title,
                      maxLines: compact ? 3 : 4,
                      overflow: TextOverflow.ellipsis,
                      style: StyleText.textPortfolio(
                        fontSize: titleSize,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: SizeUtils.s),
                    Text(
                      post.localizedExcerpt(
                        Localizations.localeOf(context).languageCode == 'en',
                      ),
                      maxLines: compact ? 3 : 4,
                      overflow: TextOverflow.ellipsis,
                      style: StyleText.textPortfolio(
                        fontSize: bodySize * 0.95,
                        color: UtilsColor.colorSecondaryWhite
                            .withValues(alpha: 0.78),
                      ),
                    ),
                    SizedBox(height: SizeUtils.m),
                    Text(
                      '${post.dateLabel} · ${post.readTime}',
                      style: StyleText.textPortfolio(
                        fontSize: bodySize * 0.82,
                        color: UtilsColor.colorSecondaryWhite
                            .withValues(alpha: 0.55),
                      ),
                    ),
                    SizedBox(height: SizeUtils.s),
                    Text(
                      al?.contentReadMore ?? 'Abrir',
                      style: StyleText.textPortfolio(
                        fontSize: bodySize * 0.9,
                        fontWeight: FontWeight.w700,
                        color: UtilsColor.colorYellow,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
