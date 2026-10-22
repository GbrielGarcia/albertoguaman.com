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
      'Soporte L1/L2 IT · Helpdesk · Flutter · Dart · Firebase · Full Stack',
  note:
      'Busco roles de soporte técnico L1/L2 IT y desarrollo donde pueda aportar criterio, seguimiento y resultados.',
);
