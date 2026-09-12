import 'package:albertoguaman/l10n/app_localizations.dart';
import 'package:albertoguaman/src/blog/blog_card.dart';
import 'package:albertoguaman/src/model/model.dart';
import 'package:albertoguaman/src/utils/utils.dart';
import 'package:albertoguaman/src/widget/widget.dart';
import 'package:flutter/material.dart';

/// Filtros principales del blog (no todas las tags sueltas).
const List<({String id, String label})> _blogFilters = [
  (id: 'all', label: 'Todo'),
  (id: 'flutter', label: 'Flutter'),
  (id: 'web', label: 'Web'),
  (id: 'linux', label: 'Linux / Homelab'),
  (id: 'javascript', label: 'JavaScript'),
  (id: 'ia', label: 'IA'),
  (id: 'datos', label: 'Datos / SQL'),
  (id: 'tutorial', label: 'Tutoriales'),
];

bool _postMatchesFilter(BlogPost post, String filterId) {
  if (filterId == 'all') return true;
  final cats = post.categories.map((c) => c.toLowerCase()).join(' ');
  return switch (filterId) {
    'flutter' =>
      cats.contains('flutter') ||
          cats.contains('dart') ||
          cats.contains('móvil') ||
          cats.contains('mobile') ||
          cats.contains('provider') ||
          cats.contains('paywall') ||
          cats.contains('enum') ||
          cats.contains('firebase'),
    'web' =>
      cats.contains('web') ||
          cats.contains('astro') ||
          cats.contains('frontend') ||
          cats.contains('html') ||
          cats.contains('lit') ||
          cats.contains('dom') ||
          cats.contains('pelican') ||
          cats.contains('despliegue') ||
          cats.contains('hosting'),
    'linux' =>
      cats.contains('linux') ||
          cats.contains('nas') ||
          cats.contains('homelab') ||
          cats.contains('servidor') ||
          cats.contains('neovim') ||
          cats.contains('lazyvim') ||
          cats.contains('xfce') ||
          cats.contains('terminal'),
    'javascript' =>
      cats.contains('javascript') ||
          cats.contains('tipos') ||
          cats.contains('dom') ||
          cats.contains('http'),
    'ia' =>
      cats.contains('ia') ||
          cats.contains('inteligencia') ||
          cats.contains('moda'),
    'datos' =>
      cats.contains('sql') ||
          cats.contains('base') ||
          cats.contains('finanzas'),
    'tutorial' => cats.contains('tutorial'),
    _ => post.categories.any((c) => c.toLowerCase() == filterId),
  };
}

class BlogListPage extends StatefulWidget {
  const BlogListPage({super.key});

  @override
  State<BlogListPage> createState() => _BlogListPageState();
}

class _BlogListPageState extends State<BlogListPage> {
  String _selected = 'all';

  List<BlogPost> get _filtered =>
      infoBlogPosts.where((p) => _postMatchesFilter(p, _selected)).toList();

  @override
  Widget build(BuildContext context) {
    final al = AppLocalizations.of(context)!;
    final isNarrow = context.isMobile || context.isMobileLarge;
    final posts = _filtered;
    final bodySize = TextStyleSize.textDescriptionSize(context.screenWidth);

    return SitePageFrame(
      title: al.blog,
      subtitle: al.blogHint,
      actions: [
        IconButton(
          tooltip: al.blogRss,
          onPressed: () => laucherURL('/blog/rss.xml'),
          icon: Icon(Icons.rss_feed, color: UtilsColor.colorBlue),
        ),
      ],
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Selector limpio: una fila tipográfica, no nube de chips.
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                for (var i = 0; i < _blogFilters.length; i++) ...[
                  if (i > 0)
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: SizeUtils.s),
                      child: Text(
                        '·',
                        style: StyleText.textPortfolio(
                          fontSize: bodySize,
                          color: UtilsColor.colorMuted.withValues(alpha: 0.5),
                        ),
                      ),
                    ),
                  _FilterLink(
                    label: _blogFilters[i].label,
                    active: _selected == _blogFilters[i].id,
                    bodySize: bodySize,
                    onTap: () =>
                        setState(() => _selected = _blogFilters[i].id),
                  ),
                ],
              ],
            ),
          ),
          SizedBox(height: SizeUtils.s),
          Divider(color: UtilsColor.hairline, height: 1),
          SizedBox(height: SizeUtils.l),
          Text(
            '${posts.length} artículos',
            style: StyleText.textPortfolio(
              fontSize: bodySize * 0.85,
              color: UtilsColor.colorMuted,
            ),
          ),
          SizedBox(height: SizeUtils.l),
          if (posts.isEmpty)
            Text(
              al.blogEmptyFilter,
              style: StyleText.textPortfolio(
                fontSize: bodySize,
                color: UtilsColor.colorMuted,
              ),
            )
          else if (isNarrow)
            for (final post in posts) ...[
              BlogPostCard(post: post, compact: true),
              SizedBox(height: SizeUtils.m),
            ]
          else
            for (var i = 0; i < posts.length; i += 2) ...[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: BlogPostCard(post: posts[i], compact: true),
                  ),
                  SizedBox(width: SizeUtils.m),
                  Expanded(
                    child: i + 1 < posts.length
                        ? BlogPostCard(post: posts[i + 1], compact: true)
                        : const SizedBox.shrink(),
                  ),
                ],
              ),
              SizedBox(height: SizeUtils.m),
            ],
        ],
      ),
    );
  }
}

class _FilterLink extends StatelessWidget {
  const _FilterLink({
    required this.label,
    required this.active,
    required this.bodySize,
    required this.onTap,
  });

  final String label;
  final bool active;
  final double bodySize;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: Text(
          label,
          style: StyleText.textPortfolio(
            fontSize: bodySize * 0.95,
            fontWeight: active ? FontWeight.w700 : FontWeight.w500,
            color: active ? UtilsColor.colorBlue : UtilsColor.colorMuted,
          ),
        ),
      ),
    );
  }
}
