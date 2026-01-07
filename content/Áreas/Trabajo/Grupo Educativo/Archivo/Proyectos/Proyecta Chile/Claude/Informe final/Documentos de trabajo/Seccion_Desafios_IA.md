##### Desafíos asociados al uso de inteligencia artificial

El uso de inteligencia artificial estaba contemplado en dos momentos clave del proceso de elaboración de Policy Briefs: primero, para la **elaboración de actas** a partir de transcripciones automáticas y apuntes de facilitadores; y segundo, para la **elaboración de los Policy Briefs** a partir de las actas y documentos de vaciado generados durante las sesiones de las mesas temáticas. Si bien la incorporación de IA representaba una oportunidad para optimizar procesos de síntesis documental, en la práctica enfrentó desafíos significativos que limitaron su efectividad y generaron aprendizajes importantes para futuras iteraciones.

**Ausencia de estándares y criterios de calidad desde el inicio:**

El desafío más significativo fue la falta de definiciones claras desde el comienzo del proceso sobre los productos esperados y sus estándares de calidad. No se estableció desde el inicio la estructura definitiva de las actas ni de los Policy Briefs, existiendo solo referencias generales. Tampoco se definió de entrada cómo cada sesión contribuía específicamente al contenido de las distintas secciones del Policy Brief, dificultando que los facilitadores supieran qué información priorizar en sus registros.

En el caso específico de las actas, no existía un formato acordado y validado con criterios de calidad explícitos que permitiera a cada facilitador comprender qué se esperaba de su trabajo. Adicionalmente, no se implementó un mecanismo de revisión de calidad que verificara si las actas cumplían con los estándares requeridos antes de ser utilizadas como insumos para etapas posteriores. Esto resultó en actas heterogéneas en estructura, profundidad y calidad de contenido.

Un aspecto que no se consideró inicialmente, y que emerge como aprendizaje relevante para futuras iteraciones, es la importancia de que las actas sean validadas por los propios participantes de las mesas temáticas. Esto no solo asegura la fidelidad del registro, sino que también contribuye a la legitimidad y apropiación del proceso por parte de los expertos involucrados.

**Heterogeneidad de insumos:**

Un principio fundamental del trabajo con modelos de lenguaje es que la calidad del output depende críticamente de la calidad del input. En este proceso, si bien existían indicaciones comunes para todos los facilitadores sobre el registro de sesiones y elaboración de actas, estas indicaciones no fueron suficientemente documentadas, profundas y explícitas desde el comienzo del proceso. Adicionalmente, no se implementó un sistema de revisión sistemática que verificara su cumplimiento.

Como resultado, el material disponible para que los modelos de lenguaje procesaran variaba significativamente entre mesas en términos de estructura, nivel de detalle y calidad analítica. Esta variabilidad en los insumos se tradujo inevitablemente en Policy Briefs de calidad inconsistente, requiriendo múltiples iteraciones de revisión y ajustes manuales significativos.

**Ausencia de dirección sistemática en iteración de prompts:**

No se estableció una dirección sistemática clara para el desarrollo y refinamiento de los prompts utilizados con los modelos de lenguaje. En la práctica, se utilizaron diversos prompts sin una supervisión centralizada que asegurara consistencia metodológica. No se implementó un proceso iterativo estructurado que permitiera identificar qué prompts generaban mejores resultados bajo qué condiciones, ni se documentaron las lecciones aprendidas de cada iteración.

Esta falta de sistematicidad impidió el desarrollo de una "receta" consistente y replicable que, asumiendo insumos de buena calidad, lograra generar resultados comparables entre distintas mesas. La ausencia de este proceso de refinamiento continuo contribuyó significativamente a la heterogeneidad de los productos desarrollados y dificultó el escalamiento eficiente del uso de IA en el proceso.

**Desafíos en la colaboración con el partner tecnológico:**

La colaboración con Amazon Web Services (AWS) como partner tecnológico enfrentó dificultades en su implementación. Las políticas de AWS le impedían trabajar directamente con nuestros datos, por lo cual el aporte que podían ofrecer era de créditos para el uso en su plataforma, que es bastante técnica y tenía herramientas bastante especializadas que requerían de la dedicación de una persona específica con perfil TI que no estuvo considerada desde el inicio en el proyecto y tuvo que ser subsanada en el camino.

Esta brecha entre las expectativas iniciales y las capacidades efectivas del partner representó un riesgo para el proceso, particularmente considerando los ajustados márgenes temporales disponibles. Si bien se logró implementar algunas herramientas de transcripción automática, el nivel de integración y especialización del apoyo tecnológico no alcanzó lo inicialmente proyectado para el procesamiento y síntesis de la información generada por las mesas.
