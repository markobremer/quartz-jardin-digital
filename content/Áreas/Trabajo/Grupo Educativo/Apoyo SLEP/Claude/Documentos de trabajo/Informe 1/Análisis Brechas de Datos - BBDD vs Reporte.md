# Análisis de Brechas de Datos - BBDD vs Reporte de Referencia

**Fecha:** 2025-10-27  
**Documento de referencia:** Anexo-N°4-Propuesta-Plan-de-Trabajo 2209.docx  
**Base de datos actual:** SharePoint/Recursos/Datos/BBDD.xlsx

---

## 1. Resumen Ejecutivo

Se identificaron **discrepancias significativas** entre los datos de la BBDD actual y los utilizados en el reporte de referencia del SLEP, así como **datos faltantes críticos** necesarios para análisis comprensivo del proyecto.

### Principales hallazgos:

1. **Discrepancias en matrícula EMTP:**
   - SLEP Santa Rosa: 1,456 (BBDD) vs 896 (Reporte) = +560 diferencia
   - SLEP Del Pino: 1,510 (BBDD) vs 2,011 (Reporte) = -501 diferencia

2. **Datos faltantes críticos:** Trayectoria educativa (egresados, titulados), evaluación docente, denuncias, PME detallado, postulantes IES

3. **Fuentes oficiales disponibles:** Se identificaron archivos CSV/XLSX en carpeta Fuentes con datos de Mineduc

---

## 2. Estructura del Reporte de Referencia

El reporte organiza la información en **4 secciones principales por cada SLEP:**

### 2.1. Tabla de Establecimientos
Contiene información a nivel de liceo:
- Nombre del liceo
- Comuna
- Especialidades EMTP
- Matrícula 2024
- Distribución por género (% Hombres, % Mujeres)
- % Estudiantes extranjeros

### 2.2. Indicadores Clave a Nivel SLEP
Datos agregados del SLEP con 17 categorías:
1. Matrícula EMTP Total (1º-4º)
2. Distribución por género y extranjería
3. **Trayectoria:** Aprobación, Reprobación, Retiro, Traslado
4. Asistencia promedio EMTP
5. Promedio de notas 4º EMTP
6. **Egresados EMTP 2024 (4º)**
7. **Titulados 2024** (con desagregación H/M y % dual)
8. **Título más frecuente**
9. **Postulantes EMTP a IES 2025**
10. **Promedios PTJE_NEM y Ranking**
11. IDPS 2º medio (AM, CC, HV, PF)
12. **Evaluación docente** (cantidad por nivel: Inicial, Temprano, Avanzado, Experto I, Experto II)
13. SEP 2024 (convenio, clasificación)
14. SEP 2024 (beneficiarios totales y cobertura %)
15. **Denuncias S.I.E.** (número y tipo más frecuente)
16. SNED (cantidad de liceos con SNED y %)
17. **Total de actividades PME** por dimensión

### 2.3. Tabla Resumen PME
Desagregación de actividades del Plan de Mejoramiento Educativo:
- Total de actividades
- Liceos TP involucrados
- Ciclos de mejora
- Actividades por dimensión: Gestión pedagógica, Convivencia, Liderazgo, Recursos
- Planes asociados: Convivencia, Formación ciudadana, PISE, PLFDPD, PSAG, Inclusión

### 2.4. Redes y Articulación
Síntesis narrativa de:
- Articulación empresa-liceo (socioproductiva)
- Vinculación con IES/CFT
- Redes territoriales

---

## 3. Estructura de BBDD Actual

### 3.1. Características
- **Formato:** 1 hoja con 39 filas (liceos) × 48 columnas
- **Nivel de análisis:** A nivel de establecimiento
- **SLEP incluidos:** 5 (Licancabur, Los Libertadores, Santa Corina, Santa Rosa, El Pino)

### 3.2. Columnas existentes
#### Identificación
- Liceo, Letra, RBD, DV, Comuna, SLEP

#### Matrícula y especialidades
- Especialidades, EMTP Jóvenes, EMTP Adultos, Matrícula Total Estab.
- N° y % Hombres, Mujeres, Extranjeros
- Matricula_EMTP_Total, % TP

