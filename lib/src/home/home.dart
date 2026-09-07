import 'dart:async';

import "package:albertoguaman/src/model/model.dart";

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

/// Colores claros para la barra animada (fondo oscuro).
final List<Color> _animatedBarColors = [
  UtilsColor.colorYellow,
  UtilsColor.colorPink,
  UtilsColor.colorBlue,
  Colors.cyanAccent,
  Colors.greenAccent,
  Colors.orangeAccent,
];

class _PortfolioScreenState extends State<HomeSrc> {
  late List<bool> inHovered;
  late List<bool> inHoveredBook;

  final ScrollController _scrollController = ScrollController();
  final ScrollController _galleryForwardController = ScrollController();
  final ScrollController _galleryReverseController = ScrollController();
  final ScrollController _galleryThirdController = ScrollController();
  Timer? _colorBarTimer;
  Timer? _galleryAutoScrollTimer;
  int _barColorIndex = 0;
  bool _navPinned = false;

  @override
  void initState() {
    super.initState();
    inHovered = List<bool>.filled(infoProjectModel.length, false);
    inHoveredBook = List<bool>.filled(infoBookModel.length, false);
    _scrollController.addListener(_onScrollPinNav);
    _colorBarTimer = Timer.periodic(const Duration(milliseconds: 2500), (_) {
      if (mounted) {
        setState(() {
          _barColorIndex = (_barColorIndex + 1) % _animatedBarColors.length;
        });
      }
    });
    _galleryAutoScrollTimer =
        Timer.periodic(const Duration(milliseconds: 30), (_) {
      _moveGalleryRow(_galleryForwardController, 0.45);
      _moveGalleryRow(_galleryReverseController, 0.38);
      _moveGalleryRow(_galleryThirdController, 0.32);
    });
  }

