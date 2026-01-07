# ==============================================================================
# ANÁLISIS DIAGNÓSTICO CAPA A - ESTABLECIMIENTOS EDUCATIVOS
# Proyecto: Apoyo SLEP 2025-2026
# Script 01: Caracterización de respuestas por EE y cargo
# ==============================================================================

# Limpiar entorno
rm(list = ls())

# Cargar librerías necesarias
library(tidyverse)
library(readr)
library(knitr)
library(kableExtra)

# ==============================================================================
# 1. CARGAR DATOS
# ==============================================================================

# Ruta a la base de datos
ruta_bbdd <- "/Users/marko/Library/CloudStorage/OneDrive-SharedLibraries-GrupoEducativo/Apoyo SLEP 2025-2026 - General/2. Ejecución/1. Diagnóstico/1. Instrumento/3. Resultados/Análisis Marko/BBDD - EE - Capa A.csv"

# Cargar datos
datos_raw <- read_delim(ruta_bbdd,
                        delim = ";",
                        locale = locale(encoding = "UTF-8"),
                        show_col_types = FALSE)

# Inspección inicial
cat("\n=== ESTRUCTURA DE LA BASE DE DATOS ===\n")
cat("Dimensiones:", dim(datos_raw), "\n")
cat("Variables:", ncol(datos_raw), "\n")
cat("Observaciones (respuestas):", nrow(datos_raw), "\n\n")

# ==============================================================================
# 2. LIMPIEZA Y PREPARACIÓN DE DATOS
# ==============================================================================

# Identificar columnas de identificación y preguntas
cols_id <- c("SLEP", "Establecimiento Educativo", "Cargo")
cols_preguntas <- setdiff(names(datos_raw), cols_id)

# Remover la última columna (comentarios adicionales)
cols_preguntas <- cols_preguntas[1:36]

cat("Columnas de identificación:", length(cols_id), "\n")
cat("Columnas de preguntas:", length(cols_preguntas), "\n\n")

# Crear version limpia con datos de identificación
# Filtrar filas con SLEP o EE faltantes (respuestas incompletas en identificación)
datos_id <- datos_raw %>%
  select(all_of(cols_id)) %>%
  filter(!is.na(SLEP) & !is.na(`Establecimiento Educativo`))

# ==============================================================================
# 3. CARACTERIZACIÓN DE RESPUESTAS POR SLEP
# ==============================================================================

cat("\n=== RESPUESTAS POR SLEP ===\n\n")

tabla_slep <- datos_id %>%
  group_by(SLEP) %>%
  summarise(
    N_Respuestas = n(),
    N_EE = n_distinct(`Establecimiento Educativo`),
    .groups = "drop"
  ) %>%
  arrange(desc(N_Respuestas))

print(tabla_slep)

# ==============================================================================
# 4. CARACTERIZACIÓN DE RESPUESTAS POR CARGO
# ==============================================================================

cat("\n\n=== RESPUESTAS POR CARGO (GENERAL) ===\n\n")

tabla_cargo <- datos_id %>%
  group_by(Cargo) %>%
  summarise(
    N_Respuestas = n(),
    Porcentaje = round(100 * n() / nrow(datos_id), 1),
    .groups = "drop"
  ) %>%
  arrange(desc(N_Respuestas))

print(tabla_cargo)

# ==============================================================================
# 5. CARACTERIZACIÓN CRUZADA: SLEP × CARGO
# ==============================================================================

cat("\n\n=== RESPUESTAS POR SLEP Y CARGO ===\n\n")

tabla_slep_cargo <- datos_id %>%
  group_by(SLEP, Cargo) %>%
  summarise(N = n(), .groups = "drop") %>%
  pivot_wider(names_from = Cargo, values_from = N, values_fill = 0) %>%
  mutate(Total = rowSums(select(., -SLEP)))

print(tabla_slep_cargo)

# ==============================================================================
# 6. CARACTERIZACIÓN POR ESTABLECIMIENTO EDUCATIVO
# ==============================================================================

cat("\n\n=== RESPUESTAS POR ESTABLECIMIENTO EDUCATIVO ===\n\n")

