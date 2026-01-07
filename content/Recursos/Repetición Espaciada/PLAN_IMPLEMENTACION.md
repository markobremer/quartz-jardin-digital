# Plan de Implementación: Sistema de Repetición Espaciada

**Fecha:** 2025-12-26
**Versión:** 1.0
**Autor:** Claude Code (asistente IA)

---

## Visión general

Sistema de repetición espaciada que combina consolidación de memoria con **cultivo generativo** del jardín digital. A diferencia de flashcards tradicionales, este sistema usa interrogación socrática para expandir ideas mientras se revisan.

### Principios rectores

1. **Generativo, no mecánico**: No solo recordar, sino elaborar y conectar
2. **Respeto al ITE**: Todo contenido IA queda fuera de Zettelkasten/Inbox/Diario
3. **Eficiente**: 15-20 min, 2-3x por semana, sustentable a largo plazo
4. **Rastrea progreso**: Metadata y logs para ver evolución
5. **100% texto plano**: Markdown, portable, no dependiente de apps

---

## Arquitectura del sistema

### Estructura de carpetas

```
4. Recursos/Repetición Espaciada/
├── PLAN_IMPLEMENTACION.md          # Este documento
├── README.md                        # Guía de uso del sistema
├── Sesiones/                        # Logs de sesiones realizadas
│   ├── 2025-12-26 - Sesión Piloto.md
│   ├── 2025-12-27 - Sesión 01.md
│   └── ...
├── Sugerencias/                     # Propuestas de enriquecimiento
│   ├── Por nota/
│   │   ├── Biológicamente Cultural.md
│   │   ├── Psicoterapia.md
│   │   └── ...
│   └── Notas nuevas sugeridas.md
└── Templates/
    ├── Template - Sesión.md
    └── Template - Sugerencia.md
```

### Metadata en notas del Zettelkasten

Agregar bloque opcional al frontmatter de cada nota:

```yaml
---
title: Biológicamente Cultural
tags: [neurociencia, evolución]
created: 2024-XX-XX
last_modified: 2025-12-26
sr:  # spaced repetition
  reviewed: 2025-12-26
  count: 3
  confidence: 4
  next: 2026-01-09
---
```

**Campos:**
- `reviewed`: Última fecha de revisión
- `count`: Número de veces revisada
- `confidence`: 1-5, auto-evaluación de comprensión
- `next`: Sugerencia de próxima revisión

**Nota importante:** Esta metadata es OPCIONAL y solo se agrega si Marko lo decide manualmente después de una sesión. Claude nunca modificará estas propiedades directamente.

---

## Algoritmo de selección de notas

Claude selecciona 3-5 notas por sesión basándose en:

### 1. Prioridad por metadata (si existe)
- Notas con `next_review` vencido o cercano
- Notas con `confidence` baja (1-2)
- Notas no revisadas nunca

### 2. Prioridad por actividad reciente
- Notas recientemente modificadas (indica trabajo activo)
- Notas vinculadas a trabajo actual de Marko

### 3. Prioridad por centralidad
- Notas hub (muchas conexiones entrantes/salientes)
- Notas fundamentales (conceptos base del sistema)

### 4. Diversidad temática
- Distribuir entre tags diferentes
- No revisar siempre las mismas áreas

### Ejemplo de algoritmo

```
1. Escanear Zettelkasten/ para notas con metadata `sr`
2. Filtrar por `next <= hoy` → candidatas prioritarias
3. Si < 3 candidatas:
   - Agregar notas sin metadata sr (nunca revisadas)
   - Agregar notas modificadas en últimos 7 días
   - Agregar notas hub (>5 backlinks)
4. Seleccionar 3-5 notas balanceando:
   - Al menos 1 revisión pendiente (si existe)
   - Al menos 1 nota nueva (si no se ha revisado)
   - Al menos 1 nota central/hub
5. Ordenar por: pendientes → nuevas → hub
```

---

## Estructura de una sesión

### Fase 1: Preparación (Claude)
1. Seleccionar 3-5 notas según algoritmo
2. Leer notas completas para contexto
3. Generar preguntas personalizadas para cada nota
4. Crear archivo de sesión en `Sesiones/`

### Fase 2: Interrogación (diálogo)
Para cada nota:

**Pregunta de síntesis** (2-3 min)
- "¿Cuál es la idea central de [concepto]?"
- Marko responde sin consultar
- Claude registra respuesta

