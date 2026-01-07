# Explicación: IVE e IVM - Índices de Vulnerabilidad JUNAEB

**Fecha:** 2025-10-27  
**Fuentes:** JUNAEB, análisis de datos BBDD.xlsx

---

## 📋 RESUMEN EJECUTIVO

Chile utiliza **dos índices complementarios** para medir la vulnerabilidad escolar, ambos desarrollados por JUNAEB (Junta Nacional de Auxilio Escolar y Becas):

| Índice | Nombre Completo | Enfoque | Escala | Uso Principal |
|--------|----------------|---------|--------|---------------|
| **IVE-SINAE** | Índice de Vulnerabilidad Escolar - Sistema Nacional de Asignación con Equidad | **Clasificación categórica** (prioridades) | 0-100% | Focalización de programas sociales (PAE, útiles) |
| **IVM** | Índice de Vulnerabilidad Multidimensional | **Medición continua** (múltiples dimensiones) | 0-100 puntos | Diagnóstico integral de vulnerabilidad |

---

## 📊 IVE-SINAE: Índice de Vulnerabilidad Escolar

### ¿Qué mide?

El IVE-SINAE mide el **porcentaje de estudiantes vulnerables** en un establecimiento, clasificados en **tres prioridades** según riesgos socioeconómicos y socio-educativos.

### Fórmula de Cálculo

```
IVE = (N° Prioridad 1 + N° Prioridad 2 + N° Prioridad 3) / Matrícula Total × 100
```

### Clasificación de Prioridades

| Prioridad | Descripción | Características |
|-----------|-------------|-----------------|
| **Prioridad 1** | **Vulnerabilidad socioeconómica alta** | Estudiantes con principalmente riesgos socioeconómicos |
| **Prioridad 2** | **Vulnerabilidad socioeconómica + riesgo educativo** | Vulnerabilidad socioeconómica menor que P1, pero con problemas de: rendimiento escolar, asistencia o riesgo de deserción |
| **Prioridad 3** | **Vulnerabilidad socioeconómica sin riesgo educativo** | Mismo nivel socioeconómico que P2, pero sin problemas de rendimiento/asistencia identificados |

### Escala

- **Rango:** 0% - 100%
- **Interpretación:** A mayor porcentaje, mayor proporción de estudiantes vulnerables

### En tu BBDD.xlsx

**Columna:** `IVE_SINAE_Media`

**Datos observados (39 liceos EMTP):**
- **Promedio:** 83.8%
- **Rango:** 59.3% - 95.3%
- **Mediana:** 85.7%

**Interpretación:** Tus liceos EMTP tienen **muy alta vulnerabilidad** (83.8% promedio), lo que significa que **8 de cada 10 estudiantes** están en alguna de las tres prioridades SINAE.

### Usos

1. ✅ **Asignación de beneficios JUNAEB:**
   - Programa de Alimentación Escolar (PAE)
   - Útiles Escolares
   - Programa Yo Elijo Mi PC
   - Becas de estudio

2. ✅ **Focalización de recursos:**
   - Priorización de establecimientos para programas especiales
   - Asignación diferenciada de recursos

3. ✅ **Subvención Escolar Preferencial (SEP):**
   - Define estudiantes prioritarios/preferentes
   - Base para cálculo de SEP (conecta con `SEP_Prioritarios_Anual` en tu BBDD)

---

## 📊 IVM: Índice de Vulnerabilidad Multidimensional

### ¿Qué mide?

El IVM es un **índice continuo y multidimensional** que mide vulnerabilidad considerando múltiples factores más allá de lo socioeconómico.

Fue desarrollado entre 2015-2016 por JUNAEB en colaboración con la **Pontificia Universidad Católica de Chile**.

### Dimensiones Evaluadas

El IVM correlaciona variables de:

1. **Condiciones socioeconómicas del hogar**
2. **Trayectoria educativa del estudiante**
3. **Riesgos socio-educativos**
4. **Contexto familiar y comunitario**

### Escala

- **Rango:** 0 - 100 puntos
- **Interpretación:** A mayor puntaje, mayor vulnerabilidad multidimensional
- **Nota:** El índice es continuo, no categórico como el IVE

### Medición por Etapa

El IVM se calcula **anualmente** en **4 mediciones independientes** según la etapa educativa:

| Etapa | Niveles |
|-------|---------|
| **Parvularia** | Prekinder y Kinder |
| **1° Ciclo Básico** | 1° a 4° básico |
| **2° Ciclo Básico** | 7° y 8° básico |
| **Media** | I° a IV° medio |

### Categorización Individual

Cada estudiante recibe un puntaje IVM (0-100) que se clasifica en **4 categorías de vulnerabilidad:**

