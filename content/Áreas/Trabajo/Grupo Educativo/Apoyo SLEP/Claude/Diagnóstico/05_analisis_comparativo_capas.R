# ============================================================================
# Script: 05_analisis_comparativo_capas.R
# Propósito: Análisis comparativo entre Capa A (dimensiones) y Capa B (módulos)
# Autor: Claude Code
# Fecha: 2025-12-17
# ============================================================================

library(tidyverse)
library(readr)
library(ggplot2)

# ============================================================================
# 1. CARGAR DATOS PROCESADOS
# ============================================================================

# Cargar medias de Capa A por dimensión
medias_capa_a_dim <- read_csv("output/02_medias_por_pregunta_slep.csv", show_col_types = FALSE)

# Calcular medias por dimensión para Capa A
medias_dim_capa_a <- medias_capa_a_dim %>%
  pivot_longer(
    cols = c(Licancabur, `El Pino`, `Santa Rosa`, `Santa Corina`, `Los Libertadores`, General),
    names_to = "SLEP",
    values_to = "Media"
  ) %>%
  group_by(SLEP, Dimension) %>%
  summarise(
    Media = mean(Media, na.rm = TRUE),
    .groups = "drop"
  ) %>%
  mutate(
    Capa = "Capa A: Curricular",
    Dimension_Corta = case_when(
      str_detect(Dimension, "Desarrollo profesional") ~ "D1. Desarrollo Docente",
      str_detect(Dimension, "Gestión estratégica") ~ "D2. Gestión Currículum",
      str_detect(Dimension, "Gestión integral") ~ "D3. Gestión Técnico-Ped.",
      TRUE ~ Dimension
    )
  )

# Cargar medias de Capa B por módulo
medias_capa_b_mod <- read_csv("output/03_medias_por_pregunta_slep_capa_b.csv", show_col_types = FALSE)

# Calcular medias por módulo para Capa B
medias_mod_capa_b <- medias_capa_b_mod %>%
  pivot_longer(
    cols = c(Licancabur, `El Pino`, `Santa Rosa`, `Santa Corina`, `Los Libertadores`, General),
    names_to = "SLEP",
    values_to = "Media"
  ) %>%
  group_by(SLEP, Modulo) %>%
  summarise(
    Media = mean(Media, na.rm = TRUE),
    .groups = "drop"
  ) %>%
  mutate(
    Capa = "Capa B: Administrativa",
    Dimension_Corta = case_when(
      str_detect(Modulo, "M1") ~ "M1. Levantamiento Necesidades",
      str_detect(Modulo, "M2") ~ "M2. Priorización",
      str_detect(Modulo, "M3") ~ "M3. Planificación",
      str_detect(Modulo, "M4") ~ "M4. Verificación",
      TRUE ~ Modulo
    )
  ) %>%
  rename(Dimension = Modulo)

# ============================================================================
# 2. COMBINAR DATOS PARA COMPARACIÓN
# ============================================================================

datos_comparativos <- bind_rows(
  medias_dim_capa_a,
  medias_mod_capa_b
)

# Filtrar para análisis (sin Los Libertadores por N bajo y sin General)
datos_comparativos_filtrado <- datos_comparativos %>%
  filter(SLEP != "Los Libertadores" & SLEP != "General")

# ============================================================================
# 3. GRÁFICO DE BARRAS AGRUPADAS: CAPA A vs CAPA B POR SLEP
# ============================================================================

# Preparar etiquetas para facetas
datos_comparativos_filtrado <- datos_comparativos_filtrado %>%
  mutate(
    Capa_Factor = factor(Capa, levels = c("Capa A: Curricular", "Capa B: Administrativa"))
  )

# Preparar datos por capa para escalas independientes
datos_capa_a_graf <- datos_comparativos_filtrado %>%
  filter(Capa == "Capa A: Curricular")

datos_capa_b_graf <- datos_comparativos_filtrado %>%
  filter(Capa == "Capa B: Administrativa")

