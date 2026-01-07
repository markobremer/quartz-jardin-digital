# EVALUACIÓN DE IMPACTO DE CORRECCIONES EN DIAGNÓSTICO IT1

**Fecha de evaluación:** 2025-10-28
**Documento evaluado:** `Diagnóstico IT1 - Completo.md`
**Fuente de correcciones:** `SharePoint/90. Recursos/Datos/BBDD.xlsx` (corregido)
**Informe de correcciones:** `SharePoint/90. Recursos/Datos/Proceso generación/INFORME_CORRECCIONES.md`

---

## RESUMEN EJECUTIVO

Se identificaron **correcciones críticas** en la base de datos que afectan significativamente el diagnóstico IT1:

### Naturaleza de las correcciones
- **84.6% de los liceos (33 de 39)** tenían datos de matrícula EMTP rotados/intercambiados
- **61.5% de los liceos (24 de 39)** tenían diferencias en datos de titulados (1-40 estudiantes por liceo)
- Los datos de matrícula total y SEP estaban correctos

### Impacto general en el diagnóstico

**🔴 IMPACTO CRÍTICO - Requiere reescritura completa:**
- Formación dual en Los Libertadores y Licancabur
- Matrícula EMTP en todos los SLEP
- Análisis de género en especialidades

**🟡 IMPACTO MODERADO - Requiere actualización de cifras:**
- Tasas de titulación (mejoran en todos los SLEP)
- Pérdidas de títulos (menores de lo reportado)
- Brechas entre SLEP (se reducen levemente)

**🟢 IMPACTO MÍNIMO - Conclusiones generales se mantienen:**
- Narrativas institucionales y visión EMTP
- Resultados académicos (SIMCE, asistencia)
- Capacidades docentes y recursos
- Desafíos comunes identificados

---

## COMPARACIÓN DE DATOS CLAVE

### Matrícula EMTP por SLEP

| SLEP | Original | Corregido | Diferencia | % Cambio |
|------|----------|-----------|------------|----------|
| **Licancabur** | 4,284 | 4,200 | -84 | -2.0% |
| **Los Libertadores** | 241 | 686 | **+445** | **+184.6%** 🔴 |
| **Santa Corina** | 1,444 | 1,001 | **-443** | **-30.7%** 🔴 |
| **Santa Rosa** | 1,456 | 841 | **-615** | **-42.2%** 🔴 |
| **Del Pino** | 1,510 | 1,797 | +287 | +19.0% |

### Tasas de Titulación

| SLEP | Original | Corregido | Diferencia | Impacto |
|------|----------|-----------|------------|---------|
| **Licancabur** | 50.33% | 58.34% | +8.01 pp | Mejora significativa |
| **Los Libertadores** | 75.13% | 76.65% | +1.52 pp | Mejora marginal |
| **Santa Corina** | 78.35% | 83.55% | +5.20 pp | Mejora moderada |
| **Santa Rosa** | 84.53% | 89.97% | +5.44 pp | Amplía liderazgo |
| **Del Pino** | 68.56% | 76.52% | +7.96 pp | Mejora significativa |

**Brecha máxima:** 34 pp (50%-84%) → 32 pp (58%-90%)

### Formación Dual

| SLEP | Original | Corregido | Impacto |
|------|----------|-----------|---------|
| **Licancabur** | 17.88% | 0.15% | 🔴 **CAMBIO CRÍTICO** - Ya NO es referente |
| **Los Libertadores** | 63.90% | 0.63% | 🔴 **CAMBIO CRÍTICO** - Elimina narrativa de "modelo exitoso" |
| **Santa Corina** | 0.00% | 0.00% | ✓ Sin cambios |
| **Santa Rosa** | 0.00% | 0.00% | ✓ Sin cambios |
| **Del Pino** | 0.00% | 0.00% | ✓ Sin cambios |

### Pérdidas de Títulos (Egresados sin titulación)

