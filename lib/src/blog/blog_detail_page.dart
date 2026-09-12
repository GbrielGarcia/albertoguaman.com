import 'package:albertoguaman/l10n/app_localizations.dart';
import 'package:albertoguaman/src/blog/blog_markdown.dart';
import 'package:albertoguaman/src/model/model.dart';
import 'package:albertoguaman/src/utils/utils.dart';
import 'package:albertoguaman/src/widget/widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

class BlogDetailPage extends StatefulWidget {
  const BlogDetailPage({super.key, required this.slug});

  final String slug;

  @override
  State<BlogDetailPage> createState() => _BlogDetailPageState();
}

class _BlogDetailPageState extends State<BlogDetailPage> {
  late final BlogPost? post;
  Future<String>? _bodyFuture;

  @override
  void initState() {
    super.initState();
    post = blogPostBySlug(widget.slug);
    if (post != null) {
      _bodyFuture = loadBlogMarkdownBody(post!.assetPath);
    }
  }

  @override
  Widget build(BuildContext context) {
    final al = AppLocalizations.of(context);
    final isNarrow = context.isMobile || context.isMobileLarge;
    final bodySize = TextStyleSize.textDescriptionSize(context.screenWidth);
    final titleSize = TextStyleSize.textTitleSectionSize(context.screenWidth);

    if (post == null) {
      return Scaffold(
        backgroundColor: UtilsColor.colorPrimaryDark,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            color: UtilsColor.colorSecondaryWhite,
            onPressed: () => context.go('/blog'),
          ),
        ),
        body: Center(
          child: Text(
            al?.pageNotFound ?? 'Página no encontrada',
            style: StyleText.textPortfolio(fontSize: bodySize),
          ),
        ),
      );
    }

    final p = post!;

    return Scaffold(
      backgroundColor: UtilsColor.colorPrimaryDark,
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => laucherURL('https://wa.me/593992889078'),
        backgroundColor: const Color(0xFF25D366),
        foregroundColor: Colors.white,
        elevation: 10,
        icon: const Icon(Icons.chat),
        label: const Text(
          'WhatsApp',
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: UtilsColor.colorSecondaryWhite,
          onPressed: () => context.go('/blog'),
          tooltip: al?.blog ?? 'Blog',
        ),
        title: Text(
          al?.blog ?? 'Blog',
          style: StyleText.textPortfolio(
            fontSize: TextStyleSize.textTitleSize(context.screenWidth),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: BubbleBackgroundLayer(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(
                  horizontal: isNarrow ? SizeUtils.m : SizeUtils.xl,
                  vertical: SizeUtils.m,
                ),
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 820),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const SiteNav(),
                        SizedBox(height: SizeUtils.l),
                        if (p.imageAsset.isNotEmpty)
                          ClipRRect(
                            borderRadius: BorderRadius.circular(SizeUtils.m),
                            child: AspectRatio(
                              aspectRatio: 2.1,
                              child: Image.asset(
                                p.imageAsset,
                                fit: BoxFit.cover,
                                semanticLabel: p.title,
                              ),
                            ),
                          ),
                        SizedBox(height: SizeUtils.l),
                        Text(
                          p.title,
                          style: StyleText.textPortfolio(
                            fontSize: titleSize,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: SizeUtils.s),
                        Text(
                          '${p.author} · ${p.dateLabel} · ${p.readTime}',
                          style: StyleText.textPortfolio(
                            fontSize: bodySize * 0.9,
                            color: UtilsColor.colorSecondaryWhite
                                .withValues(alpha: 0.65),
                          ),
                        ),
                        SizedBox(height: SizeUtils.m),
                        Wrap(
                          spacing: SizeUtils.s,
                          runSpacing: SizeUtils.s / 2,
                          children: [
                            for (final cat in p.categories)
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: SizeUtils.s,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: UtilsColor.colorYellow
                                      .withValues(alpha: 0.18),
                                  borderRadius:
                                      BorderRadius.circular(SizeUtils.m),
                                ),
                                child: Text(
                                  cat,
                                  style: StyleText.textPortfolio(
                                    fontSize: bodySize * 0.8,
                                    color: UtilsColor.colorYellow,
                                  ),
                                ),
                              ),
                          ],
                        ),
                        SizedBox(height: SizeUtils.l),
                        FutureBuilder<String>(
                          future: _bodyFuture,
                          builder: (context, snapshot) {
                            if (snapshot.connectionState !=
                                ConnectionState.done) {
                              return const Padding(
                                padding: EdgeInsets.symmetric(vertical: 48),
                                child: Center(
                                  child: CircularProgressIndicator(
                                    color: Color(0xFFFAD85D),
                                  ),
                                ),
                              );
                            }
                            if (snapshot.hasError || snapshot.data == null) {
                              return Text(
                                'No se pudo cargar el artículo.',
                                style: StyleText.textPortfolio(
                                  fontSize: bodySize,
                                  color: UtilsColor.colorSecondaryWhite
                                      .withValues(alpha: 0.7),
                                ),
                              );
                            }
                            return MarkdownBody(
                              data: snapshot.data!,
                              selectable: true,
                              onTapLink: (text, href, title) async {
                                if (href == null) return;
                                final uri = Uri.tryParse(href);
                                if (uri == null) return;
                                if (await canLaunchUrl(uri)) {
                                  await launchUrl(
                                    uri,
                                    mode: LaunchMode.externalApplication,
                                  );
                                }
                              },
                              sizedImageBuilder: (config) {
                                final asset = blogImageAssetFromUri(config.uri);
                                if (asset != null) {
                                  return Padding(
                                    padding: EdgeInsets.symmetric(
                                      vertical: SizeUtils.m,
                                    ),
                                    child: ClipRRect(
                                      borderRadius:
                                          BorderRadius.circular(SizeUtils.m),
                                      child: Image.asset(
                                        asset,
                                        fit: BoxFit.contain,
                                        semanticLabel: p.title,
                                      ),
                                    ),
                                  );
                                }
                                return const SizedBox.shrink();
                              },
                              styleSheet: MarkdownStyleSheet(
                                p: StyleText.textPortfolio(
                                  fontSize: bodySize,
                                  color: UtilsColor.colorSecondaryWhite
                                      .withValues(alpha: 0.92),
                                ).copyWith(height: 1.55),
                                h1: StyleText.textPortfolio(
                                  fontSize: titleSize * 0.85,
                                  fontWeight: FontWeight.bold,
                                  color: UtilsColor.colorSecondaryWhite,
                                ),
                                h2: StyleText.textPortfolio(
                                  fontSize: titleSize * 0.72,
                                  fontWeight: FontWeight.bold,
                                  color: UtilsColor.colorSecondaryWhite,
                                ),
                                h3: StyleText.textPortfolio(
                                  fontSize: bodySize * 1.15,
                                  fontWeight: FontWeight.bold,
                                  color: UtilsColor.colorSecondaryWhite,
                                ),
                                h4: StyleText.textPortfolio(
                                  fontSize: bodySize * 1.05,
                                  fontWeight: FontWeight.bold,
                                  color: UtilsColor.colorSecondaryWhite,
                                ),
                                h5: StyleText.textPortfolio(
                                  fontSize: bodySize,
                                  fontWeight: FontWeight.bold,
                                  color: UtilsColor.colorSecondaryWhite,
                                ),
                                h6: StyleText.textPortfolio(
                                  fontSize: bodySize * 0.95,
                                  fontWeight: FontWeight.bold,
                                  color: UtilsColor.colorSecondaryWhite
                                      .withValues(alpha: 0.9),
                                ),
                                listBullet: StyleText.textPortfolio(
                                  fontSize: bodySize,
                                  color: UtilsColor.colorSecondaryWhite,
                                ),
                                em: StyleText.textPortfolio(
                                  fontSize: bodySize,
                                  color: UtilsColor.colorSecondaryWhite
                                      .withValues(alpha: 0.92),
                                ).copyWith(fontStyle: FontStyle.italic),
                                del: StyleText.textPortfolio(
                                  fontSize: bodySize,
                                  color: UtilsColor.colorSecondaryWhite
                                      .withValues(alpha: 0.65),
                                ).copyWith(
                                  decoration: TextDecoration.lineThrough,
                                ),
                                blockquote: StyleText.textPortfolio(
                                  fontSize: bodySize,
                                  color: UtilsColor.colorSecondaryWhite
                                      .withValues(alpha: 0.85),
                                ),
                                code: StyleText.textPortfolio(
                                  fontSize: bodySize * 0.9,
                                  color: UtilsColor.colorYellow,
                                ).copyWith(
                                  backgroundColor: UtilsColor
                                      .colorSecondaryWhite
                                      .withValues(alpha: 0.1),
                                  fontFamily: 'monospace',
                                ),
                                codeblockPadding: EdgeInsets.all(SizeUtils.m),
                                codeblockDecoration: BoxDecoration(
                                  color: UtilsColor.colorSecondaryWhite
                                      .withValues(alpha: 0.08),
                                  borderRadius:
                                      BorderRadius.circular(SizeUtils.m),
                                  border: Border.all(
                                    color: UtilsColor.colorSecondaryWhite
                                        .withValues(alpha: 0.12),
                                  ),
                                ),
                                blockquoteDecoration: BoxDecoration(
                                  color: UtilsColor.colorSecondaryWhite
                                      .withValues(alpha: 0.04),
                                  border: Border(
                                    left: BorderSide(
                                      color: UtilsColor.colorYellow,
                                      width: 3,
                                    ),
                                  ),
                                ),
                                blockquotePadding: EdgeInsets.all(SizeUtils.m),
                                a: StyleText.textPortfolio(
                                  fontSize: bodySize,
                                  color: UtilsColor.colorYellow,
                                ).copyWith(
                                  decoration: TextDecoration.underline,
                                ),
                                strong: StyleText.textPortfolio(
                                  fontSize: bodySize,
                                  fontWeight: FontWeight.bold,
                                  color: UtilsColor.colorSecondaryWhite,
                                ),
                                tableHead: StyleText.textPortfolio(
                                  fontSize: bodySize * 0.95,
                                  fontWeight: FontWeight.bold,
                                  color: UtilsColor.colorYellow,
                                ),
                                tableBody: StyleText.textPortfolio(
                                  fontSize: bodySize * 0.92,
                                  color: UtilsColor.colorSecondaryWhite,
                                ),
                                tableBorder: TableBorder.all(
                                  color: UtilsColor.colorSecondaryWhite
                                      .withValues(alpha: 0.28),
                                  width: 1,
                                ),
                                tableHeadAlign: TextAlign.left,
                                tableCellsPadding: EdgeInsets.symmetric(
                                  horizontal: SizeUtils.m,
                                  vertical: SizeUtils.s,
                                ),
                                tableCellsDecoration: BoxDecoration(
                                  color: UtilsColor.colorSecondaryWhite
                                      .withValues(alpha: 0.04),
                                ),
                                tableColumnWidth: const IntrinsicColumnWidth(),
                                horizontalRuleDecoration: BoxDecoration(
                                  border: Border(
                                    top: BorderSide(
                                      color: UtilsColor.colorSecondaryWhite
                                          .withValues(alpha: 0.25),
                                      width: 1,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                        SizedBox(height: SizeUtils.xl1),
                        TextButton.icon(
                          onPressed: () => context.go('/blog'),
                          icon: const Icon(Icons.arrow_back),
                          label: Text(al?.blog ?? 'Blog'),
                          style: TextButton.styleFrom(
                            foregroundColor: UtilsColor.colorYellow,
                          ),
                        ),
                        SizedBox(height: SizeUtils.xl1),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          const BubbleBackgroundToggleOverlay(),
        ],
      ),
    );
  }
}
