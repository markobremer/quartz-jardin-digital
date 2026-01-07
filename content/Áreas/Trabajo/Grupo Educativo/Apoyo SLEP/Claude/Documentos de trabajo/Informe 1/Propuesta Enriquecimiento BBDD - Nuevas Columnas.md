# Propuesta de Enriquecimiento BBDD.xlsx

## Contexto

Este documento propone nuevas columnas para enriquecer la base de datos principal del proyecto **BBDD.xlsx** (39 liceos × 49 columnas), utilizando las siguientes fuentes oficiales descargadas de Mineduc:

- 2024_Practicantes y titulados.csv (63,635 registros)
- 2023_NEM Adultos.csv (49,541 registros)
- 2023_NEM Jóvenes.csv (212,887 registros)
- 2025_Dotación Docente.csv (16,761 establecimientos)
- 2024_Subvenciones.csv (124,436 registros mensuales)
- 2023_Evaluación docente.csv (47,473 evaluaciones)
- 2024_Egresados.csv (274,669 estudiantes)

---

## 1. EGRESADOS Y TITULACIÓN

### Fuente: `2024_Egresados.csv`
**Variables disponibles:** 21 columnas por estudiante (274,669 registros)

| Columna Propuesta | Descripción | Cálculo | Prioridad | Justificación Proyecto |
|-------------------|-------------|---------|-----------|------------------------|
| `N_Egresados_EMTP_2024` | Número total de egresados EMTP 2024 | Filtrar por RBD + COD_ENSE (TP) + MARCA_EGRESO=1 | 🔴 Alta | **Brecha 1:** Necesario para calcular tasa de titulación (denominador) |
| `N_Egresados_EMTP_HC` | Egresados con enseñanza HC completa | Filtrar ENSE_COMPLETA=1 y COD_ENSE=310 | 🟡 Media | Permite diferenciar egresados HC vs TP para análisis de trayectorias |
| `Prom_Notas_Egresados_EMTP` | Promedio de notas de egresados EMTP | Media de PROM_NOTAS_ALU filtrado por TP | 🟢 Baja | Complementa rendimiento académico |

**Script de procesamiento sugerido:**
```python
# Filtrar egresados EMTP 2024
egresados_emtp = egresados_df[
    (egresados_df['COD_ENSE'].isin([410, 510, 610, 710, 810, 910])) &  # Códigos EMTP
    (egresados_df['MARCA_EGRESO'] == 1) &
    (egresados_df['AGNO'] == 2024)
]

# Agrupar por RBD
egresados_por_liceo = egresados_emtp.groupby('RBD').agg({
    'MRUN': 'count',  # N_Egresados_EMTP_2024
    'PROM_NOTAS_ALU': 'mean'  # Prom_Notas_Egresados_EMTP
}).reset_index()
```

---

### Fuente: `2024_Practicantes y titulados.csv`
**Variables disponibles:** 57 columnas por práctica (63,635 registros)

| Columna Propuesta | Descripción | Cálculo | Prioridad | Justificación Proyecto |
|-------------------|-------------|---------|-----------|------------------------|
| `N_Titulados_2024` | Número de titulados con práctica aprobada | Filtrar ESTADO_PRACTICA=1 y AGNO_TITULACION=2024 | 🔴 Alta | **Brecha 1:** Indicador clave de efectividad EMTP para diagnóstico (LA1) |
| `Tasa_Titulacion` | % de egresados que se titulan | (N_Titulados / N_Egresados_EMTP) × 100 | 🔴 Alta | **OE2:** Medir efectividad de implementación curricular |
| `N_Practicas_Duales` | Prácticas en modalidad dual | Filtrar COD_DES_CUR=2 | 🔴 Alta | **LA1:** Dato clave mencionado en diagnóstico (baja presencia dual) |
| `%_Practicas_Duales` | Porcentaje en modalidad dual | (N_Practicas_Duales / N_Titulados) × 100 | 🔴 Alta | Evaluar brecha en alternancia laboral (LA2) |
| `Prom_Horas_Practica_Prof` | Promedio horas práctica profesional | Media HORAS_TOTALES donde TIPO_PRACTICA=1 | 🟡 Media | Verificar cumplimiento normativo |
| `N_Empresas_Vinculadas` | Empresas distintas para prácticas | COUNT DISTINCT(RUT_EMPRESA) | 🟡 Media | **LA1:** Mapeo de redes de articulación con sector productivo |
| `Top_3_Sectores_Economicos` | Sectores con más prácticas | Ranking de COD_SEC por frecuencia | 🟡 Media | Identificar sectores económicos prioritarios por SLEP |
| `Top_3_Rubros_Empresas` | Rubros de empresas con más prácticas | Ranking de GLOSA_RUBRO | 🟡 Media | **LA1:** Análisis de redes y articulación |

