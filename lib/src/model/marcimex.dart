/// Rutas de imágenes de la promoción Daytona (assets).
const String marcimexImagesPath = 'assets/img/marcimex';

/// Bloque de promoción Daytona: imágenes + textos para el conjunto.
class DaytonaPromoModel {
  DaytonaPromoModel({
    required this.imagePaths,
    required this.paragraphs,
  });

  final List<String> imagePaths;
  final List<String> paragraphs;
}

/// Datos del bloque Daytona (imágenes y los 5 textos).
final DaytonaPromoModel daytonaPromoData = DaytonaPromoModel(
  imagePaths: [
    '$marcimexImagesPath/daytona_1.png',
    '$marcimexImagesPath/daytona_2.png',
    '$marcimexImagesPath/daytona_3.png',
  ],
  paragraphs: [
    '🔥 No es solo una moto, es tu carta de presentación en la calle.',
    'Daytona combina potencia, diseño y carácter para quienes nacieron para destacar. 🏍️💨',
    'Cada detalle impone. Cada acelerada se siente. Cada kilómetro se disfruta.',
    '💳 ¡Y lo mejor! Puedes tenerla con crédito directo, fácil y rápido.',
    'Hoy es el momento de rodar con actitud. ¿Te subes? 🚀',
  ],
);

/// Datos de contacto de la página Marcimex.
class MarcimexContactModel {
  MarcimexContactModel({
    required this.place,
    required this.asesorName,
    required this.phone,
    required this.whatsappUrl,
    required this.whatsappMessage,
    required this.liliBotUrl,
  });

  final String place;
  final String asesorName;
  final String phone;
  final String whatsappUrl;
  final String whatsappMessage;
  final String liliBotUrl;
}

final MarcimexContactModel marcimexContactData = MarcimexContactModel(
  place: 'Comercial Bombolí',
  asesorName: 'Alberto Guaman',
  phone: '09 997 1099',
  whatsappUrl: 'https://wa.me/59399710779',
  whatsappMessage:
      'Hola Alberto, me interesa conocer más sobre motos Daytona y crédito directo.',
  liliBotUrl: 'https://lili-bot.com/Vr91',
);
