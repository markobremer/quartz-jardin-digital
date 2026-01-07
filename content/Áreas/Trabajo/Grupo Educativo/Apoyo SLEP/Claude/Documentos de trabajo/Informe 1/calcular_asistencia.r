# Script para calcular promedio de tasa_asistencia_anual por liceo
# Proyecto: Apoyo SLEP 2025-2026

library(readr)
library(dplyr)
library(readxl)

# Definir rutas
ruta_asistencia <- "/Users/marko/Library/CloudStorage/OneDrive-SharedLibraries-GrupoEducativo/Apoyo SLEP 2025-2026 - General/90. Recursos/Datos/Fuentes/2024_Asistencia.csv"
ruta_bbdd <- "/Users/marko/Library/CloudStorage/OneDrive-SharedLibraries-GrupoEducativo/Apoyo SLEP 2025-2026 - General/90. Recursos/Datos/BBDD.xlsx"

# Leer datos de asistencia
asistencia <- read_delim(ruta_asistencia, delim = ";", locale = locale(decimal_mark = ","))

# Leer BBDD de liceos
liceos <- read_excel(ruta_bbdd, sheet = "BBDD")

# Obtener RBDs del proyecto
rbds_proyecto <- liceos$RBD

# Filtrar asistencia solo para los liceos del proyecto
asistencia_proyecto <- asistencia %>%
  filter(rbd %in% rbds_proyecto)

# Calcular promedio de tasa_asistencia_anual por liceo (RBD)
promedio_asistencia <- asistencia_proyecto %>%
  group_by(rbd) %>%
  summarise(
    tasa_asistencia_promedio = mean(tasa_asistencia_anual, na.rm = TRUE),
    n_estudiantes = n(),
    .groups = "drop"
  )

# Unir con información de liceos para obtener nombre y SLEP
resultado <- promedio_asistencia %>%
  left_join(
    liceos %>% select(RBD, SLEP, Liceo, Comuna),
    by = c("rbd" = "RBD")
  ) %>%
  arrange(SLEP, Liceo)

# Mostrar resultados
print(resultado)

# Resumen por SLEP
resumen_slep <- resultado %>%
  group_by(SLEP) %>%
  summarise(
    tasa_asistencia_promedio_slep = mean(tasa_asistencia_promedio, na.rm = TRUE),
    n_liceos = n(),
    total_estudiantes = sum(n_estudiantes),
    .groups = "drop"
  )

print("\n=== Resumen por SLEP ===")
print(resumen_slep)

# Guardar resultados
write.csv(resultado, "resultados_asistencia_por_liceo.csv", row.names = FALSE)
write.csv(resumen_slep, "resultados_asistencia_por_slep.csv", row.names = FALSE)

cat("\nResultados guardados en:\n")
cat("- resultados_asistencia_por_liceo.csv\n")
cat("- resultados_asistencia_por_slep.csv\n")
