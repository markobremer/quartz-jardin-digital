# ==============================================================================
# ANÁLISIS DIAGNÓSTICO CAPA A - ESTABLECIMIENTOS EDUCATIVOS
# Proyecto: Apoyo SLEP 2025-2026
# Script 02: Análisis descriptivo por pregunta y SLEP
# ==============================================================================

# Limpiar entorno
rm(list = ls())

# Cargar librerías necesarias
library(tidyverse)
library(readr)
library(knitr)
library(kableExtra)
library(stringr)

# ==============================================================================
# 1. CARGAR DATOS
# ==============================================================================

ruta_bbdd <- "/Users/marko/Library/CloudStorage/OneDrive-SharedLibraries-GrupoEducativo/Apoyo SLEP 2025-2026 - General/2. Ejecución/1. Diagnóstico/1. Instrumento/3. Resultados/Análisis Marko/BBDD - EE - Capa A.csv"

datos_raw <- read_delim(ruta_bbdd,
                        delim = ";",
                        locale = locale(encoding = "UTF-8"),
                        show_col_types = FALSE)

cat("\n=== DATOS CARGADOS ===\n")
cat("Filas totales:", nrow(datos_raw), "\n")
cat("Columnas totales:", ncol(datos_raw), "\n\n")

# ==============================================================================
# 2. DEFINIR ESTRUCTURA DEL INSTRUMENTO
# ==============================================================================

# Mapeo de preguntas a estructura conceptual
estructura_instrumento <- tibble(
  Pregunta_N = 1:36,
  Dimension = c(
    # Competencia 1: Desarrollo profesional docente (1-12)
    rep("1. Desarrollo profesional docente", 12),
    # Competencia 2: Gestión estratégica del currículum (13-24)
    rep("2. Gestión estratégica del currículum", 12),
    # Competencia 3: Gestión integral técnico-pedagógica (25-36)
    rep("3. Gestión integral técnico-pedagógica", 12)
  ),
  Subdimension = c(
    # 1.1. Liderazgo en Actualización de Conocimientos (1-4)
    rep("Liderazgo en Actualización de Conocimientos", 4),
    # 1.2. Orientación Didáctica Específica (5-8)
    rep("Orientación Didáctica Específica", 4),
    # 1.3. Institucionalización del Trabajo Colaborativo (9-12)
    rep("Institucionalización del Trabajo Colaborativo", 4),
    # 2.1. Pertinencia Territorial (13-16)
    rep("Pertinencia Territorial", 4),
    # 2.2. Conducción del Sello Institucional (17-20)
    rep("Conducción del Sello Institucional", 4),
    # 2.3. Operacionalización del Perfil de Egreso (21-24)
    rep("Operacionalización del Perfil de Egreso", 4),
    # 3.1. Articulación Curricular FG-FD (25-28)
    rep("Articulación Curricular FG-FD", 4),
    # 3.2. Diseño, Planificación y Secuencia (29-32)
    rep("Diseño, Planificación y Secuencia", 4),
    # 3.3. Monitoreo y Gestión del Proceso (33-36)
    rep("Monitoreo y Gestión del Proceso", 4)
  ),
  Competencia = c(
    # P1-4: SABER, HACER, HACER, HACER
    "Saber", "Hacer", "Hacer", "Hacer",
    # P5-8: SABER, HACER, HACER, APLICAR
    "Saber", "Hacer", "Hacer", "Aplicar",
    # P9-12: HACER, HACER, APLICAR, SABER
    "Hacer", "Hacer", "Aplicar", "Saber",
    # P13-16: SABER, HACER, HACER, APLICAR
    "Saber", "Hacer", "Hacer", "Aplicar",
    # P17-20: HACER, APLICAR, APLICAR, APLICAR
    "Hacer", "Aplicar", "Aplicar", "Aplicar",
    # P21-24: SABER, HACER, APLICAR, APLICAR
    "Saber", "Hacer", "Aplicar", "Aplicar",
    # P25-28: SABER, HACER, HACER, APLICAR
    "Saber", "Hacer", "Hacer", "Aplicar",
    # P29-32: HACER, APLICAR, HACER, APLICAR
    "Hacer", "Aplicar", "Hacer", "Aplicar",
    # P33-36: APLICAR, APLICAR, APLICAR, APLICAR
    "Aplicar", "Aplicar", "Aplicar", "Aplicar"
  )
)

