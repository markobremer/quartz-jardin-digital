# Sistema de Repetición Espaciada

**Versión:** 1.0 (Piloto)
**Última actualización:** 2025-12-26

---

## ¿Qué es esto?

Sistema de revisión generativa que combina **consolidación de memoria** con **cultivo activo del jardín digital**. No son flashcards mecánicas, sino interrogación socrática que expande el pensamiento.

---

## Inicio rápido

### Para iniciar una sesión

1. Pide a Claude: `Hagamos una sesión de repetición espaciada`
2. Responde preguntas sobre 3-5 notas (15-20 min)
3. Claude guarda todo en `Sesiones/` y `Sugerencias/`
4. Revisas sugerencias cuando quieras
5. Decides qué incorporar a tu Zettelkasten

### Frecuencia recomendada

- **2-3 sesiones por semana**
- **15-20 minutos** por sesión
- **3-5 notas** por sesión

Sustentable, no abrumador.

---

## Filosofía del sistema

### No es memorización mecánica

❌ Flashcards: "¿Qué es X?" → "Definición de X"
✅ Interrogación generativa: "¿Cómo se relaciona X con Y en tu práctica clínica?"

### Es cultivo de pensamiento

El objetivo es que tu Zettelkasten:
- Se **profundice** (no solo se expanda)
- Genere **conexiones nuevas**
- Capture **elaboraciones** que surgen al pensar en voz alta
- Se mantenga **vivo** (no archivo muerto)

### Respeta tu ITE (Integrated Thinking Environment)

⚠️ Claude NUNCA edita:
- `Zettelkasten/` (tu jardín personal)
- `Diario/` (reflexiones privadas)
- `Inbox/` (captura de pensamiento)

✅ Claude SÍ genera:
- Sugerencias en `Recursos/Repetición Espaciada/`
- Preguntas personalizadas
- Propuestas de enriquecimiento

**Tú decides** qué y cuándo incorporar a tu jardín.

---

## Estructura de archivos

```
4. Recursos/Repetición Espaciada/
├── README.md                        # Esta guía
├── PLAN_IMPLEMENTACION.md           # Detalles técnicos completos
├── Sesiones/                        # Logs de cada sesión
│   └── 2025-12-26 - Sesión Piloto.md
├── Sugerencias/                     # Propuestas de enriquecimiento
│   ├── Por nota/
│   │   ├── Biológicamente Cultural.md
│   │   └── ...
│   └── Notas nuevas sugeridas.md
└── Templates/
    ├── Template - Sesión.md
    └── Template - Sugerencia.md
```

---

## Cómo funciona una sesión

### 1. Claude selecciona notas

Basándose en:
- Notas no revisadas nunca
- Notas modificadas recientemente
- Notas centrales (muchas conexiones)
- Diversidad temática

### 2. Para cada nota, Claude pregunta

**Síntesis** (2-3 min)
> "¿Cuál es la idea central de [concepto]?"

**Elaboración** (3-5 min)
> "¿Cómo se relaciona esto con [otro concepto tuyo]?"
> "¿Qué implicaciones tiene para [tu trabajo]?"

**Generativa** (2-3 min, opcional)
> "¿Qué pregunta nueva te surge?"
> "¿Qué ejemplo concreto ilustra esto?"

### 3. Tú respondes sin consultar la nota

Esto activa:
- Recuperación activa (memoria)
- Elaboración (pensamiento)
- Generación (insights nuevos)

### 4. Claude registra y sugiere

- Compara tu respuesta con la nota original
- Identifica elaboraciones valiosas
- Propone cómo enriquecer la nota
- Sugiere notas nuevas si emergieron conceptos

### 5. Tú integras (cuando quieras)

- Revisas sugerencias en tu tiempo
- Editas manualmente tu Zettelkasten
- Incorporas lo que tenga sentido
- Ignoras lo que no resuene

---

## Metadata opcional

Puedes agregar a tus notas en el Zettelkasten:

```yaml
---
title: Biológicamente Cultural
tags: [neurociencia, evolución]
created: 2024-XX-XX
last_modified: 2025-12-26
sr:
  reviewed: 2025-12-26  # Última revisión
  count: 3              # Número de revisiones
  confidence: 4         # Tu confianza (1-5)
  next: 2026-01-09      # Sugerencia próxima revisión
---
```

