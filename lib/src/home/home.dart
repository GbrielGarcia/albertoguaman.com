import 'dart:async';

import "package:albertoguaman/src/model/model.dart";
import "package:albertoguaman/src/home/home_hero.dart";

import "package:flutter/material.dart";
import 'package:albertoguaman/l10n/app_localizations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import "package:go_router/go_router.dart";
import "../utils/utils.dart";
import "../widget/widget.dart";

class HomeSrc extends StatefulWidget {
  const HomeSrc({super.key});

  @override
  State<HomeSrc> createState() => _PortfolioScreenState();
}

class _PortfolioScreenState extends State<HomeSrc> {
  late List<bool> inHovered;
  late List<bool> inHoveredBook;

  final ScrollController _scrollController = ScrollController();
  final ScrollController _clientsForwardController = ScrollController();
  final ScrollController _clientsReverseController = ScrollController();
  Timer? _clientsAutoScrollTimer;

  @override
  void initState() {
    super.initState();
    inHovered = List<bool>.filled(infoProjectModel.length, false);
    inHoveredBook = List<bool>.filled(infoBookModel.length, false);
    _clientsAutoScrollTimer =
        Timer.periodic(const Duration(milliseconds: 30), (_) {
      _moveHorizontalRow(_clientsForwardController, 0.55);
      _moveHorizontalRow(_clientsReverseController, 0.48);
    });
  }

  void _moveHorizontalRow(ScrollController controller, double step) {
    if (!controller.hasClients) return;
    final position = controller.position;
    if (!position.hasContentDimensions) return;
    final max = position.maxScrollExtent;
    if (max <= 0) return;

    final next = controller.offset + step;
    if (next > max) {
      controller.jumpTo(0);
    } else {
      controller.jumpTo(next);
    }
  }

  @override
  void dispose() {
    _clientsAutoScrollTimer?.cancel();
    _scrollController.dispose();
    _clientsForwardController.dispose();
    _clientsReverseController.dispose();
    super.dispose();
  }

  void _scrollToSection(String section) {
    final key = sectionKeys[section];
    if (key?.currentContext != null) {
      Scrollable.ensureVisible(
        key!.currentContext!,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
        alignment: 0.0,
      );
    }
  }

  /// Secciones del CV en home (casos y reseñas viven en páginas propias).
  List<({String id, String label})> _sections(AppLocalizations al) => [
        (id: SectionId.about, label: al.aboutMe),
        (id: SectionId.experience, label: al.experience),
        (id: SectionId.skills, label: al.skills),
        (id: SectionId.projects, label: al.project),
        (id: SectionId.clients, label: al.clients),
        (id: SectionId.publications, label: al.publications),
      ];