# ==============================================================================
# 3. PREPARAR DATOS EN FORMATO LARGO
# ==============================================================================

cat("\n=== TRANSFORMANDO DATOS A FORMATO LARGO ===\n\n")

# Identificar columnas
cols_id <- c("SLEP", "Establecimiento Educativo", "Cargo")
cols_preguntas <- setdiff(names(datos_raw), cols_id)
cols_preguntas <- cols_preguntas[1:36]  # Solo las 36 preguntas

# Crear dataset largo
datos_largo <- datos_raw %>%
  filter(!is.na(SLEP) & !is.na(`Establecimiento Educativo`)) %>%
  select(all_of(c(cols_id, cols_preguntas))) %>%
  pivot_longer(
    cols = all_of(cols_preguntas),
    names_to = "Pregunta_Texto",
    values_to = "Respuesta_Texto"
  ) %>%
  mutate(
    # Extraer número de pregunta del nombre de columna (si está al inicio)
    Pregunta_N = row_number() %% 36,
    Pregunta_N = ifelse(Pregunta_N == 0, 36, Pregunta_N)
  )

# Asignar número de pregunta basado en el orden de aparición
preguntas_orden <- tibble(
  Pregunta_Texto = cols_preguntas,
  Pregunta_N = 1:36
)

datos_largo <- datos_largo %>%
  select(-Pregunta_N) %>%
  left_join(preguntas_orden, by = "Pregunta_Texto")

cat("Dimensiones datos largo:", dim(datos_largo), "\n\n")

# ==============================================================================
# 4. CONVERTIR RESPUESTAS TEXTUALES A VALORES NUMÉRICOS
# ==============================================================================

cat("\n=== CONVIRTIENDO RESPUESTAS A VALORES NUMÉRICOS ===\n\n")

datos_largo <- datos_largo %>%
  mutate(
    # Extraer el primer dígito de la respuesta
    Valor_Numerico = str_extract(Respuesta_Texto, "^[0-9]"),
    Valor_Numerico = as.numeric(Valor_Numerico)
  )

# Verificar conversión
cat("Resumen de valores numéricos (antes de procesamiento):\n")
print(table(datos_largo$Valor_Numerico, datos_largo$Pregunta_N <= 24, useNA = "always"))
cat("\n")

# ==============================================================================
# 4.1. IDENTIFICAR "NO TENGO INFORMACIÓN" SEGÚN DIMENSIÓN
# ==============================================================================

cat("\n=== IDENTIFICANDO 'NO TENGO INFORMACIÓN' POR DIMENSIÓN ===\n\n")

# CRÍTICO: La codificación de "No Info" difiere por dimensión
# - Preguntas 1-24 (Dim 1-2): Valor 6 = "No Info"
# - Preguntas 25-36 (Dim 3): Valor 5 = "No Info"

datos_largo <- datos_largo %>%
  mutate(
    Es_No_Info = case_when(
      Pregunta_N >= 1 & Pregunta_N <= 24 ~ (Valor_Numerico == 6),
      Pregunta_N >= 25 & Pregunta_N <= 36 ~ (Valor_Numerico == 5),
      TRUE ~ FALSE
    ),
    # Convertir "No Info" a NA para cálculo de promedios
    Valor_Para_Promedio = ifelse(Es_No_Info, NA, Valor_Numerico)
  )

