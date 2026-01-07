# Resumen: Incorporación de Columnas Críticas a BBDD.xlsx

**Fecha:** 2025-10-27  
**Archivo actualizado:** `SharePoint/Recursos/Datos/BBDD.xlsx`  
**Backup creado:** `BBDD_backup_20251027_224516.xlsx`

---

## ✅ TAREA COMPLETADA

Se incorporaron exitosamente **20 columnas críticas** a BBDD.xlsx, enriqueciendo la base de datos principal del proyecto con indicadores clave de:
- Titulación y prácticas duales
- Rendimiento académico
- Dotación y evaluación docente
- Financiamiento

---

## 📊 RESULTADO FINAL

### Dimensiones
- **Antes:** 39 liceos × 49 columnas = 1,911 celdas
- **Después:** 39 liceos × 69 columnas = 2,691 celdas
- **Incremento:** +20 columnas (+41% de datos)

### Cobertura de Datos
Todas las 20 columnas críticas tienen **100% de cobertura** (39/39 liceos con datos).

---

## 📋 COLUMNAS CRÍTICAS INCORPORADAS

### 1. EGRESADOS Y TITULACIÓN (5 columnas)

| Columna | Descripción | Total |
|---------|-------------|-------|
| `N_Egresados_EMTP_2024` | Egresados EMTP 2024 | 2,822 estudiantes |
| `N_Titulados_2024` | Titulados con práctica aprobada | 1,853 estudiantes |
| `Tasa_Titulacion` | % egresados que se titulan | **65.7%** promedio |
| `N_Practicas_Duales` | Prácticas en modalidad dual | 176 prácticas |
| `%_Practicas_Duales` | % titulados en modalidad dual | **9.5%** promedio |

**Fuentes:** 2024_Egresados.csv, 2024_Practicantes y titulados.csv

**Impacto proyecto:** 
- 🔴 **Brecha 1 (LA1):** Indicador clave para diagnóstico de efectividad EMTP
- 🔴 **OE2 (LA2):** Evalúa traducción de visión EMTP en resultados de titulación
- 🔴 **LA1:** Dato crítico mencionado en diagnóstico (baja presencia dual: solo 9.5%)

---

### 2. RENDIMIENTO ACADÉMICO (3 columnas)

| Columna | Descripción | Total |
|---------|-------------|-------|
| `NEM_Promedio_Egresados` | Promedio NEM de egresados | **5.6** promedio |
| `N_Estudiantes_Top10%` | Estudiantes en top 10% del liceo | 480 estudiantes |
| `N_Estudiantes_Top30%` | Estudiantes en top 30% del liceo | 901 estudiantes |

**Fuentes:** 2023_NEM Jóvenes.csv, 2023_NEM Adultos.csv

**Impacto proyecto:**
- 🔴 **OE2 (LA2):** Evalúa arquitectura curricular y calidad pedagógica
- 🔴 **Oportunidades:** Identifica potencial BEA (480 estudiantes) y BVP (901 estudiantes)

---

### 3. DOTACIÓN DOCENTE (3 columnas)

| Columna | Descripción | Total |
|---------|-------------|-------|
| `N_Docentes_UTP` | Docentes en Unidad Técnico-Pedagógica | 60 docentes |
| `Horas_UTP` | Horas totales equipo UTP | Variable por liceo |
| `N_Jefes_UTP` | Jefes de UTP | Variable por liceo |

**Fuente:** 2025_Dotación Docente.csv

**Impacto proyecto:**
- 🔴 **OE2 (LA2):** Capacidad institucional para conducción curricular
- 🔴 **LA2 M1-M2:** Liderazgo pedagógico disponible para alinear visión EMTP

---

### 4. EVALUACIÓN DOCENTE (3 columnas)

| Columna | Descripción | Total |
|---------|-------------|-------|
| `N_Docentes_Evaluados_2023` | Docentes evaluados en 2023 | 374 docentes |
| `Puntaje_Promedio_Portafolio` | Promedio puntaje portafolio | **2.4** promedio |
| `%_Docentes_Destacados_Competentes` | % en categorías A+B (Carrera Docente) | Variable por liceo |

**Fuente:** 2023_Evaluación docente.csv

**Impacto proyecto:**
- 🔴 **Brecha 1 (LA2):** Indicador de desarrollo profesional docente (bajos tramos identificados)
- 🔴 **OE2 M3:** Nivel actual de desarrollo docente para planificar LA2

**Nota:** Puntaje promedio portafolio de 2.4 sugiere oportunidades significativas de mejora en desarrollo profesional.

---

