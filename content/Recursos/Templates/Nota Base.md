<%*
let titulo = tp.file.title;
tR = "---\n"
%>title: <%* tR += titulo %>
created: <% tp.file.creation_date("YYYY-MM-DD HH:mm") %>
tags: []
---

# <%* tR += titulo %>

<% tp.file.cursor() %>