  void _moveGalleryRow(ScrollController controller, double step) {
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

  void _onScrollPinNav() {
    final pinned = _scrollController.offset > 140;
    if (pinned != _navPinned && mounted) {
      setState(() => _navPinned = pinned);
    }
  }

  @override
  void dispose() {
    _colorBarTimer?.cancel();
    _galleryAutoScrollTimer?.cancel();
    _scrollController.removeListener(_onScrollPinNav);
    _scrollController.dispose();
    _galleryForwardController.dispose();
    _galleryReverseController.dispose();
    _galleryThirdController.dispose();
    super.dispose();
  }

  void _scrollToSection(String section) {
    final key = sectionKeys[section];
    if (key?.currentContext != null) {
      // Deja aire bajo el menú fijo al saltar a una sección.
      Scrollable.ensureVisible(
        key!.currentContext!,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
        alignment: _navPinned ? 0.08 : 0.0,
      );
    }
  }

  List<({String id, String label})> _sections(AppLocalizations al) => [
        (id: SectionId.about, label: al.aboutMe),
        (id: SectionId.experience, label: al.experience),
        (id: SectionId.skills, label: al.skills),
        (id: SectionId.projects, label: al.project),
        (id: SectionId.publications, label: al.publications),
        (id: SectionId.gallery, label: al.gallery),
      ];

  @override
  Widget build(BuildContext context) {
    final al = AppLocalizations.of(context)!;
    final sections = _sections(al);
    final isNarrow = context.isMobile || context.isMobileLarge;

    return Scaffold(
      drawer: isNarrow
          ? Drawer(
              backgroundColor: UtilsColor.colorPrimaryDark,
              child: SafeArea(
                child: Column(
                  children: [
                    SizedBox(height: SizeUtils.xl1),
                    buildRowName(context,
                        visibility: true,
                        visibilityNameW: true,
                        text: 'Alberto Guaman'.toUpperCase()),
                    SizedBox(height: SizeUtils.s1),
                    _buildSectionsColumn(context, sections),
                  ],
                ),
              ),
            )
          : null,
      appBar: isNarrow
          ? AppBar(
              backgroundColor: UtilsColor.colorPrimaryDark,
              elevation: 0,
              iconTheme: IconThemeData(color: UtilsColor.colorSecondaryWhite),
            )
          : null,
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
              particleCount: 110,
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
          if (_navPinned)
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Material(
                color: UtilsColor.colorPrimaryDark.withValues(alpha: 0.94),
                elevation: 10,
                child: SafeArea(
                  bottom: false,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: SizeUtils.s,
                      horizontal: SizeUtils.s,
                    ),
                    child: _buildSectionsRow(context, sections),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildHomeColumn(
      AppLocalizations al, List<({String id, String label})> sections) {
    return Column(
      children: [
        SizedBox(height: SizeUtils.m),
        buildRowName(context, animateEntrance: true),
        SizedBox(height: SizeUtils.m),
        StaggerFadeIn(
          index: 4,
          child: _buildSectionsRow(context, sections),
        ),
        SizedBox(height: SizeUtils.s),
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
        _buildSectionContent('', sectionKeys[SectionId.publications]!),
        ScrollReveal(
          controller: _scrollController,
          delay: const Duration(milliseconds: 60),
          child: _buildPublications(al),
        ),
        _buildSectionContent('', sectionKeys[SectionId.gallery]!),
        ScrollReveal(
          controller: _scrollController,
          delay: const Duration(milliseconds: 60),
          child: _buildGallery(al),
        ),
        footerData(al, context.screenWidth),
        SizedBox(height: SizeUtils.xl1),
      ],
    );
  }

  Widget _buildGallery(AppLocalizations? al) {
    final isNarrow = context.isMobile || context.isMobileLarge;
    final tileSize = isNarrow ? 156.0 : 210.0;
    final firstRow = <int>[
      for (var i = 0; i < infoGalleryItems.length; i += 3) i,
    ];
    final secondRow = <int>[
      for (var i = 1; i < infoGalleryItems.length; i += 3) i,
    ];
    final thirdRow = <int>[
      for (var i = 2; i < infoGalleryItems.length; i += 3) i,
    ];

    return ResponsiveCenter(
      child: _buildContainerInfo(
        al,
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              al?.galleryHint ??
                  'Una mirada a algunos momentos de mi día a día.',
              style: StyleText.textPortfolio(
                fontSize:
                    TextStyleSize.textDescriptionSize(context.screenWidth),
                color: UtilsColor.colorSecondaryWhite.withValues(alpha: 0.75),
              ),
            ),
            SizedBox(height: SizeUtils.m),
            _buildGalleryRow(
              indexes: firstRow,
              controller: _galleryForwardController,
              tileSize: tileSize,
            ),
            SizedBox(height: SizeUtils.s),
            _buildGalleryRow(
              indexes: secondRow,
              controller: _galleryReverseController,
              tileSize: tileSize,
              reverse: true,
            ),
            SizedBox(height: SizeUtils.s),
            _buildGalleryRow(
              indexes: thirdRow,
              controller: _galleryThirdController,
              tileSize: tileSize,
            ),
          ],
        ),
        color: Colors.transparent,
        title: al!.gallery,
      ),
    );
  }

  Widget _buildGalleryRow({
    required List<int> indexes,
    required ScrollController controller,
    required double tileSize,
    bool reverse = false,
  }) {
    return SizedBox(
      height: tileSize,
      child: ListView.separated(
        controller: controller,
        scrollDirection: Axis.horizontal,
        reverse: reverse,
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: SizeUtils.s),
        itemCount: indexes.length,
        separatorBuilder: (_, __) => SizedBox(width: SizeUtils.s),
        itemBuilder: (context, position) {
          final index = indexes[position];
          final item = infoGalleryItems[index];
          return SizedBox(
            width: tileSize,
            child: HoverScale(
              child: GestureDetector(
                onTap: () => _openGalleryViewer(index),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(SizeUtils.m),
                  child: _buildGalleryImage(item.path, index),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildGalleryImage(String path, int index) {
    return Image.asset(
      path,
      fit: BoxFit.cover,
      frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
        if (wasSynchronouslyLoaded) return child;
        return AnimatedOpacity(
          opacity: frame == null ? 0 : 1,
          duration: Duration(milliseconds: 280 + (index % 5) * 110),
          curve: Curves.easeOut,
          child: AnimatedScale(
            scale: frame == null ? 0.94 : 1,
            duration: Duration(milliseconds: 320 + (index % 4) * 90),
            curve: Curves.easeOutCubic,
            child: child,
          ),
        );
      },
      errorBuilder: (_, __, ___) => ColoredBox(
        color: UtilsColor.colorSecondaryWhite.withValues(alpha: 0.08),
        child: Icon(
          Icons.image_not_supported_outlined,
          color: UtilsColor.colorSecondaryWhite.withValues(alpha: 0.5),
        ),
      ),
    );
  }

  void _openGalleryViewer(int initialIndex) {
    showDialog<void>(
      context: context,
      barrierColor: Colors.black.withValues(alpha: 0.9),
      builder: (dialogContext) {
        var page = initialIndex;
        return StatefulBuilder(
          builder: (context, setDialogState) {
            final item = infoGalleryItems[page];
            return Dialog(
              backgroundColor: Colors.transparent,
              insetPadding: EdgeInsets.all(SizeUtils.m),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Align(
                    alignment: Alignment.centerRight,
                    child: IconButton(
                      onPressed: () => Navigator.pop(dialogContext),
                      icon: Icon(
                        Icons.close,
                        color: UtilsColor.colorSecondaryWhite,
                      ),
                    ),
                  ),
                  Flexible(
                    child: InteractiveViewer(
                      child: Image.asset(
                        item.path,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  SizedBox(height: SizeUtils.s),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: page > 0
                            ? () => setDialogState(() => page--)
                            : null,
                        icon: Icon(
                          Icons.chevron_left,
                          color: UtilsColor.colorSecondaryWhite,
                        ),
                      ),
                      Text(
                        '${page + 1} / ${infoGalleryItems.length}',
                        style: StyleText.textPortfolio(
                          fontSize: SizeUtils.s1,
                        ),
                      ),
                      IconButton(
                        onPressed: page < infoGalleryItems.length - 1
                            ? () => setDialogState(() => page++)
                            : null,
                        icon: Icon(
                          Icons.chevron_right,
                          color: UtilsColor.colorSecondaryWhite,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      },
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
            inHovered[index] ? 0.2 : 1.0,
            UtilsColor.colorYellow,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(project.title,
                    style: StyleText.textPortfolio(
                      color: UtilsColor.colorPrimaryDark,
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
                      color: UtilsColor.colorPrimaryDark,
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
        padding: EdgeInsets.all(SizeUtils.s),
        child: Material(
          color: UtilsColor.colorPink,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(SizeUtils.m),
            side: BorderSide(color: UtilsColor.colorPink),
          ),
          clipBehavior: Clip.antiAlias,
          child: Theme(
            data: Theme.of(context).copyWith(
              dividerColor: Colors.transparent,
              expansionTileTheme: ExpansionTileThemeData(
                iconColor: UtilsColor.colorSecondaryWhite,
                collapsedIconColor: UtilsColor.colorSecondaryWhite,
                textColor: UtilsColor.colorSecondaryWhite,
                collapsedTextColor: UtilsColor.colorSecondaryWhite,
              ),
            ),
            child: ExpansionTile(
              initiallyExpanded: false,
              tilePadding: EdgeInsets.symmetric(
                  horizontal: SizeUtils.s, vertical: SizeUtils.s),
              title: Text(
                '${al?.project ?? 'Proyectos'} (${infoProjectModel.length})',
                style: StyleText.textPortfolio(
                  fontWeight: FontWeight.bold,
                  fontSize:
                      TextStyleSize.textTitleSectionSize(context.screenWidth),
                  color: UtilsColor.colorSecondaryWhite,
                ),
              ),
              subtitle: Padding(
                padding: EdgeInsets.only(top: SizeUtils.s),
                child: Text(
                  al?.projectsTapToExpand ??
                      'Clic para ver la lista de proyectos',
                  style: StyleText.textPortfolio(
                    fontSize:
                        TextStyleSize.textDescriptionSize(context.screenWidth),
                    color: UtilsColor.colorSecondaryWhite,
                  ),
                ),
              ),
              children: [
                Padding(
                  padding: EdgeInsets.all(SizeUtils.s),
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
          containerBottom(() {
            context.go('/bio');
          }, 'https://www.albertoguaman.com/bio',
              al?.quickLinks ?? 'Enlaces rápidos',
              width: double.infinity),
          _buildContainerInfo(
            al,
            const AboutProfileContent(),
            title: (al?.aboutMe ?? 'Sobre mí').toUpperCase(),
          ),
          Row(
            children: [
              Expanded(
                child: containerBottom(
                    () => laucherURL('https://wa.me/593992889078'),
                    '+593 99 288 9078',
                    al?.contacMe ?? 'Contáctame',
                    width: double.infinity),
              ),
              Expanded(
                child: containerBottom(() => laucherURL(AssetsUtil.cvDev2026),
                    AssetsUtil.cvDev2026, 'cv_sep_2026',
                    width: double.infinity),
              ),
              Flexible(
                  flex: 1,
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      final maxH = constraints.maxHeight;
                      final maxW = constraints.maxWidth;
                      final height = maxH.isFinite && maxH > 0
                          ? maxH.clamp(0.0, SizeUtils.xlq)
                          : SizeUtils.xlq;
                      final color = _animatedBarColors[_barColorIndex];
                      return Padding(
                        padding: EdgeInsets.all(SizeUtils.s),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 1200),
                          curve: Curves.easeInOut,
                          width: maxW,
                          height: height,
                          decoration: BoxDecoration(
                            color: color,
                            border: Border.all(color: color),
                            borderRadius: BorderRadius.circular(SizeUtils.m),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(SizeUtils.s),
                            child: const SizedBox.shrink(),
                          ),
                        ),
                      );
                    },
                  )),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildContainerInfo(AppLocalizations? al, Widget child,
      {double? height, Color? color, String? title}) {
    final content = Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(title ?? '',
            style: StyleText.textPortfolio(
              fontWeight: FontWeight.bold,
              fontSize: TextStyleSize.textTitleSectionSize(context.screenWidth),
            )),
        child,
      ],
    );
    return Padding(
      padding: EdgeInsets.all(SizeUtils.s),
      child: Container(
        height: height,
        decoration: BoxDecoration(
            color: color ?? UtilsColor.colorBlue,
            border: Border.all(color: color ?? UtilsColor.colorBlue),
            borderRadius: BorderRadius.circular(SizeUtils.m)),
        child: Padding(
          padding: EdgeInsets.all(SizeUtils.s),
          child:
              height != null ? SingleChildScrollView(child: content) : content,
        ),
      ),
    );
  }

  Widget _buildSectionsRow(
      BuildContext context, List<({String id, String label})> sections) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: SizeUtils.s),
      child: Wrap(
        alignment: WrapAlignment.center,
        spacing: SizeUtils.s,
        runSpacing: SizeUtils.s,
        children: sections
            .map(
              (section) => GestureDetector(
                onTap: () => _scrollToSection(section.id),
                child: MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: Text(
                    section.label,
                    style: StyleText.textPortfolio(
                      fontSize: TextStyleSize.textDescriptionSize(
                          context.screenWidth),
                    ),
                  ),
                ),
              ),
            )
            .toList(),
      ),
    );
  }

  Widget _buildSectionsColumn(
      BuildContext context, List<({String id, String label})> sections) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: sections
          .map(
            (section) => GestureDetector(
              onTap: () {
                _scrollToSection(section.id);
                Navigator.pop(context);
              },
              child: Padding(
                padding: EdgeInsets.all(SizeUtils.s),
                child: MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: Text(
                    section.label,
                    style: StyleText.textPortfolio(
                      fontSize:
                          TextStyleSize.textTitleSize(context.screenWidth),
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
  final stickerSize = isNarrow ? 112.0 : 158.0;

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
            color: UtilsColor.colorYellow,
            fontSize: TextStyleSize.textDescriptionSize(context.screenWidth),
          ),
        ),
        SizedBox(height: SizeUtils.s),
        const AvatarSticker(size: 104),
      ],
    );
  }

  return Padding(
    padding: EdgeInsets.symmetric(horizontal: SizeUtils.s1),
    child: ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 680),
      child: Column(
        children: [
          wrap(
            0,
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: SizeUtils.s,
                vertical: SizeUtils.s,
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              text ?? al.helloWordIam.toUpperCase(),
                              textAlign: TextAlign.center,
                              style: StyleText.textPortfolio(
                                fontWeight: FontWeight.bold,
                                color: UtilsColor.colorYellow,
                                fontSize: TextStyleSize.textDescriptionSize(
                                    context.screenWidth),
                              ),
                            ),
                            SizedBox(height: SizeUtils.s / 2),
                            FittedBox(
                              fit: BoxFit.scaleDown,
                              alignment: Alignment.center,
                              child: Text(
                                'Alberto Guaman'.toUpperCase(),
                                style: StyleText.textPortfolio(
                                  fontWeight: FontWeight.bold,
                                  fontSize: fontSize ??
                                      TextStyleSize.textTitleSectionSize(
                                          context.screenWidth),
                                ),
                              ),
                            ),
                            SizedBox(height: SizeUtils.s / 2),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width: isNarrow ? 22 : 34,
                                  height: 2,
                                  color: UtilsColor.colorPink,
                                ),
                                SizedBox(width: SizeUtils.s),
                                Flexible(
                                  child: Text(
                                    isNarrow
                                        ? al.administratorItShort
                                        : al.administratorIt,
                                    textAlign: TextAlign.center,
                                    style: StyleText.textPortfolio(
                                      color: UtilsColor.colorSecondaryWhite
                                          .withValues(alpha: 0.7),
                                      fontSize:
                                          TextStyleSize.textDescriptionSize(
                                                  context.screenWidth) *
                                              0.9,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: isNarrow ? SizeUtils.s : SizeUtils.m),
                      wrap(
                        1,
                        AvatarSticker(size: stickerSize),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          if (visibility == false) ...[
            SizedBox(height: SizeUtils.m),
            wrap(2, iconDataRow()),
          ],
        ],
      ),
    ),
  );
}
