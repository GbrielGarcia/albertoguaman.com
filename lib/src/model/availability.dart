/// Disponibilidad y preferencias laborales (visible en inicio / contacto).
class AvailabilityInfo {
  final String status;
  final String location;
  final String workMode;
  final String contract;
  final String preferredStack;
  final String note;

  const AvailabilityInfo({
    required this.status,
    required this.location,
    required this.workMode,
    required this.contract,
    required this.preferredStack,
    required this.note,
  });
}

const AvailabilityInfo siteAvailability = AvailabilityInfo(
  status: 'Abierto a oportunidades',
  location: 'Ecuador (GMT-5)',
  workMode: 'Remoto · híbrido · presencial según acuerdo',
  contract: 'Tiempo completo · proyectos · soporte continuo',
  preferredStack:
      'Flutter / Dart · Java / MDM · soporte IT · web · e-commerce operativo',
  note:
      'Busco roles donde pueda combinar desarrollo y operación técnica con impacto medible.',
);
