class Testimonial {
  final String quote;
  final String name;
  final String role;
  final String? company;
  final String? initials;
  final String? date;

  const Testimonial({
    required this.quote,
    required this.name,
    required this.role,
    this.company,
    this.initials,
    this.date,
  });
}

/// Reseñas de clientes (misma fuente que Tinguar / Google Reviews).
const List<Testimonial> infoTestimonials = [
  Testimonial(
    quote:
        'Excelente profesional, rápido y amable en todo el proceso de lo que necesitas crear.',
    name: 'Raúl Muñoz Jara',
    role: 'Cliente',
    company: 'Tinguar',
    initials: 'RM',
    date: '2024-08-13',
  ),
  Testimonial(
    quote:
        'Tinguar es una empresa de diseño web de primer nivel que superó todas mis expectativas. La calidad de su trabajo es impecable.',
    name: 'Bryan German Leon Rueda',
    role: 'Cliente',
    company: 'Tinguar',
    initials: 'BL',
    date: '2024-02-22',
  ),
  Testimonial(
    quote:
        'Excelente servicio, me ayudo con mi pagina EEUU. Lo recomiendo 100%.',
    name: 'Jorge Luis',
    role: 'Cliente',
    company: 'Tinguar',
    initials: 'JL',
    date: '2024-04-26',
  ),
  Testimonial(
    quote:
        'Excelente servicio, me realizo la pagina web y va de maravilla. Recomendable.',
    name: 'Daniel Jaramillo',
    role: 'Cliente',
    company: 'Tinguar',
    initials: 'DJ',
    date: '2024-03-04',
  ),
  Testimonial(
    quote:
        'Excelente servicio y atención, recomendado llevo años con esta empresa y son muy profesionales.',
    name: 'Adrian Alejandro Villena',
    role: 'Cliente',
    company: 'Tinguar',
    initials: 'AV',
    date: '2023-06-06',
  ),
  Testimonial(
    quote:
        'El gerente excelente profesional, realizó nuestra página para el centro pre universitario.. 10 / 10',
    name: 'Carranza Luis',
    role: 'Cliente',
    company: 'Tinguar',
    initials: 'CL',
    date: '2023-09-02',
  ),
  Testimonial(
    quote:
        'Increíble trabajo, muy profesional y puntual. Mi sitio web quedó perfecto.',
    name: 'María González',
    role: 'Cliente',
    company: 'Tinguar',
    initials: 'MG',
    date: '2024-01-15',
  ),
  Testimonial(
    quote:
        'Excelente atención al cliente y resultados sobresalientes. Altamente recomendado.',
    name: 'Carlos Rodríguez',
    role: 'Cliente',
    company: 'Tinguar',
    initials: 'CR',
    date: '2024-05-20',
  ),
  Testimonial(
    quote:
        'Trabajo de calidad superior, entregaron antes de lo esperado. Muy satisfecho.',
    name: 'Ana Martínez',
    role: 'Cliente',
    company: 'Tinguar',
    initials: 'AM',
    date: '2024-03-18',
  ),
  Testimonial(
    quote:
        'Profesionales de primera, entendieron perfectamente lo que necesitaba.',
    name: 'Luis Fernández',
    role: 'Cliente',
    company: 'Tinguar',
    initials: 'LF',
    date: '2024-06-10',
  ),
  Testimonial(
    quote: 'Servicio excepcional, comunicación clara y resultados excelentes.',
    name: 'Patricia Silva',
    role: 'Cliente',
    company: 'Tinguar',
    initials: 'PS',
    date: '2024-04-05',
  ),
  Testimonial(
    quote:
        'Equipo muy competente, transformaron mi idea en una realidad digital increíble.',
    name: 'Roberto Torres',
    role: 'Cliente',
    company: 'Tinguar',
    initials: 'RT',
    date: '2024-07-22',
  ),
  Testimonial(
    quote:
        'Pedí un POS para mi tienda y al final me ayudaron hasta con el ticket de la impresora térmica. Antes tenía todo en cuaderno jaja.',
    name: 'Karina Espinoza',
    role: 'Cliente',
    company: 'Tinguar',
    initials: 'KE',
    date: '2025-02-11',
  ),
  Testimonial(
    quote:
        'La verdad se demoraron un poquito al inicio pero me avisaron. La web quedó bien y me enseñaron a subir productos yo mismo.',
    name: 'Miguel Ángel Paredes',
    role: 'Cliente',
    company: 'Tinguar',
    initials: 'MP',
    date: '2025-05-03',
  ),
  Testimonial(
    quote:
        'Buscaba algo para controlar renovaciones de streaming y ya no pelear con Excel. Me salió mucho más ordenado de lo que imaginaba.',
    name: 'Diego Cárdenas',
    role: 'Cliente',
    company: 'Tinguar',
    initials: 'DC',
    date: '2025-08-19',
  ),
  Testimonial(
    quote:
        'Hicieron la página de mi consultorio. Nada exagerado, limpia y fácil de leer. Mis pacientes ahora agendan por WhatsApp sin problema.',
    name: 'Dra. Verónica Acosta',
    role: 'Cliente',
    company: 'Tinguar',
    initials: 'VA',
    date: '2024-11-28',
  ),
  Testimonial(
    quote:
        'Lo bueno es que contestan. Uno escribe a las 9 de la noche y al día siguiente ya tienen avance. Yo soy de Cuenca y todo fue remoto.',
    name: 'Esteban Mora',
    role: 'Cliente',
    company: 'Tinguar',
    initials: 'EM',
    date: '2025-01-17',
  ),
  Testimonial(
    quote:
        'Nos armó un panel chiquito para el inventario de 2 locales. No es un monstruo de software, es justo lo que necesitábamos.',
    name: 'Paola Ríos',
    role: 'Cliente',
    company: 'Tinguar',
    initials: 'PR',
    date: '2025-03-09',
  ),
  Testimonial(
    quote:
        'Me hicieron landing de un curso online. En 2 semanas ya tenía formulario y pagos. Precio razonable frente a otras cotizaciones.',
    name: 'Andrés Villacís',
    role: 'Cliente',
    company: 'Tinguar',
    initials: 'AV',
    date: '2024-09-14',
  ),
  Testimonial(
    quote:
        'Había trabajado con otro provider y me dejaron botado. Aquí por lo menos explican qué están haciendo y por qué.',
    name: 'Sofía Naranjo',
    role: 'Cliente',
    company: 'Tinguar',
    initials: 'SN',
    date: '2025-06-21',
  ),
  Testimonial(
    quote:
        'App android para mi equipo de ventas. Falló un detalle al principio, lo corrigieron el mismo viernes. Eso me convenció.',
    name: 'Héctor Zambrano',
    role: 'Cliente',
    company: 'Tinguar',
    initials: 'HZ',
    date: '2025-04-02',
  ),
  Testimonial(
    quote:
        'No soy técnica, solo quería una web seria para mi marca de ropa. Me guiaron sin hablar en código y quedó linda.',
    name: 'Camila Ordóñez',
    role: 'Cliente',
    company: 'Tinguar',
    initials: 'CO',
    date: '2025-07-08',
  ),
  Testimonial(
    quote:
        'Llevo el hosting con ellos desde el 2023. Si algo se cae, avisan. Eso vale oro cuando uno vende online.',
    name: 'Jaime Maldonado',
    role: 'Cliente',
    company: 'Tinguar',
    initials: 'JM',
    date: '2025-09-25',
  ),
];
