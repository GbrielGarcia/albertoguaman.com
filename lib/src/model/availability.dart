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
      'Java · MDM · Soporte L1/L2 IT · Flutter · Dart · Firebase · Full Stack',
  note:
      'Busco roles de desarrollo (Java/MDM/Flutter) y soporte técnico L1/L2 IT donde pueda aportar criterio, seguimiento y resultados.',
);