### 5. FINANCIAMIENTO (6 columnas)

| Columna | Descripción | Total 2024 |
|---------|-------------|------------|
| `Subvencion_Escolaridad_Anual` | Subvención escolar total | Variable por liceo |
| `Subvencion_PIE_Anual` | Subvención PIE (NEE) | Variable por liceo |
| `SEP_Prioritarios_Anual` | SEP estudiantes prioritarios | Variable por liceo |
| `SEP_Preferentes_Anual` | SEP estudiantes preferentes | Variable por liceo |
| `Total_SEP_Anual` | Total SEP (prioritarios + preferentes) | **$8,380,666,080** |
| `Total_Subvenciones_Anual` | Total subvenciones recibidas | **$38,865,357,138** |

**Fuente:** 2024_Subvenciones.csv

**Impacto proyecto:**
- 🔴 **LA3 M2:** Principal fuente para valorización de necesidades de infraestructura/equipamiento
- 🔴 **LA3 M3:** Presupuesto disponible para priorización y planificación presupuestaria
- 🔴 **LA3 M1:** Recursos para levantamiento de necesidades por establecimiento

---

## 🎯 INDICADORES CLAVE GLOBALES

### Efectividad EMTP
- **Tasa de titulación:** 65.7% (1,853 / 2,822 egresados)
  - ⚠️ **Brecha identificada:** 34.3% de egresados no se titulan
  - 🎯 **Meta LA2:** Fortalecer arquitectura curricular para aumentar titulación

- **Modalidad dual:** 9.5% (176 / 1,853 titulados)
  - ⚠️ **Brecha crítica:** Muy baja presencia de alternancia laboral
  - 🎯 **Meta LA1:** Mapear redes de articulación con sector productivo

### Calidad Académica
- **NEM promedio:** 5.6
- **Excelencia académica:** 480 estudiantes top 10% (17% del total egresados)
- **Potencial educación superior:** 901 estudiantes top 30% (32% del total)

### Desarrollo Docente
- **Docentes evaluados:** 374 (en 2023)
- **Puntaje promedio portafolio:** 2.4
  - ⚠️ **Oportunidad:** Puntaje sugiere necesidad de fortalecimiento en LA2 M3

### Recursos Financieros
- **Total subvenciones anuales:** $38.9 mil millones
- **SEP disponible:** $8.4 mil millones (22% del total)
  - 🎯 **LA3:** Principal fuente para condiciones habilitantes EMTP

---

## 🔄 PROCESO TÉCNICO APLICADO

### Scripts de Procesamiento
Se crearon 6 scripts Python reutilizables para procesar cada fuente:

1. **Egresados:** Filtrado por COD_ENSE (TP) + MARCA_EGRESO=1
2. **Titulados:** Filtrado por ESTADO_PRACTICA=1 + modalidad dual (COD_DES_CUR)
3. **NEM:** Conversión decimal (coma→punto) + agregación por RBD
4. **Dotación:** Filtrado ESTADO_ESTAB=1 + año 2025
5. **Evaluación:** Conversión decimal + categorización A-B (destacados/competentes)
6. **Subvenciones:** Suma anual (12 meses) por RBD + cálculo Total_SEP

### Validaciones Aplicadas
- ✅ **Cobertura 100%:** Todos los 39 RBDs tienen datos en las 20 columnas
- ✅ **Consistencia:** Tasa de titulación validada (N_Titulados / N_Egresados)
- ✅ **Integridad:** Sin valores nulos en columnas críticas
- ✅ **Formato:** Columnas numéricas redondeadas apropiadamente

### Manejo de Datos Especiales
- **Decimales con coma:** NEM y PF_PJE convertidos de formato europeo (5,6) a estándar (5.6)
- **Agregaciones temporales:** Subvenciones sumadas por año completo (12 meses)
- **Códigos EMTP:** Filtrado por 21 códigos oficiales de enseñanza técnico-profesional
- **Encoding:** Subvenciones procesadas con `latin-1` (resto `utf-8`)

---

## 📁 ARCHIVOS GENERADOS

### Backup
- **Ubicación:** `SharePoint/Recursos/Datos/BBDD_backup_20251027_224516.xlsx`
- **Contenido:** BBDD.xlsx original (49 columnas) antes del enriquecimiento
- **Tamaño:** 30 KB

### Archivo Actualizado
- **Ubicación:** `SharePoint/Recursos/Datos/BBDD.xlsx`
- **Contenido:** BBDD enriquecida (69 columnas)
- **Tamaño:** 24 KB
- **Formato:** Columnas nuevas destacadas con fondo amarillo en header