cat("Respuestas 'No Info' por dimensión:\n")
cat("  Dim 1-2 (P1-24, valor=6):", sum(datos_largo$Es_No_Info[datos_largo$Pregunta_N <= 24], na.rm = TRUE), "\n")
cat("  Dim 3 (P25-36, valor=5):", sum(datos_largo$Es_No_Info[datos_largo$Pregunta_N >= 25], na.rm = TRUE), "\n\n")

# ==============================================================================
# 4.2. ESCALAR PREGUNTAS 25-36 DE RANGO 1-4 A RANGO 1-5
# ==============================================================================

cat("\n=== ESCALANDO PREGUNTAS 25-36 (Dimensión 3) DE 1-4 A 1-5 ===\n\n")

# CRÍTICO: Las preguntas 25-36 originalmente tenían escala 1-4 por error
# Solo los valores 1-4 deben escalarse (el valor 5 ya fue marcado como "No Info")

datos_largo <- datos_largo %>%
  mutate(
    Valor_Para_Promedio = ifelse(
      Pregunta_N >= 25 & Pregunta_N <= 36 & !is.na(Valor_Para_Promedio),
      # Fórmula: 1 + (valor_original - 1) * (4/3)
      # Esto convierte: 1→1.00, 2→2.33, 3→3.67, 4→5.00
      1 + (Valor_Para_Promedio - 1) * (4/3),
      Valor_Para_Promedio
    )
  )

# Verificar escalamiento
cat("Preguntas 25-36 después de escalamiento (excluyendo 'No Info'):\n")
valores_dim3 <- datos_largo$Valor_Para_Promedio[datos_largo$Pregunta_N >= 25 & datos_largo$Pregunta_N <= 36]
cat("  Rango observado:",
    round(min(valores_dim3, na.rm = TRUE), 2), "-",
    round(max(valores_dim3, na.rm = TRUE), 2), "\n")
cat("  Valores únicos:", paste(sort(unique(round(valores_dim3, 2))), collapse = ", "), "\n\n")

# ==============================================================================
# 5. AGREGAR ESTRUCTURA DEL INSTRUMENTO
# ==============================================================================

datos_largo <- datos_largo %>%
  left_join(estructura_instrumento, by = "Pregunta_N")

# ==============================================================================
# 6. TRATAMIENTO DE RESPUESTAS DUPLICADAS
# ==============================================================================
# Decisión metodológica: Promediar respuestas del mismo cargo en el mismo EE

cat("\n=== TRATANDO RESPUESTAS DUPLICADAS (MISMO CARGO EN MISMO EE) ===\n\n")

# Identificar duplicados antes de agregar
duplicados_antes <- datos_largo %>%
  group_by(SLEP, `Establecimiento Educativo`, Cargo, Pregunta_N) %>%
  summarise(N = n(), .groups = "drop") %>%
  filter(N > 1)

cat("Número de casos con respuestas duplicadas del mismo cargo:", nrow(duplicados_antes), "\n\n")

# Agregar promediando por EE-Cargo-Pregunta
datos_agregados <- datos_largo %>%
  group_by(SLEP, `Establecimiento Educativo`, Cargo, Pregunta_N,
           Dimension, Subdimension, Competencia) %>%
  summarise(
    Valor_Promedio = mean(Valor_Para_Promedio, na.rm = TRUE),
    N_Respuestas = sum(!is.na(Valor_Para_Promedio)),
    N_No_Info = sum(Es_No_Info, na.rm = TRUE),
    Total_Respuestas = n(),
    .groups = "drop"
  )

cat("Dimensiones datos agregados:", dim(datos_agregados), "\n\n")

# ==============================================================================
# 7. CALCULAR MEDIAS POR PREGUNTA Y SLEP
# ==============================================================================

cat("\n=== CALCULANDO MEDIAS POR PREGUNTA Y SLEP ===\n\n")