#### Vulnerabilidad y SEP
- N° y % Prioritarios, Preferentes, Beneficiarios SEP
- Clasificacion_SEP
- IVE_SINAE_Media, IVM (por nivel)

#### Indicadores académicos
- Tasa_Asistencia_Promedio, % Asist. Esperada, % Inasist. Crítica/Grave
- SIMCE (Lectura, Matemática 2M) y diferencias con año anterior
- IDPS (Autoestima/Motivación, Clima/Convivencia, Hábitos de Vida, Participación Ciudadana)

#### Docentes y SNED
- Total_Docentes, Docentes_Aula, Ratio_Estudiantes_Docente
- Indice_SNED, Seleccion_SNED, Factor_Efectividad, Factor_Superacion

---

## 4. Análisis de Brechas

### 4.1. Datos presentes en BBDD ✅

| Categoría | Indicador | Estado |
|-----------|-----------|---------|
| Identificación | Liceo, RBD, Comuna, SLEP | ✅ Completo |
| Especialidades | Lista de especialidades | ✅ Completo |
| Matrícula | Total EMTP y distribución H/M/E | ✅ Completo (con discrepancias) |
| SEP | Clasificación y beneficiarios | ✅ Completo |
| Asistencia | Promedio y desagregaciones | ✅ Completo (con discrepancias) |
| IDPS | 4 dimensiones (AM, CC, HV, PF) | ✅ Completo |
| SIMCE | Lectura y Matemática 2M | ✅ Completo (97% cobertura) |
| Docentes | Total, aula, ratio | ✅ Completo |
| SNED | Índice, selección, factores | ✅ Completo |

### 4.2. Datos ausentes en BBDD ❌

| Categoría | Indicador | Criticidad | Fuente Potencial |
|-----------|-----------|------------|------------------|
| **Trayectoria** | Aprobación, Reprobación, Retiro, Traslado | 🔴 Alta | Mineduc - Bases de rendimiento |
| **Egresados** | Egresados 4º medio 2024 | 🔴 Alta | Mineduc - Rendimiento escolar |
| **Titulación** | Titulados 2024 (H/M), % dual | 🔴 Alta | ChileValora / Mineduc TP |
| **Titulación** | Título más frecuente por SLEP | 🟡 Media | ChileValora / Mineduc TP |
| **Admisión IES** | Postulantes EMTP 2025 | 🟡 Media | DEMRE - Sistema de Acceso |
| **Admisión IES** | Promedios PTJE_NEM y Ranking | 🟡 Media | DEMRE - Sistema de Acceso |
| **Evaluación Docente** | Cantidad por nivel de desarrollo | 🟠 Media-Alta | CPEIP / Mineduc - Carrera Docente |
| **Denuncias** | N° denuncias S.I.E. y tipo | 🟠 Media-Alta | Superintendencia de Educación |
| **PME** | Total actividades por dimensión | 🟡 Media | Archivos PME en Fuentes |
| **PME** | Planes asociados (Convivencia, FC, PISE, etc.) | 🟡 Media | Archivos PME en Fuentes |
| **Promedio notas** | Promedio notas 4º EMTP | 🟢 Baja | Mineduc - Rendimiento escolar |

### 4.3. Discrepancias detectadas ⚠️

#### A. Matrícula EMTP
- **Santa Rosa:** 1,456 (BBDD) vs 896 (Reporte)
- **Del Pino:** 1,510 (BBDD) vs 2,011 (Reporte)

**Hipótesis:**
1. Diferente año de corte (BBDD puede ser 2023 o fecha diferente a corte 2024)
2. Diferentes criterios de conteo (HC+TP vs solo TP)
3. Diferentes fuentes oficiales (SIGE vs otro sistema)

#### B. Asistencia promedio
- **Santa Rosa:** 78.6% (BBDD) vs 89.6% (Reporte)
- **Del Pino:** 75.8% (BBDD) vs 83.6% (Reporte)

**Hipótesis:**
1. Asistencia de todo el establecimiento vs solo EMTP
2. Diferentes períodos de cálculo
3. Método de cálculo (promedio simple vs ponderado por matrícula)

---

## 5. Fuentes de Datos Disponibles

