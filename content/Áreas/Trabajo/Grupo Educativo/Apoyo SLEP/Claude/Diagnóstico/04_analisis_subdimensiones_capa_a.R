# ============================================================================
# Script: 04_analisis_subdimensiones_capa_a.R
# Propósito: Análisis de medias por subdimensión (nivel intermedio de agregación)
# Autor: Claude Code
# Fecha: 2025-12-17
# ============================================================================

# Cargar librerías
library(tidyverse)
library(readr)

# Cargar lista completa de establecimientos con RBD
lista_ee <- read_delim(
  "Datos/Listado colegios.csv",
  delim = ";",
  locale = locale(encoding = "UTF-8"),
  show_col_types = FALSE
)

# Limpiar nombres de columnas
names(lista_ee) <- c("SLEP", "Establecimiento Educativo", "RBD")

# Cargar datos Capa A
datos_capa_a <- read_delim(
  "Datos/BBDD - EE - Capa A.csv",
  delim = ";",
  locale = locale(encoding = "UTF-8"),
  show_col_types = FALSE
) %>%
  filter(!is.na(SLEP) & !is.na(`Establecimiento Educativo`))

# Unir con RBD
datos_capa_a <- datos_capa_a %>%
  left_join(lista_ee, by = c("SLEP", "Establecimiento Educativo"))

# ============================================================================
# 1. DEFINIR ESTRUCTURA DEL INSTRUMENTO
# ============================================================================

estructura_instrumento <- tibble(
  Pregunta_N = 1:36,
  Dimension = c(
    rep("1. Desarrollo profesional docente", 12),
    rep("2. Gestión estratégica del currículum", 12),
    rep("3. Gestión integral técnico-pedagógica", 12)
  ),
  Subdimension = c(
    rep("1.1 Liderazgo en Actualización de Conocimientos", 4),
    rep("1.2 Orientación Didáctica Específica", 4),
    rep("1.3 Institucionalización del Trabajo Colaborativo", 4),
    rep("2.1 Pertinencia Territorial", 4),
    rep("2.2 Conducción del Sello Institucional", 4),
    rep("2.3 Operacionalización del Perfil de Egreso", 4),
    rep("3.1 Articulación Curricular FG-FD", 4),
    rep("3.2 Diseño, Planificación y Secuencia", 4),
    rep("3.3 Monitoreo y Gestión del Proceso", 4)
  ),
  Competencia = c(
    "Saber", "Hacer", "Hacer", "Hacer",
    "Saber", "Hacer", "Hacer", "Aplicar",
    "Hacer", "Hacer", "Aplicar", "Saber",
    "Saber", "Hacer", "Hacer", "Aplicar",
    "Hacer", "Aplicar", "Aplicar", "Aplicar",
    "Saber", "Hacer", "Aplicar", "Aplicar",
    "Saber", "Hacer", "Hacer", "Aplicar",
    "Hacer", "Aplicar", "Hacer", "Aplicar",
    "Aplicar", "Aplicar", "Aplicar", "Aplicar"
  )
)

# ============================================================================
# 2. PREPARAR DATOS (reutilizar lógica de script 02)
# ============================================================================

# Identificar columnas
cols_id <- c("SLEP", "Establecimiento Educativo", "Cargo", "RBD")
cols_preguntas <- setdiff(names(datos_capa_a), cols_id)
cols_preguntas <- cols_preguntas[1:36]

# Transformar a formato largo
datos_largo <- datos_capa_a %>%
  select(all_of(c(cols_id, cols_preguntas))) %>%
  pivot_longer(
    cols = all_of(cols_preguntas),
    names_to = "Pregunta_Texto",
    values_to = "Respuesta_Texto"
  )

# Asignar número de pregunta
preguntas_orden <- tibble(
  Pregunta_Texto = cols_preguntas,
  Pregunta_N = 1:36
)

datos_largo <- datos_largo %>%
  left_join(preguntas_orden, by = "Pregunta_Texto") %>%
  left_join(estructura_instrumento, by = "Pregunta_N")