**Pregunta de elaboración** (3-5 min)
- "¿Cómo se relaciona esto con [otro concepto de su Zettelkasten]?"
- "¿Qué implicaciones tiene esto para [área de trabajo]?"
- Marko elabora libremente
- Claude registra elaboraciones

**Pregunta generativa** (2-3 min, opcional)
- "¿Qué pregunta nueva te surge?"
- "¿Qué ejemplo concreto ilustra esto?"
- Captura insights emergentes

### Fase 3: Revisión y captura (Claude)
1. Comparar respuestas con nota original
2. Identificar:
   - Qué se recordó bien
   - Qué se olvidó
   - Qué elaboraciones nuevas surgieron
3. Documentar en archivo de sesión

### Fase 4: Sugerencias (Claude)
1. Generar propuestas de enriquecimiento
2. Guardar en `Sugerencias/Por nota/[Nombre nota].md`
3. Sugerir nuevas notas si emergieron conceptos importantes
4. Proponer metadata actualizada

### Fase 5: Integración (Marko, asíncrono)
Marko decide qué incorporar:
- Revisa sugerencias en su tiempo
- Edita manualmente sus notas en Zettelkasten
- Crea notas nuevas si lo desea
- Actualiza metadata si lo encuentra útil

**Total tiempo de sesión:** 15-25 minutos

---

## Tipos de preguntas por nivel

### Nivel 1: Comprensión básica
- "¿Qué es [concepto]?"
- "¿Cuál es la idea central?"
- "¿Por qué es importante?"

### Nivel 2: Relaciones
- "¿Cómo se relaciona con [otro concepto]?"
- "¿En qué se diferencia de [concepto similar]?"
- "¿Qué otros conceptos dependen de este?"

### Nivel 3: Aplicación
- "¿Cómo aparece esto en tu práctica clínica?"
- "¿Qué ejemplo concreto ilustra esto?"
- "¿Cómo usarías esto en [contexto específico]?"

### Nivel 4: Análisis crítico
- "¿Qué limitaciones tiene esta idea?"
- "¿Qué autores discrepan y por qué?"
- "¿Qué tensiones no resueltas quedan?"

### Nivel 5: Síntesis generativa
- "¿Qué conexión nueva ves ahora?"
- "¿Qué pregunta surge al pensar en esto?"
- "¿Cómo reformularías esta idea hoy?"

Claude selecciona preguntas apropiadas según:
- Complejidad de la nota
- Madurez del concepto (cuánto tiempo lleva en el Zettelkasten)
- Nivel de confianza previo (metadata)

---

## Propuesta de comando/skill

### Opción 1: Comando simple `/revisar`

Invocación:
```
/revisar
```

Comportamiento:
- Selecciona notas automáticamente
- Inicia sesión interactiva
- Guarda log y sugerencias al terminar

Variantes:
```
/revisar 5              # Revisar 5 notas específicamente
/revisar pendientes     # Solo notas con revisión vencida
/revisar [nombre nota]  # Revisar nota específica
```

### Opción 2: Skill completo

**Nombre:** `repeticion-espaciada` o `sr` (spaced repetition)

**Estructura:**
```
.claude/skills/repeticion-espaciada/
├── SKILL.md                    # Definición del skill
├── prompt_sesion.md            # Template de prompts
├── selector_notas.py           # Script para selección (opcional)
└── README.md                   # Documentación
```

**SKILL.md:**
```markdown
---
name: repeticion-espaciada
description: Sistema de revisión espaciada generativa para Zettelkasten
triggers:
  - /revisar
  - /sr
  - /repaso
---

Sistema de repetición espaciada que combina consolidación de memoria con
cultivo generativo del jardín digital mediante interrogación socrática.

## Funcionamiento

1. Seleccionar 3-5 notas del Zettelkasten según algoritmo
2. Para cada nota:
   - Pregunta de síntesis
   - Pregunta de elaboración
   - Pregunta generativa (opcional)
3. Registrar respuestas en sesión
4. Generar sugerencias de enriquecimiento
5. Guardar todo en 4. Recursos/Repetición Espaciada/

## Restricciones CRÍTICAS

- NUNCA editar archivos en Zettelkasten/
- NUNCA editar archivos en Diario/
- NUNCA editar archivos en Inbox/
- Solo LEER estas carpetas para contexto
- Todas las sugerencias van a Recursos/Repetición Espaciada/

## Outputs

- Sesión completa en Sesiones/YYYY-MM-DD - Sesión XX.md
- Sugerencias individuales en Sugerencias/Por nota/[nota].md
- Lista de notas nuevas sugeridas (si aplica)
```

