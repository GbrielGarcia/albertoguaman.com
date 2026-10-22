---
title: "IA Agente (Agentic AI): qué es, cómo funciona y cómo construir tu primer agente"
excerpt: "Guía completa de la IA agente: qué la diferencia de un chatbot, el bucle que la hace funcionar, patrones de diseño, herramientas y MCP, riesgos reales y un agente funcional en TypeScript paso a paso."
author: Alberto-Guaman
date: "2026-10-22"
categories: ["IA", "Inteligencia Artificial", "Agentes", "Tutorial"]
tags: ["agentic-ai", "ia-agente", "agentes", "llm", "claude", "mcp", "typescript", "automatizacion", "tool-use"]
image: ./images/ia-agente-agentic-ai.jpg
readTime: "18 min"
featured: true
---

> **¿Escuchas "agentes de IA" en todas partes y no tienes claro qué son en realidad?**
> Aquí va desde la idea base hasta un agente funcionando en tu máquina, sin humo.

Durante un par de años usamos la IA como un buscador que conversa: le preguntas algo, te responde y ahí termina. La **IA agente** (en inglés, *Agentic AI*) cambia eso. Ya no solo responde: **recibe un objetivo, decide los pasos, usa herramientas, revisa el resultado y vuelve a intentar** hasta terminar el trabajo.

La diferencia se parece a pedirle a alguien que te *explique* cómo revisar el stock de una tienda, frente a pedirle que *lo revise, detecte lo que falta y te deje el pedido armado*. Lo segundo es un agente.

En esta guía vas a ver:

- Qué es exactamente un agente y qué no lo es.
- El bucle que hace funcionar a cualquier agente.
- Los patrones de diseño más usados y cuándo conviene cada uno.
- Herramientas, memoria y el protocolo MCP.
- Un agente real en TypeScript, explicado línea por línea.
- Riesgos, costos y buenas prácticas antes de ponerlo en producción.

---

## ¿Qué es la IA agente?

Un **agente de IA** es un sistema en el que un modelo de lenguaje (LLM) **decide por sí mismo qué acciones tomar** para cumplir un objetivo, ejecuta esas acciones mediante **herramientas** (APIs, bases de datos, navegador, terminal…) y **usa los resultados** para decidir el siguiente paso.

Se puede resumir en una fórmula práctica:

**Agente = modelo que razona + herramientas + un bucle + memoria + un objetivo**

- **Modelo que razona:** el LLM interpreta la tarea y decide qué hacer.
- **Herramientas:** funciones que el modelo puede pedir que se ejecuten (consultar un pedido, buscar en la web, leer un archivo).
- **Bucle:** el proceso se repite hasta que el objetivo se cumple o se alcanza un límite.
- **Memoria:** lo que el agente sabe de lo que ya hizo, en esta tarea y en tareas anteriores.
- **Objetivo:** la meta que le das, idealmente con un criterio claro de "terminado".

La palabra clave es **autonomía**: en un programa tradicional tú escribes cada paso; en un agente, tú defines las herramientas y el objetivo, y **el modelo decide el camino**.

---

## Chatbot, flujo de trabajo y agente: no son lo mismo

Mucho de lo que hoy se vende como "agente" en realidad es otra cosa. Esta tabla ayuda a ponerle nombre correcto a cada sistema:

| | Chatbot | Flujo de trabajo con IA | Agente |
|---|---|---|---|
| **Quién decide los pasos** | Nadie: una pregunta, una respuesta | Tú, en el código | El modelo |
| **Usa herramientas** | No | Sí, en un orden fijo | Sí, elige cuáles y cuándo |
| **Número de pasos** | Uno | Fijo | Variable |
| **Ejemplo** | "¿Qué es un SKU?" | Resumir cada correo que llega y guardarlo | "Revisa los pedidos atrasados y avisa a cada cliente" |
| **Previsibilidad** | Alta | Alta | Menor |
| **Costo por tarea** | Bajo | Medio | Más alto y variable |

