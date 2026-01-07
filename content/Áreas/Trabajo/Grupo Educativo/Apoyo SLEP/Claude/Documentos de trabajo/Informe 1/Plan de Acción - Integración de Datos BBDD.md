# Plan de Acción - Integración de Datos BBDD

**Fecha inicio:** 2025-10-27  
**Objetivo:** Completar base de datos con indicadores faltantes del reporte de referencia  
**Documento base:** [[Análisis Brechas de Datos - BBDD vs Reporte]]

---

## 📋 Checklist General

### Fase 1: Validación y Corrección (ALTA PRIORIDAD)
- [ ] 1.1. Validar matrícula EMTP 2024 desde archivo fuente
- [ ] 1.2. Recalcular asistencia promedio EMTP (archivo grande - usar chunking)
- [ ] 1.3. Validar datos SEP e IDPS

### Fase 2: Trayectoria y Titulación (ALTA PRIORIDAD)
- [ ] 2.1. Descargar base de rendimiento escolar 2024 desde Mineduc
- [ ] 2.2. Procesar egresados, aprobación, reprobación, retiro, traslado
- [ ] 2.3. Contactar ChileValora o Mineduc TP para datos de titulación
- [ ] 2.4. Integrar datos de titulación a BBDD

### Fase 3: PME (MEDIA PRIORIDAD)
- [ ] 3.1. Abrir y analizar estructura de archivos PME
- [ ] 3.2. Extraer actividades por dimensión y plan
- [ ] 3.3. Crear hoja "PME_Resumen" en BBDD

### Fase 4: Evaluación Docente (MEDIA PRIORIDAD)
- [ ] 4.1. Buscar base de evaluación docente en portal CPEIP/Mineduc
- [ ] 4.2. Procesar niveles de desarrollo docente EMTP
- [ ] 4.3. Crear hoja "Evaluacion_Docente" en BBDD

### Fase 5: Acceso Educación Superior (BAJA PRIORIDAD)
- [ ] 5.1. Buscar/solicitar base de postulantes 2025 DEMRE
- [ ] 5.2. Calcular postulantes y promedios NEM/Ranking
- [ ] 5.3. Integrar a BBDD

### Fase 6: Denuncias (BAJA PRIORIDAD)
- [ ] 6.1. Solicitar datos de denuncias 2024 a Superintendencia
- [ ] 6.2. Procesar denuncias por liceo y tipo
- [ ] 6.3. Integrar a BBDD

---

## 🎯 Fase 1: Validación (Empezar aquí)

### Tarea 1.1: Validar Matrícula EMTP 2024
**Tiempo estimado:** 2 horas  
**Archivo:** `SharePoint/Recursos/Datos/Fuentes/2024_Matrícula.csv`

#### Script Python sugerido:
```python
import pandas as pd

# Cargar matrícula oficial
matricula = pd.read_csv('Fuentes/2024_Matrícula.csv')

# Filtrar solo EMTP (1º a 4º medio TP)
# Columnas esperadas: RBD, COD_GRADO, COD_ENSEÑANZA
emtp = matricula[
    (matricula['COD_ENSEÑANZA'] == 'TP') & 
    (matricula['COD_GRADO'].isin(['10', '11', '12', '13']))  # 1º-4º medio
]

# Agrupar por RBD
matricula_por_liceo = emtp.groupby('RBD').size().reset_index(name='Matricula_EMTP_Oficial')

# Comparar con BBDD actual
bbdd = pd.read_excel('BBDD.xlsx')
comparacion = bbdd.merge(matricula_por_liceo, on='RBD', how='left')

# Identificar discrepancias
comparacion['Diferencia'] = comparacion['Matricula_EMTP_Total'] - comparacion['Matricula_EMTP_Oficial']
discrepancias = comparacion[abs(comparacion['Diferencia']) > 10]

print(discrepancias[['Liceo', 'SLEP', 'Matricula_EMTP_Total', 'Matricula_EMTP_Oficial', 'Diferencia']])

# Actualizar BBDD con valores oficiales
# bbdd['Matricula_EMTP_Total'] = comparacion['Matricula_EMTP_Oficial']
# bbdd.to_excel('BBDD_actualizada.xlsx', index=False)
```

**Resultado esperado:** Matrícula corregida que coincida con valores del reporte

---

### Tarea 1.2: Recalcular Asistencia EMTP
**Tiempo estimado:** 3 horas  
**Archivo:** `SharePoint/Recursos/Datos/Fuentes/2024_Asistencia.csv` (851 MB)

#### Script Python sugerido (con chunking):
```python
import pandas as pd

# Cargar lista de RBD objetivo
bbdd = pd.read_excel('BBDD.xlsx')
rbd_objetivo = bbdd['RBD'].unique()

# Procesar archivo grande por chunks
asistencia_liceo = {}
chunksize = 100000

for chunk in pd.read_csv('Fuentes/2024_Asistencia.csv', chunksize=chunksize):
    # Filtrar solo liceos objetivo
    chunk_filtrado = chunk[chunk['RBD'].isin(rbd_objetivo)]
    
    # Aquí agregar lógica para filtrar solo estudiantes EMTP
    # (depende de columnas disponibles: COD_GRADO, COD_ENSEÑANZA)
    
    # Calcular asistencia por estudiante y luego por liceo
    # ...
    
print(asistencia_liceo)
```