# Convertir respuestas a valores numéricos
datos_largo <- datos_largo %>%
  mutate(
    Valor_Numerico = str_extract(Respuesta_Texto, "^[0-9]"),
    Valor_Numerico = as.numeric(Valor_Numerico)
  )

# Identificar "No tengo información" según dimensión
datos_largo <- datos_largo %>%
  mutate(
    Es_No_Info = case_when(
      Pregunta_N >= 1 & Pregunta_N <= 24 ~ (Valor_Numerico == 6),
      Pregunta_N >= 25 & Pregunta_N <= 36 ~ (Valor_Numerico == 5),
      TRUE ~ FALSE
    ),
    Valor_Para_Promedio = ifelse(Es_No_Info, NA, Valor_Numerico)
  )

# ESCALAMIENTO: Preguntas 25-36 de rango 1-4 a rango 1-5
datos_largo <- datos_largo %>%
  mutate(
    Valor_Para_Promedio = ifelse(
      Pregunta_N >= 25 & Pregunta_N <= 36 & !is.na(Valor_Para_Promedio),
      1 + (Valor_Para_Promedio - 1) * (4/3),
      Valor_Para_Promedio
    )
  )

# ============================================================================
# 3. AGREGAR PROMEDIANDO DUPLICADOS (nivel pregunta)
# ============================================================================

datos_agregados <- datos_largo %>%
  group_by(SLEP, `Establecimiento Educativo`, RBD, Cargo, Pregunta_N,
           Pregunta_Texto, Dimension, Subdimension, Competencia) %>%
  summarise(
    Valor_Promedio = mean(Valor_Para_Promedio, na.rm = TRUE),
    N_Respuestas = sum(!is.na(Valor_Para_Promedio)),
    N_No_Info = sum(Es_No_Info, na.rm = TRUE),
    .groups = "drop"
  )

# ============================================================================
# 4. CALCULAR MEDIAS POR SUBDIMENSIÓN Y SLEP
# ============================================================================

# Calcular media por subdimensión, agregando las 4 preguntas que la componen
medias_subdimension_slep <- datos_agregados %>%
  group_by(SLEP, Subdimension, Dimension) %>%
  summarise(
    Media = mean(Valor_Promedio, na.rm = TRUE),
    N_Preguntas = n_distinct(Pregunta_N),
    N_Total_Respuestas = sum(N_Respuestas),
    Porc_No_Info = round(100 * sum(N_No_Info) / (sum(N_Respuestas) + sum(N_No_Info)), 1),
    .groups = "drop"
  )

# Calcular media general
medias_subdimension_general <- datos_agregados %>%
  group_by(Subdimension, Dimension) %>%
  summarise(
    Media = mean(Valor_Promedio, na.rm = TRUE),
    N_Preguntas = n_distinct(Pregunta_N),
    N_Total_Respuestas = sum(N_Respuestas),
    Porc_No_Info = round(100 * sum(N_No_Info) / (sum(N_Respuestas) + sum(N_No_Info)), 1),
    .groups = "drop"
  ) %>%
  mutate(SLEP = "General")

# Combinar
medias_subdimension_completas <- bind_rows(medias_subdimension_slep, medias_subdimension_general)

# ============================================================================
# 5. TRANSFORMAR A FORMATO ANCHO
# ============================================================================

medias_subdim_ancho <- medias_subdimension_completas %>%
  select(Subdimension, Dimension, SLEP, Media) %>%
  pivot_wider(
    names_from = SLEP,
    values_from = Media,
    id_cols = c(Subdimension, Dimension)
  ) %>%
  select(Subdimension, Dimension, Licancabur, `El Pino`, `Santa Rosa`,
         `Santa Corina`, `Los Libertadores`, General) %>%
  arrange(Subdimension)

# ============================================================================
# 6. IDENTIFICAR TOP FORTALEZAS Y BRECHAS
# ============================================================================

# Top 5 subdimensiones con mayor media
top_fortalezas_subdim <- medias_subdimension_completas %>%
  filter(SLEP == "General") %>%
  arrange(desc(Media)) %>%
  select(Subdimension, Dimension, Media, N_Preguntas)