tabla_ee <- datos_id %>%
  group_by(SLEP, `Establecimiento Educativo`) %>%
  summarise(
    N_Respuestas = n(),
    Cargos_que_respondieron = paste(sort(Cargo), collapse = ", "),
    .groups = "drop"
  ) %>%
  arrange(SLEP, desc(N_Respuestas))

print(tabla_ee, n = 100)

# ==============================================================================
# 7. IDENTIFICACIÓN DE EE CON RESPUESTA COMPLETA
# ==============================================================================

cat("\n\n=== COBERTURA DE CARGOS ESPERADOS POR ESTABLECIMIENTO ===\n\n")

# Cargos esperados
cargos_esperados <- c("Director/a", "UTP", "Coordinación EMTP")

# Análisis de cobertura
cobertura_ee <- datos_id %>%
  group_by(SLEP, `Establecimiento Educativo`) %>%
  summarise(
    N_Respuestas = n(),
    Tiene_Director = any(Cargo == "Director/a"),
    Tiene_UTP = any(Cargo == "UTP"),
    Tiene_Coord_EMTP = any(Cargo == "Coordinación EMTP"),
    Tiene_Otro = any(!Cargo %in% cargos_esperados),
    .groups = "drop"
  ) %>%
  mutate(
    Respuesta_Completa = Tiene_Director & Tiene_UTP & Tiene_Coord_EMTP,
    N_Cargos_Esperados = Tiene_Director + Tiene_UTP + Tiene_Coord_EMTP
  ) %>%
  arrange(SLEP, desc(N_Cargos_Esperados))

print(cobertura_ee, n = 100)

# ==============================================================================
# 8. RESUMEN EJECUTIVO DE COBERTURA
# ==============================================================================

cat("\n\n=== RESUMEN EJECUTIVO DE COBERTURA ===\n\n")

resumen_cobertura <- cobertura_ee %>%
  group_by(SLEP) %>%
  summarise(
    N_EE = n(),
    EE_Respuesta_Completa = sum(Respuesta_Completa, na.rm = TRUE),
    Porc_Completa = round(100 * EE_Respuesta_Completa / N_EE, 1),
    EE_Sin_Respuesta = sum(N_Respuestas == 0, na.rm = TRUE),
    EE_Respuesta_Parcial = sum(N_Respuestas > 0 & !Respuesta_Completa, na.rm = TRUE),
    .groups = "drop"
  )

print(resumen_cobertura)

# Resumen general
cat("\n\n=== RESUMEN GENERAL DEL PROYECTO ===\n\n")

cat("Total de SLEP bajo acompañamiento:", n_distinct(datos_id$SLEP), "\n")
cat("Total de establecimientos educativos que respondieron:", n_distinct(datos_id$`Establecimiento Educativo`), "\n")
cat("Total de respuestas válidas:", nrow(datos_id), "\n\n")

cat("Establecimientos con respuesta completa (3 cargos):", sum(cobertura_ee$Respuesta_Completa, na.rm = TRUE), "\n")
cat("Establecimientos con respuesta parcial:", sum(cobertura_ee$N_Respuestas > 0 & !cobertura_ee$Respuesta_Completa, na.rm = TRUE), "\n")
cat("Establecimientos sin respuesta:", sum(cobertura_ee$N_Respuestas == 0, na.rm = TRUE), "\n\n")

# Tasa de respuesta promedio
tasa_respuesta_promedio <- mean(cobertura_ee$N_Cargos_Esperados / 3, na.rm = TRUE) * 100
cat("Tasa de respuesta promedio por EE (respecto a 3 cargos esperados):",
    round(tasa_respuesta_promedio, 1), "%\n\n")

# ==============================================================================
# 9. VISUALIZACIÓN: HEATMAP DE COBERTURA POR EE
# ==============================================================================

cat("\n\n=== GENERANDO VISUALIZACIÓN DE COBERTURA ===\n\n")

