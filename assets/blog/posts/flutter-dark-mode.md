---
title: "Alterna entre Modo Oscuro y Claro en Flutter"
excerpt: "Aprende cómo implementar el modo oscuro y claro en tus aplicaciones Flutter de forma sencilla y profesional. Incluye ejemplos prácticos y consejos de diseño."
author: Alberto-Guaman
date: "2024-12-16"
categories: ["Flutter", "Dark Mode", "UI", "Desarrollo Móvil"]
tags: ["flutter", "dark-mode", "ui", "desarrollo-movil", "tema", "accesibilidad", "dart"]
image: /blog-images/alterna-entre-modo-oscuro-y-claro-en-flutter.jpg
readTime: 8 min
---

> **¿Quieres que tu app Flutter luzca moderna y se adapte a las preferencias del usuario?**  
> ¡Implementa el modo oscuro y claro fácilmente con Flutter!

---

## ¿Por qué ofrecer modo oscuro y claro?

- Mejora la experiencia de usuario y la accesibilidad.
- Ahorra batería en dispositivos con pantallas OLED.
- Es tendencia en apps modernas.

---

## ¿Cómo funciona el tema en Flutter?

Flutter permite definir temas globales para toda la app usando `ThemeData`. Puedes alternar entre tema claro y oscuro fácilmente.

---

## Ejemplo básico: Alternar modo oscuro y claro

### 1. Define los temas en tu app

```dart
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _modoOscuro = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Modo Oscuro y Claro',
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: _modoOscuro ? ThemeMode.dark : ThemeMode.light,
      home: Scaffold(
        appBar: AppBar(title: Text('Modo Oscuro y Claro')),
        body: Center(
          child: SwitchListTile(
            title: Text('Activar modo oscuro'),
            value: _modoOscuro,
            onChanged: (valor) {
              setState(() {
                _modoOscuro = valor;
              });
            },
          ),
        ),
      ),
    );
  }
}
```

---

## Detectar el modo del sistema automáticamente

Puedes hacer que tu app use el modo del sistema por defecto:

```dart
MaterialApp(
  theme: ThemeData.light(),
  darkTheme: ThemeData.dark(),
  themeMode: ThemeMode.system, // Usa el modo del sistema
  // ...
)
```

---

## Personaliza tus temas

Puedes crear temas personalizados para dar identidad a tu app:

```dart
final temaClaro = ThemeData(
  brightness: Brightness.light,
  primarySwatch: Colors.blue,
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: AppBarTheme(backgroundColor: Colors.blue),
);

final temaOscuro = ThemeData(
  brightness: Brightness.dark,
  primarySwatch: Colors.deepPurple,
  scaffoldBackgroundColor: Colors.black,
  appBarTheme: AppBarTheme(backgroundColor: Colors.deepPurple),
);

MaterialApp(
  theme: temaClaro,
  darkTheme: temaOscuro,
  themeMode: ThemeMode.system,
  // ...
)
```

---

## Guardar la preferencia del usuario

Puedes usar el paquete [`shared_preferences`](https://pub.dev/packages/shared_preferences) para recordar la elección del usuario:

```dart
import 'package:shared_preferences/shared_preferences.dart';

// Al cambiar el modo
void _guardarPreferencia(bool modoOscuro) async {
  final prefs = await SharedPreferences.getInstance();
  prefs.setBool('modoOscuro', modoOscuro);
}

// Al iniciar la app
void _cargarPreferencia() async {
  final prefs = await SharedPreferences.getInstance();
  setState(() {
    _modoOscuro = prefs.getBool('modoOscuro') ?? false;
  });
}
```

---

## Buenas prácticas

- Usa colores accesibles y buen contraste en ambos modos.
- Prueba tu app en modo claro y oscuro antes de publicar.
- Permite al usuario cambiar el modo desde la configuración de la app.

---

## Recursos útiles

- [Documentación oficial de Flutter: Temas](https://docs.flutter.dev/cookbook/design/themes)
- [Ejemplo de modo oscuro en Flutter](https://flutter.dev/docs/cookbook/design/themes)
- [shared_preferences package](https://pub.dev/packages/shared_preferences)

---

¿Listo para modernizar tu app Flutter?  
¡Con modo oscuro y claro, tus usuarios te lo agradecerán! 