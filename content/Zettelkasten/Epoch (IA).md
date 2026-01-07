---
aliases:
  - Época
---
Se refiere a cada iteración que hace un [[LLM]] en su [[Fase de entrenamiento de los LLM|fase de entrenamiento]]. Cada una de estas pasadas tiene como efecto la actualización de los pesos de la [[Red neuronal|red neuronal]] que constituye al modelo, optimizándolo y haciéndolo más preciso y útil.

Aquí hay un ejemplo del desempeño de un LLM entrenado con 800 GB de texto en inglés, pero sólo con una pasada:

![[Pasted image 20260101220035.png]]

A estas alturas, el modelo probabilístico es prácticamente plano, con lo que las tokens se selecionan básicamente al azar.

En contraste, aquí se muestra el modelo después de 1000 épocas con el mismo [[Corpus (IA)]]:

![[Pasted image 20260101220243.png]]