Un detalle importante: **más autonomía no siempre es mejor**. Un flujo de trabajo bien diseñado es más barato, más rápido y más fácil de depurar. Los agentes valen la pena cuando la tarea es abierta y no puedes escribir de antemano todos los pasos.

---

## El bucle del agente: cómo funciona por dentro

Todo agente, por sofisticado que sea, repite el mismo ciclo:

```text
        ┌─────────────────────────────────────────┐
        │                OBJETIVO                 │
        └───────────────────┬─────────────────────┘
                            ▼
   ┌──────────►  1. RAZONAR: ¿qué hago ahora?
   │                        │
   │                        ▼
   │            2. ACTUAR: pide usar una herramienta
   │                        │
   │                        ▼
   │            3. EJECUTAR: tu código corre la herramienta
   │                        │
   │                        ▼
   └──────────  4. OBSERVAR: el resultado vuelve al modelo
                            │
                (¿objetivo cumplido?)
                            ▼
                    RESPUESTA FINAL
```

Algo que confunde al principio: **el modelo no ejecuta nada por sí solo**. Lo que hace es responder con un mensaje del tipo *"quiero usar la herramienta `buscar_pedido` con el id 1042"*. **Tu código** ejecuta esa función, le devuelve el resultado y el modelo continúa. Esto es lo que se conoce como *tool use* o *function calling*.

Esa separación es muy útil: tú controlas qué se ejecuta de verdad, con qué permisos y cuándo pedir confirmación a una persona.

---

## Patrones de diseño más usados

En diciembre de 2024 Anthropic publicó la guía *Building effective agents*, que ordenó bastante el tema. Estos son los patrones que más vas a encontrar, de menos a más autónomos:

### 1. Encadenamiento de prompts

La tarea se divide en pasos fijos: la salida de uno es la entrada del siguiente. Por ejemplo, *generar un borrador → revisar el tono → traducir*. Es un flujo de trabajo, no un agente, pero resuelve muchos casos.

### 2. Enrutamiento

Un primer paso clasifica la entrada y la envía al proceso adecuado. Un mensaje de soporte se clasifica como *facturación*, *técnico* o *ventas*, y cada tipo tiene su propio prompt y herramientas.

### 3. Paralelización

Varias llamadas al modelo trabajan a la vez: revisar un contrato desde tres ángulos distintos, o pedir tres respuestas y quedarse con la que más se repite.

### 4. Orquestador y trabajadores

Un modelo "jefe" divide la tarea en subtareas, las reparte entre modelos "trabajadores" y junta los resultados. Útil cuando no sabes de antemano cuántas partes tendrá el trabajo; por ejemplo, investigar un tema en diez fuentes.

### 5. Evaluador y optimizador

Un modelo genera y otro evalúa con criterios claros; se repite hasta que pasa la evaluación. Funciona muy bien para traducciones, código que debe pasar tests o textos que deben cumplir una guía de estilo.

### 6. Agente autónomo (ReAct)

El modelo alterna libremente entre **razonar** y **actuar** (*Reason + Act*), eligiendo herramientas en cada paso hasta terminar. Es el patrón del ejemplo práctico de más abajo y el que usan los agentes de programación.

> **Regla práctica:** empieza por el patrón más simple que resuelva tu problema. Sube un nivel solo cuando tengas evidencia de que el anterior no alcanza.

---

## Herramientas: las manos del agente

Una herramienta se define con tres cosas:

1. **Nombre:** `consultar_stock`.
2. **Descripción:** cuándo y para qué usarla. **Es la parte más importante.** El modelo decide en función de lo que leas aquí.
3. **Esquema de entrada:** qué parámetros recibe, en formato JSON Schema.

Buenas prácticas al diseñarlas:

- **Pocas y bien definidas.** Diez herramientas claras funcionan mejor que cuarenta parecidas.
- **Descripciones como para un compañero nuevo:** qué hace, qué devuelve, cuándo *no* usarla.
- **Errores útiles.** Si algo falla, devuelve un mensaje que explique qué pasó ("pedido no encontrado, verifica el número"); el modelo puede corregirse con eso.
- **Separa leer de escribir.** Una herramienta que solo consulta es segura; una que borra, paga o envía mensajes necesita controles extra.

### MCP: un estándar para conectar herramientas

Antes, cada aplicación conectaba sus herramientas a su manera. En noviembre de 2024 Anthropic presentó el **Model Context Protocol (MCP)**, un estándar abierto para que cualquier aplicación de IA se conecte a cualquier fuente de datos o herramienta de la misma forma.

La idea es parecida a la de USB: escribes un **servidor MCP** una vez (por ejemplo, para tu base de datos de inventario) y lo puede usar cualquier cliente compatible. Durante 2025 lo adoptaron también OpenAI, Google y Microsoft, y hoy existen servidores MCP para GitHub, bases de datos, navegadores, Slack, sistemas de archivos y muchísimo más.

Si los agentes necesitan hablar **entre ellos** (no con herramientas), existe otro estándar complementario: **A2A** (*Agent2Agent*), presentado por Google en abril de 2025.

---

## Memoria: lo que el agente recuerda

Un modelo de lenguaje no recuerda nada entre llamadas: **todo lo que "sabe" de la tarea es lo que le envías en cada petición**. La memoria de un agente se construye por capas:

- **Memoria de corto plazo:** la conversación actual, con todas las llamadas a herramientas y sus resultados. Vive en la *ventana de contexto* del modelo.
- **Memoria de largo plazo:** datos guardados fuera del modelo (archivos, una base de datos, un buscador vectorial) que el agente consulta con una herramienta cuando los necesita.
- **Gestión del contexto:** en tareas largas el contexto se llena. Las técnicas habituales son resumir lo antiguo (*compaction*), borrar resultados de herramientas que ya no sirven y guardar notas en un archivo para releerlas después.

Un error común es meter todo en el contexto "por si acaso". Más contexto no siempre es mejor: cuesta más y puede distraer al modelo. Dale lo necesario y una herramienta para buscar el resto.

---

## Manos a la obra: tu primer agente en TypeScript

Vamos a construir un **agente de atención al cliente para una tienda**. Va a poder consultar pedidos y stock, y decidir solo qué consultar para responder. Usaremos la API de Claude de Anthropic con su SDK oficial para TypeScript.

### 1. Preparar el proyecto