| SLEP | Original | Corregido | Diferencia |
|------|----------|-----------|------------|
| **Licancabur** | 533 | 447 | -86 (sigue siendo crítico) |
| **Los Libertadores** | N/E | 46 | N/A |
| **Santa Corina** | 100 | 76 | -24 |
| **Santa Rosa** | 54 | 35 | -19 |
| **Del Pino** | 233 | 174 | -59 |

---

## SECCIONES QUE REQUIEREN MODIFICACIÓN

### 🔴 PRIORIDAD CRÍTICA - Reescritura completa necesaria

#### 1. SLEP Los Libertadores - Formación Dual (Líneas 76-77, 208-210, 290-294, 340, 365)

**PROBLEMA:** El diagnóstico presenta a Los Libertadores como "modelo exitoso de formación dual" con 63.90%, cuando en realidad es 0.63% (prácticamente inexistente).

**Texto INCORRECTO (Línea 76-77):**
> "En contraste, presenta la **segunda mejor tasa de titulación (75.13%)** y, destacadamente, la **mayor tasa de formación dual (63.90%)**, casi cuatro veces superior a Licancabur y única entre los SLEP metropolitanos. Este modelo constituye una experiencia valiosa para transferencia."

**CORRECCIÓN REQUERIDA:**
> "En contraste, presenta la **segunda mejor tasa de titulación (76.65%)**, aunque la **formación dual es prácticamente inexistente (0.63%)**, al igual que los demás SLEP del proyecto."

**Texto INCORRECTO (Línea 208-210):**
> "La **formación dual** revela el contraste más dramático: Los Libertadores presenta 63.90%, Licancabur 17.88%, mientras **Santa Corina, Santa Rosa y Del Pino muestran 0.00%**. Esta polarización plantea interrogantes sobre por qué SLEP metropolitanos con alta densidad económica no han desarrollado modelos de alternancia, mientras un SLEP pequeño y rural logra vincular casi dos tercios de sus titulados."

**CORRECCIÓN REQUERIDA:**
> "La **formación dual es prácticamente inexistente** en todos los SLEP: Los Libertadores (0.63%), Licancabur (0.15%), mientras Santa Corina, Santa Rosa y Del Pino muestran 0.00%. Esta ausencia casi total plantea interrogantes sobre por qué los cinco SLEP, incluyendo los metropolitanos con alta densidad económica, no han desarrollado modelos significativos de alternancia."

**Texto INCORRECTO (Línea 290-294):**
> "Presenta el perfil más singular: **SLEP más pequeño** (241 estudiantes), clasificación **Autónomo**, **mayor proporción SEP** (28.42%), alta vulnerabilidad y ruralidad cordillerana, oferta **muy acotada** (3 especialidades), pero **mayor formación dual (63.90%)**."

**CORRECCIÓN REQUERIDA:**
> "Presenta el perfil más singular: **SLEP más pequeño** (686 estudiantes), clasificación **Autónomo**, **mayor proporción SEP** (28.42%), alta vulnerabilidad y ruralidad cordillerana, oferta **muy acotada** (3 especialidades), y **formación dual prácticamente inexistente (0.63%)**."

**Texto a ELIMINAR (Línea 340, 365):**
- Eliminar: "**Los Libertadores**: Documentar capacidades específicas que han permitido desarrollar formación dual exitosa como "buenas prácticas" transferibles"
- Eliminar: "formación dual en Los Libertadores" de la lista de casos de referencia interna

**REEMPLAZO:**
- Cambiar el desafío específico a: "**Los Libertadores**: Explorar oportunidades para desarrollar formación dual aprovechando escala reducida, autonomía institucional y proporción alta de SEP como ventajas para experimentación."

---

#### 2. SLEP Licancabur - Datos de matrícula, titulación y formación dual (Líneas 42, 50, 206, 282-283)

**Texto INCORRECTO (Línea 42):**
> "El SLEP administra **9 liceos EMTP** que atienden a **4,284 estudiantes** (64.94% de matrícula total)"

