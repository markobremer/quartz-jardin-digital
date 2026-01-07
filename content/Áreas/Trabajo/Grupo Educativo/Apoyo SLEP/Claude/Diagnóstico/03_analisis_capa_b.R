# ============================================================================
# Script: 03_analisis_capa_b.R
# Propósito: Análisis descriptivo de Capa B (Capacidades Administrativas)
# Autor: Claude Code
# Fecha: 2025-12-17
# ============================================================================

# Cargar librerías
library(tidyverse)
library(readr)

# Cargar datos Capa B
datos_capa_b <- read_delim(
  "Datos/BBDD - EE - Capa B.csv",
  delim = ";",
  locale = locale(encoding = "UTF-8"),
  show_col_types = FALSE
) %>%
  filter(!is.na(SLEP) & !is.na(`Establecimiento Educativo`))

# Renombrar columna de Cargo
datos_capa_b <- datos_capa_b %>%
  rename(Cargo = `Cargo/Rol`)

# ============================================================================
# 1. PREPARACIÓN DE DATOS
# ============================================================================

# Definir estructura del instrumento Capa B (16 preguntas, 4 módulos)
estructura_instrumento_b <- tibble(
  Pregunta_N = 1:16,
  Modulo = c(
    rep("M1. Levantamiento de Necesidades", 4),
    rep("M2. Priorización y Criterios", 4),
    rep("M3. Planificación y Monitoreo", 4),
    rep("M4. Especificaciones y Verificación", 4)
  )
)

# Identificar columnas
cols_id_b <- c("SLEP", "Establecimiento Educativo", "Cargo")
cols_preguntas_b <- setdiff(names(datos_capa_b), cols_id_b)
cols_preguntas_b <- cols_preguntas_b[1:16]  # Solo las 16 preguntas, excluir comentarios

# Transformar a formato largo
datos_largo_b <- datos_capa_b %>%
  select(all_of(c(cols_id_b, cols_preguntas_b))) %>%
  pivot_longer(
    cols = all_of(cols_preguntas_b),
    names_to = "Pregunta_Texto",
    values_to = "Respuesta_Texto"
  )

# Asignar número de pregunta
preguntas_orden_b <- tibble(
  Pregunta_Texto = cols_preguntas_b,
  Pregunta_N = 1:16
)

datos_largo_b <- datos_largo_b %>%
  left_join(preguntas_orden_b, by = "Pregunta_Texto") %>%
  left_join(estructura_instrumento_b, by = "Pregunta_N")

# Convertir respuestas a valores numéricos
# En Capa B: 1-4 son niveles, 5 es "No cuento con suficiente información"
datos_largo_b <- datos_largo_b %>%
  mutate(
    Valor_Numerico = str_extract(Respuesta_Texto, "^[0-9]"),
    Valor_Numerico = as.numeric(Valor_Numerico)
  )

# Identificar "No tengo información" (valor 5 en Capa B)
datos_largo_b <- datos_largo_b %>%
  mutate(
    Es_No_Info = (Valor_Numerico == 5),
    Valor_Para_Promedio = ifelse(Es_No_Info, NA, Valor_Numerico)
  )

# NO SE REQUIERE ESCALAMIENTO en Capa B (todas las preguntas usan escala 1-5)

# ============================================================================
# 2. AGREGAR DATOS (promediar respuestas duplicadas)
# ============================================================================

datos_agregados_b <- datos_largo_b %>%
  group_by(SLEP, `Establecimiento Educativo`, Cargo, Pregunta_N,
           Pregunta_Texto, Modulo) %>%
  summarise(
    Valor_Promedio = mean(Valor_Para_Promedio, na.rm = TRUE),
    N_Respuestas = sum(!is.na(Valor_Para_Promedio)),
    N_No_Info = sum(Es_No_Info, na.rm = TRUE),
    .groups = "drop"
  )

# ============================================================================
# 3. CALCULAR MEDIAS POR SLEP Y PREGUNTA
# ============================================================================

medias_pregunta_slep_b <- datos_agregados_b %>%
  group_by(SLEP, Pregunta_N, Pregunta_Texto, Modulo) %>%
  summarise(
    Media = mean(Valor_Promedio, na.rm = TRUE),
    N = sum(N_Respuestas),
    Porc_No_Info = round(100 * sum(N_No_Info) / (sum(N_Respuestas) + sum(N_No_Info)), 1),
    .groups = "drop"
  )

# Calcular media general
medias_pregunta_general_b <- datos_agregados_b %>%
  group_by(Pregunta_N, Pregunta_Texto, Modulo) %>%
  summarise(
    Media = mean(Valor_Promedio, na.rm = TRUE),
    N = sum(N_Respuestas),
    Porc_No_Info = round(100 * sum(N_No_Info) / (sum(N_Respuestas) + sum(N_No_Info)), 1),
    .groups = "drop"
  ) %>%
  mutate(SLEP = "General")

# Combinar
medias_completas_b <- bind_rows(medias_pregunta_slep_b, medias_pregunta_general_b)

# ============================================================================
# 4. TRANSFORMAR A FORMATO ANCHO
# ============================================================================

medias_ancho_b <- medias_completas_b %>%
  select(Pregunta_N, Modulo, SLEP, Media) %>%
  pivot_wider(
    names_from = SLEP,
    values_from = Media,
    id_cols = c(Pregunta_N, Modulo)
  ) %>%
  select(Pregunta_N, Modulo, Licancabur, `El Pino`, `Santa Rosa`,
         `Santa Corina`, `Los Libertadores`, General)