---

## Cálculo de intervalos de revisión

Basado en nivel de confianza y número de revisiones:

```
Confianza 1 (no recuerdo): 1 día
Confianza 2 (recuerdo parcial): 3 días
Confianza 3 (recuerdo bien): 7 días
Confianza 4 (muy bien + elaboración): 14 días
Confianza 5 (perfecto + insights nuevos): 30 días
```

Multiplicador por número de revisiones:
```
1ra revisión: intervalo base
2da revisión: intervalo × 1.5
3ra revisión: intervalo × 2
4ta+ revisión: intervalo × 2.5
```

Ejemplo:
- Nota nueva, confianza 4 → siguiente en 14 días
- Misma nota, 2da revisión, confianza 5 → siguiente en 30 × 1.5 = 45 días

**Nota:** Estos intervalos son sugerencias. Marko puede ajustar manualmente.

---

## Templates

### Template - Sesión.md

```markdown
# Sesión de Revisión Espaciada - [Número]

**Fecha:** YYYY-MM-DD
**Notas revisadas:** X/Y
**Duración:** XX minutos
**Generado por:** Claude Code

---

## Nota 1: [[Nombre nota]]

### Pregunta de síntesis
[Pregunta formulada]

### Respuesta de Marko
> [Respuesta transcrita]

**Evaluación:** ✅/⚠️/❌
- [Qué capturó bien]
- [Qué faltó]

### Pregunta de elaboración
[Pregunta formulada]

### Respuesta de Marko
> [Respuesta transcrita]

**Conexiones realizadas:**
- [Lista de conexiones que Marko hizo]

**Elaboraciones nuevas:**
- [Ideas nuevas que surgieron]

### Pregunta generativa (si aplica)
[Pregunta]

### Respuesta
> [Respuesta]

---

## Sugerencias de enriquecimiento

Ver: `Sugerencias/Por nota/[Nombre nota].md`

---

## Metadata de revisión sugerida

**[[Nombre nota 1]]:**
- reviewed: YYYY-MM-DD
- count: X
- confidence: X/5
- next: YYYY-MM-DD

[Repetir para cada nota]

---

## Notas para próxima sesión

- [Observaciones]
- [Temas que emergieron]
- [Posibles focos]
```

### Template - Sugerencia.md

```markdown
# Sugerencias de enriquecimiento: [[Nombre nota]]

**Fecha de sesión:** YYYY-MM-DD
**Generado por:** Claude Code

---

## Respuestas de Marko

### Síntesis
> [Quote de respuesta]

**Evaluación:** [Lo que capturó bien / lo que faltó]

### Elaboraciones
> [Quote de elaboraciones]

**Nuevas conexiones identificadas:**
- [Lista]

**Conceptos nuevos emergentes:**
- [Lista]

---

## Propuestas de enriquecimiento

### Para la nota actual

#### Sección sugerida: "[Nombre sección]"

**Ubicación propuesta:** [Dónde en la nota]

**Texto sugerido:**
```
[Texto en markdown, incorporando elaboraciones de Marko]
```

**Conceptos a vincular:**
- [[Concepto 1]] (ya existe)
- [[Concepto 2]] (crear nueva nota)

### Notas nuevas sugeridas

#### [[Nombre nota nueva]]

**Justificación:** [Por qué sería valioso]

**Idea central:** [Resumen de qué trataría]

**Conexiones naturales:**
- [[Nota existente 1]]
- [[Nota existente 2]]

**Contenido sugerido (borrador):**
```
[Borrador basado en elaboraciones de Marko]
```

---

## Próximos pasos sugeridos

1. [Acción concreta]
2. [Acción concreta]
3. [Etc.]
```

---

## README.md del sistema