Esto ayuda a Claude a priorizar notas, pero es **completamente opcional**.

---

## Niveles de confianza

Después de cada nota, autoevalúa:

- **1 - No recuerdo:** Apenas pude responder
- **2 - Parcial:** Recordé algo, faltó bastante
- **3 - Bien:** Recordé la idea central
- **4 - Muy bien:** Recordé bien + hice elaboraciones
- **5 - Perfecto:** Recordé todo + generé insights nuevos

Claude usa esto para calcular próxima revisión:
- Confianza 1 → 1 día
- Confianza 2 → 3 días
- Confianza 3 → 7 días
- Confianza 4 → 14 días
- Confianza 5 → 30 días

(Los intervalos se multiplican con cada revisión exitosa)

---

## Ejemplos de salidas

### Sesión completa

Ver: `Sesiones/2025-12-26 - Sesión Piloto.md`

Incluye:
- Preguntas formuladas
- Tus respuestas transcritas
- Evaluación de qué capturaste
- Elaboraciones nuevas identificadas
- Metadata sugerida

### Sugerencias de enriquecimiento

Ver ejemplo en sesión piloto.

Incluye:
- Propuestas de secciones nuevas para notas existentes
- Texto sugerido (basado en TUS elaboraciones)
- Conceptos para vincular
- Notas nuevas que valdría la pena crear

---

## Tips para mejores sesiones

### Antes de la sesión

- Ten 15-20 minutos sin interrupciones
- No necesitas preparación previa
- Confía en lo que recuerdas (o no)

### Durante la sesión

- **No consultes las notas** mientras respondes
- Habla/escribe libremente, sin autocensura
- Está bien decir "no recuerdo bien" o "no estoy seguro"
- Deja que surjan conexiones espontáneas
- Elabora ejemplos concretos cuando puedas

### Después de la sesión

- No necesitas revisar sugerencias inmediatamente
- Déjalas "reposar" unos días si quieres
- Incorpora solo lo que realmente resuene
- Usa las sugerencias como inspiración, no prescripción

---

## Preguntas frecuentes

### ¿Tengo que usar la metadata?

No. Es opcional. Si no la usas, Claude igual puede seleccionar notas basándose en otros criterios (actividad reciente, centralidad, etc.).

### ¿Puedo revisar una nota específica?

Sí. Solo pide: "Quiero revisar la nota [[Nombre nota]]"

### ¿Qué pasa si no recuerdo nada?

Perfecto. Eso es información valiosa. Claude te ayudará a reconectar con la idea y sugerirá cómo fortalecerla.

### ¿Tengo que implementar todas las sugerencias?

No. Son propuestas para inspirarte. Tu jardín es tuyo. Incorpora solo lo que tenga sentido.

### ¿Puedo hacer sesiones más cortas/largas?

Sí. El formato es flexible. Puedes pedir revisar solo 2 notas (10 min) o hasta 7-8 (30 min).

### ¿Qué pasa con las notas que nunca reviso?

Nada malo. Tu Zettelkasten puede tener "áreas salvajes" no cultivadas. Está bien. El sistema prioriza lo que estás trabajando activamente.

---

## Estado actual

### ✅ Implementado (Fase Piloto)

- Estructura de carpetas
- Sesión piloto completada
- Templates básicos
- Este README y plan completo

### 🚧 En desarrollo

- Comando `/revisar` automatizado
- Algoritmo de selección inteligente
- Skill formal de Claude

### 📋 Por explorar

- Dashboard de progreso
- Visualización de red de revisiones
- Estadísticas de evolución

---

## Feedback y ajustes

Este sistema está en **fase piloto**. Se espera iterar y ajustar según tu experiencia.

Cosas a observar:
- ¿Se siente generativo o mecánico?
- ¿Surgen insights valiosos?
- ¿Es sustentable la frecuencia?
- ¿Las sugerencias son útiles?

Ajustar según necesidad.

---

## Ver también

- `PLAN_IMPLEMENTACION.md` - Detalles técnicos completos
- `Sesiones/2025-12-26 - Sesión Piloto.md` - Ejemplo real
- `/Users/marko/Obsidian/Zettelkasten/Cómo cultivo mi jardín digital.md` - Filosofía general

---

**El objetivo no es eficiencia de memorización, sino profundidad de pensamiento.**