**Resultado esperado:** Asistencia promedio EMTP que coincida con valores del reporte

---

### Tarea 1.3: Validar SEP e IDPS
**Tiempo estimado:** 1 hora  
**Archivos:** 
- `2024_Prioritarios y preferentes (SEP).csv`
- `2024_IDPS.csv`

#### Acciones:
1. Cargar archivos
2. Filtrar por RBD de los 39 liceos
3. Comparar con valores actuales de BBDD
4. Actualizar si hay discrepancias significativas

---

## 🎯 Fase 2: Trayectoria y Titulación

### Tarea 2.1: Descargar Rendimiento Escolar
**Tiempo estimado:** 2 horas  
**Fuente:** https://datosabiertos.mineduc.cl/

#### Pasos:
1. Ir a portal de Datos Abiertos Mineduc
2. Buscar sección "Rendimiento Escolar" o "Estadísticas de la Educación"
3. Descargar base de rendimiento 2024
4. Guardar en `Fuentes/2024_Rendimiento.csv`

**Datos a extraer:**
- Egresados 4º medio 2024
- Situación final: Aprobado, Reprobado, Retirado, Trasladado
- Promedio de notas 4º medio

---

### Tarea 2.2: Procesar Rendimiento Escolar
**Tiempo estimado:** 2 horas

#### Script sugerido:
```python
import pandas as pd

# Cargar rendimiento
rendimiento = pd.read_csv('Fuentes/2024_Rendimiento.csv')

# Filtrar 4º medio EMTP
cuarto_emtp = rendimiento[
    (rendimiento['COD_GRADO'] == '13') &  # 4º medio
    (rendimiento['COD_ENSEÑANZA'] == 'TP')
]

# Calcular por liceo
resumen = cuarto_emtp.groupby('RBD').agg({
    'ID_ESTUDIANTE': 'count',  # Total egresados
    'PROMEDIO_FINAL': 'mean',  # Promedio notas
})

# Calcular porcentajes de trayectoria
trayectoria = cuarto_emtp.groupby(['RBD', 'SIT_FINAL']).size().unstack(fill_value=0)
trayectoria_pct = trayectoria.div(trayectoria.sum(axis=1), axis=0) * 100

# Merge con BBDD
# ...
```

---

### Tarea 2.3: Contactar ChileValora para Titulación
**Tiempo estimado:** Variable (incluye espera)

#### Información a solicitar:
- Titulados 2024 por RBD
- Desagregación por sexo (H/M)
- % titulación dual
- Especialidad de titulación

#### Contactos sugeridos:
- Email: contacto@chilevalora.cl
- Alternativamente: Coordinación EMTP de Mineduc

#### Template de email:
```
Asunto: Solicitud de datos de titulación EMTP 2024 para proyecto con SLEP

Estimados/as,

Mi nombre es [Nombre] y trabajo en el proyecto de acompañamiento 
a Servicios Locales de Educación Pública en EMTP.

Solicito información de titulación 2024 para los siguientes 
39 establecimientos (RBD adjunto):

- Número de titulados por RBD
- Desagregación por sexo
- % titulación dual
- Especialidad de titulación

Esta información es para diagnóstico y planificación del proyecto.

Agradezco su colaboración.

Saludos,
[Firma]
```

---

## 🎯 Fase 3: PME

### Tarea 3.1: Analizar Estructura PME
**Tiempo estimado:** 2 horas  
**Archivos:**
- `2025_PME.xlsx`
- `19052025_Planificación_Anual_PME_2025_02052025.xlsx`

#### Pasos:
1. Abrir ambos archivos Excel
2. Identificar hojas relevantes
3. Mapear columnas:
   - RBD o identificador de liceo
   - Tipo de actividad / dimensión
   - Plan asociado
4. Documentar estructura en nota

---

### Tarea 3.2: Extraer Actividades PME
**Tiempo estimado:** 2 horas

#### Script sugerido:
```python
import pandas as pd

# Cargar PME
pme = pd.read_excel('Fuentes/2025_PME.xlsx', sheet_name='NOMBRE_HOJA')

# Filtrar por RBD objetivo
bbdd = pd.read_excel('BBDD.xlsx')
pme_filtrado = pme[pme['RBD'].isin(bbdd['RBD'])]

# Contar actividades por dimensión
dimensiones = ['Gestion_Pedagogica', 'Convivencia', 'Liderazgo', 'Recursos']
actividades_dimension = pme_filtrado.groupby(['RBD', 'DIMENSION']).size().unstack(fill_value=0)

# Contar actividades por plan
planes = ['Convivencia', 'Formacion_Ciudadana', 'PISE', 'PLFDPD', 'PSAG', 'Inclusion']
actividades_plan = pme_filtrado.groupby(['RBD', 'PLAN']).size().unstack(fill_value=0)

# Crear DataFrame resumen
pme_resumen = actividades_dimension.merge(actividades_plan, on='RBD')
```