**CORRECCIÓN REQUERIDA:**
> "El SLEP administra **9 liceos EMTP** que atienden a **4,200 estudiantes** (64.94% de matrícula total)"

**Texto INCORRECTO (Línea 50):**
> "**El desafío más crítico es la tasa de titulación del 50.33%**, la más baja entre los SLEP: de 1,073 egresados en 2024, solo 540 obtuvieron título técnico. Esta brecha representa una pérdida significativa de oportunidades. La formación dual alcanza 17.88% de titulados, significativamente superior a los SLEP metropolitanos."

**CORRECCIÓN REQUERIDA:**
> "**El desafío más crítico es la tasa de titulación del 58.34%**, la más baja entre los SLEP: de 1,073 egresados en 2024, 626 obtuvieron título técnico (447 estudiantes sin titular). Si bien esta tasa mejoró respecto a mediciones preliminares, sigue representando una pérdida significativa de oportunidades. La formación dual es prácticamente inexistente (0.15%)."

**Texto INCORRECTO (Línea 206):**
> "Expresado en **pérdidas absolutas**: Licancabur perdió 533 títulos en 2024, Del Pino 233, mientras Santa Rosa perdió solo 54."

**CORRECCIÓN REQUERIDA:**
> "Expresado en **pérdidas absolutas**: Licancabur registró 447 egresados sin titular en 2024, Del Pino 174, Santa Corina 76, mientras Santa Rosa registró solo 35."

**Texto INCORRECTO (Línea 266):**
> "El hallazgo más contraintuitivo es la **desconexión entre tasas de titulación y resultados SIMCE**: Santa Rosa, con resultados más bajos (216-220) y mayor vulnerabilidad (IVE 85.10%, extranjería 26.39%), presenta la tasa más alta (84.53%); mientras Licancabur, con mejores resultados (230-242) y menor vulnerabilidad (IVE 77.03%), muestra la más baja (50.33%)."

**CORRECCIÓN REQUERIDA:**
> "El hallazgo más contraintuitivo es la **desconexión entre tasas de titulación y resultados SIMCE**: Santa Rosa, con resultados más bajos (216-220) y mayor vulnerabilidad (IVE 85.10%, extranjería 26.39%), presenta la tasa más alta (89.97%); mientras Licancabur, con mejores resultados (230-242) y menor vulnerabilidad (IVE 77.03%), muestra la más baja (58.34%)."

**Texto INCORRECTO (Línea 282-283):**
> "Licancabur enfrenta la **paradoja de condiciones relativamente favorables** (mejores resultados SIMCE, menor vulnerabilidad, mayor diversidad de especialidades, presencia moderada de formación dual) pero la **tasa de titulación más baja (50.33%)**, representando pérdida de 533 títulos en 2024."

**CORRECCIÓN REQUERIDA:**
> "Licancabur enfrenta la **paradoja de condiciones relativamente favorables** (mejores resultados SIMCE, menor vulnerabilidad, mayor diversidad de especialidades) pero la **tasa de titulación más baja (58.34%)**, representando 447 egresados sin titular en 2024."

---

#### 3. SLEP Santa Corina - Matrícula y género (Líneas 96, 104, 204, 300)

**Texto INCORRECTO (Línea 96):**
> "Administra **8 liceos EMTP** con **1,444 estudiantes** (29.44% de matrícula total)."

**CORRECCIÓN REQUERIDA:**
> "Administra **8 liceos EMTP** con **1,001 estudiantes** (29.44% de matrícula total)."

**Texto INCORRECTO (Línea 104):**
> "Presenta **tasa de titulación del 78.35%**: de 462 egresados, 362 obtuvieron título."

**CORRECCIÓN REQUERIDA:**
> "Presenta **tasa de titulación del 83.55%**: de 462 egresados, 386 obtuvieron título."

**Texto INCORRECTO (Línea 90, 188, 300):**
> "**desigualdad de género en formación técnico-profesional** (Párvulos 99% mujeres, Electricidad 90% hombres)"