| Categoría | Rango (inferido) | Nivel de Vulnerabilidad |
|-----------|------------------|------------------------|
| **IVM Bajo** | Puntaje más bajo | Baja vulnerabilidad |
| **IVM Medio** | Puntaje medio-bajo | Vulnerabilidad moderada |
| **IVM Alto** | Puntaje medio-alto | Alta vulnerabilidad |
| **IVM Muy Alto** | Puntaje más alto | Vulnerabilidad crítica |

**Nota:** JUNAEB no publica los rangos numéricos exactos de cada categoría, probablemente porque varían según la distribución poblacional de cada año.

### IVM del Establecimiento

El **IVM_Establecimiento** es el **promedio** de los puntajes IVM de todos los estudiantes del establecimiento.

**Fórmula:**
```
IVM_Establecimiento = Promedio de puntajes IVM de todos los estudiantes
```

### En tu BBDD.xlsx

**Columnas:**
- `IVM_Establecimiento`: Promedio IVM del liceo
- `IVM_Bajo`: Número de estudiantes en vulnerabilidad baja
- `IVM_Medio`: Número de estudiantes en vulnerabilidad media
- `IVM_Alto`: Número de estudiantes en vulnerabilidad alta
- `IVM_Muy_Alto`: Número de estudiantes en vulnerabilidad muy alta

**Datos observados (39 liceos EMTP):**

**IVM_Establecimiento:**
- **Promedio:** 27.0 puntos
- **Rango:** 17.8 - 36.7 puntos
- **Mediana:** 26.4 puntos

**Distribución de Estudiantes por Categoría (17,244 estudiantes):**

| Categoría | Estudiantes | % | Promedio por liceo |
|-----------|-------------|---|-------------------|
| **IVM Bajo** | 5,169 | 30.0% | 136 estudiantes |
| **IVM Medio** | 1,309 | 7.6% | 34 estudiantes |
| **IVM Alto** | 1,176 | 6.8% | 31 estudiantes |
| **IVM Muy Alto** | 9,590 | **55.6%** | 252 estudiantes |

**Interpretación:**
- ⚠️ **Más de la mitad de los estudiantes** (55.6%) están en la categoría **IVM Muy Alto**
- El IVM promedio de 27.0 sugiere vulnerabilidad **media-alta** de los establecimientos
- Solo 30% de estudiantes tienen IVM Bajo

### Ejemplos de tus Liceos

**Liceos con IVM más BAJO (menor vulnerabilidad):**
- Liceo Tecnológico Bicentenario Enrique Kirberg: **17.8 puntos**
  - 61.7% estudiantes IVM Bajo
  - 20.3% IVM Muy Alto

**Liceos con IVM más ALTO (mayor vulnerabilidad):**
- Centro Educ. Dr. Amador Neghme: **36.0 puntos**
  - Solo 9.3% estudiantes IVM Bajo
  - 85.7% IVM Muy Alto
- Liceo Polivalente Eugenio Pereira Salas: **36.7 puntos**
  - Solo 7.9% estudiantes IVM Bajo
  - 84.7% IVM Muy Alto

### Usos

1. ✅ **Diagnóstico integral de vulnerabilidad**
2. ✅ **Focalización refinada de intervenciones**
3. ✅ **Seguimiento de trayectorias educativas**
4. ✅ **Investigación y evaluación de políticas públicas**

---

## 🔄 DIFERENCIAS CLAVE ENTRE IVE E IVM

| Aspecto | IVE-SINAE | IVM |
|---------|-----------|-----|
| **Tipo de medición** | Categórica (3 prioridades) | Continua (0-100 puntos) |
| **Enfoque** | Clasificación para beneficios | Diagnóstico multidimensional |
| **Agregación al establecimiento** | % estudiantes prioritarios | Promedio de puntajes individuales |
| **Actualización** | Anual | Anual por etapa educativa |
| **Dimensiones** | Principalmente socioeconómica | Multidimensional (socio+educativa+familiar) |
| **Escala del establecimiento** | 0-100% | 0-100 puntos (pero en práctica: 17-37) |
| **Uso principal** | Asignación de beneficios (PAE, SEP) | Diagnóstico y focalización de políticas |
| **Desarrollo** | JUNAEB (SINAE 2000s) | JUNAEB + PUC (2015-2016) |

### Relación entre IVE e IVM

Aunque son índices diferentes, **están correlacionados**:

- ✅ Establecimientos con **IVE alto** (muchos prioritarios) tienden a tener **IVM alto** (mayor vulnerabilidad promedio)
- ✅ Sin embargo, el IVM captura **matices** que el IVE no detecta
- ✅ Dos estudiantes pueden estar en la misma prioridad SINAE pero tener puntajes IVM muy distintos

