

Después de poner el código de seguimiento de Analytics en la página de encuadrado, se puede ver que registra eventos desde el debugger de GTM:
![[Captura de pantalla 2024-01-31 a la(s) 16.32.23.png]]

Hasta donde alcancé a revisar, puedes ir haciendo seguimiento a los eventos paso a paso, desde que visita el perfil (ej: Profile visited):

![[Captura de pantalla 2024-01-31 a la(s) 16.33.13.png]]


Hasta que entro a la plataforma de pago (ej: form_submit):

![[Captura de pantalla 2024-01-31 a la(s) 16.34.25.png]]

Lo que correspondería hacer ahora, es crear etiquetas de conversión, poniendo como disparadores cada uno de esos eventos, creando así un embudo que me permita ver hasta dónde llega cada usuario después de ver los artículos asociados a mis anuncios.