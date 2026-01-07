
Aquí voy a almacenar información asociada a mis templates más utilizados.

## Default template

```
<%* 
let title = tp.file.title 
if (title.startsWith("Untitled")) { 
title = await tp.system.prompt("Título"); 
} await tp.file.rename(title) 
-%>
title: <% title %>
aliases: 
tags: 
created: <% tp.file.creation_date("DD-MM-YYYY HH:mm") %>
last modified: <% tp.file.last_modified_date("DD-MM-YYYY HH:mm") %>

<% tp.file.cursor() %>
```

- [Obsidian Templater Fun - Macdrifter](http://www.macdrifter.com/2021/08/obsidian-templater-fun.html): Estas instrucciones funcionan, pero no cuando estás creando la nota desde un enlace. 
- [Templater: Wait for Title until Note is Named : r/ObsidianMD](https://www.reddit.com/r/ObsidianMD/comments/vft7tv/templater_wait_for_title_until_note_is_named/) Esta resuelve ese problema.

Es importante tener en cuenta que ese bloque de código se pone antes de las (---) que dan inicio al YAML. El comando de apertura tiene asterisco porque usa Javascript, el de salida tiene un "-" para borrar el espacio de después del comando y así no interferir con la creación del YAML.