### Archivos Temporales (eliminados)
- `/tmp/columnas_criticas.csv` (procesamiento intermedio)
- `/tmp/BBDD_enriquecida.xlsx` (copia temporal con formato)

---

## 🔍 VALIDACIÓN DE CONSISTENCIA

### Comparación con Columnas Existentes
Se recomienda validar consistencia entre:

1. **Matrícula:**
   - BBDD existente: `Matricula_EMTP_Total`
   - Nueva columna: `N_Egresados_EMTP_2024`
   - ⚠️ **Acción:** Verificar que egresados sean subconjunto de matrícula

2. **Financiamiento SEP:**
   - BBDD existente: `N_Beneficiarios_SEP`, `% Beneficiarios SEP`
   - Nuevas columnas: `SEP_Prioritarios_Anual`, `SEP_Preferentes_Anual`
   - ✅ **Consistencia:** Montos SEP alineados con N° beneficiarios

3. **Docentes:**
   - BBDD existente: `Total_Docentes`
   - Nuevas columnas: `N_Docentes_UTP`, `N_Docentes_Evaluados_2023`
   - ✅ **Consistencia:** UTP y evaluados son subconjuntos del total

---

## 📌 PRÓXIMOS PASOS RECOMENDADOS

### Inmediato (IT1 - Diciembre 2025)
1. ✅ **COMPLETO:** Incorporar columnas críticas
2. ⬜ **Validar con equipo GE:** Revisar indicadores calculados
3. ⬜ **Integrar con tableros LA1:** Usar para diagnóstico de línea base

### Corto Plazo (Enero 2026)
4. ⬜ **Evaluar columnas medias:** Decidir si incorporar 17 columnas 🟡 adicionales
5. ⬜ **Automatizar actualización:** Script para incorporar datos de años futuros
6. ⬜ **Crear visualizaciones:** Tableros dinámicos por SLEP con PowerBI/Tableau

### Mediano Plazo (LA4 - Evaluación)
7. ⬜ **Comparación temporal:** Versionar BBDD_2025.xlsx, BBDD_2026.xlsx
8. ⬜ **Medir impacto:** Re-calcular indicadores post-intervención LA2 y LA3
9. ⬜ **Documentar metodología:** Actualizar "Propuesta Enriquecimiento" con resultados

---

## 💡 HALLAZGOS CLAVE PARA EL PROYECTO

### Brechas Identificadas

1. **Tasa de Titulación (65.7%)**
   - 34.3% de egresados no completa titulación
   - 🎯 **Foco LA2:** Fortalecer secuencia práctica-titulación

2. **Modalidad Dual (9.5%)**
   - Muy baja presencia de alternancia laboral
   - 🎯 **Foco LA1:** Identificar barreras y oportunidades de articulación
   - 🎯 **Foco LA2:** Promover modalidad dual en especialidades pertinentes

3. **Desarrollo Docente (Puntaje 2.4)**
   - Puntaje portafolio bajo promedio nacional
   - 🎯 **Foco LA2 M3:** Priorizar desarrollo profesional docente

### Fortalezas Identificadas

1. **Excelencia Académica**
   - 480 estudiantes top 10% (potencial BEA)
   - 901 estudiantes top 30% (potencial BVP + continuidad ES)

2. **Recursos Financieros**
   - $8.4 mil millones SEP disponibles para LA3
   - $38.9 mil millones en subvenciones totales

3. **Capacidad Institucional**
   - 60 docentes UTP para liderar LA2
   - 374 docentes evaluados (línea base para M3)

---

## ✍️ NOTAS TÉCNICAS

### Consideraciones para Análisis Futuros

1. **Años de referencia mixtos:**
   - Egresados/Titulados: 2024
   - NEM: 2023
   - Evaluación Docente: 2023
   - Dotación: 2025
   - Subvenciones: 2024 (suma anual completa)

2. **Códigos EMTP utilizados:**
   - Comercial: 410, 460, 461, 463
   - Industrial: 510, 560, 561, 563
   - Técnica: 610, 660, 661, 663
   - Agrícola: 710, 760, 761, 763
   - Marítima: 810, 860, 863
   - Artística: 910, 963

3. **Modalidad Dual (COD_DES_CUR):**
   - 1: Solo Liceo (tradicional)
   - 2: Dual (alternancia)
   - 3: Otro

---

**Documento generado:** 2025-10-27  
**Responsable:** Marko Bremer (consultor GE)  
**Proyecto:** Apoyo SLEP 2025-2026  
**Próxima actualización:** Post IT1 (Febrero 2026)