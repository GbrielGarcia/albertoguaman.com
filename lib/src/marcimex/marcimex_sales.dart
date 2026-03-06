import 'package:albertoguaman/src/model/model.dart';
import 'package:albertoguaman/src/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

/// Página Asesor Comercial Marcimex – Alberto Guaman. Sin barra de volver.
class MarcimexSales extends StatelessWidget {
  const MarcimexSales({super.key});

  Future<void> _openUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  Future<void> _openWhatsApp() async {
    final c = marcimexContactData;
    final uri = Uri.parse(
      '${c.whatsappUrl}?text=${Uri.encodeComponent(c.whatsappMessage)}',
    );
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isNarrow = context.isMobile || context.isMobileLarge;

    return Scaffold(
      backgroundColor: const Color(0xFF0D0D0D),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _openWhatsApp,
        backgroundColor: const Color(0xFF25D366),
        icon: const Icon(Icons.chat, color: Colors.white),
        label: Text(
          'WhatsApp',
          style: StyleText.textPortfolio(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHero(context, isNarrow),
            _buildDaytonaBlock(context, isNarrow),
            _buildContactSection(context, isNarrow),
          ],
        ),
      ),
    );
  }

  static const String _fotoPath = 'assets/img/marcimex/alberto_foto.png';

  Widget _buildHero(BuildContext context, bool isNarrow) {
    final photoSize = isNarrow ? 180.0 : 220.0;
    final photo = Container(
      width: photoSize,
      height: photoSize,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: UtilsColor.colorYellow.withValues(alpha: 0.6),
          width: 3,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipOval(
        child: Image.asset(
          _fotoPath,
          fit: BoxFit.cover,
          width: photoSize,
          height: photoSize,
          errorBuilder: (_, __, ___) => Icon(
            Icons.person,
            size: photoSize * 0.5,
            color: Colors.white54,
          ),
        ),
      ),
    );

    final textBlock = Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment:
          isNarrow ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: [
        Text(
          'Asesor Comercial Marcimex',
          style: StyleText.textPortfolio(
            fontSize: isNarrow ? 22 : 26,
            fontWeight: FontWeight.w800,
            color: UtilsColor.colorYellow,
          ),
          textAlign: isNarrow ? TextAlign.center : TextAlign.left,
        ),
        SizedBox(height: SizeUtils.s),
        Text(
          'Alberto Guaman',
          style: StyleText.textPortfolio(
            fontSize: isNarrow ? 18 : 22,
            color: Colors.white70,
          ),
          textAlign: isNarrow ? TextAlign.center : TextAlign.left,
        ),
      ],
    );

    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(
        isNarrow ? SizeUtils.l : SizeUtils.xxl4,
        SizeUtils.xxl2 + MediaQuery.of(context).padding.top,
        isNarrow ? SizeUtils.l : SizeUtils.xxl4,
        SizeUtils.xxl2,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFF1a1a2e),
            UtilsColor.colorPrimaryDark,
            const Color(0xFF16213e),
          ],
        ),
      ),
      child: isNarrow
          ? Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                photo,
                SizedBox(height: SizeUtils.l),
                textBlock,
              ],
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                photo,
                SizedBox(width: SizeUtils.xl1),
                textBlock,
              ],
            ),
    );
  }

  /// Bloque conjunto: imágenes + textos Daytona desde el modelo.
  Widget _buildDaytonaBlock(BuildContext context, bool isNarrow) {
    final data = daytonaPromoData;
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: isNarrow ? SizeUtils.l : SizeUtils.xxl4,
        vertical: SizeUtils.xl1,
      ),
      child: Container(
        width: double.infinity,
        constraints: BoxConstraints(maxWidth: 720),
        padding: EdgeInsets.all(isNarrow ? SizeUtils.l : SizeUtils.xl),
        decoration: BoxDecoration(
          color: const Color(0xFF151520),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: UtilsColor.colorYellow.withValues(alpha: 0.35),
            width: 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildImageGrid(context, isNarrow, data.imagePaths),
            SizedBox(height: SizeUtils.xl),
            ...data.paragraphs.asMap().entries.map((e) {
              final i = e.key;
              final text = e.value;
              final isFirst = i == 0;
              final isCredit = i == 3;
              final isCta = i == 4;
              final fontSize = isNarrow
                  ? (isFirst ? 17.0 : (isCredit || isCta ? 15.0 : 14.0))
                  : (isFirst ? 20.0 : (isCredit || isCta ? 17.0 : 16.0));
              return Padding(
                padding: EdgeInsets.only(
                  bottom: i < data.paragraphs.length - 1
                      ? (isFirst ? SizeUtils.l : SizeUtils.s1)
                      : 0,
                ),
                child: Text(
                  text,
                  textAlign: TextAlign.center,
                  style: StyleText.textPortfolio(
                    fontSize: fontSize,
                    fontWeight: isFirst || isCredit || isCta
                        ? FontWeight.w600
                        : FontWeight.normal,
                    color: isFirst
                        ? UtilsColor.colorSecondaryWhite
                        : isCredit
                            ? UtilsColor.colorYellow
                            : isCta
                                ? UtilsColor.colorPink
                                : Colors.white70,
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildContactSection(BuildContext context, bool isNarrow) {
    final c = marcimexContactData;
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: isNarrow ? SizeUtils.l : SizeUtils.xxl4,
        vertical: SizeUtils.l,
      ),
      child: Container(
        width: double.infinity,
        constraints: BoxConstraints(maxWidth: 500),
        padding: EdgeInsets.all(isNarrow ? SizeUtils.l : SizeUtils.xl),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              UtilsColor.colorBlue.withValues(alpha: 0.2),
              UtilsColor.colorPink.withValues(alpha: 0.15),
            ],
          ),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: UtilsColor.colorYellow.withValues(alpha: 0.4),
            width: 1,
          ),
        ),
        child: Column(
          children: [
            Text(
              '📍 ${c.place}',
              textAlign: TextAlign.center,
              style: StyleText.textPortfolio(
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: SizeUtils.s),
            Text(
              '📲 Asesor: ${c.asesorName}',
              textAlign: TextAlign.center,
              style: StyleText.textPortfolio(
                fontSize: 15,
                color: Colors.white70,
              ),
            ),
            SizedBox(height: SizeUtils.s),
            InkWell(
              onTap: _openWhatsApp,
              child: Text(
                '📞 ${c.phone}',
                textAlign: TextAlign.center,
                style: StyleText.textPortfolio(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: UtilsColor.colorYellow,
                ),
              ),
            ),
            SizedBox(height: SizeUtils.l),
            InkWell(
              onTap: () => _openUrl(c.liliBotUrl),
              child: Text(
                '🔗 ${c.liliBotUrl}',
                textAlign: TextAlign.center,
                style: StyleText.textPortfolio(
                  fontSize: 14,
                  color: UtilsColor.colorBlue,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            SizedBox(height: SizeUtils.l),
            TextButton(
              onPressed: () => context.go('/'),
              child: Text(
                'Ver portafolio · albertoguaman.com',
                style: StyleText.textPortfolio(
                  fontSize: 13,
                  color: Colors.white54,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImageGrid(
      BuildContext context, bool isNarrow, List<String> imagePaths) {
    final spacing = SizeUtils.s1;
    if (isNarrow) {
      return _NarrowImageCarousel(
        imagePaths: imagePaths,
        onImageTap: (index) => _openImageViewer(context, imagePaths, index),
      );
    }
    // En pantalla grande: 3 imágenes en fila.
    return LayoutBuilder(
      builder: (context, constraints) {
        const crossAxisCount = 3;
        final width = (constraints.maxWidth - spacing * (crossAxisCount - 1)) /
            crossAxisCount;
        return Wrap(
          spacing: spacing,
          runSpacing: spacing,
          alignment: WrapAlignment.center,
          children: List.generate(
            imagePaths.length,
            (index) {
              final assetPath = imagePaths[index];
              return GestureDetector(
                onTap: () => _openImageViewer(context, imagePaths, index),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: SizedBox(
                    width: width,
                    child: AspectRatio(
                      aspectRatio: 4 / 3,
                      child: Image.asset(
                        assetPath,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => Container(
                          color: Colors.white12,
                          child: Icon(
                            Icons.two_wheeler,
                            size: 48,
                            color: Colors.white24,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  void _openImageViewer(
      BuildContext context, List<String> imagePaths, int initialIndex) {
    Navigator.of(context).push(
      PageRouteBuilder(
        opaque: true,
        barrierColor: Colors.black87,
        pageBuilder: (_, __, ___) => _DaytonaImageViewer(
          imagePaths: imagePaths,
          initialIndex: initialIndex,
        ),
      ),
    );
  }
}

/// Carrusel de imágenes en pantalla pequeña con flechas que indican más imágenes.
class _NarrowImageCarousel extends StatefulWidget {
  const _NarrowImageCarousel({
    required this.imagePaths,
    required this.onImageTap,
  });

  final List<String> imagePaths;
  final void Function(int index) onImageTap;

  @override
  State<_NarrowImageCarousel> createState() => _NarrowImageCarouselState();
}

class _NarrowImageCarouselState extends State<_NarrowImageCarousel> {
  late PageController _pageController;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = (MediaQuery.of(context).size.width - 32) * (3 / 4);
    final hasMultiple = widget.imagePaths.length > 1;

    return SizedBox(
      height: height,
      child: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            itemCount: widget.imagePaths.length,
            onPageChanged: (i) => setState(() => _currentIndex = i),
            itemBuilder: (context, index) {
              final assetPath = widget.imagePaths[index];
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: GestureDetector(
                  onTap: () => widget.onImageTap(index),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      assetPath,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      errorBuilder: (_, __, ___) => Container(
                        color: Colors.white12,
                        child: Icon(
                          Icons.two_wheeler,
                          size: 48,
                          color: Colors.white24,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
          if (hasMultiple) ...[
            Positioned(
              left: 0,
              top: 0,
              bottom: 0,
              child: Center(
                child: IconButton(
                  onPressed: _currentIndex > 0
                      ? () {
                          _pageController.previousPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeOut,
                          );
                        }
                      : null,
                  icon: Icon(
                    Icons.chevron_left,
                    size: 36,
                    color: _currentIndex > 0
                        ? Colors.white
                        : Colors.white24,
                  ),
                  style: IconButton.styleFrom(
                    backgroundColor: Colors.black38,
                  ),
                ),
              ),
            ),
            Positioned(
              right: 0,
              top: 0,
              bottom: 0,
              child: Center(
                child: IconButton(
                  onPressed: _currentIndex < widget.imagePaths.length - 1
                      ? () {
                          _pageController.nextPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeOut,
                          );
                        }
                      : null,
                  icon: Icon(
                    Icons.chevron_right,
                    size: 36,
                    color: _currentIndex < widget.imagePaths.length - 1
                        ? Colors.white
                        : Colors.white24,
                  ),
                  style: IconButton.styleFrom(
                    backgroundColor: Colors.black38,
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

/// Visor a pantalla completa: imagen ampliada y deslizar para cambiar.
class _DaytonaImageViewer extends StatefulWidget {
  const _DaytonaImageViewer({
    required this.imagePaths,
    required this.initialIndex,
  });

  final List<String> imagePaths;
  final int initialIndex;

  @override
  State<_DaytonaImageViewer> createState() => _DaytonaImageViewerState();
}

class _DaytonaImageViewerState extends State<_DaytonaImageViewer> {
  late PageController _pageController;
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: widget.initialIndex);
    _currentIndex = widget.initialIndex;
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final hasMultiple = widget.imagePaths.length > 1;
    return GestureDetector(
      onTap: () => Navigator.of(context).pop(),
      behavior: HitTestBehavior.opaque,
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Stack(
          children: [
            PageView.builder(
            controller: _pageController,
            itemCount: widget.imagePaths.length,
            onPageChanged: (i) => setState(() => _currentIndex = i),
            itemBuilder: (context, index) {
              return InteractiveViewer(
                minScale: 0.5,
                maxScale: 4.0,
                child: Center(
                  child: Image.asset(
                    widget.imagePaths[index],
                    fit: BoxFit.contain,
                    errorBuilder: (_, __, ___) => const Icon(
                      Icons.broken_image,
                      size: 80,
                      color: Colors.white54,
                    ),
                  ),
                ),
              );
            },
          ),
          Positioned(
            top: MediaQuery.of(context).padding.top + 8,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: const Icon(Icons.close, color: Colors.white, size: 32),
                  tooltip: 'Cerrar',
                  style: IconButton.styleFrom(
                    backgroundColor: Colors.black54,
                  ),
                ),
                if (hasMultiple)
                  Text(
                    '${_currentIndex + 1} / ${widget.imagePaths.length}',
                    style: StyleText.textPortfolio(
                      fontSize: 16,
                      color: Colors.white70,
                    ),
                  ),
                const SizedBox(width: 48),
              ],
            ),
          ),
          if (hasMultiple) ...[
            Positioned(
              left: 20,
              top: 0,
              bottom: 0,
              child: Center(
                child: IconButton(
                  onPressed: _currentIndex > 0
                      ? () {
                          _pageController.previousPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeOut,
                          );
                        }
                      : null,
                  icon: const Icon(Icons.chevron_left, color: Colors.white, size: 36),
                  style: IconButton.styleFrom(
                    backgroundColor: Colors.black54,
                    padding: const EdgeInsets.all(12),
                  ),
                ),
              ),
            ),
            Positioned(
              right: 20,
              top: 0,
              bottom: 0,
              child: Center(
                child: IconButton(
                  onPressed: _currentIndex < widget.imagePaths.length - 1
                      ? () {
                          _pageController.nextPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeOut,
                          );
                        }
                      : null,
                  icon: const Icon(Icons.chevron_right, color: Colors.white, size: 36),
                  style: IconButton.styleFrom(
                    backgroundColor: Colors.black54,
                    padding: const EdgeInsets.all(12),
                  ),
                ),
              ),
            ),
          ],
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: SafeArea(
              top: false,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (hasMultiple)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            onPressed: _currentIndex > 0
                                ? () {
                                    _pageController.previousPage(
                                      duration: const Duration(milliseconds: 300),
                                      curve: Curves.easeOut,
                                    );
                                  }
                                : null,
                            icon: const Icon(Icons.chevron_left, size: 32, color: Colors.white),
                            style: IconButton.styleFrom(
                              backgroundColor: Colors.white24,
                              padding: const EdgeInsets.all(8),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Text(
                              '${_currentIndex + 1} / ${widget.imagePaths.length}',
                              style: StyleText.textPortfolio(
                                fontSize: 15,
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          IconButton(
                            onPressed: _currentIndex < widget.imagePaths.length - 1
                                ? () {
                                    _pageController.nextPage(
                                      duration: const Duration(milliseconds: 300),
                                      curve: Curves.easeOut,
                                    );
                                  }
                                : null,
                            icon: const Icon(Icons.chevron_right, size: 32, color: Colors.white),
                            style: IconButton.styleFrom(
                              backgroundColor: Colors.white24,
                              padding: const EdgeInsets.all(8),
                            ),
                          ),
                        ],
                      ),
                    const SizedBox(height: 8),
                    Text(
                      'Toca en cualquier lugar para cerrar',
                      style: StyleText.textPortfolio(
                        fontSize: 13,
                        color: Colors.white54,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          ],
        ),
      ),
    );
  }
}