**PROBLEMA:** Los datos corregidos NO muestran segregación tan extrema. Solo 1 liceo (Francisco de Aguirre) muestra 95% mujeres en Párvulos. Los liceos con Electricidad en Santa Corina muestran 84.8% y 57.6% hombres, NO 90%.

**CORRECCIÓN REQUERIDA:**
> "**desigualdad de género en formación técnico-profesional**, con segregación significativa en algunas especialidades (ej. Párvulos con alta feminización en ciertos liceos, Electricidad con alta masculinización)"

**O bien, ELIMINAR la mención de porcentajes específicos y mantener solo la observación general.**

---

#### 4. SLEP Santa Rosa - Matrícula y titulación (Líneas 124, 132, 206, 306)

**Texto INCORRECTO (Línea 124):**
> "Administra **8 liceos EMTP** con **1,456 estudiantes** (44.41% de matrícula total)."

**CORRECCIÓN REQUERIDA:**
> "Administra **8 liceos EMTP** con **841 estudiantes** (44.41% de matrícula total)."

**Texto INCORRECTO (Línea 132):**
> "En contraste dramático, presenta la **tasa de titulación más alta (84.53%)**: de 349 egresados, 295 obtuvieron título"

**CORRECCIÓN REQUERIDA:**
> "En contraste dramático, presenta la **tasa de titulación más alta (89.97%)**: de 349 egresados, 314 obtuvieron título"

**Texto INCORRECTO (Línea 306):**
> "Presenta el perfil más paradójico: **mayor vulnerabilidad** (IVE 85.10%), **mayor extranjería (26.39%)**, **resultados SIMCE más bajos (216-220)**, **menor asistencia (79.98%)**, clasificación **En Recuperación**, pero **tasa de titulación más alta (84.53%)**."

**CORRECCIÓN REQUERIDA:**
> "Presenta el perfil más paradójico: **mayor vulnerabilidad** (IVE 85.10%), **mayor extranjería (26.39%)**, **resultados SIMCE más bajos (216-220)**, **menor asistencia (79.98%)**, clasificación **En Recuperación**, pero **tasa de titulación más alta (89.97%)**."

---

#### 5. SLEP Del Pino - Matrícula y titulación (Líneas 152, 162, 204, 316, 324)

**Texto INCORRECTO (Línea 152):**
> "Administra el **mayor número de liceos: 12 establecimientos** con **1,510 estudiantes EMTP** (22.99% de matrícula total)."

**CORRECCIÓN REQUERIDA:**
> "Administra el **mayor número de liceos: 12 establecimientos** con **1,797 estudiantes EMTP** (22.99% de matrícula total)."

**Texto INCORRECTO (Línea 162):**
> "Presenta **tasa de titulación del 68.56%**: de 741 egresados, 508 obtuvieron título, quedando significativamente por debajo de Santa Rosa y Santa Corina. La brecha con Santa Rosa (16 puntos porcentuales) representa aproximadamente 233 estudiantes que egresaron sin título."

**CORRECCIÓN REQUERIDA:**
> "Presenta **tasa de titulación del 76.52%**: de 741 egresados, 567 obtuvieron título, quedando por debajo de Santa Rosa y Santa Corina. La brecha con Santa Rosa (13 puntos porcentuales) representa 174 egresados sin titular."

**Texto INCORRECTO (Línea 204):**
> "La dispersión es dramática: desde 50.33% (Licancabur) hasta 84.53% (Santa Rosa), con Los Libertadores (75.13%), Santa Corina (78.35%) y Del Pino (68.56%) en posiciones intermedias. Esta brecha de 34 puntos representa la diferencia entre sistemas que certifican a más de 4 de cada 5 egresados versus sistemas donde solo la mitad obtiene título."