# Preparar datos para el heatmap
datos_heatmap <- cobertura_ee %>%
  select(SLEP, `Establecimiento Educativo`, Tiene_Director, Tiene_UTP, Tiene_Coord_EMTP) %>%
  pivot_longer(cols = starts_with("Tiene_"),
               names_to = "Cargo_Tipo",
               values_to = "Presente") %>%
  mutate(
    Cargo_Tipo = case_when(
      Cargo_Tipo == "Tiene_Director" ~ "Director/a",
      Cargo_Tipo == "Tiene_UTP" ~ "UTP",
      Cargo_Tipo == "Tiene_Coord_EMTP" ~ "Coord. EMTP",
      TRUE ~ Cargo_Tipo
    ),
    Cargo_Tipo = factor(Cargo_Tipo, levels = c("Director/a", "UTP", "Coord. EMTP"))
  )

# Crear el gráfico
p1 <- ggplot(datos_heatmap, aes(x = Cargo_Tipo, y = `Establecimiento Educativo`, fill = Presente)) +
  geom_tile(color = "white", size = 0.5) +
  facet_wrap(~ SLEP, scales = "free_y", ncol = 1) +
  scale_fill_manual(values = c("FALSE" = "#d73027", "TRUE" = "#1a9850"),
                    labels = c("No respondió", "Respondió"),
                    name = "Estado") +
  theme_minimal(base_size = 10) +
  theme(
    axis.text.x = element_text(angle = 45, hjust = 1),
    axis.text.y = element_text(size = 8),
    strip.text = element_text(face = "bold", size = 11),
    panel.grid = element_blank(),
    legend.position = "bottom"
  ) +
  labs(
    title = "Cobertura de Respuestas por Establecimiento Educativo y Cargo Esperado",
    subtitle = "Diagnóstico Capa A - Capacidades Implementación Curricular EMTP",
    x = "Cargo Esperado",
    y = "Establecimiento Educativo"
  )

# Guardar gráfico
ggsave("output/01_heatmap_cobertura_ee_cargo.png",
       plot = p1,
       width = 10,
       height = 14,
       dpi = 300)

cat("Gráfico guardado en: output/01_heatmap_cobertura_ee_cargo.png\n\n")

# ==============================================================================
# 10. IDENTIFICAR ESTABLECIMIENTOS CON RESPUESTAS ATÍPICAS
# ==============================================================================

cat("\n=== ESTABLECIMIENTOS CON RESPUESTAS ATÍPICAS ===\n\n")

# EE sin ninguna respuesta de cargo esperado (si respondió "Otro")
ee_solo_otro <- cobertura_ee %>%
  filter(Tiene_Otro & N_Cargos_Esperados == 0)

if(nrow(ee_solo_otro) > 0) {
  cat("Establecimientos que respondieron solo con cargo 'Otro':\n")
  print(ee_solo_otro %>% select(SLEP, `Establecimiento Educativo`, N_Respuestas))
} else {
  cat("No hay establecimientos con solo respuestas de cargo 'Otro'.\n")
}

# EE con respuestas duplicadas del mismo cargo
cat("\n\nEstablecimientos con respuestas duplicadas del mismo cargo:\n")
duplicados <- datos_id %>%
  group_by(SLEP, `Establecimiento Educativo`, Cargo) %>%
  summarise(N = n(), .groups = "drop") %>%
  filter(N > 1)

if(nrow(duplicados) > 0) {
  print(duplicados)
} else {
  cat("No hay duplicados detectados.\n")
}

# ==============================================================================
# 11. EXPORTAR TABLAS RESUMEN
# ==============================================================================

cat("\n\n=== EXPORTANDO TABLAS RESUMEN ===\n\n")

# Crear directorio output si no existe
if(!dir.exists("output")) {
  dir.create("output")
}

# Exportar tabla de cobertura por EE
write_csv(cobertura_ee, "output/01_cobertura_por_ee.csv")
cat("Tabla exportada: output/01_cobertura_por_ee.csv\n")

# Exportar resumen por SLEP
write_csv(resumen_cobertura, "output/01_resumen_cobertura_slep.csv")
cat("Tabla exportada: output/01_resumen_cobertura_slep.csv\n")

# Exportar tabla de respuestas por cargo
write_csv(tabla_cargo, "output/01_respuestas_por_cargo.csv")
cat("Tabla exportada: output/01_respuestas_por_cargo.csv\n\n")

cat("=== SCRIPT COMPLETADO ===\n")