---

## 🎯 Fase 4: Evaluación Docente

### Tarea 4.1: Buscar Base Evaluación Docente
**Tiempo estimado:** 3 horas  
**Fuente:** Portal CPEIP o Mineduc - Carrera Docente

#### Pasos:
1. Buscar en https://www.cpeip.cl/ sección "Datos y Estadísticas"
2. Alternativamente: Portal de Datos Abiertos Mineduc
3. Descargar base de desarrollo profesional docente 2024
4. Guardar en `Fuentes/2024_Evaluacion_Docente.csv`

---

### Tarea 4.2: Procesar Evaluación Docente
**Tiempo estimado:** 2 horas

#### Script sugerido:
```python
import pandas as pd

# Cargar evaluación docente
eval_doc = pd.read_csv('Fuentes/2024_Evaluacion_Docente.csv')

# Filtrar solo docentes EMTP de los 39 liceos
# (puede requerir merge con dotación docente)
bbdd = pd.read_excel('BBDD.xlsx')
eval_emtp = eval_doc[eval_doc['RBD'].isin(bbdd['RBD'])]

# Contar por nivel de desarrollo
niveles = eval_emtp.groupby(['RBD', 'NIVEL_DESARROLLO']).size().unstack(fill_value=0)

# Resultado esperado: columnas Inicial, Temprano, Avanzado, Experto_I, Experto_II
```

---

## 🎯 Fase 5: Acceso Educación Superior

### Tarea 5.1: Solicitar Datos DEMRE
**Tiempo estimado:** Variable

#### Contacto:
- Portal: https://demre.cl/
- Email: demre@demre.cl
- Alternativamente: Portal Acceso Mineduc

#### Datos a solicitar:
- Postulantes 2025 egresados de los 39 liceos (RBD)
- Promedio NEM
- Promedio Ranking

---

## 🎯 Fase 6: Denuncias

### Tarea 6.1: Solicitar Datos Superintendencia
**Tiempo estimado:** Variable (puede requerir solicitud Ley Transparencia)

#### Contacto:
- Portal: https://www.supereduc.cl/
- Sistema SIE (si hay acceso directo)
- Ley de Transparencia si es necesario

#### Datos a solicitar:
- Denuncias 2024 por RBD
- Tipo de denuncia
- Estado de denuncia

---

## 📊 Estructura Final de BBDD

### Nuevas Hojas a Crear:

1. **Trayectoria**
   - RBD, SLEP, Liceo
   - Aprobacion_Pct, Reprobacion_Pct, Retiro_Pct, Traslado_Pct

2. **Titulacion**
   - RBD, SLEP, Liceo
   - Titulados_Total, Titulados_H, Titulados_M
   - Pct_Dual, Especialidad_Frecuente

3. **PME_Resumen**
   - RBD, SLEP, Liceo
   - Total_Actividades, Act_por_Dimension, Act_por_Plan

4. **Evaluacion_Docente**
   - RBD, SLEP, Liceo
   - Docentes por nivel de desarrollo

5. **Indicadores_SLEP**
   - Vista agregada con fórmulas que sumen datos de hojas anteriores

---

## 🔄 Mantenimiento y Actualización

### Protocolo de actualización:
1. Crear backup antes de actualización masiva
2. Documentar fecha y fuente de cada actualización
3. Validar rangos razonables de datos
4. Comparar con versión anterior para detectar anomalías

### Archivo de metadatos sugerido:
```
# Metadatos_BBDD.txt

Última actualización: 2025-10-27

Fuentes por columna:
- Matricula_EMTP_Total: Mineduc/2024_Matrícula.csv (2025-10-27)
- Tasa_Asistencia_Promedio: Mineduc/2024_Asistencia.csv (2025-10-27)
- Egresados_4M_2024: Mineduc/2024_Rendimiento.csv (2025-10-XX)
- Titulados_2024: ChileValora (2025-10-XX)
...
```

---

## ✅ Verificación Final

Antes de considerar completada la integración:

- [ ] Todas las columnas críticas tienen datos (sin nulos masivos)
- [ ] Datos agregados por SLEP coinciden con reporte de referencia
- [ ] Fórmulas de hojas agregadas funcionan correctamente
- [ ] Archivo de metadatos está actualizado
- [ ] Backup de versión anterior está guardado
- [ ] Documentación de cambios está completa

---

**Nota:** Este plan puede ajustarse según disponibilidad de datos y accesos a fuentes oficiales. Priorizar siempre las fases 1 y 2 por su alto impacto en el diagnóstico del proyecto.
