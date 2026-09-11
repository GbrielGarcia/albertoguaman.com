---
title: "Manejando Estados con Flutter Utilizando Provider"
excerpt: "Aprende a gestionar el estado de tu aplicación Flutter de manera eficiente usando Provider. Descubre patrones de diseño y mejores prácticas para aplicaciones escalables."
author: Alberto-Guaman
date: "2024-12-28"
categories: ["Flutter", "Provider", "Estado", "Desarrollo Móvil"]
tags: ["flutter", "provider", "estado", "desarrollo-movil", "dart", "patrones", "tutorial", "gestion-estado"]
image: /blog-images/manejando-estados-con-flutter-utilizando-provider.jpg
readTime: 12 min
---

> **¿Quieres construir apps Flutter reactivas y escalables?**  
> ¡Provider es la solución recomendada para manejar el estado de forma sencilla y eficiente!

---

## ¿Qué es Provider?

Provider es un paquete oficial de Flutter para la gestión de estado. Permite compartir datos y lógica entre widgets de manera reactiva, eficiente y desacoplada.

- **Sencillo:** Fácil de aprender y usar.
- **Escalable:** Ideal para proyectos pequeños y grandes.
- **Recomendado:** Es la solución sugerida por el equipo de Flutter.

---

## ¿Por qué necesitas manejar el estado?

En Flutter, el "estado" es cualquier dato que puede cambiar durante la vida de la app (ej: usuario logueado, contador, lista de tareas, etc). Manejarlo bien es clave para apps robustas y mantenibles.

---

## Instalación de Provider

Agrega Provider a tu archivo `pubspec.yaml`:

```yaml
dependencies:
  flutter:
    sdk: flutter
  provider: ^6.0.0
```

Luego ejecuta:

```bash
flutter pub get
```

---

## Ejemplo básico: Contador con Provider

### 1. Crea una clase de estado

```dart
import 'package:flutter/material.dart';

class ContadorModel with ChangeNotifier {
  int _valor = 0;

  int get valor => _valor;

  void incrementar() {
    _valor++;
    notifyListeners();
  }
}
```

### 2. Provee el estado en el árbol de widgets

```dart
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => ContadorModel(),
      child: MyApp(),
    ),
  );
}
```

### 3. Consume el estado en tus widgets

```dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Contador con Provider')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Valor actual:'),
              Consumer<ContadorModel>(
                builder: (context, contador, child) =>
                  Text(
                    '${contador.valor}',
                    style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                  ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => context.read<ContadorModel>().incrementar(),
                child: Text('Incrementar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
```

---

## ¿Cómo funciona Provider?

- **ChangeNotifier:** Clase base que notifica a los widgets cuando hay cambios.
- **ChangeNotifierProvider:** Provee una instancia de tu modelo a los widgets hijos.
- **Consumer:** Widget que escucha los cambios y reconstruye solo lo necesario.
- **context.read<T>() / context.watch<T>():** Acceso directo al modelo desde el contexto.

---

## Buenas prácticas con Provider

- Mantén la lógica de negocio fuera de los widgets.
- Usa varios providers para separar responsabilidades (ej: AuthProvider, CartProvider, etc).
- Evita anidar demasiados providers, usa `MultiProvider` si es necesario.
- Usa `notifyListeners()` solo cuando realmente cambie el estado.

---

## Ejemplo avanzado: Lista de tareas (To-Do)

### 1. Modelo de tarea y provider

```dart
class Tarea {
  final String titulo;
  bool completada;

  Tarea(this.titulo, {this.completada = false});
}

class TareasProvider with ChangeNotifier {
  List<Tarea> _tareas = [];

  List<Tarea> get tareas => _tareas;

  void agregarTarea(String titulo) {
    _tareas.add(Tarea(titulo));
    notifyListeners();
  }

  void toggleTarea(int index) {
    _tareas[index].completada = !_tareas[index].completada;
    notifyListeners();
  }
}
```

### 2. Proveer y consumir el estado

```dart
void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => TareasProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: TareasScreen(),
    );
  }
}

class TareasScreen extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Lista de Tareas')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(hintText: 'Nueva tarea'),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    if (_controller.text.isNotEmpty) {
                      context.read<TareasProvider>().agregarTarea(_controller.text);
                      _controller.clear();
                    }
                  },
                )
              ],
            ),
          ),
          Expanded(
            child: Consumer<TareasProvider>(
              builder: (context, tareasProvider, child) => ListView.builder(
                itemCount: tareasProvider.tareas.length,
                itemBuilder: (context, index) {
                  final tarea = tareasProvider.tareas[index];
                  return ListTile(
                    title: Text(
                      tarea.titulo,
                      style: TextStyle(
                        decoration: tarea.completada ? TextDecoration.lineThrough : null,
                      ),
                    ),
                    trailing: Checkbox(
                      value: tarea.completada,
                      onChanged: (_) => context.read<TareasProvider>().toggleTarea(index),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
```

---

## Recursos útiles

- [Documentación oficial de Provider](https://pub.dev/packages/provider)
- [Gestión de estado en Flutter (docs)](https://docs.flutter.dev/development/data-and-backend/state-mgmt/intro)
- [Ejemplo oficial de Provider](https://flutter.dev/docs/cookbook/state/provider-counter)

---

¿Listo para crear apps Flutter reactivas y escalables?  
¡Con Provider, manejar el estado es más fácil que nunca! 