medias_pregunta_slep <- datos_agregados %>%
  group_by(SLEP, Pregunta_N, Dimension, Subdimension, Competencia) %>%
  summarise(
    Media = mean(Valor_Promedio, na.rm = TRUE),
    N = sum(N_Respuestas),
    N_EE = n_distinct(`Establecimiento Educativo`),
    Porc_No_Info = round(100 * sum(N_No_Info) / sum(Total_Respuestas), 1),
    .groups = "drop"
  )

# Calcular media general
medias_pregunta_general <- datos_agregados %>%
  group_by(Pregunta_N, Dimension, Subdimension, Competencia) %>%
  summarise(
    Media = mean(Valor_Promedio, na.rm = TRUE),
    N = sum(N_Respuestas),
    N_EE = n_distinct(`Establecimiento Educativo`),
    Porc_No_Info = round(100 * sum(N_No_Info) / sum(Total_Respuestas), 1),
    .groups = "drop"
  ) %>%
  mutate(SLEP = "General")

# Combinar
medias_completas <- bind_rows(medias_pregunta_slep, medias_pregunta_general)

# ==============================================================================
# 8. CREAR TABLA FORMATO ANCHO (COMO IMAGEN COMPARTIDA)
# ==============================================================================

cat("\n=== CREANDO TABLA EN FORMATO ANCHO ===\n\n")

# Pivotar a formato ancho
tabla_ancha <- medias_completas %>%
  select(Pregunta_N, SLEP, Media) %>%
  pivot_wider(names_from = SLEP, values_from = Media) %>%
  arrange(Pregunta_N)

# Agregar información de estructura
tabla_ancha <- tabla_ancha %>%
  left_join(
    estructura_instrumento %>% select(Pregunta_N, Dimension, Subdimension, Competencia),
    by = "Pregunta_N"
  ) %>%
  select(Pregunta_N, Dimension, Subdimension, Competencia, everything())

# Reordenar columnas para que General esté al final
columnas_orden <- c("Pregunta_N", "Dimension", "Subdimension", "Competencia",
                    "Licancabur", "El Pino", "Santa Rosa", "Santa Corina",
                    "Los Libertadores", "General")

# Verificar qué columnas existen
columnas_disponibles <- intersect(columnas_orden, names(tabla_ancha))
tabla_ancha <- tabla_ancha %>% select(all_of(columnas_disponibles))

# Redondear a 2 decimales
tabla_ancha <- tabla_ancha %>%
  mutate(across(where(is.numeric) & !Pregunta_N, ~round(.x, 2)))

# Guardar tabla
write_csv(tabla_ancha, "output/02_medias_por_pregunta_slep.csv")
cat("Tabla guardada en: output/02_medias_por_pregunta_slep.csv\n\n")

# ==============================================================================
# 9. CREAR TABLA CON N ASOCIADO
# ==============================================================================

cat("\n=== CREANDO TABLA CON N (TAMAÑO DE MUESTRA) ===\n\n")

tabla_n <- medias_completas %>%
  select(Pregunta_N, SLEP, N) %>%
  pivot_wider(names_from = SLEP, values_from = N, names_prefix = "N_") %>%
  arrange(Pregunta_N)

# Agregar información de estructura
tabla_n <- tabla_n %>%
  left_join(
    estructura_instrumento %>% select(Pregunta_N, Dimension, Subdimension, Competencia),
    by = "Pregunta_N"
  ) %>%
  select(Pregunta_N, Dimension, Subdimension, Competencia, everything())

write_csv(tabla_n, "output/02_n_por_pregunta_slep.csv")
cat("Tabla N guardada en: output/02_n_por_pregunta_slep.csv\n\n")

# ==============================================================================
# 10. CALCULAR PORCENTAJE "NO TENGO INFORMACIÓN" POR PREGUNTA
# ==============================================================================

cat("\n=== CALCULANDO PORCENTAJE 'NO TENGO INFORMACIÓN' ===\n\n")