# Top 5 subdimensiones con menor media (brechas)
top_brechas_subdim <- medias_subdimension_completas %>%
  filter(SLEP == "General") %>%
  arrange(Media) %>%
  select(Subdimension, Dimension, Media, N_Preguntas)

# ============================================================================
# 7. CALCULAR VARIABILIDAD INTER-SLEP
# ============================================================================

variabilidad_inter_slep <- medias_subdimension_slep %>%
  group_by(Subdimension) %>%
  summarise(
    Media_General = mean(Media, na.rm = TRUE),
    Rango = max(Media, na.rm = TRUE) - min(Media, na.rm = TRUE),
    SD = sd(Media, na.rm = TRUE),
    N_SLEP_Critico = sum(Media < 2.5, na.rm = TRUE),
    .groups = "drop"
  ) %>%
  arrange(desc(Rango))

# ============================================================================
# 8. CALCULAR COBERTURA REAL DE ESTABLECIMIENTOS
# ============================================================================

# Establecimientos que respondieron por SLEP
ee_respondieron <- datos_capa_a %>%
  distinct(SLEP, `Establecimiento Educativo`, RBD)

# Total de EE por SLEP
ee_totales_slep <- lista_ee %>%
  group_by(SLEP) %>%
  summarise(N_EE_Total = n(), .groups = "drop")

# EE que respondieron por SLEP
ee_respondieron_slep <- ee_respondieron %>%
  group_by(SLEP) %>%
  summarise(N_EE_Respondieron = n(), .groups = "drop")

# Calcular cobertura
cobertura_ee_real <- ee_totales_slep %>%
  left_join(ee_respondieron_slep, by = "SLEP") %>%
  mutate(
    N_EE_Respondieron = ifelse(is.na(N_EE_Respondieron), 0, N_EE_Respondieron),
    N_EE_Sin_Respuesta = N_EE_Total - N_EE_Respondieron,
    Porc_Cobertura = round(100 * N_EE_Respondieron / N_EE_Total, 1)
  ) %>%
  arrange(desc(Porc_Cobertura))

# ============================================================================
# 9. EXPORTAR RESULTADOS
# ============================================================================

dir.create("output", showWarnings = FALSE)

write_csv(medias_subdim_ancho, "output/04_medias_por_subdimension_slep.csv")
write_csv(top_fortalezas_subdim, "output/04_top_fortalezas_subdimensiones.csv")
write_csv(top_brechas_subdim, "output/04_top_brechas_subdimensiones.csv")
write_csv(variabilidad_inter_slep, "output/04_variabilidad_inter_slep_subdimensiones.csv")
write_csv(cobertura_ee_real, "output/04_cobertura_real_ee_por_slep.csv")

# ============================================================================
# 10. GENERAR HEATMAP DE SUBDIMENSIONES
# ============================================================================

library(ggplot2)

# Preparar datos para heatmap (formato largo)
datos_heatmap_subdim <- medias_subdimension_completas %>%
  filter(SLEP != "General") %>%
  mutate(
    SLEP = factor(SLEP, levels = c("Licancabur", "Santa Rosa", "El Pino",
                                    "Santa Corina", "Los Libertadores")),
    # Acortar nombres de subdimensiones para el eje Y
    Subdim_Label = str_replace(Subdimension, "^[0-9]\\.[0-9] ", "")
  )

datos_heatmap_general_subdim <- medias_subdimension_completas %>%
  filter(SLEP == "General") %>%
  mutate(Subdim_Label = str_replace(Subdimension, "^[0-9]\\.[0-9] ", ""))

