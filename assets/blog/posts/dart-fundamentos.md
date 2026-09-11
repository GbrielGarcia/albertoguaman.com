---
title: "Guía Completa de Dart: Fundamentos y Ejemplos Prácticos"
excerpt: "Aprende Dart desde cero con esta guía completa. Desde sintaxis básica hasta conceptos avanzados, domina el lenguaje que impulsa Flutter."
author: Alberto-Guaman
date: "2024-12-16"
categories: ["Dart", "Programación", "Flutter", "Fundamentos"]
tags: ["dart", "programacion", "flutter", "fundamentos", "sintaxis", "tutorial", "lenguaje", "principiante"]
image: /blog-images/guia-completa-de-dart-fundamentos-y-ejemplos-practicos.jpg
readTime: 15 min
---

> **¿Quieres aprender Dart desde cero o reforzar tus bases?**  
> ¡Esta guía te llevará de los fundamentos a ejemplos prácticos y modernos!

---

## ¿Qué es Dart?

Dart es un lenguaje de programación moderno, desarrollado por Google, enfocado en la productividad y el rendimiento. Es el lenguaje principal para crear apps con Flutter, pero también se usa en web, backend y más.

---

## Características principales de Dart

- Sintaxis clara y familiar (similar a JavaScript, Java, C#)
- Tipado estático y dinámico
- Soporte para programación orientada a objetos y funcional
- Hot reload (con Flutter)
- Gran rendimiento y multiplataforma

---

## Variables y tipos de datos

```dart
void main() {
  int edad = 25;
  double altura = 1.75;
  String nombre = 'Ana';
  bool esEstudiante = true;
  var ciudad = 'Quito'; // Inferencia de tipo

  print('Nombre: $nombre, Edad: $edad');
}
```

---

## Listas, Sets y Mapas

```dart
void main() {
  List<String> frutas = ['Manzana', 'Banana', 'Naranja'];
  Set<int> numerosUnicos = {1, 2, 3, 3};
  Map<String, int> edades = {'Ana': 25, 'Luis': 30};

  print(frutas[0]); // Manzana
  print(numerosUnicos); // {1, 2, 3}
  print(edades['Luis']); // 30
}
```

---

## Funciones en Dart

```dart
int sumar(int a, int b) {
  return a + b;
}

void saludar(String nombre) => print('Hola, $nombre!');

void main() {
  print(sumar(2, 3));
  saludar('Ana');
}
```

---

## Null safety

Dart obliga a manejar valores nulos de forma segura:

```dart
String? nombre; // Puede ser null
nombre = 'Carlos';
print(nombre?.toUpperCase()); // Carlos
```

---

## Clases y objetos

```dart
class Persona {
  String nombre;
  int edad;

  Persona(this.nombre, this.edad);

  void saludar() {
    print('Hola, soy $nombre y tengo $edad años.');
  }
}

void main() {
  var persona = Persona('Lucía', 28);
  persona.saludar();
}
```

---

## Herencia y polimorfismo

```dart
class Animal {
  void hablar() => print('Hace un sonido');
}

class Perro extends Animal {
  @override
  void hablar() => print('Guau!');
}

void main() {
  Animal miPerro = Perro();
  miPerro.hablar(); // Guau!
}
```

---

## Funciones anónimas y de orden superior

```dart
void main() {
  var numeros = [1, 2, 3, 4];
  var cuadrados = numeros.map((n) => n * n).toList();
  print(cuadrados); // [1, 4, 9, 16]
}
```

---

## Futures y async/await

```dart
Future<String> obtenerDatos() async {
  await Future.delayed(Duration(seconds: 2));
  return 'Datos recibidos';
}

void main() async {
  print('Cargando...');
  String datos = await obtenerDatos();
  print(datos);
}
```

---

## Extensiones y mixins

```dart
extension StringExtension on String {
  String capitalizar() => '${this[0].toUpperCase()}${substring(1)}';
}

mixin Volador {
  void volar() => print('Estoy volando!');
}

class Pajaro with Volador {}

void main() {
  print('hola'.capitalizar()); // Hola
  Pajaro().volar();
}
```

---

## Ejemplo práctico: Calculadora simple

```dart
class Calculadora {
  int sumar(int a, int b) => a + b;
  int restar(int a, int b) => a - b;
}

void main() {
  var calc = Calculadora();
  print(calc.sumar(5, 3)); // 8
  print(calc.restar(10, 4)); // 6
}
```

---

## Buenas prácticas

- Usa nombres descriptivos para variables y funciones.
- Aprovecha null safety y el tipado estático.
- Escribe funciones pequeñas y reutilizables.
- Documenta tu código con comentarios y docstrings.

---

## Recursos útiles

- [Documentación oficial de Dart](https://dart.dev/guides)
- [Tour del lenguaje Dart](https://dart.dev/guides/language/language-tour)
- [Ejercicios de Dart](https://exercism.org/tracks/dart/exercises)

---

¿Listo para dominar Dart y crear apps modernas?  
¡Con estos fundamentos y ejemplos, tu camino en Flutter y más allá será mucho más fácil! 