**Script de procesamiento sugerido:**
```python
# Filtrar titulados 2024 con práctica aprobada
titulados = practicantes_df[
    (practicantes_df['ESTADO_PRACTICA'] == 1) &  # Aprobada
    (practicantes_df['AGNO_TITULACION'] == 2024)
]

# Calcular indicadores por RBD
titulacion_por_liceo = titulados.groupby('RBD_EGRESO').agg({
    'ID_PRACTICA': 'count',  # N_Titulados_2024
    'COD_DES_CUR': lambda x: (x == 2).sum(),  # N_Practicas_Duales
    'HORAS_TOTALES': lambda x: x[titulados.loc[x.index, 'TIPO_PRACTICA'] == 1].mean(),  # Prom_Horas_Practica_Prof
    'RUT_EMPRESA': 'nunique',  # N_Empresas_Vinculadas
    'COD_SEC': lambda x: x.mode()[0] if not x.mode().empty else None  # Sector más común
}).reset_index()

# Top 3 sectores por liceo (requiere procesamiento adicional)
top_sectores = titulados.groupby(['RBD_EGRESO', 'COD_SEC']).size().reset_index(name='count')
top_sectores = top_sectores.sort_values(['RBD_EGRESO', 'count'], ascending=[True, False])
top_sectores = top_sectores.groupby('RBD_EGRESO').head(3)
```

---

## 2. RENDIMIENTO ACADÉMICO Y EXCELENCIA

### Fuente: `2023_NEM Jóvenes.csv` + `2023_NEM Adultos.csv`
**Variables disponibles:** 8 columnas (212,887 jóvenes + 49,541 adultos)

| Columna Propuesta | Descripción | Cálculo | Prioridad | Justificación Proyecto |
|-------------------|-------------|---------|-----------|------------------------|
| `NEM_Promedio_Egresados` | NEM promedio de egresados del liceo | Media de NEM por RBD | 🔴 Alta | **OE2:** Evaluar arquitectura curricular y calidad pedagógica |
| `N_Estudiantes_Top10%` | Estudiantes en top 10% del liceo | COUNT donde PUESTO_10='SI' | 🔴 Alta | Identificar potencial BEA (Beca Excelencia Académica) |
| `N_Estudiantes_Top30%` | Estudiantes en top 30% del liceo | COUNT donde PUESTO_30='SI' | 🔴 Alta | Identificar potencial BVP (Beca Vocación Profesor) |
| `%_Estudiantes_Top10%` | Porcentaje top 10% | (N_Top10 / N_Egresados) × 100 | 🟡 Media | Medir excelencia académica relativa |
| `%_Estudiantes_Top30%` | Porcentaje top 30% | (N_Top30 / N_Egresados) × 100 | 🟡 Media | Oportunidades de continuidad estudios superiores |
| `Percentil_Promedio` | Percentil promedio del liceo | Media de PERCENTIL por RBD | 🟡 Media | Comparación con establecimientos similares a nivel nacional |