# ============================================================================
# 5. CALCULAR N POR PREGUNTA Y SLEP
# ============================================================================

n_ancho_b <- medias_completas_b %>%
  select(Pregunta_N, Modulo, SLEP, N) %>%
  pivot_wider(
    names_from = SLEP,
    values_from = N,
    id_cols = c(Pregunta_N, Modulo)
  ) %>%
  select(Pregunta_N, Modulo, Licancabur, `El Pino`, `Santa Rosa`,
         `Santa Corina`, `Los Libertadores`, General)

# ============================================================================
# 6. CALCULAR % "NO INFO" POR PREGUNTA
# ============================================================================

porc_no_info_ancho_b <- medias_completas_b %>%
  select(Pregunta_N, Modulo, SLEP, Porc_No_Info) %>%
  pivot_wider(
    names_from = SLEP,
    values_from = Porc_No_Info,
    id_cols = c(Pregunta_N, Modulo)
  ) %>%
  select(Pregunta_N, Modulo, Licancabur, `El Pino`, `Santa Rosa`,
         `Santa Corina`, `Los Libertadores`, General)

# ============================================================================
# 7. RESUMEN POR SLEP
# ============================================================================

# Calcular N de personas por SLEP
n_personas_slep_b <- datos_capa_b %>%
  mutate(ID_Persona = paste(SLEP, `Establecimiento Educativo`, Cargo)) %>%
  group_by(SLEP) %>%
  summarise(N_Personas = n_distinct(ID_Persona), .groups = "drop")

resumen_slep_b <- medias_completas_b %>%
  group_by(SLEP) %>%
  summarise(
    N_Preguntas = n(),
    Media_General = round(mean(Media, na.rm = TRUE), 2),
    Min = round(min(Media, na.rm = TRUE), 2),
    Max = round(max(Media, na.rm = TRUE), 2),
    .groups = "drop"
  ) %>%
  left_join(n_personas_slep_b, by = "SLEP") %>%
  arrange(desc(Media_General))

# Para "General", calcular el total de personas únicas
resumen_slep_b <- resumen_slep_b %>%
  mutate(N_Personas = ifelse(SLEP == "General", sum(n_personas_slep_b$N_Personas), N_Personas))

# Calcular % No Info promedio por SLEP
porc_no_info_slep_b <- medias_completas_b %>%
  group_by(SLEP) %>%
  summarise(
    Porc_No_Info_Promedio = round(mean(Porc_No_Info, na.rm = TRUE), 1),
    .groups = "drop"
  )

resumen_slep_b <- resumen_slep_b %>%
  left_join(porc_no_info_slep_b, by = "SLEP")

# ============================================================================
# 8. CALCULAR % "NO INFO" POR MÓDULO
# ============================================================================

porc_no_info_modulo_b <- datos_agregados_b %>%
  group_by(Modulo, SLEP) %>%
  summarise(
    Total_No_Info = sum(N_No_Info),
    Total_Respuestas = sum(N_Respuestas) + sum(N_No_Info),
    Porc_No_Info = round(100 * Total_No_Info / Total_Respuestas, 1),
    .groups = "drop"
  ) %>%
  select(Modulo, SLEP, Porc_No_Info) %>%
  pivot_wider(
    names_from = SLEP,
    values_from = Porc_No_Info,
    names_prefix = "NoInfo_"
  )

# ============================================================================
# 9. EXPORTAR RESULTADOS
# ============================================================================

# Crear carpeta output si no existe
dir.create("output", showWarnings = FALSE)

# Exportar tablas principales
write_csv(medias_ancho_b, "output/03_medias_por_pregunta_slep_capa_b.csv")
write_csv(n_ancho_b, "output/03_n_por_pregunta_slep_capa_b.csv")
write_csv(porc_no_info_ancho_b, "output/03_porc_no_info_por_pregunta_capa_b.csv")
write_csv(porc_no_info_modulo_b, "output/03_porc_no_info_por_modulo_capa_b.csv")
write_csv(resumen_slep_b, "output/03_resumen_ejecutivo_slep_capa_b.csv")

# ============================================================================
# 10. RESUMEN FINAL
# ============================================================================

cat("\n============================================================================\n")
cat("ANÁLISIS CAPA B - CAPACIDADES ADMINISTRATIVAS COMPLETADO\n")
cat("============================================================================\n\n")

cat("Archivos generados en output/:\n")
cat("  - 03_medias_por_pregunta_slep_capa_b.csv\n")
cat("  - 03_n_por_pregunta_slep_capa_b.csv\n")
cat("  - 03_porc_no_info_por_pregunta_capa_b.csv\n")
cat("  - 03_porc_no_info_por_modulo_capa_b.csv\n")
cat("  - 03_resumen_ejecutivo_slep_capa_b.csv\n\n")

cat("Resumen de la muestra:\n")
cat("  - Total personas respondientes:", nrow(n_personas_slep_b), "\n")
cat("  - Total respuestas:", nrow(datos_capa_b), "\n")
cat("  - SLEP participantes:", n_distinct(datos_capa_b$SLEP), "\n")
cat("  - Establecimientos:", n_distinct(datos_capa_b$`Establecimiento Educativo`), "\n\n")

cat("Ranking de SLEP por media general (Capa B):\n")
print(resumen_slep_b %>% select(SLEP, Media_General, N_Personas), n = Inf)

cat("\n============================================================================\n")