En la carpeta `SharePoint/Recursos/Datos/Fuentes/` se identificaron las siguientes fuentes oficiales:

| Archivo | Descripción | Uso Potencial |
|---------|-------------|---------------|
| `2024_Matrícula.csv` | Matrícula oficial Mineduc 2024 | ✅ Validar matrícula EMTP por liceo |
| `2024_Asistencia.csv` | Registros de asistencia 2024 (851 MB) | ✅ Calcular asistencia promedio EMTP |
| `2024_IDPS.csv` | Indicadores Desarrollo Personal y Social | ✅ Validar IDPS actual |
| `2024_Prioritarios y preferentes (SEP).csv` | Datos SEP 2024 | ✅ Validar beneficiarios SEP |
| `2024_SIMCE 2 medio.csv` | Resultados SIMCE 2024 | ✅ Validar SIMCE actual |
| `2024_SNED.csv` | Datos SNED 2024 | ✅ Validar SNED actual |
| `2025_Dotación Docente.csv` | Dotación docente 2025 | ✅ Validar número docentes EMTP |
| `2025_IVE.xlsx` | Índice de Vulnerabilidad Escolar | ✅ Complementar vulnerabilidad |
| `2025_IVM.xlsx` | Índice de Vulnerabilidad Multidimensional | ✅ Complementar vulnerabilidad |
| `2025_PME.xlsx` | Plan de Mejoramiento Educativo | ✅ Extraer actividades PME por dimensión |
| `19052025_Planificación_Anual_PME_2025_02052025.xlsx` | Planificación PME detallada | ✅ Complementar análisis PME |

### 5.1. Fuentes externas a buscar

| Dato Faltante | Fuente Oficial | URL / Sistema |
|---------------|----------------|---------------|
| Egresados y trayectoria | Mineduc - Rendimiento escolar | https://datosabiertos.mineduc.cl/ |
| Titulados y certificación | ChileValora | https://www.chilevalora.cl/ o Mineduc TP |
| Postulantes IES | DEMRE - Acceso a la Educación Superior | https://demre.cl/ o https://acceso.mineduc.cl/ |
| Evaluación Docente | CPEIP - Carrera Docente | https://www.cpeip.cl/ o portal Mineduc |
| Denuncias | Superintendencia de Educación | https://www.supereduc.cl/ - Sistema SIE |

---

## 6. Plan de Acción para Obtención e Integración de Datos

### Fase 1: Validación y Corrección de Datos Existentes (Prioridad Alta)

#### 1.1. Validar matrícula EMTP 2024
- **Fuente:** `2024_Matrícula.csv`
- **Acción:** 
  - Filtrar por RBD de los 39 liceos
  - Filtrar solo estudiantes de EMTP (1º-4º medio TP)
  - Calcular matrícula total por liceo y SLEP
  - Comparar con valores del reporte y actualizar BBDD
- **Herramienta:** Python/pandas
- **Tiempo estimado:** 2 horas

#### 1.2. Recalcular asistencia promedio EMTP
- **Fuente:** `2024_Asistencia.csv` (851 MB - archivo grande)
- **Acción:**
  - Filtrar por RBD de los 39 liceos
  - Filtrar solo estudiantes EMTP
  - Calcular asistencia promedio anual por estudiante
  - Agregar por liceo y SLEP
- **Herramienta:** Python/pandas (usar chunking por tamaño)
- **Tiempo estimado:** 3 horas

#### 1.3. Validar datos SEP y IDPS
- **Fuentes:** `2024_Prioritarios y preferentes (SEP).csv`, `2024_IDPS.csv`
- **Acción:**
  - Verificar beneficiarios SEP por liceo
  - Validar indicadores IDPS
  - Actualizar si hay discrepancias
- **Tiempo estimado:** 1 hora

### Fase 2: Integración de Datos de Trayectoria y Titulación (Prioridad Alta)

#### 2.1. Obtener datos de rendimiento escolar (egresados, aprobación, reprobación)
- **Fuente:** Mineduc - Bases de Rendimiento
- **URL:** https://datosabiertos.mineduc.cl/
- **Acción:**
  - Buscar base de rendimiento 2024
  - Descargar archivo
  - Filtrar por RBD de los 39 liceos y niveles EMTP
  - Calcular:
    - Egresados 4º medio 2024
    - % Aprobación, Reprobación, Retiro, Traslado
    - Promedio de notas 4º medio EMTP
  - Agregar columnas a BBDD