**Script de procesamiento sugerido:**
```python
# Combinar NEM Jóvenes y Adultos
nem_completo = pd.concat([nem_jovenes_df, nem_adultos_df])

# Filtrar solo egresados 2023 (año más reciente)
nem_2023 = nem_completo[nem_completo['AGNO_EGRESO'] == 2023]

# Calcular por RBD
nem_por_liceo = nem_2023.groupby('RBD').agg({
    'NEM': 'mean',  # NEM_Promedio_Egresados
    'PUESTO_10': lambda x: (x == 'SI').sum(),  # N_Estudiantes_Top10%
    'PUESTO_30': lambda x: (x == 'SI').sum(),  # N_Estudiantes_Top30%
    'PERCENTIL': 'mean',  # Percentil_Promedio
    'MRUN': 'count'  # Total para calcular porcentajes
}).reset_index()
```

---

## 3. DOTACIÓN Y DESARROLLO DOCENTE

### Fuente: `2025_Dotación Docente.csv`
**Variables disponibles:** 47 columnas (16,761 establecimientos)

| Columna Propuesta | Descripción | Cálculo | Prioridad | Justificación Proyecto |
|-------------------|-------------|---------|-----------|------------------------|
| `N_Docentes_UTP` | Docentes en Unidad Técnico-Pedagógica | DC_UTP | 🔴 Alta | **OE2:** Capacidad institucional para conducción curricular |
| `Horas_UTP` | Horas totales equipo UTP | HH_UTP | 🔴 Alta | Recursos dedicados a gestión pedagógica (LA2) |
| `N_Jefes_UTP` | Número de Jefes UTP | DC_JUTP | 🔴 Alta | Liderazgo pedagógico disponible |
| `N_Orientadores` | Número de Orientadores | DC_OR | 🟡 Media | **Brecha 1:** Apoyo a convivencia y desarrollo docente |
| `N_Inspectores_Generales` | Número de Inspectores Generales | DC_IG | 🟡 Media | **Brecha 1:** Gestión de convivencia escolar (clima bajo) |
| `N_Subdirectores` | Número de Subdirectores | DC_SUBDIR | 🟡 Media | Capacidad de gestión directiva |
| `Horas_Promedio_Docente_Aula` | Horas promedio por docente de aula | HH_A / DC_A | 🟡 Media | Carga horaria y condiciones laborales |
| `N_Educadores_Tradicionales` | Educadores Tradicionales | DC_EDUC_TRAD | 🟢 Baja | Pertinencia cultural (si aplica) |

**Nota:** La columna `Total_Docentes` ya existe en BBDD.xlsx (corresponde a DC_TOT), verificar consistencia.

**Script de procesamiento sugerido:**
```python
# Filtrar año 2025 y establecimientos funcionando
dotacion_2025 = dotacion_df[
    (dotacion_df['AGNO'] == 2025) &
    (dotacion_df['ESTADO_ESTAB'] == 1)  # Funcionando
]

# Seleccionar columnas relevantes por RBD
dotacion_por_liceo = dotacion_2025[['RBD', 'DC_UTP', 'HH_UTP', 'DC_JUTP', 
                                      'DC_OR', 'DC_IG', 'DC_SUBDIR', 
                                      'DC_A', 'HH_A', 'DC_EDUC_TRAD']].copy()

# Calcular horas promedio por docente de aula
dotacion_por_liceo['Horas_Promedio_Docente_Aula'] = (
    dotacion_por_liceo['HH_A'] / dotacion_por_liceo['DC_A']
).round(1)
```

---

### Fuente: `2023_Evaluación docente.csv`
**Variables disponibles:** 22 columnas (47,473 evaluaciones individuales)