tabla_no_info_pregunta <- medias_completas %>%
  select(Pregunta_N, SLEP, Porc_No_Info) %>%
  pivot_wider(names_from = SLEP, values_from = Porc_No_Info, names_prefix = "NoInfo_") %>%
  arrange(Pregunta_N)

# Agregar información de estructura
tabla_no_info_pregunta <- tabla_no_info_pregunta %>%
  left_join(
    estructura_instrumento %>% select(Pregunta_N, Dimension, Subdimension, Competencia),
    by = "Pregunta_N"
  ) %>%
  select(Pregunta_N, Dimension, Subdimension, Competencia, everything())

write_csv(tabla_no_info_pregunta, "output/02_porc_no_info_por_pregunta.csv")
cat("Tabla % No Info guardada en: output/02_porc_no_info_por_pregunta.csv\n\n")

# ==============================================================================
# 11. CALCULAR PORCENTAJE "NO TENGO INFORMACIÓN" POR SUBDIMENSIÓN
# ==============================================================================

cat("\n=== PORCENTAJE 'NO TENGO INFORMACIÓN' POR SUBDIMENSIÓN ===\n\n")

no_info_subdimension <- datos_agregados %>%
  group_by(SLEP, Dimension, Subdimension) %>%
  summarise(
    Porc_No_Info = round(100 * sum(N_No_Info) / sum(Total_Respuestas), 1),
    .groups = "drop"
  )

# Formato ancho
tabla_no_info_subdim <- no_info_subdimension %>%
  pivot_wider(names_from = SLEP, values_from = Porc_No_Info, names_prefix = "NoInfo_")

write_csv(tabla_no_info_subdim, "output/02_porc_no_info_por_subdimension.csv")
cat("Tabla guardada en: output/02_porc_no_info_por_subdimension.csv\n\n")

# ==============================================================================
# 12. CALCULAR PORCENTAJE "NO TENGO INFORMACIÓN" POR DIMENSIÓN
# ==============================================================================

no_info_dimension <- datos_agregados %>%
  group_by(SLEP, Dimension) %>%
  summarise(
    Porc_No_Info = round(100 * sum(N_No_Info) / sum(Total_Respuestas), 1),
    .groups = "drop"
  )

# Formato ancho
tabla_no_info_dim <- no_info_dimension %>%
  pivot_wider(names_from = SLEP, values_from = Porc_No_Info, names_prefix = "NoInfo_")

write_csv(tabla_no_info_dim, "output/02_porc_no_info_por_dimension.csv")
cat("Tabla guardada en: output/02_porc_no_info_por_dimension.csv\n\n")

# ==============================================================================
# 13. GENERAR TABLA VISUAL TIPO HEATMAP
# ==============================================================================

cat("\n=== GENERANDO VISUALIZACIÓN TIPO HEATMAP ===\n\n")

# Preparar datos para heatmap
datos_heatmap <- tabla_ancha %>%
  select(-Dimension, -Subdimension, -Competencia) %>%
  pivot_longer(cols = -Pregunta_N, names_to = "SLEP", values_to = "Media") %>%
  mutate(
    # Categorizar medias
    Categoria = case_when(
      is.na(Media) ~ "Sin dato",
      Media < 2.0 ~ "Muy bajo (< 2.0)",
      Media < 2.5 ~ "Bajo (2.0-2.5)",
      Media < 3.0 ~ "Medio-Bajo (2.5-3.0)",
      Media < 3.5 ~ "Medio (3.0-3.5)",
      Media < 4.0 ~ "Medio-Alto (3.5-4.0)",
      TRUE ~ "Alto (≥ 4.0)"
    ),
    Categoria = factor(Categoria, levels = c(
      "Muy bajo (< 2.0)", "Bajo (2.0-2.5)", "Medio-Bajo (2.5-3.0)",
      "Medio (3.0-3.5)", "Medio-Alto (3.5-4.0)", "Alto (≥ 4.0)", "Sin dato"
    ))
  )