**CORRECCIÓN REQUERIDA:**
> "La dispersión es dramática: desde 58.34% (Licancabur) hasta 89.97% (Santa Rosa), con Los Libertadores (76.65%), Del Pino (76.52%) y Santa Corina (83.55%) en posiciones intermedias. Esta brecha de 32 puntos representa la diferencia entre sistemas que certifican a casi 9 de cada 10 egresados versus sistemas donde aproximadamente 6 de cada 10 obtienen título."

**Texto INCORRECTO (Línea 316):**
> "**tasa de titulación intermedia-baja (68.56%)**"

**CORRECCIÓN REQUERIDA:**
> "**tasa de titulación intermedia (76.52%)**"

**Texto INCORRECTO (Línea 324):**
> "La **tasa de titulación intermedia-baja (68.56%)** representa pérdida de 233 títulos. Considerando que Del Pino tiene 12 liceos, incluso mejoras moderadas (alcanzar 75%) generarían impactos absolutos significativos (≈50 títulos adicionales anuales)."

**CORRECCIÓN REQUERIDA:**
> "La **tasa de titulación intermedia (76.52%)** representa 174 egresados sin titular. Considerando que Del Pino tiene 12 liceos, incluso mejoras moderadas (alcanzar 85%) generarían impactos absolutos significativos (≈60 títulos adicionales anuales)."

---

### 🟡 PRIORIDAD MODERADA - Actualizaciones menores

#### 6. Sección 2.4 - Análisis comparativo de trayectorias (Línea 204-210)

**Actualizar ranking de tasas de titulación:**
- Nuevo orden: Santa Rosa (89.97%) > Santa Corina (83.55%) > Los Libertadores (76.65%) > Del Pino (76.52%) > Licancabur (58.34%)
- Actualizar brecha máxima: 32 pp (no 34 pp)
- Eliminar narrativa de formación dual en Los Libertadores

#### 7. Conclusiones sobre capacidades institucionales (Línea 266-270)

**Mantener la conclusión general** pero actualizar cifras específicas:
- Santa Rosa sigue siendo el caso más destacado (ahora con 90% de titulación)
- Licancabur mejora pero sigue siendo el más bajo (58% en lugar de 50%)
- La desconexión con SIMCE se mantiene como hallazgo válido

---

### 🟢 PRIORIDAD BAJA - Verificación opcional

#### 8. Narrativas sobre desafíos comunes (Sección 3.1)

**Verificar coherencia** de las narrativas sobre:
- Ausentismo crítico (sin cambios en datos)
- Desarrollo profesional docente (sin cambios en datos)
- Resultados académicos bajos (sin cambios en datos)

**Acción:** Revisión de consistencia, sin modificaciones sustanciales requeridas.

---

## CONCLUSIONES Y RECOMENDACIONES

### Impacto en las conclusiones principales del diagnóstico

#### ✅ CONCLUSIONES QUE SE MANTIENEN VÁLIDAS:

1. **Desafíos comunes transversales:**
   - Brecha masiva en desarrollo profesional docente
   - Ausentismo crítico como factor de riesgo
   - Resultados académicos consistentemente bajos
   - Desarticulación entre capacidades de titulación y resultados académicos (aunque con cifras actualizadas)

2. **Hallazgo sobre Santa Rosa:**
   - Sigue siendo el SLEP con tasa de titulación más alta
   - La paradoja de "alta titulación en contexto de máxima vulnerabilidad" se **FORTALECE** (ahora casi 90%)
   - Validez de posicionar a Santa Rosa como referente en procesos de titulación

3. **Vulnerabilidad y contextos territoriales:**
   - Diferencias significativas en IVE, extranjería, y condiciones socioeconómicas se mantienen
   - Análisis de perfil de cobertura y oferta formativa permanecen válidos

#### ❌ CONCLUSIONES QUE DEBEN ELIMINARSE O REFORMULARSE:

1. **"Los Libertadores como modelo exitoso de formación dual"**
   - Narrativa COMPLETAMENTE INCORRECTA
   - Debe eliminarse toda referencia a Los Libertadores como caso transferible de formación dual
   - Las hipótesis sobre formación dual deben reformularse para todos los SLEP