| Columna Propuesta | Descripción | Cálculo | Prioridad | Justificación Proyecto |
|-------------------|-------------|---------|-----------|------------------------|
| `N_Docentes_Evaluados_2023` | Docentes evaluados en 2023 | COUNT MRUN por RBD | 🔴 Alta | **Brecha 1:** Indicador de desarrollo profesional docente |
| `Puntaje_Promedio_Portafolio` | Promedio puntaje portafolio | Media PF_PJE por RBD | 🔴 Alta | **OE2 M3:** Nivel de desarrollo profesional docente (LA2) |
| `N_Docentes_Categoria_A` | Docentes en categoría destacada | COUNT PF_CAT_CARRERA='A' | 🟡 Media | Excelencia pedagógica instalada |
| `N_Docentes_Categoria_B` | Docentes en categoría competente | COUNT PF_CAT_CARRERA='B' | 🟡 Media | Estándar de calidad alcanzado |
| `N_Docentes_Categoria_C` | Docentes categoría básico | COUNT PF_CAT_CARRERA='C' | 🟡 Media | **Brecha 1:** Necesidad de formación (bajos tramos) |
| `N_Docentes_Categoria_D` | Docentes categoría insatisfactorio | COUNT PF_CAT_CARRERA='D' | 🟡 Media | Foco urgente de acompañamiento |
| `%_Docentes_Destacados_Competentes` | % en categorías A+B | (Cat_A + Cat_B) / Total × 100 | 🔴 Alta | **LA2 M3:** Indicador de calidad del desarrollo docente |

**Script de procesamiento sugerido:**
```python
# Filtrar evaluación 2023
eval_2023 = eval_docente_df[eval_docente_df['AGNO_EVAL'] == 2023]

# Agrupar por RBD
eval_por_liceo = eval_2023.groupby('RBD').agg({
    'MRUN': 'count',  # N_Docentes_Evaluados_2023
    'PF_PJE': 'mean',  # Puntaje_Promedio_Portafolio
    'PF_CAT_CARRERA': lambda x: {
        'A': (x == 'A').sum(),
        'B': (x == 'B').sum(),
        'C': (x == 'C').sum(),
        'D': (x == 'D').sum()
    }
}).reset_index()

# Expandir categorías
eval_por_liceo[['N_Docentes_Categoria_A', 'N_Docentes_Categoria_B', 
                'N_Docentes_Categoria_C', 'N_Docentes_Categoria_D']] = \
    eval_por_liceo['PF_CAT_CARRERA'].apply(pd.Series)
```

---

## 4. FINANCIAMIENTO Y RECURSOS

### Fuente: `2024_Subvenciones.csv`
**Variables disponibles:** 45 columnas (124,436 registros RBD×Mes)

| Columna Propuesta | Descripción | Cálculo | Prioridad | Justificación Proyecto |
|-------------------|-------------|---------|-----------|------------------------|
| `Subvencion_Escolaridad_Anual` | Subvención escolar total 2024 | SUM(ESCOLARIDAD) por RBD | 🔴 Alta | **LA3:** Fuente principal de financiamiento para condiciones habilitantes |
| `Subvencion_PIE_Anual` | Subvención PIE total 2024 | SUM(ESCOLARIDAD_PIE) por RBD | 🔴 Alta | Recursos para estudiantes con NEE |
| `SEP_Prioritarios_Anual` | SEP estudiantes prioritarios 2024 | SUM(SEP_PRIO) por RBD | 🔴 Alta | **LA3 M2:** Principal fuente para valorización y financiamiento |
| `SEP_Preferentes_Anual` | SEP estudiantes preferentes 2024 | SUM(SEP_PREF) por RBD | 🔴 Alta | Complemento SEP para planificación presupuestaria |
| `Total_SEP_Anual` | Total SEP (prioritarios + preferentes) | SEP_Prioritarios + SEP_Preferentes | 🔴 Alta | **LA3 M3:** Presupuesto disponible para priorización |
| `Subv_Mantenimiento_Anual` | Subvención mantenimiento 2024 | SUM(MANTENIMIENTO) por RBD | 🟡 Media | **LA3:** Recursos para mantención infraestructura/equipamiento |
| `Subv_Desempeño_Dificil_Anual` | Subvención desempeño difícil docentes | SUM(DESEMPEÑO_DIFICIL) por RBD | 🟡 Media | Incentivos docentes en contextos vulnerables |
| `Subv_Asist_Educacion_Anual` | Subvención asistentes educación | SUM(SUBV_ASISTENTES_EDUCACION) por RBD | 🟡 Media | Personal de apoyo disponible |
| `SNED_Anual` | Incentivo SNED recibido 2024 | SUM(SNED) por RBD | 🟡 Media | Reconocimiento desempeño (cruzar con Indice_SNED existente) |
| `Total_Subvenciones_Anual` | Total subvenciones recibidas 2024 | SUM(SUB_NORMAL) por RBD | 🔴 Alta | **LA3 M2:** Presupuesto total para valorización de necesidades |
| `Promedio_Matricula_Pago` | Matrícula promedio mensual 2024 | MEAN(MATRICULA) por RBD | 🟡 Media | Validar consistencia con matrícula SIGE |