# Crear el heatmap
p1 <- ggplot(datos_heatmap, aes(x = SLEP, y = factor(Pregunta_N), fill = Media)) +
  geom_tile(color = "white", linewidth = 0.5) +
  geom_text(aes(label = ifelse(!is.na(Media), sprintf("%.2f", Media), "")),
            size = 2.5, color = "black") +
  scale_fill_gradient2(
    low = "#d73027",      # Rojo para valores bajos
    mid = "#ffffbf",      # Amarillo para valores medios
    high = "#1a9850",     # Verde para valores altos
    midpoint = 3.0,
    limits = c(1, 5),
    na.value = "grey90",
    name = "Media"
  ) +
  scale_y_discrete(limits = rev(levels(factor(1:36)))) +
  theme_minimal(base_size = 10) +
  theme(
    axis.text.x = element_text(angle = 45, hjust = 1),
    axis.text.y = element_text(size = 8),
    panel.grid = element_blank(),
    legend.position = "right"
  ) +
  labs(
    title = "Medias por Pregunta y SLEP",
    subtitle = "Diagnóstico Capa A - Capacidades Implementación Curricular EMTP",
    x = "SLEP",
    y = "Pregunta #"
  )

ggsave("output/02_heatmap_medias_pregunta_slep.png",
       plot = p1,
       width = 12,
       height = 18,
       dpi = 300)

cat("Gráfico guardado en: output/02_heatmap_medias_pregunta_slep.png\n\n")

# ==============================================================================
# 14. RESUMEN EJECUTIVO POR SLEP
# ==============================================================================

cat("\n=== RESUMEN EJECUTIVO POR SLEP ===\n\n")

resumen_slep <- medias_completas %>%
  group_by(SLEP) %>%
  summarise(
    N_Preguntas = n(),
    Media_General = round(mean(Media, na.rm = TRUE), 2),
    Min = round(min(Media, na.rm = TRUE), 2),
    Max = round(max(Media, na.rm = TRUE), 2),
    N_Total_Respuestas = sum(N),
    Porc_No_Info_Promedio = round(mean(Porc_No_Info, na.rm = TRUE), 1),
    .groups = "drop"
  ) %>%
  arrange(desc(Media_General))

print(resumen_slep)

write_csv(resumen_slep, "output/02_resumen_ejecutivo_slep.csv")
cat("\nTabla guardada en: output/02_resumen_ejecutivo_slep.csv\n\n")

# ==============================================================================
# 15. ADVERTENCIAS METODOLÓGICAS
# ==============================================================================

cat("\n=== ADVERTENCIAS METODOLÓGICAS ===\n\n")

# Identificar SLEP con N bajo
slep_n_bajo <- resumen_slep %>%
  filter(N_Total_Respuestas < 30) %>%
  select(SLEP, N_Total_Respuestas)

if(nrow(slep_n_bajo) > 0) {
  cat("ADVERTENCIA: Los siguientes SLEP tienen N < 30 respuestas.\n")
  cat("Sus resultados deben interpretarse con precaución:\n\n")
  print(slep_n_bajo)
  cat("\n")
}

# Identificar preguntas con alta tasa de "No tengo información"
preguntas_alta_no_info <- tabla_no_info_pregunta %>%
  filter(if_any(starts_with("NoInfo_"), ~ .x > 20)) %>%
  select(Pregunta_N, Subdimension, starts_with("NoInfo_"))

if(nrow(preguntas_alta_no_info) > 0) {
  cat("ADVERTENCIA: Las siguientes preguntas tienen >20% de respuestas 'No tengo información':\n\n")
  print(preguntas_alta_no_info, n = 50)
  cat("\n")
}

cat("=== SCRIPT COMPLETADO ===\n")