2. **"Licancabur con presencia moderada de formación dual"**
   - INCORRECTA: 0.15% es marginal, no moderada
   - No hay contraste significativo entre Licancabur y SLEP metropolitanos

3. **Segregación de género con cifras específicas**
   - Las menciones de "99% mujeres" y "90% hombres" son imprecisas o basadas en casos aislados
   - Mantener observación general de segregación, pero eliminar porcentajes específicos

#### 🔄 CONCLUSIONES QUE REQUIEREN MATIZACIÓN:

1. **Brecha en tasas de titulación:**
   - Se reduce de 34 pp a 32 pp (cambio menor pero debe actualizarse)
   - Licancabur mejora de 50% a 58% (sigue siendo el más bajo, pero brecha menos dramática)
   - Del Pino mejora de 68% a 76% (ya no es "intermedio-bajo" sino "intermedio")

2. **Pérdidas de títulos:**
   - Las magnitudes son menores (Licancabur: 447 no 533; Del Pino: 174 no 233)
   - El problema sigue siendo significativo pero menos crítico de lo reportado originalmente

### Recomendaciones operativas

#### INMEDIATO (Antes de socializar el diagnóstico):

1. **Reescribir completamente** las secciones sobre formación dual
2. **Actualizar todas las cifras** de matrícula EMTP, titulados y tasas
3. **Eliminar o matizar** menciones específicas de segregación de género

#### CORTO PLAZO (Durante LA1):

1. **Validar en terreno** la ausencia de formación dual:
   - ¿Los datos de 0.15%-0.63% reflejan ausencia real o sub-registro?
   - ¿Existen experiencias de alternancia no formalizadas?

2. **Explorar causas** de la mejora en tasas de titulación respecto a datos preliminares:
   - ¿Procesos tardíos de titulación registrados después?
   - ¿Cambios en criterios de registro?

3. **Documentar distribución de género** por especialidad durante visitas:
   - Verificar en terreno patrones de segregación observados
   - Identificar especialidades con mayor/menor segregación

### Validez general del diagnóstico

A pesar de las correcciones requeridas, el diagnóstico IT1 **mantiene validez en sus conclusiones estructurales principales**:

✅ Los cinco SLEP enfrentan desafíos transversales significativos en capacidades docentes, ausentismo y resultados académicos

✅ Existen brechas importantes en tasas de titulación que reflejan diferencias en capacidades institucionales

✅ Santa Rosa emerge como caso de referencia en procesos de titulación

✅ Los desafíos específicos por SLEP identificados (escala, vulnerabilidad, dispersión) permanecen válidos

❌ Las narrativas sobre formación dual requieren reescritura completa

❌ Todas las cifras específicas de matrícula EMTP, titulados y tasas deben actualizarse

---

## PRIORIZACIÓN DE TRABAJO

### Orden sugerido de correcciones:

1. **Fase 1 - Correcciones críticas (2-3 horas):**
   - Reescribir secciones de formación dual (Los Libertadores, Licancabur)
   - Actualizar todas las cifras de matrícula EMTP
   - Actualizar todas las tasas de titulación y pérdidas de títulos
   - Eliminar/matizar menciones de segregación de género

2. **Fase 2 - Verificación de consistencia (1-2 horas):**
   - Revisar que rankings y comparaciones estén actualizados
   - Verificar coherencia narrativa tras cambios
   - Actualizar resumen ejecutivo y conclusiones finales

3. **Fase 3 - Validación final (30 min):**
   - Lectura completa para identificar inconsistencias remanentes
   - Verificar que tablas de anexos estén alineadas con narrativa

---

**Documento generado:** 2025-10-28
**Responsable:** Marko Bremer, Consultor de Acompañamiento
**Próximo paso:** Aplicar correcciones priorizadas al diagnóstico IT1