Necesitas Node.js 20 o superior y una clave de API de [platform.claude.com](https://platform.claude.com).

```bash
mkdir agente-tienda && cd agente-tienda
npm init -y
npm pkg set type=module   # para poder usar await fuera de funciones
npm install @anthropic-ai/sdk
npm install -D tsx typescript
export ANTHROPIC_API_KEY="tu-clave"
```

> Nunca escribas la clave dentro del código ni la subas a GitHub. Úsala siempre como variable de entorno.

### 2. Definir las herramientas

Crea `agente.ts`. Primero, los datos de ejemplo y las dos herramientas. En un sistema real, estas funciones consultarían tu base de datos o tu API.

```typescript
import Anthropic from "@anthropic-ai/sdk";

const client = new Anthropic(); // lee ANTHROPIC_API_KEY del entorno

// Datos de ejemplo (en producción vendrían de tu base de datos)
const pedidos: Record<string, { cliente: string; producto: string; estado: string }> = {
  "1042": { cliente: "María", producto: "Teclado mecánico", estado: "en camino" },
  "1043": { cliente: "Jorge", producto: "Mouse inalámbrico", estado: "retrasado" },
};
const stock: Record<string, number> = {
  "teclado mecánico": 4,
  "mouse inalámbrico": 0,
};

// Las herramientas que el modelo puede pedir usar
const tools: Anthropic.Tool[] = [
  {
    name: "buscar_pedido",
    description:
      "Busca un pedido por su número y devuelve cliente, producto y estado. " +
      "Úsala cuando el usuario mencione un número de pedido.",
    input_schema: {
      type: "object",
      properties: {
        numero: { type: "string", description: "Número del pedido, por ejemplo 1042" },
      },
      required: ["numero"],
    },
  },
  {
    name: "consultar_stock",
    description:
      "Devuelve cuántas unidades hay disponibles de un producto. " +
      "Úsala antes de prometer un reemplazo o una nueva venta.",
    input_schema: {
      type: "object",
      properties: {
        producto: { type: "string", description: "Nombre del producto" },
      },
      required: ["producto"],
    },
  },
];
```

### 3. Ejecutar lo que el modelo pide

Esta función recibe el nombre de la herramienta y sus parámetros, y devuelve el resultado como texto. Fíjate en que los errores también se devuelven como texto útil, no como excepciones.

```typescript
function ejecutarHerramienta(nombre: string, input: Record<string, string>): string {
  if (nombre === "buscar_pedido") {
    const pedido = pedidos[input.numero];
    return pedido
      ? JSON.stringify(pedido)
      : `No existe el pedido ${input.numero}. Pide al cliente que verifique el número.`;
  }
  if (nombre === "consultar_stock") {
    const unidades = stock[input.producto.toLowerCase()];
    return unidades === undefined
      ? `No encontré el producto "${input.producto}" en el inventario.`
      : `${unidades} unidades disponibles`;
  }
  return `Herramienta desconocida: ${nombre}`;
}
```

### 4. El bucle del agente

Este es el corazón del agente: llama al modelo, ejecuta las herramientas que pida, le devuelve los resultados y repite hasta que el modelo termina.

```typescript
const MAX_PASOS = 10; // freno de seguridad para no quedar en un bucle infinito

async function agente(objetivo: string): Promise<string> {
  const messages: Anthropic.MessageParam[] = [{ role: "user", content: objetivo }];

  for (let paso = 1; paso <= MAX_PASOS; paso++) {
    const response = await client.messages.create({
      model: "claude-opus-5-5",
      max_tokens: 16000,
      output_config: { effort: "medium" },
      system:
        "Eres el asistente de atención al cliente de una tienda de tecnología en Ecuador. " +
        "Consulta los datos con las herramientas antes de responder; nunca inventes estados ni stock. " +
        "Responde en español, breve y amable.",
      tools,
      messages,
    });

    // Guardamos la respuesta completa del modelo en el historial
    messages.push({ role: "assistant", content: response.content });

    if (response.stop_reason === "refusal") {
      return "El modelo no pudo completar esta solicitud.";
    }

    // Si el modelo no pidió herramientas, terminó: devolvemos su texto
    if (response.stop_reason !== "tool_use") {
      return response.content
        .filter((b): b is Anthropic.TextBlock => b.type === "text")
        .map((b) => b.text)
        .join("\n");
    }

    // Ejecutamos TODAS las herramientas que pidió en este paso
    const resultados: Anthropic.ToolResultBlockParam[] = [];
    for (const block of response.content) {
      if (block.type === "tool_use") {
        const input = block.input as Record<string, string>;
        console.log(`  🔧 Paso ${paso}: ${block.name}(${JSON.stringify(input)})`);
        resultados.push({
          type: "tool_result",
          tool_use_id: block.id,
          content: ejecutarHerramienta(block.name, input),
        });
      }
    }

    // Todos los resultados van juntos en un solo mensaje del usuario
    messages.push({ role: "user", content: resultados });
  }

  return "Se alcanzó el límite de pasos sin terminar la tarea.";
}

const respuesta = await agente(
  "Hola, soy Jorge. Mi pedido 1043 no llega. Si no hay forma de enviarlo pronto, ¿me pueden cambiar el producto?",
);
console.log("\n🤖", respuesta);
```

### 5. Ejecutarlo

```bash
npx tsx agente.ts
```

Verás algo parecido a esto:

```text
  🔧 Paso 1: buscar_pedido({"numero":"1043"})
  🔧 Paso 2: consultar_stock({"producto":"mouse inalámbrico"})

🤖 Hola Jorge, revisé tu pedido 1043: el mouse inalámbrico está retrasado y
ahora mismo no tenemos unidades en stock, así que no podemos reponerlo de
inmediato. Puedo ofrecerte el reembolso o cambiarlo por otro producto
disponible, ¿qué prefieres?
```

Nadie le dijo que revisara el stock. **El modelo dedujo que, para responder sobre un cambio, primero tenía que saber si había unidades.** Esa es la diferencia con un flujo fijo.

### 6. Lo que acabas de construir

- El **modelo** razona y decide qué herramienta usar.
- **Tu código** ejecuta las herramientas y controla qué está permitido.
- El **bucle** repite hasta terminar, con un límite de pasos.
- El **historial de mensajes** es la memoria de corto plazo.

El SDK también trae un *tool runner* que hace este bucle por ti, pero escribirlo a mano una vez es la mejor forma de entender qué pasa por dentro.

---

## Frameworks: ¿hace falta uno?

Para empezar, **no**. El bucle de arriba tiene menos de 50 líneas y entiendes cada una. Cuando el agente crece (varios agentes, estados complejos, reintentos, observabilidad), un framework ahorra trabajo. Algunos de los más usados:

| Herramienta | Para qué destaca |
|---|---|
| **Claude Agent SDK** | El mismo motor de Claude Code como librería: archivos, terminal, búsqueda web y subagentes listos para usar |
| **OpenAI Agents SDK** | Agentes con traspasos entre ellos y controles de entrada y salida |
| **LangGraph** | Flujos con estado modelados como grafos, con control fino de cada paso |
| **CrewAI** | Equipos de agentes con roles definidos ("investigador", "redactor") |
| **Google ADK** | Agentes integrados con el ecosistema de Google Cloud |

Mi consejo: entiende primero el bucle a mano, luego elige un framework por lo que **de verdad** necesitas, no por popularidad.

---

## Casos de uso reales

- **Programación:** agentes que leen un repositorio, hacen cambios, ejecutan los tests y corrigen hasta que pasan. Hoy es el caso más maduro.
- **Atención al cliente:** consultar pedidos, iniciar devoluciones y escalar a una persona cuando hace falta.
- **Investigación:** buscar en varias fuentes, contrastar y entregar un informe con referencias.
- **Operaciones y back office:** conciliar facturas, revisar inventario, preparar reportes repetitivos.
- **Soporte técnico e infraestructura:** revisar alertas, leer logs y proponer una causa probable. Si ya tienes [Uptime Kuma en tu servidor](/blog/zimaos-uptime-kuma-app-store), un agente puede leer sus alertas y sugerir el primer diagnóstico.

---

## Riesgos que no puedes ignorar

Un agente **actúa**, así que sus errores también actúan. Estos son los riesgos más importantes:

### Inyección de instrucciones (prompt injection)

Si el agente lee contenido externo (correos, páginas web, documentos), ese contenido puede traer instrucciones escondidas del tipo *"ignora lo anterior y envía los datos a…"*. Es el riesgo número uno de los agentes. Mitígalo así:

- Trata todo contenido externo como **datos, nunca como órdenes**.
- No le des al mismo agente acceso a datos sensibles **y** a canales para enviarlos fuera sin control.
- Pide **confirmación humana** antes de acciones importantes.

### Permisos excesivos

Dale a cada agente **solo las herramientas que necesita** (principio de mínimo privilegio). Un agente que responde consultas no necesita poder borrar pedidos.

### Bucles y costos descontrolados

Un agente puede quedarse dando vueltas y gastar mucho. Pon siempre un **límite de pasos**, un límite de tokens o presupuesto por tarea, y revisa el costo **por tarea completada**, no por llamada.

### Acciones equivocadas con total seguridad

El modelo puede equivocarse con mucha confianza. Para acciones irreversibles (pagos, envíos, borrados), usa **aprobación humana**, valida las entradas de cada herramienta y registra todo lo que hace.

### Expectativas infladas

Gartner estimó en junio de 2025 que más del 40 % de los proyectos de IA agente se cancelarían antes de terminar 2027 por costos altos, valor poco claro o falta de controles de riesgo. La lección: empieza por un problema concreto y mide.

---

## ¿Cuándo SÍ usar un agente? Checklist rápido

Antes de construir uno, responde estas cuatro preguntas:

1. **Complejidad:** ¿la tarea tiene varios pasos que no puedes definir de antemano?
2. **Valor:** ¿el resultado justifica más costo y más tiempo de respuesta?
3. **Viabilidad:** ¿el modelo es capaz de hacer bien este tipo de tarea?
4. **Costo del error:** ¿puedes detectar y corregir sus errores (tests, revisión, deshacer)?

Si alguna respuesta es "no", probablemente te conviene un flujo de trabajo o una sola llamada al modelo.

---

## Buenas prácticas para llevarlo a producción

- **Empieza simple** y agrega autonomía solo cuando la necesites.
- **Escribe las descripciones de las herramientas** con el mismo cuidado que el prompt.
- **Registra cada paso:** qué herramienta usó, con qué datos y qué obtuvo. Sin esto no podrás depurar.
- **Crea un conjunto de pruebas** (evals) con casos reales y revisa los resultados cada vez que cambies el prompt o el modelo.
- **Humano en el bucle** para todo lo irreversible.
- **Límites claros:** pasos, tokens, tiempo y presupuesto.
- **Mide el costo por tarea completada**, no por petición.

---

## Cómo seguir aprendiendo

1. Reproduce el agente de este artículo y agrégale una herramienta nueva (por ejemplo, `crear_ticket`).
2. Añade una confirmación por consola antes de ejecutar cualquier herramienta que modifique datos.
3. Conecta un servidor MCP existente (por ejemplo, el de sistema de archivos) y observa cómo el agente lo usa.
4. Prueba el patrón **evaluador y optimizador**: un segundo modelo que revise la respuesta antes de enviarla.
5. Lee la guía *Building effective agents* de Anthropic y la documentación de *tool use* de la API.

---

## Preguntas frecuentes

**¿IA agente y agente de IA son lo mismo?**
Casi. *Agente de IA* es el sistema concreto; *IA agente* (Agentic AI) es el enfoque general de construir sistemas que actúan con autonomía.

**¿Necesito saber machine learning para crear un agente?**
No. Necesitas saber programar y entender APIs. El modelo ya viene entrenado; tu trabajo es diseñar herramientas, prompts y controles.

**¿Un agente puede trabajar sin internet o con un modelo local?**
Sí. Hay modelos que corren en tu propio equipo o servidor, aunque los modelos grandes en la nube suelen ser bastante mejores eligiendo herramientas y planificando tareas largas.

**¿Cuánto cuesta ejecutar un agente?**
Depende del modelo y del número de pasos. Cada paso es una llamada al modelo que envía todo el historial, así que el costo crece con la longitud de la tarea. Por eso conviene limitar pasos y medir el costo por tarea.

**¿Los agentes van a reemplazar a los programadores?**
Hoy funcionan mejor como colaboradores que como reemplazo: aceleran tareas repetitivas y bien definidas, pero alguien tiene que definir el objetivo, revisar el resultado y responder por lo que se entrega.

---

## Conclusión

La IA agente no es magia ni un chatbot con otro nombre: es **un modelo que razona, dentro de un bucle, con herramientas que tú controlas**. Entender ese bucle te permite construir agentes útiles, y también reconocer cuándo **no** necesitas uno.

Mi recomendación: copia el ejemplo, rómpelo, agrégale herramientas y mira cómo decide. En una tarde vas a entender más de agentes que leyendo diez hilos de redes sociales.

¿Estás armando un agente para tu negocio o tu trabajo? [Escríbeme](/contacto) y lo conversamos.