- **Tiempo estimado:** 4 horas

#### 2.2. Obtener datos de titulación
- **Fuente:** ChileValora o Mineduc TP
- **Acción:**
  - Contactar ChileValora para datos de titulación 2024 por RBD
  - Alternativamente, buscar en portal Mineduc sección EMTP
  - Extraer:
    - Número de titulados por liceo (H/M)
    - % titulación dual
    - Especialidad más frecuente por SLEP
  - Agregar columnas a BBDD
- **Tiempo estimado:** 6 horas (incluye contacto y espera)

### Fase 3: Integración de Datos PME (Prioridad Media)

#### 3.1. Procesar archivos PME
- **Fuentes:** `2025_PME.xlsx`, `19052025_Planificación_Anual_PME_2025_02052025.xlsx`
- **Acción:**
  - Abrir archivos PME
  - Identificar estructura de datos
  - Filtrar actividades de los 39 liceos EMTP
  - Contar actividades por dimensión:
    - Gestión pedagógica
    - Convivencia
    - Liderazgo
    - Recursos
  - Contar actividades por plan asociado:
    - Convivencia
    - Formación ciudadana
    - PISE
    - PLFDPD
    - PSAG
    - Inclusión
  - Crear nueva hoja en BBDD: "PME_Resumen"
- **Tiempo estimado:** 4 horas

### Fase 4: Integración de Datos de Evaluación Docente (Prioridad Media)

#### 4.1. Obtener datos de carrera docente
- **Fuente:** CPEIP - Portal Mineduc
- **Acción:**
  - Buscar base de datos de evaluación docente 2024
  - Filtrar por RBD de los 39 liceos
  - Filtrar solo docentes EMTP
  - Contar docentes por nivel:
    - Inicial
    - Temprano
    - Avanzado
    - Experto I
    - Experto II
  - Crear nueva hoja en BBDD: "Evaluacion_Docente"
- **Tiempo estimado:** 5 horas

### Fase 5: Integración de Datos de Acceso a Educación Superior (Prioridad Media-Baja)

#### 5.1. Obtener datos de postulación IES
- **Fuente:** DEMRE o Portal Acceso Mineduc
- **Acción:**
  - Solicitar o descargar base de postulantes 2025
  - Filtrar egresados 2024 de los 39 liceos EMTP
  - Calcular:
    - Número de postulantes por liceo
    - Promedio PTJE_NEM
    - Promedio Ranking
  - Agregar columnas a BBDD
- **Tiempo estimado:** 5 horas

### Fase 6: Integración de Datos de Denuncias (Prioridad Media-Baja)

#### 6.1. Obtener datos del Sistema de Información General de Estudiantes (SIE)
- **Fuente:** Superintendencia de Educación
- **URL:** https://www.supereduc.cl/
- **Acción:**
  - Buscar base de denuncias 2024 o solicitar vía Ley de Transparencia
  - Filtrar por RBD de los 39 liceos
  - Contar denuncias y clasificar por tipo
  - Identificar tipo más frecuente por SLEP
  - Agregar columnas a BBDD
- **Tiempo estimado:** 6 horas (incluye solicitud)

---

## 7. Estructura Propuesta de BBDD Mejorada

### 7.1. Hoja 1: "Establecimientos" (actual Sheet1 mejorada)
**Columnas a agregar:**
- Egresados_4M_2024
- Promedio_Notas_4M_EMTP
- Postulantes_IES_2025
- Promedio_NEM
- Promedio_Ranking
- Denuncias_2024
- Tipo_Denuncia_Frecuente

### 7.2. Hoja 2: "Trayectoria" (nueva)
Columnas por liceo:
- RBD
- SLEP
- Liceo
- Aprobacion_Pct
- Reprobacion_Pct
- Retiro_Pct
- Traslado_Pct

