import '../util/util.dart';

extension DoubleX on double {
  double sizeScaled(
    double screenWidth, {
    required double minSize,
  }) {
    const double minBP = BreakpointValues.mobile; // Accede al valor estático
    const double maxBP = BreakpointValues.desktop; // Accede al valor estático
    final maxSize = this;
    double scaledSize;

    if (screenWidth <= minBP) {
      // Para pantallas menores al breakpoint mínimo
      scaledSize = minSize;
    } else if (screenWidth >= maxBP) {
      // Para pantallas mayores al breakpoint máximo
      scaledSize = maxSize;
    } else {
      // Para pantallas entre los breakpoints
      final proportion = (screenWidth - minBP) / (maxBP - minBP);
      final calculatedResize = minSize + (maxSize - minSize) * proportion;
      scaledSize = calculatedResize.clamp(minSize, maxSize);
    }

    return scaledSize;
  }
}