**Ejemplo en tus datos:**
- **IVE promedio:** 83.8% (muy alto)
- **IVM promedio:** 27.0 puntos (medio-alto)
- **Interpretación:** Aunque la mayoría son estudiantes prioritarios (IVE), la vulnerabilidad multidimensional promedio es moderada (IVM)

---

## 📌 IMPLICACIONES PARA TU PROYECTO

### Para LA1 (Diagnóstico)

**IVE-SINAE (83.8% promedio):**
- ✅ Identifica tu población objetivo: **contextos de alta vulnerabilidad**
- ✅ Conecta con SEP: Alto IVE → más estudiantes prioritarios → más recursos SEP
- 🎯 Justifica foco en **condiciones habilitantes** (LA3): población vulnerable requiere infraestructura/equipamiento adecuado

**IVM (55.6% en categoría "Muy Alto"):**
- ⚠️ **Más de la mitad de estudiantes** están en vulnerabilidad crítica multidimensional
- 🎯 Requiere atención integral: no solo académico, sino también **convivencia** (clima bajo identificado en diagnóstico)
- 🎯 Refuerza necesidad de **desarrollo profesional docente** (LA2) para trabajar con población vulnerable

### Para LA2 (Capacidades Curriculares)

- 🎯 **OE2 M1:** Visión EMTP debe considerar contexto de alta vulnerabilidad
- 🎯 **OE2 M3:** Desarrollo docente debe incluir estrategias para trabajo con población IVM Muy Alto
- 🎯 Diseño curricular debe incorporar apoyos diferenciados según categoría IVM

### Para LA3 (Capacidades Administrativas)

- 💰 **Alto IVE → Alto SEP:** $8.4 mil millones disponibles para condiciones habilitantes
- 🎯 **M2 (Valorización):** Priorizar necesidades para estudiantes IVM Muy Alto (55.6%)
- 🎯 **M3 (Priorización):** Usar IVM como criterio de focalización de recursos

### Para LA4 (Evaluación Participativa)

- 📊 **Línea base:** IVE 83.8% e IVM 27.0
- 🎯 **Indicador de impacto:** Si mejora efectividad (titulación), ¿se mantiene en contexto de alta vulnerabilidad?
- 🎯 **Contexto:** Interpretar resultados considerando perfil vulnerable de la población

---

## 📚 FUENTES Y REFERENCIAS

### Documentos Oficiales
- JUNAEB (2024). *Índices de Vulnerabilidad Escolar IVE-SINAE*. Disponible en: https://www.junaeb.cl/ive
- JUNAEB (2024). *Medición de la Vulnerabilidad Multidimensional del Estudiante*. Disponible en: https://www.junaeb.cl/medicion-la-vulnerabilidad-ivm
- JUNAEB (2024). *Publicación Índices de Vulnerabilidad Escolar 2024*. https://www.junaeb.cl/imprescindibles-para-realizar-un-analisis-de-las-comunidades-educativas-del-pais-junaeb-publica-indices-de-vulnerabilidad-escolar-2024/

### Metodología
- CIAE Universidad de Chile & JUNAEB (2024). *Actualización de índices de vulnerabilidad educativa*. https://ciae.uchile.cl/noticia/junaeb-y-ciae-preparan-actualizacion-de-los-indices-de-vulnerabilidad-educativa
- Libro de código SNED 2024-2025 (analizado en este proyecto)

### Datos Analizados
- BBDD.xlsx (39 liceos EMTP, SLEP Santa Rosa y Del Pino)
- 17,244 estudiantes con clasificación IVM
- Año de referencia: 2024

---

## 💡 NOTAS TÉCNICAS

### Actualización de Índices
- Ambos índices se actualizan **anualmente**
- JUNAEB publica resultados generalmente en **julio-agosto** de cada año
- Para 2024, JUNAEB y CIAE están trabajando en **actualización metodológica** de IVE e IVM

### Limitaciones
1. **Rangos IVM:** JUNAEB no publica los puntos de corte exactos para categorías Bajo/Medio/Alto/Muy Alto
2. **Temporalidad:** IVE e IVM pueden corresponder a años distintos en algunas bases de datos
3. **Cobertura:** Solo aplica a establecimientos subvencionados (no particulares pagados)

### Relación con otras Variables de tu BBDD
- **IVE** ↔ `N_Prioritarios`, `N_Preferentes`, `% Beneficiarios SEP`
- **IVM** ↔ `Tasa_Asistencia_Promedio`, `IDPS_Clima_Convivencia` (liceos con IVM alto tienden a tener más desafíos de clima)
- **Ambos** ↔ `Total_SEP_Anual` (a mayor vulnerabilidad, mayor SEP)

---

**Documento generado:** 2025-10-27  
**Responsable:** Marko Bremer (consultor GE)  
**Proyecto:** Apoyo SLEP 2025-2026  
**Última actualización:** Octubre 2025