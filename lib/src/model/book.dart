class BookModel {
  final String title;
  final String description;
  final String doi;
  final String isbn;
  final String data;
  final String type;
  final String buttonVoidCall;
  final String buttonText;

  BookModel({
    required this.title,
    required this.description,
    required this.doi,
    required this.data,
    required this.isbn,
    required this.type,
    required this.buttonVoidCall,
    required this.buttonText,
  });
}

List<BookModel> infoBookModel = [
  BookModel(
      title:
          'Impacto del uso de flutter en el rendimiento académico de estudiantes de un instituto tecnológico',
      description:
          'Este estudio investiga el impacto del uso de Flutter en el rendimiento académico de los estudiantes de un instituto tecnológico. Se utilizó un diseño experimental con una muestra de 150 estudiantes de diversas carreras tecnológicas, divididos en un grupo experimental que usó Flutter y un grupo control con métodos tradicionales. Los resultados mostraron que el uso de Flutter mejoró significativamente el rendimiento académico, la satisfacción y la participación de los estudiantes. Estos hallazgos tienen implicaciones importantes para el desarrollo de programas educativos y políticas institucionales.',
      doi: '10.37811/cl_rcm.v8i4.12588',
      data: '2024-08-21',
      isbn: 'isbn',
      type: 'Articulo',
      buttonVoidCall: 'https://doi.org/10.37811/cl_rcm.v8i4.12588',
      buttonText: 'Ver Articulo'),
  BookModel(
      title: 'Manejo Eficaz de Aulas Virtuales: Guía Completa para Educadores',
      description:
          'En los últimos años, la educación ha experimentado una transformación significativa, impulsada por los avances tecnológicos y la creciente demanda de flexibilidad en los entornos de aprendizaje. Las aulas virtuales, una vez vistas como una alternativa complementaria a la educación tradicional, se han convertido en una parte integral del panorama educativo moderno. Este libro, “Manejo Eficaz de Aulas Virtuales: Guía Completa para Educadores”, surge de la necesidad de ofrecer una guía exhaustiva y práctica para aquellos que buscan mejorar la experiencia educativa en el entorno digital.',
      doi: 'https://doi.org/10.37811/cli_w1119',
      data: '2024-11-06',
      isbn: 'En gestión',
      type: 'Libro',
      buttonVoidCall: 'https://doi.org/10.37811/cli_w1119',
      buttonText: 'Ver Libro')
];
