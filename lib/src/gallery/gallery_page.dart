import 'dart:async';

import 'package:albertoguaman/l10n/app_localizations.dart';
import 'package:albertoguaman/src/home/home.dart';
import 'package:albertoguaman/src/model/model.dart';
import 'package:albertoguaman/src/utils/utils.dart';
import 'package:albertoguaman/src/widget/widget.dart';
import 'package:flutter/material.dart';

class GalleryPage extends StatefulWidget {
  const GalleryPage({super.key});

  @override
  State<GalleryPage> createState() => _GalleryPageState();
}

class _GalleryPageState extends State<GalleryPage> {
  final ScrollController _forwardController = ScrollController();
  final ScrollController _reverseController = ScrollController();
  final ScrollController _thirdController = ScrollController();
  Timer? _autoScrollTimer;

  @override
  void initState() {
    super.initState();
    _autoScrollTimer = Timer.periodic(const Duration(milliseconds: 30), (_) {
      _moveRow(_forwardController, 0.45);
      _moveRow(_reverseController, 0.38);
      _moveRow(_thirdController, 0.32);
    });
  }

  void _moveRow(ScrollController controller, double step) {
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
    _autoScrollTimer?.cancel();
    _forwardController.dispose();
    _reverseController.dispose();
    _thirdController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final al = AppLocalizations.of(context)!;
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
      drawer: isNarrow
          ? Drawer(
              backgroundColor: UtilsColor.colorPrimaryDark,
              child: SafeArea(
                child: Column(
                  children: [
                    SizedBox(height: SizeUtils.xl1),
                    buildRowName(
                      context,
                      visibility: true,
                      visibilityNameW: true,
                      text: 'Alberto Guaman'.toUpperCase(),
                    ),
                    SizedBox(height: SizeUtils.s1),
                    SiteNav(
                      axis: Axis.vertical,
                      onNavigate: () => Navigator.pop(context),
                    ),
                  ],
                ),
              ),
            )
          : null,
      appBar: AppBar(
        backgroundColor: UtilsColor.colorPrimaryDark,
        elevation: 0,
        iconTheme: IconThemeData(color: UtilsColor.colorSecondaryWhite),
        title: Text(
          al.gallery,
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
                    constraints: const BoxConstraints(maxWidth: 1024),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const SiteNav(),
                        SizedBox(height: SizeUtils.l),
                        Text(
                          al.galleryHint,
                          style: StyleText.textPortfolio(
                            fontSize: TextStyleSize.textDescriptionSize(
                                context.screenWidth),
                            color: UtilsColor.colorSecondaryWhite
                                .withValues(alpha: 0.75),
                          ),
                        ),
                        SizedBox(height: SizeUtils.m),
                        _buildRow(
                          indexes: firstRow,
                          controller: _forwardController,
                          tileSize: tileSize,
                        ),
                        SizedBox(height: SizeUtils.s),
                        _buildRow(
                          indexes: secondRow,
                          controller: _reverseController,
                          tileSize: tileSize,
                          reverse: true,
                        ),
                        SizedBox(height: SizeUtils.s),
                        _buildRow(
                          indexes: thirdRow,
                          controller: _thirdController,
                          tileSize: tileSize,
                        ),
                        SizedBox(height: SizeUtils.xl),
                        footerData(al, context.screenWidth),
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

  Widget _buildRow({
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
                onTap: () => _openViewer(index),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(SizeUtils.m),
                  child: _buildImage(item.path, index),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildImage(String path, int index) {
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

  void _openViewer(int initialIndex) {
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
}
