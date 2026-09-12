class FaqItem {
  final String question;
  final String answer;

  const FaqItem({required this.question, required this.answer});
}

const List<FaqItem> infoFaqHowIWork = [
  FaqItem(
    question: '¿Cómo arranca un proyecto contigo?',
    answer:
        'Primero alineamos objetivo, alcance y urgencia (mensaje o llamada corta). '
        'Luego propongo un plan por etapas con entregas visibles: no “caja negra”.',
  ),
  FaqItem(
    question: '¿Cuánto tarda una primera versión?',
    answer:
        'Depende del alcance. Una landing o ajuste puede ir en días; un MVP de app o panel '
        'suele ir por sprints semanales con demos. Lo importante: ves avance, no solo promesas.',
  ),
  FaqItem(
    question: '¿Con qué herramientas trabajas?',
    answer:
        'Flutter/Dart, web (HTML/CSS/JS, Astro, WordPress), Java para MDM, Git, Firebase, '
        'helpdesk y stack de operación (inventario, facturación, paneles). Uso IA (Cursor, Claude) '
        'para acelerar sin soltar el criterio de lo que se entrega.',
  ),
  FaqItem(
    question: '¿Cómo nos comunicamos?',
    answer:
        'WhatsApp o email para el día a día; videollamada cuando hace falta decidir. '
        'Dejo registro de acuerdos, pendientes y próximos pasos para que no se pierda el hilo.',
  ),
  FaqItem(
    question: '¿Haces soporte después de entregar?',
    answer:
        'Sí. Puedo acompañar con soporte remoto, mantenimiento preventivo y mejoras. '
        'Acordamos canal, horarios y prioridades antes de empezar.',
  ),
  FaqItem(
    question: '¿Trabajas remoto o presencial?',
    answer:
        'Base en Ecuador (GMT-5). Remoto a nivel nacional e internacional; presencial '
        'cuando el proyecto lo requiere y se acuerda.',
  ),
];