### 7.3. Hoja 3: "Titulacion" (nueva)
Columnas por liceo:
- RBD
- SLEP
- Liceo
- Titulados_Total
- Titulados_Hombres
- Titulados_Mujeres
- Pct_Titulacion_Dual
- Especialidad_Mas_Frecuente

### 7.4. Hoja 4: "PME_Resumen" (nueva)
Columnas por liceo:
- RBD
- SLEP
- Liceo
- Total_Actividades
- Ciclo_Mejora
- Act_Gestion_Pedagogica
- Act_Convivencia
- Act_Liderazgo
- Act_Recursos
- Plan_Convivencia
- Plan_Formacion_Ciudadana
- Plan_PISE
- Plan_PLFDPD
- Plan_PSAG
- Plan_Inclusion

### 7.5. Hoja 5: "Evaluacion_Docente" (nueva)
Columnas por liceo:
- RBD
- SLEP
- Liceo
- Total_Docentes_EMTP
- Docentes_Inicial
- Docentes_Temprano
- Docentes_Avanzado
- Docentes_Experto_I
- Docentes_Experto_II

### 7.6. Hoja 6: "Indicadores_SLEP" (nueva - agregados)
Vista resumen con totales por SLEP calculados automáticamente desde hojas anteriores

---

## 8. Cronograma Estimado

| Fase | Actividad | Tiempo | Dependencias |
|------|-----------|--------|--------------|
| 1 | Validación matrícula | 2h | - |
| 1 | Recálculo asistencia | 3h | - |
| 1 | Validación SEP e IDPS | 1h | - |
| 2 | Obtener rendimiento escolar | 4h | Internet, Mineduc |
| 2 | Obtener datos titulación | 6h | ChileValora/Mineduc |
| 3 | Procesar PME | 4h | Archivos locales |
| 4 | Obtener evaluación docente | 5h | CPEIP/Mineduc |
| 5 | Obtener postulación IES | 5h | DEMRE/Mineduc |
| 6 | Obtener denuncias | 6h | Supereduc |
| - | **Total** | **36 horas** | - |

**Distribución sugerida:** 
- Semana 1: Fases 1-2 (validación y trayectoria)
- Semana 2: Fases 3-4 (PME y evaluación docente)
- Semana 3: Fases 5-6 (IES y denuncias)

---

## 9. Recomendaciones

### 9.1. Inmediatas
1. **Priorizar Fase 1 y 2:** Los datos de matrícula, asistencia, trayectoria y titulación son críticos para el diagnóstico inicial del proyecto
2. **Automatizar cálculos:** Crear scripts Python reutilizables para procesar archivos grandes (ej. asistencia)
3. **Documentar fuentes:** Crear archivo "Metadatos.txt" con fecha, fuente y método de obtención de cada dato

### 9.2. A mediano plazo
1. **Crear dashboard:** Considerar herramienta de visualización (Power BI, Tableau) para tableros ejecutivos por SLEP
2. **Actualización periódica:** Definir protocolo de actualización trimestral/semestral de indicadores clave
3. **Validación cruzada:** Comparar múltiples fuentes cuando estén disponibles para verificar consistencia

### 9.3. Consideraciones técnicas
1. **Backup:** Mantener versiones anteriores de BBDD antes de actualizaciones masivas
2. **Control de calidad:** Validar rangos razonables de indicadores (ej. asistencia entre 0-100%)
3. **Trazabilidad:** Usar columna "Fuente_Dato" y "Fecha_Actualizacion" para cada indicador

---

## 10. Próximos Pasos

### Acción inmediata:
1. ✅ Revisar y aprobar este análisis
2. ⬜ Ejecutar Fase 1: Validación de datos existentes
3. ⬜ Descargar bases de rendimiento escolar desde Mineduc
4. ⬜ Contactar ChileValora para datos de titulación

### Preguntas para resolver:
1. ¿Existe acceso a Sistema de Información de Estudiantes (SIGE) para datos en tiempo real?
2. ¿El SLEP o Grupo Educativo tiene contacto directo con Superintendencia para datos de denuncias?
3. ¿Se requiere solicitud formal vía Ley de Transparencia para algunos datos?

---

**Elaborado por:** Claude Code (Análisis automatizado)  
**Revisado por:** [Marko Bremer]  
**Fecha próxima revisión:** [Definir]