**Script de procesamiento sugerido:**
```python
# Filtrar año 2024
subv_2024 = subvenciones_df[subvenciones_df['AGNO'] == 2024]

# Agrupar por RBD y sumar año completo
subv_por_liceo = subv_2024.groupby('RBD').agg({
    'ESCOLARIDAD': 'sum',  # Subvencion_Escolaridad_Anual
    'ESCOLARIDAD_PIE': 'sum',  # Subvencion_PIE_Anual
    'SEP_PRIO': 'sum',  # SEP_Prioritarios_Anual
    'SEP_PREF': 'sum',  # SEP_Preferentes_Anual
    'MANTENIMIENTO': 'sum',  # Subv_Mantenimiento_Anual
    'DESEMPEÑO_DIFICIL': 'sum',  # Subv_Desempeño_Dificil_Anual
    'SUBV_ASISTENTES_EDUCACION': 'sum',  # Subv_Asist_Educacion_Anual
    'SNED': 'sum',  # SNED_Anual
    'SUB_NORMAL': 'sum',  # Total_Subvenciones_Anual
    'MATRICULA': 'mean'  # Promedio_Matricula_Pago
}).reset_index()

# Calcular Total SEP
subv_por_liceo['Total_SEP_Anual'] = (
    subv_por_liceo['SEP_Prioritarios_Anual'] + 
    subv_por_liceo['SEP_Preferentes_Anual']
)
```

---

## 5. RESUMEN DE PRIORIZACIÓN

### Columnas Críticas (Prioridad 🔴 Alta) - Total: 21 columnas

**Justificación:** Necesarias para LA1 (Diagnóstico), LA2 (Curricular), LA3 (Administrativa)

| Categoría | Columnas | Total |
|-----------|----------|-------|
| **Egresados y Titulación** | N_Egresados_EMTP_2024, N_Titulados_2024, Tasa_Titulacion, N_Practicas_Duales, %_Practicas_Duales | 5 |
| **Rendimiento Académico** | NEM_Promedio_Egresados, N_Estudiantes_Top10%, N_Estudiantes_Top30% | 3 |
| **Dotación Docente** | N_Docentes_UTP, Horas_UTP, N_Jefes_UTP | 3 |
| **Evaluación Docente** | N_Docentes_Evaluados_2023, Puntaje_Promedio_Portafolio, %_Docentes_Destacados_Competentes | 3 |
| **Financiamiento** | Subvencion_Escolaridad_Anual, Subvencion_PIE_Anual, SEP_Prioritarios_Anual, SEP_Preferentes_Anual, Total_SEP_Anual, Total_Subvenciones_Anual | 7 |