```markdown
# Sistema de Repetición Espaciada

Sistema de revisión generativa que combina consolidación de memoria con
cultivo activo del jardín digital.

## Inicio rápido

1. Invocar: `/revisar` o `/sr`
2. Responder preguntas de 3-5 notas (15-20 min)
3. Revisar sugerencias en `Sugerencias/`
4. Decidir qué incorporar a tu Zettelkasten

## Filosofía

No es memorización mecánica, sino **cultivo de pensamiento**:
- Preguntas socráticas (no flashcards)
- Elaboración generativa (no solo recall)
- Enriquecimiento continuo del jardín

## Estructura

- `Sesiones/`: Logs de cada sesión
- `Sugerencias/`: Propuestas de enriquecimiento por Claude
- `Templates/`: Templates de documentos

## Flujo de trabajo

```
1. Claude selecciona notas → Sesión de interrogación (15-20 min)
2. Claude genera sugerencias → Guardadas en Sugerencias/
3. Tú revisas sugerencias → Decides qué incorporar
4. Tú editas manualmente → Tu Zettelkasten permanece tuyo
```

## Restricciones importantes

⚠️ Claude NUNCA edita Zettelkasten/, Diario/ o Inbox/
✅ Todas las sugerencias van a Recursos/Repetición Espaciada/
✅ Tú decides qué y cuándo incorporar a tu jardín

## Metadata opcional

Puedes agregar a tus notas:

```yaml
sr:
  reviewed: 2025-12-26
  count: 3
  confidence: 4
  next: 2026-01-09
```

Esto ayuda a Claude a priorizar, pero es completamente opcional.

## Frecuencia recomendada

- 2-3 sesiones por semana
- 15-20 minutos por sesión
- 3-5 notas por sesión

Sustentable a largo plazo.
```

---

## Roadmap de implementación

### Fase 1: Prototipo funcional ✅
- [x] Sesión piloto manual
- [x] Estructura de carpetas
- [x] Template de sesión
- [x] Template de sugerencias

### Fase 2: Automatización básica
- [ ] Crear skill `/revisar`
- [ ] Implementar algoritmo de selección
- [ ] Automatizar creación de archivos de sesión
- [ ] Probar con 3-5 sesiones reales

### Fase 3: Refinamiento
- [ ] Ajustar tipos de preguntas según feedback
- [ ] Optimizar selección de notas
- [ ] Mejorar formato de sugerencias
- [ ] Crear visualización de progreso (opcional)

### Fase 4: Integración completa
- [ ] Metadata automática (si Marko lo aprueba)
- [ ] Dashboard de revisiones pendientes
- [ ] Estadísticas de evolución
- [ ] Exportación de insights

---

## Consideraciones técnicas

### Lectura del Zettelkasten
Claude debe:
1. Leer archivos en Zettelkasten/ (solo lectura)
2. Parsear frontmatter (si existe metadata `sr`)
3. Analizar backlinks (¿qué notas referencian esta?)
4. Identificar tags para diversidad temática

### Generación de preguntas
Claude debe:
1. Entender concepto central de la nota
2. Identificar notas relacionadas en el Zettelkasten
3. Formular preguntas contextualizadas al trabajo actual de Marko
4. Variar tipos de preguntas según nivel

### Formato de outputs
- Todo en Markdown
- Wikilinks [[Así]]
- Citas con `>` blockquotes
- Estructura clara con headings

---

## Métricas de éxito

¿Cómo saber si el sistema funciona?

### Cuantitativas
- Notas revisadas por semana
- % de sugerencias incorporadas
- Nuevas notas creadas desde sesiones
- Consistencia en frecuencia de sesiones

### Cualitativas
- ¿Se sienten las sesiones generativas (no mecánicas)?
- ¿Surgen insights nuevos regularmente?
- ¿Se expanden las notas del Zettelkasten?
- ¿Se mantiene el sistema a largo plazo?

### Indicador clave
**¿El Zettelkasten crece en profundidad y conexiones, no solo en cantidad?**

---

## Próximos pasos inmediatos

1. **Revisar este plan** con Marko
2. **Ajustar** según feedback
3. **Decidir** si implementar como skill o comando simple
4. **Hacer 2-3 sesiones piloto** más para iterar
5. **Crear skill formal** si el sistema funciona bien

---

## Notas finales

Este sistema respeta los principios del ITE:
- Zettelkasten permanece exclusivamente humano
- IA actúa como sparring socrático, no ghostwriter
- Todas las decisiones de qué incorporar son de Marko
- El jardín digital sigue siendo su jardín

**El objetivo no es eficiencia de memorización, sino profundidad de pensamiento.**