  @override
  Widget build(BuildContext context) {
    final al = AppLocalizations.of(context)!;
    final sections = _sections(al);

    return Scaffold(
      drawer: Drawer(
        backgroundColor: UtilsColor.colorBg,
        child: SafeArea(
          child: ListView(
            padding: EdgeInsets.symmetric(
              horizontal: SizeUtils.l,
              vertical: SizeUtils.xl,
            ),
            children: [
              Text(
                'Alberto Guaman',
                style: StyleText.textPortfolio(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                  color: UtilsColor.colorSecondaryWhite,
                ),
              ),
              SizedBox(height: SizeUtils.xl),
              Text(
                al.home.toUpperCase(),
                style: StyleText.textPortfolio(
                  fontSize: TextStyleSize.textDescriptionSize(
                          context.screenWidth) *
                      0.78,
                  fontWeight: FontWeight.w700,
                  color: UtilsColor.colorMuted,
                ).copyWith(letterSpacing: 1.1),
              ),
              SizedBox(height: SizeUtils.s),
              SiteNav(
                axis: Axis.vertical,
                onNavigate: () => Navigator.pop(context),
              ),
              SizedBox(height: SizeUtils.xl),
              Divider(color: UtilsColor.hairline, height: 1),
              SizedBox(height: SizeUtils.l),
              Text(
                al.portfolio.toUpperCase(),
                style: StyleText.textPortfolio(
                  fontSize: TextStyleSize.textDescriptionSize(
                          context.screenWidth) *
                      0.78,
                  fontWeight: FontWeight.w700,
                  color: UtilsColor.colorMuted,
                ).copyWith(letterSpacing: 1.1),
              ),
              SizedBox(height: SizeUtils.s),
              _buildSectionsColumn(context, sections),
            ],
          ),
        ),
      ),
      appBar: const SiteHeader(),
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
      body: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned.fill(
            child: BubbleBackgroundLayer(
              particleCount: 40,
              child: Responsive(
                mobile: SingleChildScrollView(
                  controller: _scrollController,
                  clipBehavior: Clip.antiAlias,
                  child: _buildHomeColumn(al, sections),
                ),
                desktop: SingleChildScrollView(
                  controller: _scrollController,
                  clipBehavior: Clip.antiAlias,
                  child: _buildHomeColumn(al, sections),
                ),
              ),
            ),
          ),
          const BubbleBackgroundToggleOverlay(),
        ],
      ),
    );
  }

  Widget _buildHomeColumn(
      AppLocalizations al, List<({String id, String label})> sections) {
    final isNarrow = context.isMobile || context.isMobileLarge;
    final bodySize = TextStyleSize.textDescriptionSize(context.screenWidth);
    final titleSize = TextStyleSize.textTitleSectionSize(context.screenWidth);

    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 1040),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: isNarrow ? SizeUtils.l : SizeUtils.xl,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: isNarrow ? SizeUtils.l : SizeUtils.xl),
              // —— Hero ——
              StaggerFadeIn(
                index: 0,
                child: HomeHero(
                  al: al,
                  titleSize: titleSize,
                  bodySize: bodySize,
                  isNarrow: isNarrow,
                  onDownloadCv: () => laucherURL(AssetsUtil.cvDev2026),
                ),
              ),
              SizedBox(height: SizeUtils.xl),
              // —— Ancla CV ——
              if (!isNarrow)
                Padding(
                  padding: EdgeInsets.only(bottom: SizeUtils.m),
                  child: Wrap(
                    spacing: SizeUtils.l,
                    runSpacing: SizeUtils.s,
                    children: [
                      for (final s in sections)
                        GestureDetector(
                          onTap: () => _scrollToSection(s.id),
                          child: MouseRegion(
                            cursor: SystemMouseCursors.click,
                            child: Text(
                              s.label,
                              style: StyleText.textPortfolio(
                                fontSize: bodySize * 0.88,
                                color: UtilsColor.colorMuted,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              Divider(color: UtilsColor.hairline, height: 1),
              SizedBox(height: SizeUtils.xl),
              _buildSectionContent('', sectionKeys[SectionId.about]!),
              ScrollReveal(
                controller: _scrollController,
                child: _buildAboutMe(al),
              ),
              _buildSectionContent('', sectionKeys[SectionId.experience]!),
              ScrollReveal(
                controller: _scrollController,
                delay: const Duration(milliseconds: 40),
                child: _buildExperience(al),
              ),
              _buildSectionContent('', sectionKeys[SectionId.skills]!),
              ScrollReveal(
                controller: _scrollController,
                delay: const Duration(milliseconds: 60),
                child: _buildSkills(al),
              ),
              _buildSectionContent('', sectionKeys[SectionId.projects]!),
              ScrollReveal(
                controller: _scrollController,
                delay: const Duration(milliseconds: 60),
                child: _buildProject(al, context),
              ),
              _buildSectionContent('', sectionKeys[SectionId.clients]!),
              ScrollReveal(
                controller: _scrollController,
                delay: const Duration(milliseconds: 60),
                child: _buildClients(al),
              ),
              _buildSectionContent('', sectionKeys[SectionId.publications]!),
              ScrollReveal(
                controller: _scrollController,
                delay: const Duration(milliseconds: 60),
                child: _buildPublications(al),
              ),
              footerData(al, context.screenWidth),
              SizedBox(height: SizeUtils.xl1),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSkills(AppLocalizations? al) {
    final descriptionSize =
        TextStyleSize.textDescriptionSize(context.screenWidth);
    final isNarrow = context.isMobile || context.isMobileLarge;

    return ResponsiveCenter(
      child: _buildContainerInfo(
        al,
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            for (final group in infoSkillGroups) ...[
              SizedBox(height: SizeUtils.m),
              Container(
                padding: EdgeInsets.all(SizeUtils.m),
                decoration: BoxDecoration(
                  color: UtilsColor.colorSecondaryWhite.withValues(alpha: 0.04),
                  border: Border.all(
                    color:
                        UtilsColor.colorSecondaryWhite.withValues(alpha: 0.18),
                  ),
                  borderRadius: BorderRadius.circular(SizeUtils.m),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      group.title.toUpperCase(),
                      style: StyleText.textPortfolio(
                        fontSize: descriptionSize,
                        fontWeight: FontWeight.bold,
                        color: UtilsColor.colorYellow,
                      ),
                    ),
                    SizedBox(height: SizeUtils.s),
                    Text(
                      group.subtitle,
                      style: StyleText.textPortfolio(
                        fontSize: descriptionSize * 0.92,
                        color: UtilsColor.colorSecondaryWhite
                            .withValues(alpha: 0.7),
                      ),
                    ),
                    SizedBox(height: SizeUtils.m),
                    LayoutBuilder(
                      builder: (context, constraints) {
                        final maxW = constraints.maxWidth;
                        final columns = isNarrow
                            ? 2
                            : maxW > 900
                                ? 4
                                : 3;
                        final gap = SizeUtils.s;
                        final tileW = (maxW - (gap * (columns - 1))) / columns;
                        return Wrap(
                          spacing: gap,
                          runSpacing: gap,
                          children: group.items
                              .map(
                                (item) => SizedBox(
                                  width: tileW,
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: SizeUtils.s,
                                      vertical: SizeUtils.m,
                                    ),
                                    decoration: BoxDecoration(
                                      color: UtilsColor.colorPrimaryDark
                                          .withValues(alpha: 0.55),
                                      border: Border.all(
                                        color: UtilsColor.colorYellow
                                            .withValues(alpha: 0.35),
                                      ),
                                      borderRadius:
                                          BorderRadius.circular(SizeUtils.m),
                                    ),
                                    child: Row(
                                      children: [
                                        FaIcon(
                                          item.icon,
                                          size: descriptionSize,
                                          color: UtilsColor.colorYellow,
                                        ),
                                        SizedBox(width: SizeUtils.s),
                                        Expanded(
                                          child: Text(
                                            item.name,
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: StyleText.textPortfolio(
                                              fontSize: descriptionSize * 0.95,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              )
                              .toList(),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
            SizedBox(height: SizeUtils.s),
          ],
        ),
        color: Colors.transparent,
        title: al!.skills,
      ),
    );
  }

  Widget _buildClients(AppLocalizations? al) {
    final descriptionSize =
        TextStyleSize.textDescriptionSize(context.screenWidth);
    final firstRow = <String>[
      for (var i = 0; i < infoClientNames.length; i += 2) infoClientNames[i],
    ];
    final secondRow = <String>[
      for (var i = 1; i < infoClientNames.length; i += 2) infoClientNames[i],
    ];

    return ResponsiveCenter(
      child: _buildContainerInfo(
        al,
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildClientsRow(
              names: firstRow,
              controller: _clientsForwardController,
              descriptionSize: descriptionSize,
            ),
            SizedBox(height: SizeUtils.s),
            _buildClientsRow(
              names: secondRow,
              controller: _clientsReverseController,
              descriptionSize: descriptionSize,
              reverse: true,
            ),
          ],
        ),
        color: Colors.transparent,
        title: al!.clients,
      ),
    );
  }

  Widget _buildClientsRow({
    required List<String> names,
    required ScrollController controller,
    required double descriptionSize,
    bool reverse = false,
  }) {
    // Repetir para que siempre haya recorrido horizontal.
    const repeats = 4;
    final items = <String>[
      for (var r = 0; r < repeats; r++) ...names,
    ];
    final rowHeight = descriptionSize * 2.2;

    return SizedBox(
      height: rowHeight,
      child: ListView.separated(
        controller: controller,
        scrollDirection: Axis.horizontal,
        reverse: reverse,
        physics: const BouncingScrollPhysics(),
        itemCount: items.length,
        separatorBuilder: (_, __) => SizedBox(width: SizeUtils.s),
        itemBuilder: (context, index) {
          return Container(
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(
              horizontal: SizeUtils.m,
              vertical: SizeUtils.s,
            ),
            decoration: BoxDecoration(
              color: UtilsColor.colorSecondaryWhite,
              borderRadius: BorderRadius.circular(SizeUtils.m),
            ),
            child: Text(
              items[index],
              style: StyleText.textPortfolio(
                fontSize: descriptionSize * 0.92,
                fontWeight: FontWeight.w600,
                color: UtilsColor.colorPrimaryDark,
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildExperience(AppLocalizations? al) {
    final grouped = <String, List<Experience>>{};
    for (final e in infoExperienceModel) {
      grouped.putIfAbsent(e.title, () => []).add(e);
    }
    final companies = grouped.keys.toList();

    return ResponsiveCenter(
      child: _buildContainerInfo(
        al,
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: companies.length,
          itemBuilder: (context, companyIndex) {
            final companyName = companies[companyIndex];
            final experiences = grouped[companyName]!;
            final isTimeline = experiences.length > 1;

            if (isTimeline) {
              return Padding(
                padding: EdgeInsets.only(
                    bottom:
                        companyIndex < companies.length - 1 ? SizeUtils.xl : 0),
                child: _buildCompanyTimeline(context, companyName, experiences),
              );
            }
            final experience = experiences.single;
            final isCurrent =
                experience.data.toLowerCase().contains('actualidad');
            return Padding(
              padding: EdgeInsets.symmetric(
                  vertical: companyIndex != 1 ? 0 : SizeUtils.s),
              child: _buildExperienceCard(experience, isCurrent: isCurrent),
            );
          },
        ),
        color: Colors.transparent,
        title: al!.experience,
      ),
    );
  }

  Widget _buildCompanyTimeline(
      BuildContext context, String companyName, List<Experience> experiences) {
    final totalLabel = totalExperienceDurationLabel(experiences);
    final timeline = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(companyName.toUpperCase(),
            style: StyleText.textPortfolio(
              fontSize: TextStyleSize.textTitleSize(context.screenWidth),
              fontWeight: FontWeight.bold,
            )),
        SizedBox(height: SizeUtils.l),
        IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                width: 24,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    for (int i = 0; i < experiences.length; i++) ...[
                      Container(
                        width: 12,
                        height: 12,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: UtilsColor.colorYellow,
                          border: Border.all(
                              color: UtilsColor.colorSecondaryWhite, width: 2),
                        ),
                      ),
                      if (i < experiences.length - 1)
                        Expanded(
                          child: Center(
                            child: Container(
                              width: 2,
                              color: UtilsColor.colorYellow,
                            ),
                          ),
                        ),
                    ],
                  ],
                ),
              ),
              SizedBox(width: SizeUtils.s),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (int i = 0; i < experiences.length; i++) ...[
                      _buildTimelineExperienceContent(context, experiences[i],
                          isLast: i == experiences.length - 1),
                      if (i < experiences.length - 1)
                        SizedBox(height: SizeUtils.xl),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );

    if (totalLabel == null) return timeline;

    // Mismo estilo de etiqueta lateral que el resto de experiencias.
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Padding(
          padding: EdgeInsets.only(top: SizeUtils.s),
          child: timeline,
        ),
        Positioned(
          top: -10,
          right: 0,
          child: Container(
            padding: EdgeInsets.all(SizeUtils.m),
            decoration: const BoxDecoration(
              color: Colors.transparent,
              shape: BoxShape.rectangle,
            ),
            child: Text(
              'Total: $totalLabel',
              style: StyleText.textPortfolio(
                fontSize: SizeUtils.l,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTimelineExperienceContent(
      BuildContext context, Experience experience,
      {bool isLast = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(experience.type,
            style: StyleText.textPortfolio(
              fontSize: TextStyleSize.textDescriptionSize(context.screenWidth),
              fontWeight: FontWeight.bold,
              color: UtilsColor.colorYellow,
            )),
        SizedBox(height: SizeUtils.s),
        Text(experience.data,
            style: StyleText.textPortfolio(
              fontSize: TextStyleSize.textDescriptionSize(context.screenWidth),
            )),
        if (experience.country.isNotEmpty) ...[
          SizedBox(height: SizeUtils.s),
          Text(experience.country,
              style: StyleText.textPortfolio(
                fontSize:
                    TextStyleSize.textDescriptionSize(context.screenWidth),
                color: UtilsColor.colorSecondaryWhite.withValues(alpha: 0.75),
              )),
        ],
        if (experience.stack != null && experience.stack!.isNotEmpty) ...[
          SizedBox(height: SizeUtils.m),
          Container(
            padding: EdgeInsets.symmetric(
                horizontal: SizeUtils.s, vertical: SizeUtils.m),
            decoration: BoxDecoration(
              color: UtilsColor.colorYellow.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(SizeUtils.m),
              border: Border.all(color: UtilsColor.colorYellow, width: 1),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Stack: ',
                    style: StyleText.textPortfolio(
                      fontSize: TextStyleSize.textDescriptionSize(
                          context.screenWidth),
                      fontWeight: FontWeight.bold,
                      color: UtilsColor.colorYellow,
                    )),
                Expanded(
                  child: Text(experience.stack!,
                      style: StyleText.textPortfolio(
                        fontSize: TextStyleSize.textDescriptionSize(
                            context.screenWidth),
                        color: UtilsColor.colorYellow,
                      )),
                ),
              ],
            ),
          ),
        ],
        SizedBox(height: SizeUtils.m),
        ...experience.description.map((desc) => Padding(
              padding: EdgeInsets.only(bottom: SizeUtils.s),
              child: Text(desc,
                  style: StyleText.textPortfolio(
                      fontSize: TextStyleSize.textDescriptionSize(
                          context.screenWidth))),
            )),
        if (!isLast) ...[SizedBox(height: SizeUtils.s1), linerSpace()],
      ],
    );
  }

  Widget _buildExperienceCard(Experience experience, {bool isCurrent = false}) {
    final card = _buildCardInfo(
        () {},
        1.0,
        Colors.transparent,
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (isCurrent) SizedBox(height: SizeUtils.s1),
            Text(experience.title.toUpperCase(),
                style: StyleText.textPortfolio(
                  fontSize: TextStyleSize.textTitleSize(context.screenWidth),
                  fontWeight: FontWeight.bold,
                  color: isCurrent ? UtilsColor.colorYellow : null,
                )),
            SizedBox(height: SizeUtils.m),
            Text(experience.type,
                style: StyleText.textPortfolio(
                  fontSize:
                      TextStyleSize.textDescriptionSize(context.screenWidth),
                  fontWeight: FontWeight.bold,
                )),
            if (experience.country.isNotEmpty) ...[
              SizedBox(height: SizeUtils.s),
              Text(experience.country,
                  style: StyleText.textPortfolio(
                    fontSize:
                        TextStyleSize.textDescriptionSize(context.screenWidth),
                    color:
                        UtilsColor.colorSecondaryWhite.withValues(alpha: 0.75),
                  )),
            ],
            if (experience.stack != null && experience.stack!.isNotEmpty) ...[
              SizedBox(height: SizeUtils.m),
              Container(
                padding: EdgeInsets.symmetric(
                    horizontal: SizeUtils.s, vertical: SizeUtils.m),
                decoration: BoxDecoration(
                  color: UtilsColor.colorYellow.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(SizeUtils.m),
                  border: Border.all(color: UtilsColor.colorYellow, width: 1),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Stack: ',
                        style: StyleText.textPortfolio(
                          fontSize: TextStyleSize.textDescriptionSize(
                              context.screenWidth),
                          fontWeight: FontWeight.bold,
                          color: UtilsColor.colorYellow,
                        )),
                    Expanded(
                      child: Text(experience.stack!,
                          style: StyleText.textPortfolio(
                            fontSize: TextStyleSize.textDescriptionSize(
                                context.screenWidth),
                            color: UtilsColor.colorYellow,
                          )),
                    ),
                  ],
                ),
              ),
            ],
            SizedBox(height: SizeUtils.m),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: experience.description.map((desc) {
                return Text(desc,
                    style: StyleText.textPortfolio(
                        fontSize: TextStyleSize.textDescriptionSize(
                            context.screenWidth)));
              }).toList(),
            ),
            SizedBox(height: SizeUtils.s1),
            linerSpace(),
          ],
        ),
        'url',
        'urlTitle',
        'view',
        experience.data,
        isCurrent ? UtilsColor.colorYellow : Colors.transparent,
        [],
        titleToolTip: true,
        positioned: true,
        elevation: true);

    if (!isCurrent) return HoverScale(scale: 1.01, child: card);
    return HoverScale(
      scale: 1.01,
      child: CurrentRoleHighlight(child: card),
    );
  }

  Widget _buildPublications(AppLocalizations? al) {
    return ResponsiveCenter(
      child: _buildContainerInfo(
          al,
          ListView.builder(
            shrinkWrap: true,
            // padding: EdgeInsets.all(SizeUtils.m ),
            physics: const NeverScrollableScrollPhysics(),
            itemCount: infoBookModel.length,
            itemBuilder: (context, index) {
              final book = infoBookModel[index];
              return Padding(
                padding: EdgeInsets.symmetric(
                    vertical: index != 1 ? 0 : SizeUtils.s),
                child: HoverScale(
                  child: _buildCardInfo(
                    () {
                      setState(() {
                        inHoveredBook[index] = !inHoveredBook[index];
                      });
                    },
                    inHoveredBook[index] ? 0.2 : 1.0,
                    UtilsColor.colorSecondaryWhite,
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(book.title,
                            style: StyleText.textPortfolio(
                              color: UtilsColor.colorPrimaryDark,
                              fontSize: TextStyleSize.textTitleSize(
                                  context.screenWidth),
                              fontWeight: FontWeight.bold,
                            )),
                        SizedBox(height: SizeUtils.m),
                        Text(
                          book.description,
                          maxLines: context.isDesktop ? 4 : 3,
                          overflow: TextOverflow.ellipsis,
                          style: StyleText.textPortfolio(
                              color: UtilsColor.colorPrimaryDark,
                              fontSize: TextStyleSize.textDescriptionSize(
                                  context.screenWidth)),
                        ),
                      ],
                    ),
                    book.buttonVoidCall,
                    book.buttonVoidCall,
                    book.buttonText,
                    '${index + 1}',
                    UtilsColor.colorPink,
                    [inHoveredBook[index]],
                  ),
                ),
              );
            },
          ),
          title: al?.publications ?? 'Publicaciones',
          color: UtilsColor.colorPrimaryDark),
    );
  }

  Widget _buildProject(AppLocalizations? al, BuildContext context) {
    final int crossAxisCount = context.isDesktop
        ? 2
        : context.isTabletLarge
            ? 2
            : context.isTablet
                ? 2
                : context.isMobileLarge
                    ? 1
                    : 1;
    final double mainAxisExtent = context.isDesktop
        ? 156
        : context.isTabletLarge
            ? 150
            : context.isTablet
                ? 156
                : context.isMobileLarge
                    ? 135
                    : 150;

    final gridContent = GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        mainAxisExtent: mainAxisExtent,
        crossAxisSpacing: SizeUtils.s1,
        mainAxisSpacing: SizeUtils.s1,
        childAspectRatio: 2,
      ),
      itemCount: infoProjectModel.length,
      itemBuilder: (context, index) {
        final project = infoProjectModel[index];
        return HoverScale(
          child: _buildCardInfo(
            () {
              setState(() {
                inHovered[index] = !inHovered[index];
              });
            },
            inHovered[index] ? 0.25 : 1.0,
            UtilsColor.colorElevated,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(project.title,
                    style: StyleText.textPortfolio(
                      color: UtilsColor.colorSecondaryWhite,
                      fontSize:
                          TextStyleSize.textTitleSize(context.screenWidth),
                      fontWeight: FontWeight.bold,
                    )),
                SizedBox(height: SizeUtils.m),
                Text(
                  project.description,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: StyleText.textPortfolio(
                      color: UtilsColor.colorMuted,
                      fontSize: TextStyleSize.textDescriptionSize(
                          context.screenWidth)),
                ),
              ],
            ),
            project.buttonVoidCall,
            project.buttonVoidCall,
            project.title,
            '${index + 1}',
            UtilsColor.colorBlue,
            [inHovered[index]],
          ),
        );
      },
    );

    return ResponsiveCenter(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: SizeUtils.s,
          vertical: SizeUtils.m,
        ),
        child: Material(
          color: UtilsColor.colorSurface.withValues(alpha: 0.85),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(SizeUtils.l),
            side: BorderSide(
              color: UtilsColor.colorSecondaryWhite.withValues(alpha: 0.08),
            ),
          ),
          clipBehavior: Clip.antiAlias,
          child: Theme(
            data: Theme.of(context).copyWith(
              dividerColor: Colors.transparent,
              expansionTileTheme: ExpansionTileThemeData(
                iconColor: UtilsColor.colorBlue,
                collapsedIconColor: UtilsColor.colorMuted,
                textColor: UtilsColor.colorSecondaryWhite,
                collapsedTextColor: UtilsColor.colorSecondaryWhite,
              ),
            ),
            child: ExpansionTile(
              initiallyExpanded: false,
              tilePadding: EdgeInsets.symmetric(
                  horizontal: SizeUtils.l, vertical: SizeUtils.m),
              title: Row(
                children: [
                  Container(
                    width: 4,
                    height: 22,
                    decoration: BoxDecoration(
                      color: UtilsColor.colorBlue,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  SizedBox(width: SizeUtils.s),
                  Expanded(
                    child: Text(
                      '${al?.project ?? 'Proyectos'} (${infoProjectModel.length})',
                      style: StyleText.textPortfolio(
                        fontWeight: FontWeight.w700,
                        fontSize: TextStyleSize.textTitleSectionSize(
                            context.screenWidth),
                        color: UtilsColor.colorSecondaryWhite,
                      ),
                    ),
                  ),
                ],
              ),
              subtitle: Padding(
                padding: EdgeInsets.only(top: SizeUtils.s, left: SizeUtils.l),
                child: Text(
                  al?.projectsTapToExpand ??
                      'Clic para ver la lista de proyectos',
                  style: StyleText.textPortfolio(
                    fontSize:
                        TextStyleSize.textDescriptionSize(context.screenWidth),
                    color: UtilsColor.colorMuted,
                  ),
                ),
              ),
              children: [
                Padding(
                  padding: EdgeInsets.all(SizeUtils.l),
                  child: gridContent,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCardInfo(
    VoidCallback onTap,
    double opacity,
    Color color,
    Widget child,
    String url,
    String urlTitle,
    String view,
    String titleShape,
    Color colorShape,
    List<bool> listBool, {
    bool? titleToolTip = false,
    bool? positioned = false,
    bool? elevation = false,
  }) {
    return tooltipW(
      titleToolTip == false
          ? (AppLocalizations.of(context)?.moreInfo ?? 'Más información')
          : '',
      GestureDetector(
        onTap: onTap,
        child: Stack(
          children: [
            AnimatedOpacity(
              opacity: opacity,
              duration: const Duration(milliseconds: 100),
              child: Card(
                color: color,
                elevation: elevation == false ? 4 : 0,
                child: Padding(
                  padding: EdgeInsets.all(SizeUtils.s),
                  child: child,
                ),
              ),
            ),
            if (listBool.isNotEmpty && listBool.any((boolValue) => boolValue))
              Positioned.fill(
                child: Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: EdgeInsets.all(SizeUtils.s),
                    child: containerBottom(
                        () => laucherURL(url), urlTitle, view,
                        padding: 0),
                  ),
                ),
              ),
            // ... (
            Positioned(
                top: -10,
                right: 0,
                child: Container(
                    padding: EdgeInsets.all(SizeUtils.m),
                    decoration: BoxDecoration(
                      color: colorShape,
                      shape: BoxShape.rectangle,
                    ),
                    child: Text(titleShape,
                        style: StyleText.textPortfolio(
                            fontSize: positioned == false
                                ? SizeUtils.xl
                                : SizeUtils.l))))
          ],
        ),
      ),
    );
  }

  Widget _buildAboutMe(AppLocalizations? al) {
    return ResponsiveCenter(
      child: Column(
        children: [
          _buildContainerInfo(
            al,
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const AboutProfileContent(),
                SizedBox(height: SizeUtils.l),
                Wrap(
                  spacing: SizeUtils.s,
                  runSpacing: SizeUtils.s,
                  children: [
                    TextButton(
                      onPressed: () => context.go('/bio'),
                      style: TextButton.styleFrom(
                        foregroundColor: UtilsColor.colorBlue,
                      ),
                      child: Text(
                        al?.quickLinks ?? 'Enlaces rápidos',
                        style: StyleText.textPortfolio(
                          fontSize: TextStyleSize.textDescriptionSize(
                              context.screenWidth),
                          color: UtilsColor.colorBlue,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: SizeUtils.s),
                Row(
                  children: [
                    Expanded(
                      child: containerBottom(
                        () => laucherURL('https://wa.me/593992889078'),
                        '+593 99 288 9078',
                        al?.contacMe ?? 'Contáctame',
                        width: double.infinity,
                        variant: PortfolioButtonVariant.solid,
                      ),
                    ),
                    Expanded(
                      child: containerBottom(
                        () => laucherURL(AssetsUtil.cvDev2026),
                        AssetsUtil.cvDev2026,
                        'cv_sep_2026',
                        width: double.infinity,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            color: Colors.transparent,
            title: (al?.aboutMe ?? 'Sobre mí').toUpperCase(),
          ),
        ],
      ),
    );
  }

  Widget _buildContainerInfo(AppLocalizations? al, Widget child,
      {double? height, Color? color, String? title}) {
    final useSurface = color == null || color == Colors.transparent;
    final content = Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (title != null && title.isNotEmpty) ...[
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 3,
                height:
                    TextStyleSize.textTitleSectionSize(context.screenWidth) *
                        0.7,
                decoration: BoxDecoration(
                  color: UtilsColor.colorBlue,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              SizedBox(width: SizeUtils.s),
              Expanded(
                child: Text(
                  title,
                  style: StyleText.textPortfolio(
                    fontWeight: FontWeight.w700,
                    fontSize:
                        TextStyleSize.textTitleSectionSize(context.screenWidth),
                    color: UtilsColor.colorSecondaryWhite,
                    height: 1.15,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: SizeUtils.s),
          Divider(
            height: 1,
            thickness: 1,
            color: UtilsColor.hairline,
          ),
          SizedBox(height: SizeUtils.l),
        ],
        child,
      ],
    );

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: SizeUtils.s,
        vertical: SizeUtils.l,
      ),
      child: Container(
        height: height,
        decoration: BoxDecoration(
          color: useSurface
              ? UtilsColor.colorSurface.withValues(alpha: 0.88)
              : color,
          border: Border.all(color: UtilsColor.hairline),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: EdgeInsets.all(SizeUtils.l),
          child:
              height != null ? SingleChildScrollView(child: content) : content,
        ),
      ),
    );
  }

  Widget _buildSectionsColumn(
      BuildContext context, List<({String id, String label})> sections) {
    final fontSize =
        TextStyleSize.textDescriptionSize(context.screenWidth) * 1.05;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: sections
          .map(
            (section) => GestureDetector(
              onTap: () {
                _scrollToSection(section.id);
                Navigator.pop(context);
              },
              child: MouseRegion(
                cursor: SystemMouseCursors.click,
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: SizeUtils.s / 2),
                  child: Text(
                    section.label,
                    style: StyleText.textPortfolio(
                      fontSize: fontSize,
                      fontWeight: FontWeight.w500,
                      color: UtilsColor.colorMuted,
                    ),
                  ),
                ),
              ),
            ),
          )
          .toList(),
    );
  }

  Widget _buildSectionContent(String title, GlobalKey key) {
    if (title.isEmpty) {
      return SizedBox(key: key, height: 0);
    }
    return Container(
      key: key,
      child: Text(title,
          style: StyleText.textPortfolioDancingScript(
              fontWeight: FontWeight.w100,
              color: UtilsColor.colorSecondaryWhite,
              fontSize: SizeUtils.s1)),
    );
  }
}

Widget buildRowName(
  BuildContext context, {
  bool? visibility = false,
  bool? visibilityNameW = false,
  String? text,
  double? fontSize,
  bool animateEntrance = false,
}) {
  final al = AppLocalizations.of(context)!;
  final isNarrow = context.isMobile || context.isMobileLarge;
  final stickerSize = isNarrow ? 128.0 : 188.0;
  final greetingSize =
      TextStyleSize.textDescriptionSize(context.screenWidth) * 0.88;
  final nameSize = fontSize ??
      TextStyleSize.textTitleSectionSize(context.screenWidth) *
          (isNarrow ? 1.05 : 1.12);
  final roleSize =
      TextStyleSize.textDescriptionSize(context.screenWidth) * 0.95;

  Widget wrap(int index, Widget child) {
    if (!animateEntrance) return child;
    return StaggerFadeIn(index: index, child: child);
  }

  if (visibilityNameW == true) {
    return Column(
      children: [
        Text(
          text ?? 'Alberto Guaman'.toUpperCase(),
          textAlign: TextAlign.center,
          style: StyleText.textPortfolio(
            fontWeight: FontWeight.bold,
            color: UtilsColor.colorBlue,
            fontSize: TextStyleSize.textDescriptionSize(context.screenWidth),
          ),
        ),
        SizedBox(height: SizeUtils.s),
        const AvatarSticker(size: 104),
      ],
    );
  }

  final identity = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        text ?? al.helloWordIam.toUpperCase(),
        style: StyleText.textPortfolio(
          fontWeight: FontWeight.w600,
          color: UtilsColor.colorBlue,
          fontSize: greetingSize,
          height: 1.2,
        ).copyWith(letterSpacing: 1.6),
      ),
      SizedBox(height: SizeUtils.s),
      FittedBox(
        fit: BoxFit.scaleDown,
        alignment: Alignment.centerLeft,
        child: Text(
          'Alberto Guaman'.toUpperCase(),
          style: StyleText.textPortfolio(
            fontWeight: FontWeight.w700,
            fontSize: nameSize,
            height: 1.05,
            color: UtilsColor.colorSecondaryWhite,
          ).copyWith(letterSpacing: 0.8),
        ),
      ),
      SizedBox(height: SizeUtils.m),
      Row(
        children: [
          Container(
            width: isNarrow ? 28 : 42,
            height: 3,
            decoration: BoxDecoration(
              color: UtilsColor.colorBlue,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          SizedBox(width: SizeUtils.s),
          Flexible(
            child: Text(
              isNarrow ? al.administratorItShort : al.administratorIt,
              style: StyleText.textPortfolio(
                color: UtilsColor.colorSecondaryWhite.withValues(alpha: 0.72),
                fontSize: roleSize,
                height: 1.35,
              ),
            ),
          ),
        ],
      ),
    ],
  );

  final avatar = wrap(
    1,
    Stack(
      alignment: Alignment.center,
      clipBehavior: Clip.none,
      children: [
        Container(
          width: stickerSize * 1.15,
          height: stickerSize * 1.15,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: RadialGradient(
              colors: [
                UtilsColor.colorBlue.withValues(alpha: 0.28),
                UtilsColor.colorBlue.withValues(alpha: 0.0),
              ],
            ),
          ),
        ),
        AvatarSticker(size: stickerSize),
      ],
    ),
  );

  return Padding(
    padding: EdgeInsets.symmetric(
      horizontal: SizeUtils.s1,
      vertical: SizeUtils.s,
    ),
    child: ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 980),
      child: Column(
        children: [
          wrap(
            0,
            Stack(
              alignment: Alignment.center,
              clipBehavior: Clip.none,
              children: [
                Positioned.fill(
                  child: IgnorePointer(
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(SizeUtils.xl),
                        gradient: RadialGradient(
                          center: const Alignment(0.55, -0.1),
                          radius: 1.05,
                          colors: [
                            UtilsColor.colorBlue.withValues(alpha: 0.16),
                            UtilsColor.colorBlue.withValues(alpha: 0.04),
                            Colors.transparent,
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: isNarrow ? SizeUtils.m : SizeUtils.l,
                    vertical: isNarrow ? SizeUtils.l : SizeUtils.xl,
                  ),
                  child: isNarrow
                      ? Column(
                          children: [
                            identity,
                            SizedBox(height: SizeUtils.l),
                            avatar,
                          ],
                        )
                      : Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(child: identity),
                            SizedBox(width: SizeUtils.xl),
                            avatar,
                          ],
                        ),
                ),
              ],
            ),
          ),
          if (visibility == false) ...[
            SizedBox(height: SizeUtils.l),
            wrap(2, iconDataRow()),
            SizedBox(height: SizeUtils.l),
            wrap(
              3,
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 560),
                child: const AvailabilityBadge(),
              ),
            ),
          ],
        ],
      ),
    ),
  );
}