**Impacto directo en:**
- **LA1 (Diagnóstico):** 11 columnas permiten completar tableros de línea base
- **LA2 (Curricular):** 6 columnas evalúan arquitectura curricular y desarrollo docente
- **LA3 (Administrativa):** 7 columnas habilitan valorización y planificación presupuestaria

---

### Columnas Importantes (Prioridad 🟡 Media) - Total: 17 columnas

**Justificación:** Enriquecen análisis y evaluación participativa (LA4)

- Complementan indicadores de efectividad
- Permiten análisis de redes y articulación territorial
- Facilitan comparaciones inter-liceos
- Apoyan focalización de acompañamiento

---

### Columnas Complementarias (Prioridad 🟢 Baja) - Total: 3 columnas

**Justificación:** Información contextual adicional

- Prom_Notas_Egresados_EMTP
- N_Educadores_Tradicionales
- Percentil_Promedio (parcialmente redundante con NEM)

---

## 6. DIMENSIÓN FINAL PROPUESTA

**BBDD.xlsx actual:** 39 liceos × 49 columnas = 1,911 celdas

**BBDD.xlsx enriquecida:**
- Con columnas críticas (🔴): 39 × 70 = 2,730 celdas (+43% datos clave)
- Con todas las columnas: 39 × 90 = 3,510 celdas (+84% información total)

---

## 7. PRÓXIMOS PASOS RECOMENDADOS

### Fase 1: Validación (Noviembre 2025)
1. ✅ Revisar propuesta con equipo técnico GE
2. ⬜ Priorizar columnas críticas vs. medias según necesidades IT1
3. ⬜ Validar que RBDs de BBDD.xlsx coinciden con fuentes (filtrar por 5 SLEPs)

### Fase 2: Implementación Prioritaria (Diciembre 2025)
1. ⬜ Procesar columnas críticas (🔴 Alta) - **21 columnas**
2. ⬜ Generar scripts Python reutilizables por fuente
3. ⬜ Validar consistencia con columnas existentes (ej: Total_Docentes vs DC_TOT)
4. ⬜ Documentar fórmulas de cálculo en hoja "Metodología" de BBDD.xlsx

### Fase 3: Enriquecimiento Completo (Enero 2026)
1. ⬜ Incorporar columnas media (🟡) - **17 columnas**
2. ⬜ Evaluar utilidad de columnas baja (🟢) - **3 columnas**
3. ⬜ Crear tableros dinámicos por SLEP
4. ⬜ Integrar con tableros de diagnóstico LA1

---

## 8. CONSIDERACIONES TÉCNICAS

### Integridad de Datos
- **Años de referencia mixtos:** Usar siempre el año más reciente disponible por fuente
- **Filtrado por SLEP:** Algunos archivos no tienen columna NOMBRE_SLEP, filtrar por RBD de los 39 liceos
- **Manejo de valores nulos:** Documentar criterios (ej: 0 vs NULL vs "Sin datos")
- **Agregación temporal:** Subvenciones requiere suma anual (12 meses)

### Validación Cruzada Recomendada
1. **Matrícula:** Comparar BBDD.xlsx vs Subvenciones.MATRICULA vs Egresados
2. **Docentes:** Verificar Total_Docentes (actual) vs DC_TOT (Dotación 2025)
3. **Egresados vs Titulados:** Validar tasa de titulación (rango esperado 70-90%)
4. **SEP:** Cruzar montos SEP con N_Prioritarios y N_Preferentes existentes

### Mantenimiento Futuro
- **Actualización anual:** Script automatizado para incorporar nuevas versiones de fuentes
- **Histórico:** Considerar versionar BBDD por año (BBDD_2025.xlsx, BBDD_2026.xlsx)
- **Documentación:** Mantener bitácora de cambios en pestaña "Control de Versiones"

---

**Documento generado:** 2025-10-27  
**Autor:** Análisis realizado por Claude Code para proyecto Apoyo SLEP 2025-2026  
**Próxima revisión:** Post IT1 (Febrero 2026)