# Crear gráfico para Capa A (eje Y: 1-5)
p_capa_a <- ggplot(datos_capa_a_graf, aes(x = SLEP, y = Media, fill = Dimension_Corta)) +
  geom_col(position = "dodge", color = "white", linewidth = 0.3) +
  geom_text(
    aes(label = sprintf("%.2f", Media)),
    position = position_dodge(width = 0.9),
    vjust = -0.3,
    size = 2.5,
    fontface = "bold"
  ) +
  scale_fill_brewer(palette = "Set3") +
  scale_y_continuous(breaks = seq(0, 5, 0.5), expand = expansion(mult = c(0, 0.1))) +
  coord_cartesian(ylim = c(1, 5)) +
  theme_minimal(base_size = 11) +
  theme(
    plot.title = element_text(face = "bold", size = 12, hjust = 0.5),
    axis.text.x = element_text(angle = 45, hjust = 1, face = "bold"),
    legend.position = "none",
    panel.grid.major.x = element_blank(),
    plot.margin = margin(5, 5, 5, 5)
  ) +
  labs(
    title = "Capa A: Curricular",
    x = NULL,
    y = "Media (1-5)"
  )

# Crear gráfico para Capa B (eje Y: 1-4)
p_capa_b <- ggplot(datos_capa_b_graf, aes(x = SLEP, y = Media, fill = Dimension_Corta)) +
  geom_col(position = "dodge", color = "white", linewidth = 0.3) +
  geom_text(
    aes(label = sprintf("%.2f", Media)),
    position = position_dodge(width = 0.9),
    vjust = -0.3,
    size = 2.5,
    fontface = "bold"
  ) +
  scale_fill_brewer(palette = "Set3") +
  scale_y_continuous(breaks = seq(0, 4, 0.5), expand = expansion(mult = c(0, 0.1))) +
  coord_cartesian(ylim = c(1, 4)) +
  theme_minimal(base_size = 11) +
  theme(
    plot.title = element_text(face = "bold", size = 12, hjust = 0.5),
    axis.text.x = element_text(angle = 45, hjust = 1, face = "bold"),
    legend.position = "bottom",
    legend.title = element_text(face = "bold"),
    panel.grid.major.x = element_blank(),
    plot.margin = margin(5, 5, 5, 5)
  ) +
  labs(
    title = "Capa B: Administrativa",
    x = "SLEP",
    y = "Media (1-4)",
    fill = "Dimensión / Módulo"
  ) +
  guides(fill = guide_legend(nrow = 3, byrow = TRUE))

# Combinar ambos gráficos
library(gridExtra)

# Guardar gráfico
png("output/05_comparacion_barras_capa_a_vs_b.png", width = 1400, height = 1000, res = 100)
grid.arrange(
  p_capa_a, p_capa_b,
  ncol = 1,
  heights = c(1, 1.3),
  top = grid::textGrob(
    "Comparación de Capacidades Curriculares vs Administrativas por SLEP\nCapa A (3 Dimensiones) vs Capa B (4 Módulos) | Excluye Los Libertadores y General",
    gp = grid::gpar(fontsize = 14, fontface = "bold")
  )
)
dev.off()

# ============================================================================
# 4. TABLA RESUMEN: MEDIAS GENERALES CAPA A vs CAPA B POR SLEP
# ============================================================================

resumen_comparativo_slep <- bind_rows(
  medias_dim_capa_a %>%
    filter(SLEP != "Los Libertadores") %>%
    group_by(SLEP, Capa) %>%
    summarise(Media_Capa = mean(Media, na.rm = TRUE), .groups = "drop"),
  medias_mod_capa_b %>%
    filter(SLEP != "Los Libertadores") %>%
    group_by(SLEP, Capa) %>%
    summarise(Media_Capa = mean(Media, na.rm = TRUE), .groups = "drop")
) %>%
  pivot_wider(
    names_from = Capa,
    values_from = Media_Capa
  ) %>%
  mutate(
    Brecha_A_menos_B = `Capa A: Curricular` - `Capa B: Administrativa`
  ) %>%
  arrange(desc(`Capa A: Curricular`))

write_csv(resumen_comparativo_slep, "output/05_resumen_comparativo_capas_por_slep.csv")

# ============================================================================
# 5. RESUMEN FINAL
# ============================================================================

cat("\n============================================================================\n")
cat("ANÁLISIS COMPARATIVO CAPA A vs CAPA B COMPLETADO\n")
cat("============================================================================\n\n")

cat("Archivos generados en output/:\n")
cat("  - 05_comparacion_barras_capa_a_vs_b.png\n")
cat("  - 05_resumen_comparativo_capas_por_slep.csv\n\n")

cat("Resumen Comparativo por SLEP (sin Los Libertadores):\n")
print(resumen_comparativo_slep, n = Inf)

cat("\n============================================================================\n")
