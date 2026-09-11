---
title: "Guía Completa sobre Enum y Enum Avanzados en Flutter"
excerpt: "Domina el uso de enumeraciones en Flutter y Dart. Desde conceptos básicos hasta técnicas avanzadas, aprende a crear código más limpio y mantenible."
author: Alberto-Guaman
date: "2024-12-22"
categories: ["Flutter", "Enum", "Dart", "Programación"]
tags: ["flutter", "enum", "dart", "programacion", "enumeraciones", "tutorial", "codigo-limpio", "fundamentos"]
image: /blog-images/guia-completa-sobre-enum-y-enum-avanzados-en-flutter.jpg
readTime: 10 min
---

> **¿Quieres escribir código más claro y seguro en Flutter?**  
> ¡Los enums son tu mejor aliado para representar estados, opciones y más!

---

## ¿Qué es un Enum en Dart/Flutter?

Un `enum` (enumeración) es un tipo especial que permite definir un conjunto de valores constantes y nombrados. Son ideales para representar estados, opciones de menú, roles de usuario, etc.

---

## Ejemplo básico de Enum

```dart
enum EstadoPedido {
  pendiente,
  procesando,
  enviado,
  entregado,
  cancelado,
}

void main() {
  EstadoPedido estado = EstadoPedido.procesando;
  print(estado); // EstadoPedido.procesando
}
```

---

## Ventajas de usar Enum

- Código más legible y seguro.
- Evita errores por strings o números mágicos.
- Facilita el uso de `switch` y validaciones.

---

## Usando Enum en un Widget Flutter

```dart
enum Filtro { todos, completados, pendientes }

class FiltroTareas extends StatelessWidget {
  final Filtro filtroSeleccionado;
  final ValueChanged<Filtro> onFiltroCambiado;

  FiltroTareas({required this.filtroSeleccionado, required this.onFiltroCambiado});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: Filtro.values.map((filtro) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: ChoiceChip(
            label: Text(filtro.name),
            selected: filtro == filtroSeleccionado,
            onSelected: (_) => onFiltroCambiado(filtro),
          ),
        );
      }).toList(),
    );
  }
}
```

---

## Métodos útiles y propiedades de Enum (Dart 2.17+)

- `.values`: Lista de todos los valores del enum.
- `.name`: Nombre del valor como string.
- `.index`: Posición del valor (0, 1, 2...)

```dart
for (var estado in EstadoPedido.values) {
  print('${estado.name} - ${estado.index}');
}
```

---

## Enum con métodos y propiedades personalizadas (Dart 2.17+)

Puedes agregar getters y métodos a tus enums:

```dart
enum Prioridad {
  baja,
  media,
  alta;

  String get descripcion {
    switch (this) {
      case Prioridad.baja:
        return 'Baja';
      case Prioridad.media:
        return 'Media';
      case Prioridad.alta:
        return 'Alta';
    }
  }
}

void main() {
  Prioridad p = Prioridad.alta;
  print(p.descripcion); // Alta
}
```

---

## Enum con valores asociados (Dart 3.0+)

Desde Dart 3, puedes asociar valores a los enums:

```dart
enum RolUsuario {
  admin('Administrador'),
  editor('Editor'),
  lector('Lector');

  final String descripcion;
  const RolUsuario(this.descripcion);
}

void main() {
  RolUsuario rol = RolUsuario.editor;
  print(rol.descripcion); // Editor
}
```

---

## Ejemplo avanzado: Enum y switch en Flutter

```dart
enum EstadoConexion { conectado, desconectado, conectando }

Widget iconoConexion(EstadoConexion estado) {
  switch (estado) {
    case EstadoConexion.conectado:
      return Icon(Icons.wifi, color: Colors.green);
    case EstadoConexion.desconectado:
      return Icon(Icons.wifi_off, color: Colors.red);
    case EstadoConexion.conectando:
      return Icon(Icons.wifi_tethering, color: Colors.orange);
  }
}
```

---

## Buenas prácticas con Enum

- Usa enums para estados, roles, filtros y opciones fijas.
- Aprovecha las nuevas características de Dart 2.17+ y 3.0+.
- No abuses de los enums para datos dinámicos o configuraciones externas.

---

## Recursos útiles

- [Enums en Dart (docs)](https://dart.dev/language/enums)
- [Novedades de enums en Dart 2.17+](https://dart.dev/guides/language/language-tour#enhanced-enums)
- [Ejemplo de enums en Flutter](https://docs.flutter.dev/cookbook/forms/validation#using-enums)

---

¿Listo para escribir código más limpio y seguro?  
¡Con enums avanzados, tus apps Flutter serán más robustas y expresivas! 