# Crear heatmap para SLEP
p_slep_subdim <- ggplot(datos_heatmap_subdim,
                        aes(x = SLEP, y = reorder(Subdim_Label, desc(Subdimension)), fill = Media)) +
  geom_tile(color = "white", linewidth = 1) +
  geom_text(aes(label = sprintf("%.2f", Media)),
            size = 5, fontface = "bold", color = "black") +
  scale_fill_gradient2(
    low = scales::alpha("#d73027", 0.4),
    mid = scales::alpha("#ffffbf", 0.4),
    high = scales::alpha("#1a9850", 0.4),
    midpoint = 3.0,
    limits = c(1, 5),
    na.value = "grey90",
    name = "Media\n(1-5)"
  ) +
  theme_minimal(base_size = 12) +
  theme(
    axis.text.x = element_text(angle = 45, hjust = 1, face = "bold", size = 12),
    axis.text.y = element_text(size = 11, hjust = 1, lineheight = 0.9, face = "bold"),
    axis.title = element_blank(),
    panel.grid = element_blank(),
    legend.position = "right",
    legend.key.height = unit(2, "cm"),
    legend.key.width = unit(0.8, "cm"),
    legend.title = element_text(face = "bold", size = 11),
    plot.margin = margin(5, 2, 5, 5),
    plot.title = element_text(face = "bold", size = 14, hjust = 0)
  ) +
  labs(title = "Medias por SLEP")

# Crear heatmap para General
p_general_subdim <- ggplot(datos_heatmap_general_subdim,
                           aes(x = SLEP, y = reorder(Subdim_Label, desc(Subdimension)), fill = Media)) +
  geom_tile(color = "white", linewidth = 1) +
  geom_text(aes(label = sprintf("%.2f", Media)),
            size = 5, fontface = "bold", color = "black") +
  scale_fill_gradient2(
    low = scales::alpha("#d73027", 0.4),
    mid = scales::alpha("#ffffbf", 0.4),
    high = scales::alpha("#1a9850", 0.4),
    midpoint = 3.0,
    limits = c(1, 5),
    na.value = "grey90",
    name = "Media\n(1-5)"
  ) +
  theme_minimal(base_size = 12) +
  theme(
    axis.text.x = element_text(angle = 45, hjust = 1, face = "bold", size = 12),
    axis.text.y = element_blank(),
    axis.title = element_blank(),
    panel.grid = element_blank(),
    legend.position = "none",
    plot.title = element_text(face = "bold", size = 14, hjust = 0.5),
    plot.margin = margin(5, 5, 5, 15)
  ) +
  labs(title = "Media\nGeneral")

# Combinar usando gridExtra
library(gridExtra)

png("output/04_heatmap_subdimensiones_slep.png", width = 1400, height = 800, res = 100)
grid.arrange(
  p_slep_subdim, p_general_subdim,
  ncol = 2,
  widths = c(5, 1),
  top = grid::textGrob(
    "Medias por Subdimensión y SLEP - Capa A (Capacidades Curriculares)\nAgregación de 4 preguntas por subdimensión | Escala 1-5",
    gp = grid::gpar(fontsize = 16, fontface = "bold")
  )
)
dev.off()

# ============================================================================
# 11. RESUMEN FINAL
# ============================================================================

cat("\n============================================================================\n")
cat("ANÁLISIS DE SUBDIMENSIONES CAPA A COMPLETADO\n")
cat("============================================================================\n\n")

cat("Archivos generados en output/:\n")
cat("  - 04_medias_por_subdimension_slep.csv\n")
cat("  - 04_top_fortalezas_subdimensiones.csv\n")
cat("  - 04_top_brechas_subdimensiones.csv\n")
cat("  - 04_variabilidad_inter_slep_subdimensiones.csv\n")
cat("  - 04_cobertura_real_ee_por_slep.csv\n")
cat("  - 04_heatmap_subdimensiones_slep.png\n\n")

cat("Cobertura REAL de establecimientos por SLEP:\n")
print(cobertura_ee_real, n = Inf)
cat("\n")

cat("Top 3 Fortalezas (Subdimensiones con medias más altas):\n")
print(head(top_fortalezas_subdim, 3), n = Inf)
cat("\n")

cat("Top 3 Brechas Críticas (Subdimensiones con medias más bajas):\n")
print(head(top_brechas_subdim, 3), n = Inf)
cat("\n")

cat("Subdimensiones con mayor variabilidad entre SLEP:\n")
print(head(variabilidad_inter_slep, 3), n = Inf)

cat("\n============================================================================\n")
